create or replace package unit_jyutyu is
    function get_jyutyu_no return number;

	/*	Script		�F �󒍔ԍ��̔�
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F �󒍔ԍ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/

    v_error_message     varchar2(4000);
    v_error_stack       varchar2(4000);
    v_error_backtrace   varchar2(4000);

end unit_jyutyu;
/

create or replace package body unit_jyutyu is

	/*	Script		�F �󒍔ԍ��̔�
		Author		�F K.Sakamoto
		Parameters	�F �Ȃ�
		Return		�F �󒍔ԍ�
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function get_jyutyu_no
    return number
    is
        l_cnt           number;
        l_jyutyu_no     number;
    begin
        loop
            -- �󒍔ԍ��̔ԁi����ԍ��P�ʁj
            select seq_jyutyu_no.nextval into l_jyutyu_no from dual;
            -- �󒍔ԍ����݃`�F�b�N
            select count(*) into l_cnt from d_jyutyu where jyutyu_no = l_jyutyu_no;
            if l_cnt = 0 then
                exit;
            end if;
        end loop;
        return l_jyutyu_no;

    exception
        when others then
            -- �G���[�����O���[�o���ϐ��ɃZ�b�g
            v_error_message := sqlerrm;
            v_error_stack := dbms_utility.format_error_stack;
            v_error_backtrace := dbms_utility.format_error_backtrace;
            return null;
    end get_jyutyu_no;

end unit_jyutyu;
/
