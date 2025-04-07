create or replace package unit_jyutyu is
    function get_jyutyu_no return number;

	/*	Script		： 受注番号採番
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： 受注番号
		DataWritten	： 2025/03/12
		Modified	：
	*/

    v_error_message     varchar2(4000);
    v_error_stack       varchar2(4000);
    v_error_backtrace   varchar2(4000);

end unit_jyutyu;
/

create or replace package body unit_jyutyu is

	/*	Script		： 受注番号採番
		Author		： K.Sakamoto
		Parameters	： なし
		Return		： 受注番号
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function get_jyutyu_no
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
            -- エラー情報をグローバル変数にセット
            v_error_message := sqlerrm;
            v_error_stack := dbms_utility.format_error_stack;
            v_error_backtrace := dbms_utility.format_error_backtrace;
            return null;
    end get_jyutyu_no;

end unit_jyutyu;
/
