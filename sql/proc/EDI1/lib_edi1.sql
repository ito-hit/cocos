CREATE OR REPLACE package lib_edi1 is
	/*	Script		： EOS取込ラッパー
		Author		： K.Sakamoto
		Parameters	： p_edi_kyoten_code    - EDI拠点コード
                    ： p_edi_tokui_code     - EDI得意先コード
                    ： p_entry_user_id      - 処理者コード
                    ： p_filename           - ファイル名
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（0：異常、1：正常）
		DataWritten	： 2025/03/26
		Modified	：
	*/
    function torikomi_main (
        p_edi_kyoten_code in d_edi_jyutyu.edi_kyoten_code%type,
        p_edi_tokui_code in d_edi_jyutyu.edi_tokui_code%type,
        p_entry_user_id in d_edi_jyutyu.entry_user_id%type,
        p_filename in varchar2,
        p_user_id in d_edi_jyutyu.touroku_user_id%type,
        p_client_id in d_edi_jyutyu.touroku_client_id%type
    ) return number;

	/*	Script		： EOS取込チェックラッパー
		Author		： K.Sakamoto
		Parameters	： p_edi_jyusin_no  - EDI受信番号
                    ： p_edi_tokui_code - EDI得意先
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（0：異常、1：正常）
		DataWritten	： 2025/04/02
		Modified	：
	*/
    function torikomi_check (
        p_edi_jyusin_no in  d_edi_jyutyu.edi_jyusin_no%type,
        p_edi_tokui_code in d_edi_jyutyu.edi_tokui_code%type,
        p_user_id in d_edi_jyutyu.kousin_user_id%type,
        p_client_id in d_edi_jyutyu.kousin_client_id%type
    ) return number;

end lib_edi1;
/
CREATE OR REPLACE package body lib_edi1 is
	/*	Script		： EOS取込ラッパー
		Author		： K.Sakamoto
		Parameters	： p_edi_kyoten_code    - EDI拠点コード
                    ： p_edi_tokui_code     - EDI得意先コード
                    ： p_entry_user_id      - 処理者コード
                    ： p_filename           - ファイル名
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（0：異常、1：正常）
		DataWritten	： 2025/03/26
		Modified	：
	*/
    function torikomi_main (
        p_edi_kyoten_code in d_edi_jyutyu.edi_kyoten_code%type,
        p_edi_tokui_code in d_edi_jyutyu.edi_tokui_code%type,
        p_entry_user_id in d_edi_jyutyu.entry_user_id%type,
        p_filename in varchar2,
        p_user_id in d_edi_jyutyu.touroku_user_id%type,
        p_client_id in d_edi_jyutyu.touroku_client_id%type
    ) return number
    is
        l_edi_syori_id      m_edi_kanri.edi_syori_id%type;
        l_edi_jyusin_no     d_edi_jyutyu.edi_jyusin_no%type;
        l_sql               varchar(4000);
        l_result            number;
    begin
        -- ここではエラーになることはないためエラー処理は省略
        select
            edi_syori_id
        into
            l_edi_syori_id
        from m_edi_kanri
        where m_edi_kanri.edi_tokui_code = p_edi_tokui_code
        ;
        -- ファイルを展開してワークに登録する
        l_sql := 'begin :1 := edi1_' || l_edi_syori_id || '_torikomi.main(:2, :3, :4, :5, :6, :7); end;';
        execute immediate l_sql using out l_result, p_filename, p_edi_kyoten_code, p_edi_tokui_code, p_entry_user_id, p_user_id, p_client_id;
        if l_result = 0 then
            raise_application_error(-20001, '予期しないデータが取り込まれたため処理を中止します。');
        end if;
        return 1;
    exception
        when others then
            lib_edi.err_disp;
            return 0;
    end torikomi_main;

	/*	Script		： EOS取込チェックラッパー
		Author		： K.Sakamoto
		Parameters	： p_edi_jyusin_no  - EDI受信番号
                    ： p_edi_tokui_code - EDI得意先
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（0：異常、1：正常）
		DataWritten	： 2025/04/02
		Modified	：
	*/
    function torikomi_check (
        p_edi_jyusin_no in  d_edi_jyutyu.edi_jyusin_no%type,
        p_edi_tokui_code in d_edi_jyutyu.edi_tokui_code%type,
        p_user_id in d_edi_jyutyu.kousin_user_id%type,
        p_client_id in d_edi_jyutyu.kousin_client_id%type
    ) return number
    is
    begin
        return 1;
    end torikomi_check;

end lib_edi1;
/
