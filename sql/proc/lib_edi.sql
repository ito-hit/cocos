CREATE OR REPLACE package lib_edi is
    -- 配送リードタイム情報
    type lt_info_t is record (
        leadtime_keisan_kbn     m_mise.leadtime_keisan_kbn%type,    -- 配送リードタイム計算区分
        lt                      number                              -- 配送リードタイム（日数）
    );

    procedure edi_debug_log(message varchar2);
    procedure err_disp;
    function get_clientid return varchar2;
    procedure clear_userid;
	procedure set_userid(p_user_id in varchar2);
    function get_userid return varchar2;
    procedure fix2work(
        p_table_name    in  varchar2,
        p_line_buffer   in  varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    );
    procedure csv2work(
        p_table_name    in  varchar2,
        p_line_buffer   in  varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    );
    function edi_jyusin_no return number;
    function get_jyutyuno return number;
    function is_duplicate_jyutyu(p_d_edi_jyutyu d_edi_jyutyu%rowtype) return boolean;
    function get_lt_info (
        p_kyoten_code m_teisu.teisu_code%type,
        p_tokui_code  m_mise.tokui_code%type,
        p_mise_code   m_mise.mise_code%type
    ) return lt_info_t;

    -- エラーチェックパターン情報
    type error_check_pattern_t is record (
        tokui   varchar2(1),    -- 得意先判定パターン（A：入力コード、B：データ項目、C：店マスター）
        mise    varchar2(1),    -- 店判定パターン    （A：データ、B：店マスター）
        kyoten  varchar2(1),    -- 拠点判定パターン  （A：単一、B：得意先判定、C：店マスター判定）
        tanka   varchar2(1)     -- 単価判定パターン  （A：発注単価、B：当社登録単価）
    );
    procedure error_check(
        p_check_pattern_info    in error_check_pattern_t ,
        p_d_edi_jyutyu          in out d_edi_jyutyu%rowtype
    );
    procedure warning_check(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype);
    procedure set_others_item(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype);

