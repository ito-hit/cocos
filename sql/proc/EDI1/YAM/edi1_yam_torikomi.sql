create or replace package edi1_yam_torikomi is
    function main (
        p_filename in varchar2,
        p_edi_kyoten_code in number,
        p_edi_tokui_code in number,
        p_entry_user_id in varchar2,
        p_user_id in varchar2,
        p_client_id in varchar2
    ) return number;

    function load (
        p_filename in varchar2
    ) return number;

    function ext (
        p_edi_kyoten_code in number,
        p_edi_tokui_code in number,
        p_entry_user_id in varchar2,
        p_user_id in varchar2,
        p_client_id in varchar2,
        o_edi_jyusin_no out number
    ) return number;

    function check_update (
        p_edi_jyusin_no in number ,
        p_edi_rec_no in number default 0,
        p_user_id in varchar2,
        p_client_id in varchar2
    ) return number;
end edi1_yam_torikomi;
/
create or replace package body edi1_yam_torikomi is
	/*	Script		： 発注ファイル取込メイン
					： 呼出用
		Author		： K.Sakamoto
		Parameters	： p_filename           - 取込ファイル名
                    ： p_edi_kyoten_code    - EDI拠点コード
					： p_edi_tokui_code     - EDI得意先コード
					： p_entry_user_id      - 処理者コード
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（-1：異常、0：正常）
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function main (
        p_filename in varchar2,
        p_edi_kyoten_code in number,
        p_edi_tokui_code in number,
        p_entry_user_id in varchar2,
        p_user_id in varchar2,
        p_client_id in varchar2
    ) return number
    is
        l_result            number;
        l_edi_jyusin_no     d_edi_jyutyu_yam.edi_jyusin_no%type;
    begin
        l_result := load(p_filename);
        if l_result = 0 then
            return -1;
        end if;

        l_result := ext(p_edi_kyoten_code, p_edi_tokui_code, p_entry_user_id, p_user_id, p_client_id, l_edi_jyusin_no);
        if l_result = 0 then
            return -1;
        end if;

        l_result := check_update(l_edi_jyusin_no, 0, p_user_id, p_client_id);
        if l_result = 0 then
            return -1;
        end if;

        return 0;
    end main;

	/*	Script		： 発注ファイル取込
					：
		Author		： K.Sakamoto
		Parameters	： p_filename   - 取込ファイル名
		Return		： 成否判定（-1：異常、0：正常）
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function load (
        p_filename in varchar2
    ) return number
    is
        file_handle      utl_file.file_type;
        max_line_length     number := 32767;
        l_line_buffer       varchar2(32767);
        l_table_name        varchar2(30);
        l_column_list       varchar2(4000);
        l_value_list        varchar2(4000);

        l_line_number       number := 0;
        l_lineh             w_edi_yam_jyutyu_h.lineh%type;
        l_line1             w_edi_yam_jyutyu_a.line1%type;
        l_line2             w_edi_yam_jyutyu_b.line2%type;
        l_line3             w_edi_yam_jyutyu_c.line3%type;
    begin
        -- ファイルを開く
        begin
            file_handle := utl_file.fopen(upper('ccs_rcv_dir'), p_filename, 'r', max_line_length);
        exception
            when utl_file.invalid_path then
                fnc.disp_out('err: invalid file path.');
                return -1;
            when utl_file.invalid_mode then
                fnc.disp_out('err: invalid file open mode.');
                return -1;
            when utl_file.invalid_operation then
                fnc.disp_out('err: invalid file operation.');
                return -1;   -- ファイルが無くても正常として処理を終了する
            when others then
                fnc.disp_out('err: ' || sqlerrm);
                return -1;
        end;

        $if $$debug $then
        -- エラーログテーブルの作成
        begin
            begin
                l_table_name := upper('w_edi_yam_jyutyu_h');
                execute immediate 'begin dbms_errlog.create_error_log(dml_table_name => ''' || l_table_name || '''); end;';
                l_table_name := upper('w_edi_yam_jyutyu_a');
                execute immediate 'begin dbms_errlog.create_error_log(dml_table_name => ''' || l_table_name || '''); end;';
                l_table_name := upper('w_edi_yam_jyutyu_b');
                execute immediate 'begin dbms_errlog.create_error_log(dml_table_name => ''' || l_table_name || '''); end;';
                l_table_name := upper('w_edi_yam_jyutyu_c');
                execute immediate 'begin dbms_errlog.create_error_log(dml_table_name => ''' || l_table_name || '''); end;';
            exception
                when others then
                    -- ora-00955: 名称が既存オブジェクトと重複している場合は無視
                    if sqlcode != -955 then
                        raise;
                    end if;
            end;
        end;
        $end

        -- ファイルを1行ずつ処理する
        l_lineh := 0;
        l_line1 := 0;
        l_line_number := 0;
        loop
            begin
                utl_file.get_line(file_handle, l_line_buffer, max_line_length);
            exception
                when no_data_found then
                    exit;
            end;

            -- 行カウンタアップ
            l_line_number := l_line_number + 1;

            -- 識別子判定
            case lower(substr(l_line_buffer, 1, 1))
            when 'h' then
                l_table_name := upper('w_edi_yam_jyutyu_h');
                l_lineh := l_lineh + 1;
                l_line2 := 0;
                l_line3 := 0;
                l_column_list := 'lineh';
                l_value_list := l_lineh;
            when 'a' then
                l_table_name := upper('w_edi_yam_jyutyu_a');
                l_line1 := l_line1 + 1;
                l_line2 := 0;
                l_line3 := 0;
                l_column_list := 'line1';
                l_value_list := l_line1;
            when 'b' then
                l_table_name := upper('w_edi_yam_jyutyu_b');
                l_line2 := l_line2 + 1;
                l_line3 := 0;
                l_column_list := 'line1, line2';
                l_value_list := l_line1 || ',' || l_line2;
            when 'c' then
                l_table_name := upper('w_edi_yam_jyutyu_c');
                l_line3 := l_line3 + 1;
                l_column_list := 'line1, line2, line3';
                l_value_list := l_line1 || ',' || l_line2 || ',' || l_line3;
            else
                l_column_list := '';
                l_value_list := '';
                continue;
            end case;

            -- CSVデータをワークに投入
            lib_edi.csv2work(l_table_name, l_line_buffer, l_column_list, l_value_list);
        end loop;

        utl_file.fclose(file_handle);

        -- 行カウンタが0の時はエラーとする
        if l_line_number > 0 THEN
            return 0;
        else
            return -1;
        end if;

    exception
        when others then
            if utl_file.is_open(file_handle) then
                utl_file.fclose(file_handle);
            end if;
            lib_edi.err_disp;
            return -1;
    end load;

	/*	Script		： 取込時展開処理
					：
		Author		： K.Sakamoto
		Parameters	： p_edi_kyoten_code    - EDI拠点コード
					： p_edi_tokui_code     - EDI得意先コード
					： p_entry_user_id      - 処理者コード
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
					： o_edi_jyusin_no      - EDI受信番号（OUT）
		Return		： 成否判定（-1：異常、0：正常）
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function ext (
        p_edi_kyoten_code in number,
        p_edi_tokui_code in number,
        p_entry_user_id in varchar2,
        p_user_id in varchar2,
        p_client_id in varchar2,
        o_edi_jyusin_no out number
    ) return number
    is
        l_pg_id             d_edi_jyutyu.touroku_pg_id%type := 'edi1_yam_torikomi.ext';

        -- 受注番号（取引番号毎）の採番単位カーソル
        cursor cur_h(v_edi_jyusin_no d_edi_jyutyu_yam.edi_jyusin_no%type) is
        select  datb002
          from  d_edi_jyutyu_yam
         where  edi_jyusin_no = v_edi_jyusin_no
        group by
                datb002
        ;
        -- 共通を作成する為の明細カーソル
        cursor cur_m(v_edi_jyusin_no d_edi_jyutyu_yam.edi_jyusin_no%type, v_datb002 d_edi_jyutyu_yam.datb002%type) is
        select
                to_number(to_char(sysdate, 'yyyymmdd')) jyutyu_date,
                to_number(to_char(sysdate, 'hh24miss')) jyutyu_time,
                d_edi_jyutyu_yam.*
          from  d_edi_jyutyu_yam
         where  d_edi_jyutyu_yam.edi_jyusin_no = v_edi_jyusin_no
           and  d_edi_jyutyu_yam.datb002 = v_datb002
        order by
            edi_rec_no
        ;

        cur                     sys_refcursor;
        l_d_edi_jyutyu_yam      d_edi_jyutyu_yam%ROWTYPE;

        l_syori_date            m_kihon.syori_date%type;
        l_m_tanto               m_tanto%rowtype;            -- 担当者マスタ
        l_m_edi_kanri           m_edi_kanri%rowtype;        -- edi管理マスタ
        l_d_edi_jyutyu          d_edi_jyutyu%rowtype;       -- edi受注データ（共通）
        l_m_tokui               m_tokui%rowtype;            -- 得意先マスタ
        l_edi_jyusin_date       d_edi_jyutyu.edi_jyusin_date%type;  -- edi受信日

        l_column_list_h     varchar2(4000);
        l_column_list_a     varchar2(4000);
        l_column_list_b     varchar2(4000);
        l_column_list_c     varchar2(4000);
        l_sql               clob;
        idx                 integer;
        l_cnt               number;
    begin
        -- 入力者名
        select * into l_m_tanto from m_tanto where tanto_code = p_entry_user_id;

        -- 受信番号を採番する
        o_edi_jyusin_no := lib_edi.edi_jyusin_no;

        -- edi管理マスタ取得
        select * into l_m_edi_kanri from m_edi_kanri where edi_tokui_code = p_edi_tokui_code;

        -- edi受信日
        select to_number(to_char(sysdate, 'yyyymmdd')) into l_edi_jyusin_date from dual;

        -- ユーザーidと端末id
        l_d_edi_jyutyu.touroku_user_id := nvl(p_user_id, lib_edi.get_userid);
        l_d_edi_jyutyu.touroku_client_id := nvl(p_client_id, lib_edi.get_clientid);
        l_d_edi_jyutyu.touroku_pg_id := 'edi1_yam_torikomi.ext';

        -- hのカラムリストを動的に作成
        for idx in 1..16 loop
            if idx > 1 then
                l_column_list_h := l_column_list_h || ', ';
            end if;
            l_column_list_h := l_column_list_h || 'dath' || to_char(idx, 'fm000');
        end loop;

        -- aのカラムリストを動的に作成
        for idx in 1..7 loop
            if idx > 1 then
                l_column_list_a := l_column_list_a || ', ';
            end if;
            l_column_list_a := l_column_list_a || 'data' || to_char(idx, 'fm000');
        end loop;

        -- bのカラムリストを動的に作成
        for idx in 1..69 loop
            if idx > 1 then
                l_column_list_b := l_column_list_b || ', ';
            end if;
            l_column_list_b := l_column_list_b || 'datb' || to_char(idx, 'fm000');
        end loop;

        -- cのカラムリストを動的に作成
        for idx in 1..56 loop
            if idx > 1 then
                l_column_list_c := l_column_list_c || ', ';
            end if;
            l_column_list_c := l_column_list_c || 'datc' || to_char(idx, 'fm000');
        end loop;

        -- 動的sqlを生成
        l_sql := '
            select
                :1      edi_kyoten_code,
                :2      edi_jyusin_no,
                :3      edi_jyusin_date,
                :4      edi_tokui_code,
                0       edi_rec_no,
                ' || replace(l_column_list_h, 'dath', 'w_edi_yam_jyutyu_h.dath') || ',
                ' || replace(l_column_list_a, 'data', 'w_edi_yam_jyutyu_a.data') || ',
                ' || replace(l_column_list_b, 'datb', 'w_edi_yam_jyutyu_b.datb') || ',
                ' || replace(l_column_list_c, 'datc', 'w_edi_yam_jyutyu_c.datc') || ',
                1       jyotai_kbn,     -- 受信済        ※エラーになった状態でも受信済
                sysdate touroku_date,
                :5      touroku_user_id,
                :6      touroku_client_id,
                :7      touroku_pg_id,
                null    henkou_date,
                null    henkou_user_id,
                null    henkou_client_id,
                null    henkou_pg_id,
                null    kousin_date,
                null    kousin_user_id,
                null    kousin_client_id,
                null    kousin_pg_id,
                0       haita_flg      -- 排他フラグ
            from
                        w_edi_yam_jyutyu_h
            left join   w_edi_yam_jyutyu_a  on  w_edi_yam_jyutyu_a.line1 = w_edi_yam_jyutyu_h.lineh
            left join   w_edi_yam_jyutyu_b  on  w_edi_yam_jyutyu_b.line1 = w_edi_yam_jyutyu_a.line1
            left join   w_edi_yam_jyutyu_c  on  w_edi_yam_jyutyu_c.line1 = w_edi_yam_jyutyu_a.line1
                                            and w_edi_yam_jyutyu_c.line2 = w_edi_yam_jyutyu_b.line2
            order by
                w_edi_yam_jyutyu_h.lineh,
                w_edi_yam_jyutyu_a.line1,
                w_edi_yam_jyutyu_b.line2,
                w_edi_yam_jyutyu_c.line3
        ';
        $if $$debug $then
            lib_edi.edi_debug_log('生成されてたSQL文');
            lib_edi.edi_debug_log(l_sql);
        $end

        open cur for l_sql using
                p_edi_kyoten_code,
                o_edi_jyusin_no,
                l_edi_jyusin_date,
                p_edi_tokui_code,
                l_d_edi_jyutyu.touroku_user_id,
                l_d_edi_jyutyu.touroku_client_id,
                l_d_edi_jyutyu.touroku_pg_id;
        loop
            fetch cur into l_d_edi_jyutyu_yam;
            exit when cur%notfound;
            l_d_edi_jyutyu_yam.edi_rec_no := seq_edi_rec_no.nextval;
            insert into d_edi_jyutyu_yam values l_d_edi_jyutyu_yam;
            lib_edi.edi_debug_log('d_edi_jyutyu_yamへデータを投入');
        end loop;

        -- 受注番号を採番しながらedi受注データ（共通）を作成する（エラーチェック前）
        for rec in cur_h(o_edi_jyusin_no) loop
            l_d_edi_jyutyu.jyutyu_no := lib_edi.get_jyutyuno;
            l_d_edi_jyutyu.jyutyu_gyo_no := 0;

            for rec_m in cur_m(o_edi_jyusin_no, rec.datb002) loop
                l_d_edi_jyutyu.edi_kyoten_code          := p_edi_kyoten_code;                           -- edi拠点コード
                l_d_edi_jyutyu.edi_jyusin_no            := o_edi_jyusin_no;                             -- edi受信番号
                l_d_edi_jyutyu.edi_jyusin_date          := l_edi_jyusin_date;                           -- edi受信日
                l_d_edi_jyutyu.edi_tokui_code           := p_edi_tokui_code;                            -- edi得意先コード
                l_d_edi_jyutyu.edi_syori_id             := l_m_edi_kanri.edi_syori_id;                  -- edi処理id
                l_d_edi_jyutyu.edi_konpo_kbn            := 2;                                           -- edi梱包区分
                l_d_edi_jyutyu.edi_nohin_kbn            := 2;                                           -- edi納品区分
                l_d_edi_jyutyu.edi_hatyu_no             := rec_m.datb002;                               -- edi発注番号
                l_d_edi_jyutyu.edi_hatyu_date           := rec_m.datb042;                               -- edi発注日
                l_d_edi_jyutyu.edi_nohin_sitei_date     := rec_m.datb044;                               -- edi納品指定日
                l_d_edi_jyutyu.edi_mise_code            := rec_m.datb008;                               -- edi店コード
                l_d_edi_jyutyu.edi_mise_mei             := rec_m.datb010;                               -- edi店名
                l_d_edi_jyutyu.edi_okuri_mise_code      := 0;                                           -- edi送り店コード
                l_d_edi_jyutyu.edi_okuri_mise_mei       := null;                                        -- edi送り店名
                l_d_edi_jyutyu.edi_syohin_code          := rec_m.datc011;                               -- edi商品コード
                l_d_edi_jyutyu.edi_syohin_mei           := rec_m.datc014;                               -- edi商品名
                l_d_edi_jyutyu.edi_syohin_kikaku        := rec_m.datc016;                               -- edi商品規格
                l_d_edi_jyutyu.edi_hatyu_su             := rec_m.datc048;                               -- edi発注数量
                l_d_edi_jyutyu.edi_tanka                := rec_m.datc043;                               -- edi原単価
                l_d_edi_jyutyu.edi_baika                := rec_m.datc045;                               -- edi売単価
                l_d_edi_jyutyu.edi_reserve_kbn          := 1;                                           -- ediリザーブ区分
                l_d_edi_jyutyu.edi_genbutu_kbn          := 1;                                           -- edi現物引当区分
                l_d_edi_jyutyu.edi_jyutyuzan_kbn        := 2;                                           -- edi受注残引当区分
                l_d_edi_jyutyu.edi_error_flg_1          := 1;                                           -- ediエラーフラグ1
                l_d_edi_jyutyu.edi_error_flg_2          := 1;                                           -- ediエラーフラグ2
                l_d_edi_jyutyu.edi_error_flg_3          := 1;                                           -- ediエラーフラグ3
                l_d_edi_jyutyu.edi_error_flg_4          := 1;                                           -- ediエラーフラグ4
                l_d_edi_jyutyu.edi_error_flg_5          := 1;                                           -- ediエラーフラグ5
                l_d_edi_jyutyu.edi_keikoku_flg_1        := 1;                                           -- edi警告フラグ1
                l_d_edi_jyutyu.edi_keikoku_flg_2        := 1;                                           -- edi警告フラグ2
                l_d_edi_jyutyu.edi_keikoku_flg_3        := 1;                                           -- edi警告フラグ3
                l_d_edi_jyutyu.edi_keikoku_flg_4        := 1;                                           -- edi警告フラグ4
                l_d_edi_jyutyu.edi_keikoku_flg_5        := 1;                                           -- edi警告フラグ5
                                                                                                        -- 受注番号(外ループでセット済)
                l_d_edi_jyutyu.jyutyu_date              := rec_m.jyutyu_date;                           -- 受注日付
                l_d_edi_jyutyu.jyutyu_time              := rec_m.jyutyu_time;                           -- 受注時刻
                l_d_edi_jyutyu.jyutyu_houhou            := 2;                                           -- 受注方法
                l_d_edi_jyutyu.jyusin_no                := l_d_edi_jyutyu.edi_jyusin_no;                -- 受信番号
                l_d_edi_jyutyu.entry_user_id            := p_entry_user_id;                             -- 入力者コード
                l_d_edi_jyutyu.entry_user_mei           := l_m_tanto.tanto_mei;                         -- 入力者名
                l_d_edi_jyutyu.tokui_code               := l_d_edi_jyutyu.edi_tokui_code;               -- 得意先コード
                l_d_edi_jyutyu.mise_code                := l_d_edi_jyutyu.edi_mise_code;                -- 店コード
                l_d_edi_jyutyu.denpyo_syubetu           := 1;                                           -- 伝票種別
                l_d_edi_jyutyu.syukka_kbn               := 1;                                           -- 出荷区分
                l_d_edi_jyutyu.syukka_houhou            := 1;                                           -- 出荷方法
                l_d_edi_jyutyu.jyutyu_gyo_no            := l_d_edi_jyutyu.jyutyu_gyo_no + 1;            -- 受注行番号
                l_d_edi_jyutyu.kyoten_code              := 0;                                           -- 拠点コード
                l_d_edi_jyutyu.torihiki_kbn_1           := 11;                                          -- 取引区分１
                l_d_edi_jyutyu.jyutyu_su                := l_d_edi_jyutyu.edi_hatyu_su;                 -- 受注数量
                l_d_edi_jyutyu.tanka                    := l_d_edi_jyutyu.edi_tanka;                    -- 単価
                l_d_edi_jyutyu.kazei_kbn                := 1;                                           -- 課税区分
                l_d_edi_jyutyu.aite_baika1              := l_d_edi_jyutyu.edi_baika;                    -- 相手売価１
                l_d_edi_jyutyu.jyutyu_tekiyo            := null;                                        -- 受注摘要
                l_d_edi_jyutyu.denpyo_tekiyo            := null;                                        -- 伝票摘要
                l_d_edi_jyutyu.buturyu_tekiyo           := null;                                        -- 物流摘要
                l_d_edi_jyutyu.location_kbn             := null;                                        -- 出荷ロケ区分
                l_d_edi_jyutyu.edi_rec_no               := rec_m.edi_rec_no;                            -- ediレコード番号
                l_d_edi_jyutyu.sample_kbn               := 1;                                           -- サンプル区分
                l_d_edi_jyutyu.okuri_tokui_code         := l_d_edi_jyutyu.tokui_code;                   -- 送り得意先コード
                l_d_edi_jyutyu.okuri_mise_code          := l_d_edi_jyutyu.mise_code;                    -- 送り店コード
                l_d_edi_jyutyu.nifuda_bikou             := null;                                        -- 荷札備考
                l_d_edi_jyutyu.nohinsyo_hakkou_kbn      := 1;                                           -- 同送納品書発行区分
                l_d_edi_jyutyu.hatyu_date               := l_d_edi_jyutyu.edi_hatyu_date;               -- 発注日
                l_d_edi_jyutyu.nohin_sitei_date         := l_d_edi_jyutyu.edi_nohin_sitei_date;         -- 納品指定日
                l_d_edi_jyutyu.naiyou_meisai_bikou      := null;                                        -- 内容明細書備考
                l_d_edi_jyutyu.aite_hatyu_no            := substrb(l_d_edi_jyutyu.edi_hatyu_no, 1, lengthb(l_d_edi_jyutyu.edi_hatyu_no)-1);    -- 相手発注番号
                l_d_edi_jyutyu.aite_hatyu_no_cd         := substrb(l_d_edi_jyutyu.edi_hatyu_no, -1, 1);                                        -- 相手発注番号c/d
                l_d_edi_jyutyu.aite_denpyo_kbn          := rec_m.datb058;                               -- 相手伝票区分
                l_d_edi_jyutyu.aite_bumon_code          := rec_m.datb040;                               -- 相手部門コード
                l_d_edi_jyutyu.aite_hatyu_kbn           := null;                                        -- 相手発注区分
                l_d_edi_jyutyu.aite_hatyu_kbn_mei       := null;                                        -- 相手発注区分名
                l_d_edi_jyutyu.aite_syukka_kbn          := null;                                        -- 相手出荷区分
                l_d_edi_jyutyu.aite_syukka_kbn_mei      := null;                                        -- 相手出荷区分名
                l_d_edi_jyutyu.aite_konpo_kbn           := null;                                        -- 相手梱包区分
                l_d_edi_jyutyu.aite_konpo_kbn_mei       := null;                                        -- 相手梱包区分名
                l_d_edi_jyutyu.aite_sonota_kbn          := null;                                        -- 相手その他区分
                l_d_edi_jyutyu.aite_sonota_kbn_mei      := null;                                        -- 相手その他区分名
                l_d_edi_jyutyu.kyakutyu_flg             := 0;                                           -- 客注フラグ
                l_d_edi_jyutyu.aite_denpyo_no           := l_d_edi_jyutyu.aite_hatyu_no;                -- 相手伝票番号
                l_d_edi_jyutyu.aite_denpyo_no_cd        := l_d_edi_jyutyu.aite_hatyu_no_cd;             -- 相手伝票番号c/d
                l_d_edi_jyutyu.aite_denpyo_gyo_no       := rec_m.datc002;                               -- 相手伝票行番号
                l_d_edi_jyutyu.nohinsyo_prt_flg         := 0;                                           -- 納品書発行済フラグ
                l_d_edi_jyutyu.senden_prt_flg           := 9;                                           -- 専用伝票発行済フラグ
                l_d_edi_jyutyu.nohindata_crt_flg        := 0;                                           -- 納品データ作成済フラグ
                l_d_edi_jyutyu.eos_flg                  := 1;                                           -- eosフラグ
                l_d_edi_jyutyu.naiyou_meisai_flg        := 1;                                           -- 内容明細書発行フラグ
                l_d_edi_jyutyu.label_flg                := 1;                                           -- 物流ラベル発行フラグ
                l_d_edi_jyutyu.jyotai_kbn               := 1;                                           -- 状態区分
                -- l_d_edi_jyutyu.touroku_date             := -- 登録日
                -- l_d_edi_jyutyu.touroku_user_id          := -- 登録ユーザーid
                -- l_d_edi_jyutyu.touroku_client_id        := -- 登録クライアントid
                -- l_d_edi_jyutyu.touroku_pg_id            := ; -- 登録プログラムid
                l_d_edi_jyutyu.henkou_date              := null;    -- 変更日
                l_d_edi_jyutyu.henkou_user_id           := null;    -- 変更ユーザーid
                l_d_edi_jyutyu.henkou_client_id         := null;    -- 変更クライアントid
                l_d_edi_jyutyu.henkou_pg_id             := null;    -- 変更プログラムid
                l_d_edi_jyutyu.kousin_date              := null;    -- 更新日
                l_d_edi_jyutyu.kousin_user_id           := null;    -- 更新ユーザーid
                l_d_edi_jyutyu.kousin_client_id         := null;    -- 更新クライアントid
                l_d_edi_jyutyu.kousin_pg_id             := null;    -- 更新プログラムid
                l_d_edi_jyutyu.haita_flg                := 1;       -- 排他フラグ

                -- edi得意先
                begin
                    select * into l_m_tokui from m_tokui where m_tokui.tokui_code = l_d_edi_jyutyu.edi_tokui_code;
                    /*
                    以下はエラー
                    ア）未登録の場合
                    イ）終息フラグ＝1（終息）の場合
                    ウ）取引停止区分＝3（完全停止）の場合
                    */
                    l_d_edi_jyutyu.edi_error_flg_5 := 0;
                    if l_m_tokui.syusoku_flg = 1 then
                        l_d_edi_jyutyu.edi_error_flg_5 := 1;
                    end if;
                    if l_m_tokui.torihiki_teisi_kbn = 3 then
                        l_d_edi_jyutyu.edi_error_flg_5 := 1;
                    end if;
                exception
                    when no_data_found then
                        l_d_edi_jyutyu.edi_error_flg_5 := 1;
                    when others then
                        raise;
                end;

                insert into d_edi_jyutyu(
                    edi_kyoten_code,
                    edi_jyusin_no,
                    edi_jyusin_date,
                    edi_tokui_code,
                    edi_syori_id,
                    edi_konpo_kbn,
                    edi_nohin_kbn,
                    edi_hatyu_no,
                    edi_hatyu_date,
                    edi_nohin_sitei_date,
                    edi_mise_code,
                    edi_mise_mei,
                    edi_okuri_mise_code,
                    edi_okuri_mise_mei,
                    edi_syohin_code,
                    edi_syohin_mei,
                    edi_syohin_kikaku,
                    edi_hatyu_su,
                    edi_tanka,
                    edi_baika,
                    edi_reserve_kbn,
                    edi_genbutu_kbn,
                    edi_jyutyuzan_kbn,
                    edi_error_flg_1,
                    edi_error_flg_2,
                    edi_error_flg_3,
                    edi_error_flg_4,
                    edi_error_flg_5,
                    edi_keikoku_flg_1,
                    edi_keikoku_flg_2,
                    edi_keikoku_flg_3,
                    edi_keikoku_flg_4,
                    edi_keikoku_flg_5,
                    jyutyu_no,
                    jyutyu_date,
                    jyutyu_time,
                    jyutyu_houhou,
                    jyusin_no,
                    entry_user_id,
                    entry_user_mei,
                    tokui_code,
                    mise_code,
                    denpyo_syubetu,
                    syukka_kbn,
                    syukka_houhou,
                    jyutyu_gyo_no,
                    kyoten_code,
                    torihiki_kbn_1,
                    jyutyu_su,
                    tanka,
                    kazei_kbn,
                    aite_baika1,
                    jyutyu_tekiyo,
                    denpyo_tekiyo,
                    buturyu_tekiyo,
                    location_kbn,
                    edi_rec_no,
                    sample_kbn,
                    okuri_tokui_code,
                    okuri_mise_code,
                    nifuda_bikou,
                    nohinsyo_hakkou_kbn,
                    hatyu_date,
                    nohin_sitei_date,
                    naiyou_meisai_bikou,
                    aite_hatyu_no,
                    aite_hatyu_no_cd,
                    aite_denpyo_kbn,
                    aite_bumon_code,
                    aite_hatyu_kbn,
                    aite_hatyu_kbn_mei,
                    aite_syukka_kbn,
                    aite_syukka_kbn_mei,
                    aite_konpo_kbn,
                    aite_konpo_kbn_mei,
                    aite_sonota_kbn,
                    aite_sonota_kbn_mei,
                    kyakutyu_flg,
                    aite_denpyo_no,
                    aite_denpyo_no_cd,
                    aite_denpyo_gyo_no,
                    nohinsyo_prt_flg,
                    senden_prt_flg,
                    nohindata_crt_flg,
                    eos_flg,
                    naiyou_meisai_flg,
                    label_flg,
                    jyotai_kbn,
                    touroku_date,
                    touroku_user_id,
                    touroku_client_id,
                    touroku_pg_id,
                    henkou_date,
                    henkou_user_id,
                    henkou_client_id,
                    henkou_pg_id,
                    kousin_date,
                    kousin_user_id,
                    kousin_client_id,
                    kousin_pg_id,
                    haita_flg
                ) values (
                    l_d_edi_jyutyu.edi_kyoten_code,
                    l_d_edi_jyutyu.edi_jyusin_no,
                    l_d_edi_jyutyu.edi_jyusin_date,
                    l_d_edi_jyutyu.edi_tokui_code,
                    l_d_edi_jyutyu.edi_syori_id,
                    l_d_edi_jyutyu.edi_konpo_kbn,
                    l_d_edi_jyutyu.edi_nohin_kbn,
                    l_d_edi_jyutyu.edi_hatyu_no,
                    l_d_edi_jyutyu.edi_hatyu_date,
                    l_d_edi_jyutyu.edi_nohin_sitei_date,
                    l_d_edi_jyutyu.edi_mise_code,
                    l_d_edi_jyutyu.edi_mise_mei,
                    l_d_edi_jyutyu.edi_okuri_mise_code,
                    l_d_edi_jyutyu.edi_okuri_mise_mei,
                    l_d_edi_jyutyu.edi_syohin_code,
                    l_d_edi_jyutyu.edi_syohin_mei,
                    l_d_edi_jyutyu.edi_syohin_kikaku,
                    l_d_edi_jyutyu.edi_hatyu_su,
                    l_d_edi_jyutyu.edi_tanka,
                    l_d_edi_jyutyu.edi_baika,
                    l_d_edi_jyutyu.edi_reserve_kbn,
                    l_d_edi_jyutyu.edi_genbutu_kbn,
                    l_d_edi_jyutyu.edi_jyutyuzan_kbn,
                    l_d_edi_jyutyu.edi_error_flg_1,
                    l_d_edi_jyutyu.edi_error_flg_2,
                    l_d_edi_jyutyu.edi_error_flg_3,
                    l_d_edi_jyutyu.edi_error_flg_4,
                    l_d_edi_jyutyu.edi_error_flg_5,
                    l_d_edi_jyutyu.edi_keikoku_flg_1,
                    l_d_edi_jyutyu.edi_keikoku_flg_2,
                    l_d_edi_jyutyu.edi_keikoku_flg_3,
                    l_d_edi_jyutyu.edi_keikoku_flg_4,
                    l_d_edi_jyutyu.edi_keikoku_flg_5,
                    l_d_edi_jyutyu.jyutyu_no,
                    l_d_edi_jyutyu.jyutyu_date,
                    l_d_edi_jyutyu.jyutyu_time,
                    l_d_edi_jyutyu.jyutyu_houhou,
                    l_d_edi_jyutyu.jyusin_no,
                    l_d_edi_jyutyu.entry_user_id,
                    l_d_edi_jyutyu.entry_user_mei,
                    l_d_edi_jyutyu.tokui_code,
                    l_d_edi_jyutyu.mise_code,
                    l_d_edi_jyutyu.denpyo_syubetu,
                    l_d_edi_jyutyu.syukka_kbn,
                    l_d_edi_jyutyu.syukka_houhou,
                    l_d_edi_jyutyu.jyutyu_gyo_no,
                    l_d_edi_jyutyu.kyoten_code,
                    l_d_edi_jyutyu.torihiki_kbn_1,
                    l_d_edi_jyutyu.jyutyu_su,
                    l_d_edi_jyutyu.tanka,
                    l_d_edi_jyutyu.kazei_kbn,
                    l_d_edi_jyutyu.aite_baika1,
                    l_d_edi_jyutyu.jyutyu_tekiyo,
                    l_d_edi_jyutyu.denpyo_tekiyo,
                    l_d_edi_jyutyu.buturyu_tekiyo,
                    l_d_edi_jyutyu.location_kbn,
                    l_d_edi_jyutyu.edi_rec_no,
                    l_d_edi_jyutyu.sample_kbn,
                    l_d_edi_jyutyu.okuri_tokui_code,
                    l_d_edi_jyutyu.okuri_mise_code,
                    l_d_edi_jyutyu.nifuda_bikou,
                    l_d_edi_jyutyu.nohinsyo_hakkou_kbn,
                    l_d_edi_jyutyu.hatyu_date,
                    l_d_edi_jyutyu.nohin_sitei_date,
                    l_d_edi_jyutyu.naiyou_meisai_bikou,
                    l_d_edi_jyutyu.aite_hatyu_no,
                    l_d_edi_jyutyu.aite_hatyu_no_cd,
                    l_d_edi_jyutyu.aite_denpyo_kbn,
                    l_d_edi_jyutyu.aite_bumon_code,
                    l_d_edi_jyutyu.aite_hatyu_kbn,
                    l_d_edi_jyutyu.aite_hatyu_kbn_mei,
                    l_d_edi_jyutyu.aite_syukka_kbn,
                    l_d_edi_jyutyu.aite_syukka_kbn_mei,
                    l_d_edi_jyutyu.aite_konpo_kbn,
                    l_d_edi_jyutyu.aite_konpo_kbn_mei,
                    l_d_edi_jyutyu.aite_sonota_kbn,
                    l_d_edi_jyutyu.aite_sonota_kbn_mei,
                    l_d_edi_jyutyu.kyakutyu_flg,
                    l_d_edi_jyutyu.aite_denpyo_no,
                    l_d_edi_jyutyu.aite_denpyo_no_cd,
                    l_d_edi_jyutyu.aite_denpyo_gyo_no,
                    l_d_edi_jyutyu.nohinsyo_prt_flg,
                    l_d_edi_jyutyu.senden_prt_flg,
                    l_d_edi_jyutyu.nohindata_crt_flg,
                    l_d_edi_jyutyu.eos_flg,
                    l_d_edi_jyutyu.naiyou_meisai_flg,
                    l_d_edi_jyutyu.label_flg,
                    l_d_edi_jyutyu.jyotai_kbn,
                    l_d_edi_jyutyu.touroku_date,
                    l_d_edi_jyutyu.touroku_user_id,
                    l_d_edi_jyutyu.touroku_client_id,
                    l_d_edi_jyutyu.touroku_pg_id,
                    l_d_edi_jyutyu.henkou_date,
                    l_d_edi_jyutyu.henkou_user_id,
                    l_d_edi_jyutyu.henkou_client_id,
                    l_d_edi_jyutyu.henkou_pg_id,
                    l_d_edi_jyutyu.kousin_date,
                    l_d_edi_jyutyu.kousin_user_id,
                    l_d_edi_jyutyu.kousin_client_id,
                    l_d_edi_jyutyu.kousin_pg_id,
                    l_d_edi_jyutyu.haita_flg
                );
                lib_edi.EDI_DEBUG_LOG('受注共通へデータを投入');                
            end loop;   -- cur_m
        end loop;   -- cur_h

        return 0;
    exception
        when others then
            lib_edi.err_disp;
            return -1;
    end ext;

	/*	Script		： エラーチェック
					：
		Author		： K.Sakamoto
		Parameters	： p_edi_jyusin_no      - EDI受信番号
					： p_edi_rec_no         - EDIレコード番号（0指定時は全件チェック）
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（-1：異常、0：正常）
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function check_update (
        p_edi_jyusin_no in number ,
        p_edi_rec_no in number default 0,
        p_user_id in varchar2,
        p_client_id in varchar2
    ) return number
    is
        l_pg_id             d_edi_jyutyu.touroku_pg_id%type := 'edi1_yam_torikomi.check_update';

        cursor cur(v_edi_jyusin_no d_edi_jyutyu.edi_jyusin_no%type, v_edi_rec_no d_edi_jyutyu.edi_rec_no%type) is
        select  d_edi_jyutyu.*
          from  d_edi_jyutyu
         where  d_edi_jyutyu.edi_jyusin_no = v_edi_jyusin_no
           and (v_edi_rec_no = 0 or d_edi_jyutyu.edi_rec_no = edi_rec_no)
           and d_edi_jyutyu.jyotai_kbn < 4
        ;
        l_d_edi_jyutyu      d_edi_jyutyu%rowtype;
        l_check_pattern     lib_edi.error_check_pattern_t;  -- エラーチェックパターン情報
    begin
        for rec in cur(p_edi_jyusin_no, p_edi_rec_no) loop
            l_d_edi_jyutyu := rec;
            l_d_edi_jyutyu.kousin_user_id := nvl(p_user_id, lib_edi.get_userid);        -- 更新ユーザーID
            l_d_edi_jyutyu.kousin_client_id := nvl(p_client_id, lib_edi.get_clientid);  -- 更新クライアントID
            l_d_edi_jyutyu.kousin_pg_id := l_pg_id;                                     -- 更新プログラムID

            -- チェック処理
            l_check_pattern.tokui   := 'A';
            l_check_pattern.mise    := 'A';
            l_check_pattern.kyoten  := 'A';
            l_check_pattern.tanka   := 'A';
            lib_edi.error_check(l_check_pattern, l_d_edi_jyutyu);

            -- 警告チェック
            lib_edi.warning_check(l_d_edi_jyutyu);

            -- その他項目編集
            lib_edi.set_others_item(l_d_edi_jyutyu);

            -- フラグ反映＋マスタ項目セット(row = l_d_edi_jyutyu は仮想列があり使用不可)
            update d_edi_jyutyu
            set
                edi_haiso_nissu = l_d_edi_jyutyu.edi_haiso_nissu,
                edi_error_flg_1 = l_d_edi_jyutyu.edi_error_flg_1,
                edi_error_flg_2 = l_d_edi_jyutyu.edi_error_flg_2,
                edi_error_flg_3 = l_d_edi_jyutyu.edi_error_flg_3,
                edi_error_flg_4 = l_d_edi_jyutyu.edi_error_flg_4,
                edi_error_flg_5 = l_d_edi_jyutyu.edi_error_flg_5,
                edi_keikoku_flg_1 = l_d_edi_jyutyu.edi_keikoku_flg_1,
                edi_keikoku_flg_2 = l_d_edi_jyutyu.edi_keikoku_flg_2,
                edi_keikoku_flg_3 = l_d_edi_jyutyu.edi_keikoku_flg_3,
                edi_keikoku_flg_4 = l_d_edi_jyutyu.edi_keikoku_flg_4,
                edi_keikoku_flg_5 = l_d_edi_jyutyu.edi_keikoku_flg_5,
                torihiki_jyoken_kbn = l_d_edi_jyutyu.torihiki_jyoken_kbn,
                kyoten_code = l_d_edi_jyutyu.kyoten_code,
                syohin_code = l_d_edi_jyutyu.syohin_code,
                iro_no = l_d_edi_jyutyu.iro_no,
                sku_code = l_d_edi_jyutyu.sku_code,
                hin_ban = l_d_edi_jyutyu.hin_ban,
                hin_mei = l_d_edi_jyutyu.hin_mei,
                iro_mei = l_d_edi_jyutyu.iro_mei,
                size_mei = l_d_edi_jyutyu.size_mei,
                genka_tanka = l_d_edi_jyutyu.genka_tanka,
                syohizei_kbn = l_d_edi_jyutyu.syohizei_kbn,
                ryutu_kako_kbn1 = l_d_edi_jyutyu.ryutu_kako_kbn1,
                ryutu_kako_tekiyo1 = l_d_edi_jyutyu.ryutu_kako_tekiyo1,
                ryutu_kako_kbn2 = l_d_edi_jyutyu.ryutu_kako_kbn2,
                ryutu_kako_tekiyo2 = l_d_edi_jyutyu.ryutu_kako_tekiyo2,
                ryutu_kako_kbn3 = l_d_edi_jyutyu.ryutu_kako_kbn3,
                ryutu_kako_tekiyo3 = l_d_edi_jyutyu.ryutu_kako_tekiyo3,
                ryutu_kako_kbn4 = l_d_edi_jyutyu.ryutu_kako_kbn4,
                ryutu_kako_tekiyo4 = l_d_edi_jyutyu.ryutu_kako_tekiyo4,
                ryutu_kako_kbn5 = l_d_edi_jyutyu.ryutu_kako_kbn5,
                ryutu_kako_tekiyo5 = l_d_edi_jyutyu.ryutu_kako_tekiyo5,
                syokuti_syohin_flg = l_d_edi_jyutyu.syokuti_syohin_flg,
                suryo_keisan_flg = l_d_edi_jyutyu.suryo_keisan_flg,
                kingaku_keisan_flg = l_d_edi_jyutyu.kingaku_keisan_flg,
                arari_keisan_flg = l_d_edi_jyutyu.arari_keisan_flg,
                hako_keisan_flg = l_d_edi_jyutyu.hako_keisan_flg,
                kenpin_taisyo_flg = l_d_edi_jyutyu.kenpin_taisyo_flg,
                kobetu_haiso_flg = l_d_edi_jyutyu.kobetu_haiso_flg,
                todofuken_code = l_d_edi_jyutyu.todofuken_code,
                sikutyoson_code = l_d_edi_jyutyu.sikutyoson_code,
                yubin_no = l_d_edi_jyutyu.yubin_no,
                jyusyo1 = l_d_edi_jyutyu.jyusyo1,
                jyusyo2 = l_d_edi_jyutyu.jyusyo2,
                jyusyo3 = l_d_edi_jyutyu.jyusyo3,
                okuri_tokui_mei = l_d_edi_jyutyu.okuri_tokui_mei,
                okuri_mei1 = l_d_edi_jyutyu.okuri_mei1,
                okuri_mei2 = l_d_edi_jyutyu.okuri_mei2,
                tel_no = l_d_edi_jyutyu.tel_no,
                unso_code = l_d_edi_jyutyu.unso_code,
                tyakuten_code = l_d_edi_jyutyu.tyakuten_code,
                tyakuten_tome_flg = l_d_edi_jyutyu.tyakuten_tome_flg,
                niokurinin_code = l_d_edi_jyutyu.niokurinin_code,
                aite_denpyo_kbn_mei = l_d_edi_jyutyu.aite_denpyo_kbn_mei,
                aite_bumon_mei = l_d_edi_jyutyu.aite_bumon_mei,
                kousin_date = l_d_edi_jyutyu.kousin_date,
                kousin_user_id = l_d_edi_jyutyu.kousin_user_id,
                kousin_client_id = l_d_edi_jyutyu.kousin_client_id,
                kousin_pg_id = l_d_edi_jyutyu.kousin_pg_id
            where
                jyutyu_no = l_d_edi_jyutyu.jyutyu_no
            and jyutyu_gyo_no = l_d_edi_jyutyu.jyutyu_gyo_no
            ;
        end loop;

        return 0;
    exception
        when others then
            lib_edi.err_disp;
            return -1;
    end check_update;
end edi1_yam_torikomi;
/