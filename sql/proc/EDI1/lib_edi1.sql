CREATE OR REPLACE package lib_edi1 is
	/*	Script		�F EOS�捞���b�p�[
		Author		�F K.Sakamoto
		Parameters	�F p_edi_kyoten_code    - EDI���_�R�[�h
                    �F p_edi_tokui_code     - EDI���Ӑ�R�[�h
                    �F p_entry_user_id      - �����҃R�[�h
                    �F p_filename           - �t�@�C����
                    �F p_user_id            - ���[�U�[ID
                    �F p_client_id          - �N���C�A���gID
		Return		�F ���۔���i0�F�ُ�A1�F����j
		DataWritten	�F 2025/03/26
		Modified	�F
	*/
    function torikomi_main (
        p_edi_kyoten_code in d_edi_jyutyu.edi_kyoten_code%type,
        p_edi_tokui_code in d_edi_jyutyu.edi_tokui_code%type,
        p_entry_user_id in d_edi_jyutyu.entry_user_id%type,
        p_filename in varchar2,
        p_user_id in d_edi_jyutyu.touroku_user_id%type,
        p_client_id in d_edi_jyutyu.touroku_client_id%type
    ) return number;

	/*	Script		�F EOS�捞�`�F�b�N���b�p�[
		Author		�F K.Sakamoto
		Parameters	�F p_edi_jyusin_no  - EDI��M�ԍ�
                    �F p_edi_tokui_code - EDI���Ӑ�
                    �F p_user_id            - ���[�U�[ID
                    �F p_client_id          - �N���C�A���gID
		Return		�F ���۔���i0�F�ُ�A1�F����j
		DataWritten	�F 2025/04/02
		Modified	�F
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
	/*	Script		�F EOS�捞���b�p�[
		Author		�F K.Sakamoto
		Parameters	�F p_edi_kyoten_code    - EDI���_�R�[�h
                    �F p_edi_tokui_code     - EDI���Ӑ�R�[�h
                    �F p_entry_user_id      - �����҃R�[�h
                    �F p_filename           - �t�@�C����
                    �F p_user_id            - ���[�U�[ID
                    �F p_client_id          - �N���C�A���gID
		Return		�F ���۔���i0�F�ُ�A1�F����j
		DataWritten	�F 2025/03/26
		Modified	�F
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
        -- �����ł̓G���[�ɂȂ邱�Ƃ͂Ȃ����߃G���[�����͏ȗ�
        select
            edi_syori_id
        into
            l_edi_syori_id
        from m_edi_kanri
        where m_edi_kanri.edi_tokui_code = p_edi_tokui_code
        ;
        -- �t�@�C����W�J���ă��[�N�ɓo�^����
        l_sql := 'begin :1 := edi1_' || l_edi_syori_id || '_torikomi.main(:2, :3, :4, :5, :6, :7); end;';
        execute immediate l_sql using out l_result, p_filename, p_edi_kyoten_code, p_edi_tokui_code, p_entry_user_id, p_user_id, p_client_id;
        if l_result = 0 then
            raise_application_error(-20001, '�\�����Ȃ��f�[�^����荞�܂ꂽ���ߏ����𒆎~���܂��B');
        end if;
        return 1;
    exception
        when others then
            lib_edi.err_disp;
            return 0;
    end torikomi_main;

	/*	Script		�F EOS�捞�`�F�b�N���b�p�[
		Author		�F K.Sakamoto
		Parameters	�F p_edi_jyusin_no  - EDI��M�ԍ�
                    �F p_edi_tokui_code - EDI���Ӑ�
                    �F p_user_id            - ���[�U�[ID
                    �F p_client_id          - �N���C�A���gID
		Return		�F ���۔���i0�F�ُ�A1�F����j
		DataWritten	�F 2025/04/02
		Modified	�F
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