end lib_edi;
/
CREATE OR REPLACE package body lib_edi is

	/*	Script		： EDI系のパッケージでデバックをEDI_LOGテーブルに投入する
		Author		： K.Sakamoto
		Parameters	： message  - ログに出力するメッセージ
		Return		： なし
		DataWritten	： 2025/03/26
		Modified	：
	*/
    procedure edi_debug_log(message varchar2)
    is
    begin
        -- $if $$debug $then
            execute immediate 'insert into edi_log (message) values (:1)' using message;
        -- $end
        null;
    end edi_debug_log;

	/*	Script		： 現在のセッションで使用されているクライアント端末情報（端末名）を取得
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： クライアント端末情報（端末名）
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function get_clientid
    return varchar2
    is
        client_id   varchar2(40);
    begin
        -- select
        --     decode( terminal, 'unknown', substr( machine, instr( machine, '\', -1 ) + 1 ), terminal ) into client_id
        -- from v$session
	    -- where audsid	= userenv( 'SESSIONID' );
        client_id := 'unknown';
        select sys_context('userenv', 'terminal') into client_id from dual;
        return  client_id;
    end get_clientid;

	/*	Script		： セッションごとに一意のクライアント識別子（ユーザーID）をクリアする
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： なし
		DataWritten	： 2025/03/12
		Modified	：
	*/
    procedure clear_userid
    is
    begin
        dbms_session.clear_identifier;
    end clear_userid;

	/*	Script		： セッションごとに一意のクライアント識別子（ユーザーID）を設定
					： パッケージで更新する際などに予めこのメソッドにてユーザーIDを現在のデータベースセッションの client_identifier に設定しておく
		Author		： K.Sakamoto
		Parameters	： p_user_id
		Return		： なし
		DataWritten	： 2025/03/12
		Modified	：
	*/
	procedure set_userid(p_user_id in varchar2)
	is
	begin
		dbms_session.set_identifier(p_user_id);
	end set_userid;

	/*	Script		： セッションごとに一意のクライアント識別子（ユーザーID）を返却
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： なし
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function get_userid
    return varchar2
    is
        l_userid varchar2(40);
    begin
        select nvl(trim(client_identifier), user) into l_userid from v$session where audsid = userenv('sessionid');
        return l_userid;
    exception
        when no_data_found then
            -- 通常はあり得ない
            return null;
    end get_userid;

	/*	Script		： 固定長データをワークテーブルにinsertする
                    ： 基本ロジックは csv2work と同じ
		Author		： K.Sakamoto
		Parameters	： p_table_name     - ワークテーブル名
                    ： p_line_buffer    - 行データ
                    ： p_column_list    - INSERTカラムリスト
                    ： p_value_list     - VALUESリスト
		Return		： なし
		DataWritten	： 2025/03/26
		Modified	：
	*/
    procedure fix2work(
        p_table_name    varchar2,
        p_line_buffer   varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    )
    is
        l_column_type       varchar2(4000);
        l_column_length     number;
        l_result            number;

        l_pos               number := 1;
        l_value             varchar2(4000);
        l_sql               varchar2(4000);
    begin
        if lengthb(trim(p_line_buffer)) < 1 then
            return;
        end if;

        -- レコードを分解してワークに登録する
        l_pos := 1;
        for rec in (select column_name from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('lineh', 'line1', 'line2', 'line3') order by column_name)
        loop
            execute immediate 'begin :1 := fnc.get_column_info(:2, :3, :4, :5); end;'
            using out l_result, in p_table_name, in rec.column_name, out l_column_type, out l_column_length;
            l_value := trim(rtrim(substrb(p_line_buffer, l_pos, l_column_length), '　'));   -- 右空白（全角半角）のみ切捨る
            l_pos := l_pos + l_column_length;
            -- 数値カラムの対応
            if upper(trim(l_column_type)) = upper('number') then
                l_value := to_char(to_number(regexp_replace(l_value, '^0+-', '-')));
            end if;

            -- 空フィールドは null とする（文字列 'null' ではなく実際の null を使う場合）
            if l_value is null or l_value = '' then
                p_value_list := p_value_list || ', ' || 'null';
            else
                p_value_list := p_value_list || ', ' || '''' || l_value || '''';
            end if;

            p_column_list := p_column_list || ', ' || rec.column_name;
        end loop;

        -- 最後の余計なカンマを削除
        p_column_list := ltrim(p_column_list, ', ');
        p_value_list := ltrim(p_value_list, ', ');
        -- 登録処理
        l_sql := 'insert into ' || p_table_name || ' (' || p_column_list || ') values (' || p_value_list || ') ';
        $if $$debug $then
            l_sql := l_sql || 'log errors into err$_' || p_table_name || ' (''load'') reject limit unlimited';
        $end
        l_sql := upper(l_sql);
        edi_debug_log(l_sql);
        execute immediate l_sql;
    exception
        when no_data_found then
            raise_application_error(-20001, p_table_name || ' というテーブルはありません。');
        when others then
            raise;
    end fix2work;

	/*	Script		： CSVデータをワークテーブルにinsertする
                    ： 基本ロジックは fix2work と同じ
		Author		： K.Sakamoto
		Parameters	： p_table_name     - ワークテーブル名
                    ： p_line_buffer    - 行データ
                    ： p_column_list    - INSERTカラムリスト
                    ： p_value_list     - VALUESリスト
		Return		： なし
		DataWritten	： 2025/03/26
		Modified	：
	*/
    procedure csv2work(
        p_table_name    varchar2,
        p_line_buffer   varchar2,
        p_column_list   in out varchar2,
        p_value_list    in out varchar2
    )
    is
        l_column_count      number;
        l_csv_count         number;
        l_column_type       varchar2(4000);
        l_column_length     number;
        l_result            number;

        l_delimiter         varchar2(10) := '(.*?)(,|$)';
        l_pos               number := 1;
        l_value             varchar2(4000);
        l_sql               varchar2(4000);
    begin
        -- 切出項目数のチェック
        select count(*) into l_column_count from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('lineh', 'line1', 'line2', 'line3');
        l_csv_count := REGEXP_COUNT(p_line_buffer, ',') + 1;
        if l_column_count > l_csv_count THEN
            raise_application_error(-20001, 'データの項目数：' || l_csv_count || 'が、ワークテーブルの項目数：' || l_column_count || 'よりも少ないです。');
        end if;

        -- レコードを分解してワークに登録する
        l_pos := 1;
        for rec in (select column_name from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('lineh', 'line1', 'line2', 'line3') order by column_name)
        loop
            execute immediate 'begin :1 := fnc.get_column_info(:2, :3, :4, :5); end;'
            using out l_result, in p_table_name, in rec.column_name, out l_column_type, out l_column_length;
            l_value := regexp_substr(p_line_buffer, l_delimiter, 1, l_pos, null, 1);
            l_value := trim(rtrim(l_value, '　'));   -- 右空白（全角半角）のみ切捨る    ※不要なハズ
            l_pos := l_pos + 1;
            -- 数値カラムの対応
            if upper(trim(l_column_type)) = upper('number') then
                l_value := to_char(to_number(regexp_replace(l_value, '^0+-', '-')));
            end if;

            -- 空フィールドは null とする（文字列 'null' ではなく実際の null を使う場合）
            if l_value is null or l_value = '' then
                p_value_list := p_value_list || ', ' || 'null';
            else
                p_value_list := p_value_list || ', ' || '''' || l_value || '''';
            end if;

            p_column_list := p_column_list || ', ' || rec.column_name;
        end loop;

        -- 最後の余計なカンマを削除
        p_column_list := ltrim(p_column_list, ', ');
        p_value_list := ltrim(p_value_list, ', ');
        -- 登録処理
        l_sql := 'insert into ' || p_table_name || ' (' || p_column_list || ') values (' || p_value_list || ') ';
        $if $$debug $then
            l_sql := l_sql || 'log errors into err$_' || p_table_name || ' (''load'') reject limit unlimited';
        $end
        l_sql := upper(l_sql);
        -- edi_debug_log(l_sql);
        execute immediate l_sql;
    exception
        when no_data_found then
            raise_application_error(-20001, p_table_name || ' というテーブルはありません。');
        when others then
            raise;
    end csv2work;

	/*	Script		： 指定されたテーブルをcsvファイルとして出力する
		Author		： K.Sakamoto
		Parameters	： p_table_name     - ワークテーブル名
                    ： p_out_file       - 出力ファイル名
		Return		： なし
		DataWritten	： 2025/03/26
		Modified	：
	*/
    procedure work2csv(
        p_table_name    varchar2,
        p_out_file      varchar2
    )
    is
        v_file      utl_file.file_type;  -- 出力用ファイルのハンドル
        v_header    varchar2(32767);     -- ヘッダ文字列（列名をカンマ区切りに連結したもの）
        v_sql       varchar2(32767);     -- 動的sql文を保持する変数
        v_cursor    integer;             -- dbms_sql 用のカーソル番号
        v_col_cnt   number;              -- 定義するカラム数
        v_value     varchar2(4000);      -- 各カラムの値を受け取る変数
        v_line      varchar2(32767);     -- 各行のcsv文字列
        rec_tab     dbms_sql.desc_tab;
    begin

        -- ヘッダ行の作成：user_tab_columns から p_table_name のカラム名を取得
        for rec in (select column_name from user_tab_columns where table_name = p_table_name and lower(column_name) not in ('recno') order by column_name)
        loop
            if v_header is null then
                v_header := rec.column_name;
            else
                v_header := v_header || ',' || rec.column_name;
            end if;
        end loop;

        -- 出力先
        v_file := utl_file.fopen('your_dir', 'output.csv', 'w', 32767);
        -- ヘッダ行をファイルに出力
        utl_file.put_line(v_file, v_header);

        -- データ取得用の動的sql文を作成
        v_sql := 'select ' || v_header || ' from ' || p_table_name;
        v_cursor := dbms_sql.open_cursor;
        dbms_sql.parse(v_cursor, v_sql, dbms_sql.native);

        -- 結果セットのカラム数を取得し、各カラムを定義
        dbms_sql.describe_columns(v_cursor, v_col_cnt, rec_tab);
        for i in 1 .. v_col_cnt loop
        dbms_sql.define_column(v_cursor, i, v_value, 4000);
        end loop;

        -- ループして各行を取得し、csv形式の文字列に変換してファイルに書き込み
        while dbms_sql.fetch_rows(v_cursor) > 0 loop
            v_line := null;
            for i in 1 .. v_col_cnt loop
                dbms_sql.column_value(v_cursor, i, v_value);
                -- ★NULLデータの対応が必要
                if i > 1 then
                    v_line := v_line || ',' || v_value;
                else
                    v_line := v_value;
                end if;
            end loop;
            utl_file.put_line(v_file, v_line);
        end loop;

        -- カーソルとファイルをクローズ
        dbms_sql.close_cursor(v_cursor);
        utl_file.fclose(v_file);

    exception
        when others then
            if dbms_sql.is_open(v_cursor) then
            dbms_sql.close_cursor(v_cursor);
            end if;
            if utl_file.is_open(v_file) then
            utl_file.fclose(v_file);
            end if;
            raise;
    end work2csv;

	/*	Script		： EDI受信番号採番
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： EDI受信番号
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function edi_jyusin_no
    return number
    is
        l_edi_jyusin_no number;
        l_syori_date    m_kihon.syori_date%type;
    begin
        select seq_edi_jyusin_no.nextval into l_edi_jyusin_no from dual;
        select syori_date into l_syori_date from m_kihon where kanri_code = 0;
        l_edi_jyusin_no := l_syori_date * 100 + l_edi_jyusin_no;
        return l_edi_jyusin_no;

    exception
        when others then
            lib_edi.err_disp;
            return null;
    end edi_jyusin_no;

	/*	Script		： 受注番号採番
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： 受注番号
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function get_jyutyuno
    return number
    is
        l_cnt           number;
        l_jyutyu_no     number;
    begin
        loop
            -- 受注番号採番（取引番号単位）
            select seq_jyutyu_no.nextval into l_jyutyu_no from dual;
            -- 受注番号存在チェック
            select count(*) into l_cnt from d_jyutyu where jyutyu_no = l_jyutyu_no;
            if l_cnt = 0 then
                exit;
            end if;
        end loop;
        return l_jyutyu_no;

    exception
        when others then
            lib_edi.err_disp;
            return null;
    end get_jyutyuno;

	/*	Script		： 重複受注
		Author		： K.Sakamoto
		Parameters	： p_d_edi_jyutyu - EDI受注データ（共通）
		Return		： ture=重複有、false=重複無
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function is_duplicate_jyutyu(p_d_edi_jyutyu d_edi_jyutyu%rowtype)
    return boolean
    is
        l_exists NUMBER;
        l_result        boolean := true;
    begin
        /*
        with target_data as (
            -- 調査対象となるデータ
            select *
            from d_edi_jyutyu
            where
                edi_syori_id    = p_d_edi_jyutyu.edi_syori_id
            and edi_hatyu_no    = p_d_edi_jyutyu.edi_hatyu_no
            and edi_hatyu_date  = p_d_edi_jyutyu.edi_hatyu_date
            and edi_mise_code   = p_d_edi_jyutyu.edi_mise_code
            and edi_syohin_code = p_d_edi_jyutyu.edi_syohin_code
        ),
        jyotai_excluded as (
            -- 状態区分＝9（意図的に削除）のレコードは除く
            select jyutyu_no, jyutyu_gyo_no
            from d_edi_jyutyu
            where jyotai_kbn = 9
        ),
        jyusin_excluded as (
            -- 自身の受信分は除く
            select jyutyu_no, jyutyu_gyo_no
            from d_edi_jyutyu
            where edi_jyusin_no = p_d_edi_jyutyu.edi_jyusin_no
        )
        select case
            when exists (
                select 1
                from target_data d1
                where not exists (
                    select 1
                    from jyusin_excluded d3
                    where
                        d3.jyutyu_no = d1.jyutyu_no
                    and d3.jyutyu_gyo_no = d1.jyutyu_gyo_no
                )
                and not exists (
                    select 1
                    from jyotai_excluded d2
                    where
                        d2.jyutyu_no = d1.jyutyu_no
                    and d2.jyutyu_gyo_no = d1.jyutyu_gyo_no
                )
            )
            then 1
            else 0
        end ret
        into l_exists
        from dual;
        */
        select case
            when exists (
                select 1
                from        d_edi_jyutyu d1
                left join   d_edi_jyutyu d3 on  d3.jyutyu_no = d1.jyutyu_no
                                            and d3.jyutyu_gyo_no = d1.jyutyu_gyo_no
                                            and d3.edi_jyusin_no = p_d_edi_jyutyu.edi_jyusin_no
                left join   d_edi_jyutyu d2 on  d2.jyutyu_no = d1.jyutyu_no
                                            and d2.jyutyu_gyo_no = d1.jyutyu_gyo_no
                                            and d2.jyotai_kbn = 9
                where
                    d1.edi_syori_id    = p_d_edi_jyutyu.edi_syori_id
                and d1.edi_hatyu_no    = p_d_edi_jyutyu.edi_hatyu_no
                and d1.edi_hatyu_date  = p_d_edi_jyutyu.edi_hatyu_date
                and d1.edi_mise_code   = p_d_edi_jyutyu.edi_mise_code
                and d1.edi_syohin_code = p_d_edi_jyutyu.edi_syohin_code
                and d3.edi_jyusin_no is null    -- 自身の受信分は除く
                and d2.jyotai_kbn is null       -- 状態区分＝9（意図的に削除）のレコードは除く
            )
            then 1
            else 0
        end ret
        into l_exists
        from dual;

        if l_exists = 0 then
            l_result := false;
        end if;
        return l_result;

    exception
        when others then
            lib_edi.err_disp;
            return null;
    end is_duplicate_jyutyu;

	/*	Script		： 配送情報取得
					： 配送リードタイム計算区分と配送リードタイムを取得
		Author		： K.Sakamoto
		Parameters	： p_kyoten_code    - 拠点コード
					： p_tokui_code		- 得意先コード
                    ： p_mise_code      - 店コード
		Return		： 配送情報ﾚｺｰﾄﾞ型
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function get_lt_info (
        p_kyoten_code m_teisu.teisu_code%type,
        p_tokui_code  m_mise.tokui_code%type,
        p_mise_code   m_mise.mise_code%type
    ) return lt_info_t
    is
        -- 戻り値として利用するレコード型の変数を宣言
        l_lt_info lt_info_t;
    begin
        -- Oracle結合子の記載に修正必要か？
        -- 設定漏れチェックのためにINNER JOINにしている
        select
            m_mise.leadtime_keisan_kbn, -- 配送リードタイム計算区分（1＝暦日で計算、2＝当社営業日で計算、3＝土日祝日除外）
            m_teisu.teisu_1             -- 配送リードタイム
        into
            l_lt_info.leadtime_keisan_kbn,
            l_lt_info.lt
        from
                    m_mise
        inner join  m_meisyo on m_meisyo.meisyo_code = m_mise.leadtime_kbn
        inner join  m_teisu  on m_teisu.teisu_kbn  = m_meisyo.meisyo_code
        where
            m_mise.tokui_code   = p_tokui_code
        and m_mise.mise_code    = p_mise_code
        and m_meisyo.meisyo_kbn = 154   -- 固定値
        and m_teisu.teisu_code  = p_kyoten_code
        ;

        return l_lt_info;
    exception
        when no_data_found then
            l_lt_info.leadtime_keisan_kbn := -1;
            l_lt_info.lt := -1;
            return l_lt_info;
        when others then
            lib_edi.err_disp;
            return null;
    end get_lt_info;

	/*	Script		： エラーチェック
					： エラーチェックの共通箇所をチェックしてエラーの場合は規定値もセットする
		Author		： K.Sakamoto
		Parameters	： p_check_pattern_info - エラーチェックパターン情報
                    ： p_d_edi_jyutyu       - EDI受注データ（共通）
		Return		： なし
		DataWritten	： 2025/03/12
		Modified	：
	*/
    procedure error_check(
        p_check_pattern_info    in error_check_pattern_t ,
        p_d_edi_jyutyu          in out d_edi_jyutyu%rowtype
    )
    is
        l_m_kyoten          m_kyoten%rowtype;
        l_m_mise            m_mise%rowtype;
        l_m_syohin          m_syohin%rowtype;
        l_m_tokui           m_tokui%rowtype;
        l_m_tokui_okuri     m_tokui%rowtype;
        l_lt_ifo            lib_edi.lt_info_t;  -- 配送リードタイム情報

        l_cnt               number;
        l_flg               number;
    begin
            -- edi得意先　※取込時点チェック
            -- edi店
            /*
            ア）未登録の場合
            イ）終息フラグ＝1（終息）の場合
            ウ）閉店フラグ＝1（閉店）の場合
            */
            begin
                select * into l_m_mise from m_mise where m_mise.tokui_code = p_d_edi_jyutyu.edi_tokui_code and m_mise.mise_code = p_d_edi_jyutyu.edi_mise_code ;
                p_d_edi_jyutyu.edi_error_flg_1 := 0;
                if l_m_mise.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
                if l_m_mise.heiten_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                when others then
                    raise;
            end;

            -- 受注.得意先
            /*
            以下はエラー
            ア）未登録の場合
            イ）終息フラグ＝1（終息）の場合
            ウ）取引停止区分＝3（完全停止）の場合
            */
            begin
                select * into l_m_tokui from m_tokui where m_tokui.tokui_code = p_d_edi_jyutyu.tokui_code;
                p_d_edi_jyutyu.edi_error_flg_5 := 0;
                if l_m_tokui.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                end if;
                if l_m_tokui.torihiki_teisi_kbn = 3 then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                when others then
                    raise;
            end;
            if p_d_edi_jyutyu.edi_error_flg_5 = 0 then
                p_d_edi_jyutyu.torihiki_jyoken_kbn  := l_m_tokui.torihiki_jyoken_kbn;
                p_d_edi_jyutyu.syohizei_kbn         := l_m_tokui.syohizei_kbn;
            else
                p_d_edi_jyutyu.torihiki_jyoken_kbn  := null;
                p_d_edi_jyutyu.syohizei_kbn         := null;
            end if;

            -- 受注.店
            /*
            ア）未登録の場合
            イ）終息フラグ＝1（終息）の場合
            ウ）閉店フラグ＝1（閉店）の場合
            */
            begin
                select * into l_m_mise from m_mise where m_mise.tokui_code = p_d_edi_jyutyu.tokui_code and m_mise.mise_code = p_d_edi_jyutyu.mise_code ;
                p_d_edi_jyutyu.edi_error_flg_1 := 0;
                if l_m_mise.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
                if l_m_mise.heiten_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_1 := 1;
                when others then
                    raise;
            end;

            -- 得意先（送り得意先参照）
            /*
            以下はエラー
            ア）未登録の場合
            イ）終息フラグ＝1（終息）の場合
            ウ）取引停止区分＝3（完全停止）の場合
            */
            begin
                select * into l_m_tokui from m_tokui where m_tokui.tokui_code = p_d_edi_jyutyu.okuri_tokui_code;
                p_d_edi_jyutyu.edi_error_flg_2 := 0;
                if l_m_tokui.syusoku_flg = 1 then
                    p_d_edi_jyutyu.edi_error_flg_2 := 1;
                end if;
                if l_m_tokui.torihiki_teisi_kbn = 3 then
                    p_d_edi_jyutyu.edi_error_flg_2 := 1;
                end if;
            exception
                when no_data_found then
                    p_d_edi_jyutyu.edi_error_flg_2 := 1;
                when others then
                    raise;
            end;
            if p_d_edi_jyutyu.edi_error_flg_2 = 0 then
                p_d_edi_jyutyu.okuri_tokui_mei := l_m_tokui.tokui_mei_syagai;
            else
                p_d_edi_jyutyu.okuri_tokui_mei := null;
            end if;

            -- 店チェック（送り先）
            /*
            ア）未登録の場合
            イ）終息フラグ＝1（終息）の場合
            ウ）閉店フラグ＝1（閉店）の場合
            */
            if p_d_edi_jyutyu.edi_error_flg_2 = 0 then
                begin
                    select * into l_m_mise from m_mise where m_mise.tokui_code = p_d_edi_jyutyu.okuri_tokui_code and m_mise.mise_code = p_d_edi_jyutyu.okuri_mise_code ;
                    p_d_edi_jyutyu.edi_error_flg_2 := 0;
                    if l_m_mise.syusoku_flg = 1 then
                        p_d_edi_jyutyu.edi_error_flg_2 := 1;
                    end if;
                    if l_m_mise.heiten_flg = 1 then
                        p_d_edi_jyutyu.edi_error_flg_2 := 1;
                    end if;
                exception
                    when no_data_found then
                        p_d_edi_jyutyu.edi_error_flg_2 := 1;
                    when others then
                        raise;
                end;
            end if;
            -- 送り先が取得出来た場合はマスターからの項目セット（未取得の時はnullでリセット）
            if p_d_edi_jyutyu.edi_error_flg_2 = 0 then
                p_d_edi_jyutyu.kobetu_haiso_flg     := l_m_mise.kobetu_haiso_flg ;
                p_d_edi_jyutyu.yubin_no             := l_m_mise.yubin_no         ;
                p_d_edi_jyutyu.jyusyo1              := l_m_mise.jyusyo1          ;
                p_d_edi_jyutyu.jyusyo2              := l_m_mise.jyusyo2          ;
                p_d_edi_jyutyu.jyusyo3              := l_m_mise.jyusyo3          ;
                p_d_edi_jyutyu.okuri_mei1           := l_m_mise.okuri_mei1       ;
                p_d_edi_jyutyu.okuri_mei2           := l_m_mise.okuri_mei2       ;
                p_d_edi_jyutyu.tel_no               := l_m_mise.tel_no           ;
                p_d_edi_jyutyu.unso_code            := l_m_mise.unso_code        ;
                p_d_edi_jyutyu.tyakuten_code        := l_m_mise.tyakuten_code    ;
                p_d_edi_jyutyu.tyakuten_tome_flg    := l_m_mise.tyakuten_tome_flg;
                p_d_edi_jyutyu.niokurinin_code      := l_m_mise.niokurinin_code  ;
            else
                p_d_edi_jyutyu.kobetu_haiso_flg     := null;
                p_d_edi_jyutyu.yubin_no             := null;
                p_d_edi_jyutyu.jyusyo1              := null;
                p_d_edi_jyutyu.jyusyo2              := null;
                p_d_edi_jyutyu.jyusyo3              := null;
                p_d_edi_jyutyu.okuri_mei1           := null;
                p_d_edi_jyutyu.okuri_mei2           := null;
                p_d_edi_jyutyu.tel_no               := null;
                p_d_edi_jyutyu.unso_code            := null;
                p_d_edi_jyutyu.tyakuten_code        := null;
                p_d_edi_jyutyu.tyakuten_tome_flg    := null;
                p_d_edi_jyutyu.niokurinin_code      := null;
            end if;

            -- ③商品チェック
            begin
                select
                    m_syohin.* into l_m_syohin
                from
                            m_gtin
                inner join  m_syohin    on  m_syohin.sku_code = m_gtin.sku_code
                where
                    m_gtin.gtin_code = p_d_edi_jyutyu.edi_syohin_code
                and m_gtin.code_kbn = 1
                ;
                p_d_edi_jyutyu.edi_error_flg_3 := 0;
            exception
                when no_data_found then
                    begin
                        select m_syohin.* into l_m_syohin
                        from m_syohin
                        where m_syohin.sku_code = (
                            select sku_code
                            from (
                                select m_aite_hinban.sku_code
                                from m_aite_hinban
                                where m_aite_hinban.tokui_code = p_d_edi_jyutyu.okuri_tokui_code
                                and m_aite_hinban.syohin_code = p_d_edi_jyutyu.edi_syohin_code
                                order by m_aite_hinban.touroku_date
                            ) where rownum = 1
                        )
                        ;
                        p_d_edi_jyutyu.edi_error_flg_3 := 0;
                    exception
                        when no_data_found THEN
                            p_d_edi_jyutyu.edi_error_flg_3 := 1;
                    when others then
                        fnc.disp_out('商品読み込みエラー：' || p_d_edi_jyutyu.edi_syohin_code);
                        raise;
                    end;
                when others then
                    raise;
            end;
            -- 商品マスタからのセット
            if p_d_edi_jyutyu.edi_error_flg_3 = 0 then
                p_d_edi_jyutyu.syohin_code          := l_m_syohin.syohin_code       ;
                p_d_edi_jyutyu.iro_no               := l_m_syohin.iro_no            ;
                p_d_edi_jyutyu.sku_code             := l_m_syohin.sku_code          ;
                p_d_edi_jyutyu.hin_ban              := l_m_syohin.hin_ban           ;
                p_d_edi_jyutyu.hin_mei              := l_m_syohin.hin_mei           ;
                p_d_edi_jyutyu.iro_mei              := l_m_syohin.iro_mei           ;
                p_d_edi_jyutyu.size_mei             := l_m_syohin.size_mei          ;
                p_d_edi_jyutyu.genka_tanka          := l_m_syohin.hyojyun_genka     ;
                p_d_edi_jyutyu.syokuti_syohin_flg   := l_m_syohin.syokuti_flg;
                p_d_edi_jyutyu.suryo_keisan_flg     := l_m_syohin.suryo_keisan_flg  ;
                p_d_edi_jyutyu.kingaku_keisan_flg   := l_m_syohin.kingaku_keisan_flg;
                p_d_edi_jyutyu.arari_keisan_flg     := l_m_syohin.arari_keisan_flg  ;
                p_d_edi_jyutyu.hako_keisan_flg      := l_m_syohin.hako_keisan_flg   ;
                p_d_edi_jyutyu.kenpin_taisyo_flg    := l_m_syohin.kenpin_taisyo_flg ;
            else
                p_d_edi_jyutyu.syohin_code          := null;
                p_d_edi_jyutyu.iro_no               := null;
                p_d_edi_jyutyu.sku_code             := null;
                p_d_edi_jyutyu.hin_ban              := null;
                p_d_edi_jyutyu.hin_mei              := null;
                p_d_edi_jyutyu.iro_mei              := null;
                p_d_edi_jyutyu.size_mei             := null;
                p_d_edi_jyutyu.genka_tanka          := null;
                p_d_edi_jyutyu.syokuti_syohin_flg   := null;
                p_d_edi_jyutyu.suryo_keisan_flg     := null;
                p_d_edi_jyutyu.kingaku_keisan_flg   := null;
                p_d_edi_jyutyu.arari_keisan_flg     := null;
                p_d_edi_jyutyu.hako_keisan_flg      := null;
                p_d_edi_jyutyu.kenpin_taisyo_flg    := null;
            end if;

            -- 単価チェック
            if nvl(p_d_edi_jyutyu.tanka,0) > 0 then
                p_d_edi_jyutyu.edi_error_flg_4 := 0;
            else
                p_d_edi_jyutyu.edi_error_flg_4 := 1;
            end if;

            -- その他チェック

            -- 拠点
            p_d_edi_jyutyu.kyoten_code := p_d_edi_jyutyu.edi_kyoten_code;   -- 拠点コード　※単一拠点パターン
            if p_d_edi_jyutyu.kyoten_code = 0 then
                begin
                    select * into l_m_kyoten from m_kyoten where m_kyoten.kyoten_code = p_d_edi_jyutyu.kyoten_code;
                    /*
                    以下はエラー
                    ア）未登録の場合
                    イ）拠点区分＝1（出荷拠点）以外の場合
                    ウ）在庫管理フラグ＝1（在庫管理する）以外の場合
                    エ）wms 稼働区分＝3（物流センターシステム導入拠点）以外の場合
                    */
                    -- 先にチェックしている p_d_edi_jyutyu.edi_error_flg_5 をクリアしないため別変数にて判定する
                    l_flg := 0;
                    if l_m_kyoten.kyoten_kbn <> 1 then
                        l_flg := 1;
                    end if;
                    if l_m_kyoten.zaiko_kanri_flg <> 1 then
                        l_flg := 1;
                    end if;
                    if l_m_kyoten.wms_kadou_kbn <> 3 then
                        l_flg := 1;
                    end if;
                exception
                    when no_data_found then
                        l_flg := 1;
                    when others then
                        raise;
                end;
                if l_flg = 0 then
                    p_d_edi_jyutyu.kyoten_code := l_m_kyoten.kyoten_code;
                else
                    p_d_edi_jyutyu.kyoten_code := l_m_kyoten.kyoten_code;   -- クリアせずセットしておく
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
                end if;
            end if;

            -- EDI配送日数
            l_lt_ifo := lib_edi.get_lt_info(p_d_edi_jyutyu.kyoten_code, p_d_edi_jyutyu.okuri_tokui_code, p_d_edi_jyutyu.okuri_mise_code);
            p_d_edi_jyutyu.EDI_HAISO_NISSU := l_lt_ifo.lt;
            if p_d_edi_jyutyu.EDI_HAISO_NISSU = -1 then
                    p_d_edi_jyutyu.edi_error_flg_5 := 1;
            end if;

    exception
        when others then
            lib_edi.err_disp;
    end error_check;

	/*	Script		： ワーニングチェック
					： ワーニングチェックの共通箇所をチェックする
		Author		： K.Sakamoto
		Parameters	： p_d_edi_jyutyu - EDI受注データ（共通）　※ByRef
		Return		： なし
		DataWritten	： 2025/03/12
		Modified	：
	*/
    procedure warning_check(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype)
    is
    begin
            -- 重複チェック
            if is_duplicate_jyutyu(p_d_edi_jyutyu) then
                p_d_edi_jyutyu.edi_keikoku_flg_1 := 1;
            else
                p_d_edi_jyutyu.edi_keikoku_flg_1 := 0;
            end if;

            -- 日付チェック
                p_d_edi_jyutyu.edi_keikoku_flg_2 := 0;

                p_d_edi_jyutyu.edi_keikoku_flg_3 := 0;

            -- 単価チェック
            if nvl(p_d_edi_jyutyu.edi_tanka,0) = nvl(p_d_edi_jyutyu.genka_tanka,0) then
                p_d_edi_jyutyu.edi_keikoku_flg_4 := 0;
            else
                p_d_edi_jyutyu.edi_keikoku_flg_4 := 1;
            end if;

            -- その他チェック
                p_d_edi_jyutyu.edi_keikoku_flg_5 := 0;

    exception
        when others then
            lib_edi.err_disp;
    end warning_check;

	/*	Script		： その他項目の編集
					： どこまで共通で転送出来るのかは不明
                    ： 例：各種相手区分は共通仕様では a～i まであるが、山新などは、a,bのみ転送なので最低限を転記
		Author		： K.Sakamoto
		Parameters	： p_d_edi_jyutyu - EDI受注データ（共通）　※ByRef
		Return		： なし
		DataWritten	： 2025/03/12
		Modified	：
	*/
    procedure set_others_item(p_d_edi_jyutyu in out d_edi_jyutyu%rowtype)
    is
        l_jis_code      m_yubin.jis_code%type;  -- 全国地方公共団体コード（全国地方公共団体コード）※※共通
    begin
        -- 流通加工区分１   流通加工M.同名項目（送り先の得意先コード＋商品コードにて参照）
        begin
            select ryutu_kako_kbn1 into p_d_edi_jyutyu.ryutu_kako_kbn1 from m_ryutu_kako where tokui_code = p_d_edi_jyutyu.okuri_tokui_code and syohin_code = p_d_edi_jyutyu.syohin_code;
        exception
            when no_data_found then
                p_d_edi_jyutyu.ryutu_kako_kbn1 := null;
            when others then
                raise;
        end;
        -- 郵便番号M参照
        begin
            select jis_code into l_jis_code from m_yubin where yubin_no = p_d_edi_jyutyu.yubin_no;
            p_d_edi_jyutyu.todofuken_code := substrb(l_jis_code, 1, 2);    -- 都道府県コード   郵便番号M.全国地方公共団体コードの先頭2バイト
            p_d_edi_jyutyu.sikutyoson_code := l_jis_code;                  -- 市区町村コード   郵便番号M.全国地方公共団体コード
        exception
            when no_data_found then
                 l_jis_code:= null;
            when others then
                raise;
        end;

        -- 相手伝票区分名   相手名称M.名称1（名称区分＝004）※相手伝票区分<>NULLの場合
        if p_d_edi_jyutyu.aite_denpyo_kbn is not null then
            begin
                select meisyo_1 into p_d_edi_jyutyu.aite_denpyo_kbn_mei from m_aite_meisyo where tokui_code = p_d_edi_jyutyu.okuri_tokui_code and meisyo_kbn = '004';
            exception
                when no_data_found then
                    p_d_edi_jyutyu.aite_denpyo_kbn_mei := null;
                when others then
                    raise;
            end;
        end if;

        --相手部門名        相手名称M.名称1（名称区分＝003）※相手部門コード<>NULLの場合
        if p_d_edi_jyutyu.AITE_BUMON_CODE is not null then
            begin
                select meisyo_1 into p_d_edi_jyutyu.aite_bumon_mei from m_aite_meisyo where tokui_code = p_d_edi_jyutyu.okuri_tokui_code and meisyo_kbn = '003';
            exception
                when no_data_found then
                    null;
                when others then
                    raise;
            end;
        end if;
    exception
        when others then
            lib_edi.err_disp;
    end set_others_item;

	/*	Script		： EDI系のパッケージでエラーが発生した時のデバッグ表示
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： なし
		DataWritten	： 2025/03/26
		Modified	：
	*/
    procedure err_disp
    is
        v_error_message     varchar2(4000);
        v_error_stack       varchar2(4000);
        v_error_backtrace   varchar2(4000);
    begin
            -- エラー情報をグローバル変数にセット
            v_error_message := sqlerrm;
            v_error_stack := dbms_utility.format_error_stack;
            v_error_backtrace := dbms_utility.format_error_backtrace;
            -- エラー情報を出力
            -- fnc.disp_out('エラー: ' || v_error_message);
            fnc.disp_out('エラースタック: ' || v_error_stack);
            fnc.disp_out('エラー発生元: ' || v_error_backtrace);
            edi_debug_log('エラースタック: ' || v_error_stack);
            edi_debug_log('エラー発生元: ' || v_error_backtrace);
    end err_disp;

end lib_edi;
/
