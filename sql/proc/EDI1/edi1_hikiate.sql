create or replace package edi1_zaiko_hikiate is
    function main (
        p_syori_kbn         in number,
        p_ra_kbn            in number,
        p_ba_kbn            in number,
        p_edi_jyusin_no     in d_edi_jyutyu.edi_jyusin_no%type,
        p_kyoten_code       in d_edi_jyutyu.kyoten_code%type,
        p_okuri_tokui_code  in d_edi_jyutyu.okuri_tokui_code%type,
        p_syukka_date       in d_edi_jyutyu.syukka_date%type,
        p_entry_user_id     in d_edi_jyutyu.entry_user_id%type,
        p_user_id           in d_edi_jyutyu.kousin_user_id%type,
        p_client_id         in d_edi_jyutyu.kousin_client_id%type
    ) return number;

end edi1_zaiko_hikiate;
/
create or replace package body edi1_zaiko_hikiate is
	/*	Script		�F �o�׃��C��
					�F �ďo�p
		Author		�F K.Sakamoto
		Parameters	�F p_syori_kbn          - �����敪�i1�F�݌Ɉ����A2�F�݌Ɉ�������A3�F�S�L�����Z���A4�F�S���i�j
                    �F p_ra_kbn             - ���U�[�u�����i1�FON�A0�FOFF�j
                    �F p_ba_kbn             - �ϓ������i1�FON�A0�FOFF�j
                    �F p_edi_jyusin_no      - EDI��M�ԍ�
                    �F p_kyoten_code        - �i�o�ׁj���_�R�[�h
					�F p_okuri_tokui_code   - ���蓾�Ӑ�R�[�h
                    �F p_syukka_date        - �o�ד�
					�F p_entry_user_id      - �����҃R�[�h
                    �F p_user_id            - ���[�U�[ID
                    �F p_client_id          - �N���C�A���gID
		Return		�F ���۔���i-1�F�ُ�A0�F����j
		DataWritten	�F 2025/03/12
		Modified	�F
	*/
    function main (
        p_syori_kbn         in number,
        p_ra_kbn            in number,
        p_ba_kbn            in number,
        p_edi_jyusin_no     in d_edi_jyutyu.edi_jyusin_no%type,
        p_kyoten_code       in d_edi_jyutyu.kyoten_code%type,
        p_okuri_tokui_code  in d_edi_jyutyu.okuri_tokui_code%type,
        p_syukka_date       in d_edi_jyutyu.syukka_date%type,
        p_entry_user_id     in d_edi_jyutyu.entry_user_id%type,
        p_user_id           in d_edi_jyutyu.kousin_user_id%type,
        p_client_id         in d_edi_jyutyu.kousin_client_id%type
    ) return number
    is
        -- �����P�ʃJ�[�\��
        cursor cur is
        select rowid,
               d_edi_jyutyu.edi_jyusin_no,
               d_edi_jyutyu.jyutyu_no
          from d_edi_jyutyu
         where d_edi_jyutyu.edi_jyusin_no = p_edi_jyusin_no
           and d_edi_jyutyu.okuri_tokui_code = p_okuri_tokui_code
           and d_edi_jyutyu.syukka_date = p_syukka_date
           and (
                (p_syori_kbn = 1 and d_edi_jyutyu.jyotai_kbn in (4, 5, 6)) or
                (p_syori_kbn = 2 and d_edi_jyutyu.jyotai_kbn in (5)) or
                (p_syori_kbn in (3, 4) and d_edi_jyutyu.jyotai_kbn in (4, 5, 6, 7))
                )
        ;
        l_jyotai_kbn        d_edi_jyutyu.jyotai_kbn%type;
        l_result            number;
    begin
        case p_syori_kbn
        when 1 then
            l_jyotai_kbn := 5;
        when 2 then
            l_jyotai_kbn := 4;
        when 3 then
            l_jyotai_kbn := 5;
        when 4 then
            l_jyotai_kbn := 5;
        else
            -- ��L�ȊO�̓G���[
            return -1;
        end case;

        -- ��ԋ敪��ύX
        for rec in cur loop
            update d_edi_jyutyu
            set
                jyotai_kbn = l_jyotai_kbn
            where
                rowid = rec.rowid
            ;
        end loop;

        return 0;
    end main;

end edi1_zaiko_hikiate;
/