create or replace package lib_uriage is

	-- �[������
	function	get_hasuu( p_number number,p_hasuu number ) return number;
	-- �^�M���x�z�擾
	function	get_yosin_gendo_gaku( p_seikyu_code number ) return number;
	-- �����z�擾
	function	get_so_saiken_gaku( p_seikyu_code number ) return number;
	-- ���\��z�擾
	function	get_saiken_yotei_gaku( p_tokui_code number ) return number;

	procedure	disp_out( p_log varchar2 );
end lib_uriage;
/

create or replace package body lib_uriage is
	err_num		number		:= 0;
	err_msg		varchar2(300)	:= ' ';

	/*
		�[������	2024.08.23 J.Tanaka
		p_number	: �l
		p_hasuu		: �[�������敪�i1�F�؎̂� 2�F�l�̌ܓ� 3�F�؏グ�j
		return 		: �[��������̒l
	*/
	function	get_hasuu( p_number number,p_hasuu number ) return number is
		-- �ϐ��̐錾
		l_rtn		number	:= 0;
		l_number	number	:= 0;
		l_flg		number	:= 1;

		begin

			-- �[�������͐�Βl�ōs���I
			if p_number < 0 then
				l_flg := -1;
			end if;
			l_number := p_number * l_flg;

			-- 1�F�؎̂�
			if p_hasuu = 1 then
				l_rtn := trunc( l_number, 0 );
			-- 2�F�l�̌ܓ�
			elsif p_hasuu = 2 then
				l_rtn := round( l_number, 0 );
			-- 3�F�؏グ
			elsif p_hasuu = 3 then
				l_rtn := ceil( l_number );
			end if;

			return l_rtn * l_flg ;

	end get_hasuu;

	/*
		�^�M���x�z�擾	2024.08.23 J.Tanaka
		p_seikyu_code	: ������R�[�h
		return 		: �^�M���x�z
	*/
	function	get_yosin_gendo_gaku( p_seikyu_code number ) return number is
		-- �ϐ��̐錾
		l_rtn			number;

		-- �J�[�\���̐錾
		cursor cr1 is
			select mt.yosin_gendo_gaku 
			  from m_tokui mt
			 where mt.tokui_code  = p_seikyu_code;
		cr1_rec	cr1%rowtype;

		begin

			-- �J�[�\���I�[�v��
			open cr1;
			fetch cr1 into cr1_rec;

			if cr1%found then
				l_rtn := cr1_rec.yosin_gendo_gaku;
			else
				l_rtn := 0;
			end if;

			-- �J�[�\���N���[�Y
			close cr1;

			return l_rtn;

	end get_yosin_gendo_gaku;

	/*
		�����z�擾	2024.08.23 J.Tanaka
		p_seikyu_code	: ������R�[�h
		return 		: �����z
	*/
	function	get_so_saiken_gaku( p_seikyu_code number ) return number is
		-- �ϐ��̐錾
		l_rtn			number	:= 0;
		l_tougetu_urikake_zan	number	:= 0;
		l_mikessai_tegata_zan	number	:= 0;

		-- �J�[�\���̐錾
		cursor cr1 is
			-- < ���������|���c�� >
			-- �O�������|���c�� + ������z + �ԕi���z + �l�����z + �l�����z + �������z + ����ŋ��z - �������z
			select nvl( sum( du.zengetu_urikake_zan +
			                 du.uriage_kingaku +
			                 du.henpin_kingaku +
			                 du.nemasi_kingaku +
			                 du.nebiki_kingaku +
			                 du.bubiki_kingaku +
			                 du.syohizei_kingaku  -
			                 du.nyukin_kingaku ), 0 ) tougetu_urikake_zan
			  from d_urikake du
			 where du.sime_flg    = 0		-- 0�F�������ߖ�����
			   and du.seikyu_code = p_seikyu_code;
		cr1_rec	cr1%rowtype;

		cursor cr2 is
			-- < �����ώ�`�c�� >
			-- ���ʋ��z�i�������z�j - ���ϋ��z
			select nvl( sum( dt.tegata_kingaku -
			                 dt.kessai_kingaku ), 0 ) mikessai_tegata_zan 
			  from d_tegata dt
			 where ( dt.tegata_kingaku - dt.kessai_kingaku ) > 0
			   and dt.seikyu_code = p_seikyu_code;
		cr2_rec	cr2%rowtype;

		begin

			-- < ���������|���c�� >
			-- �J�[�\���I�[�v��
			open cr1;
			fetch cr1 into cr1_rec;

			if cr1%found then
				l_tougetu_urikake_zan := cr1_rec.tougetu_urikake_zan;
			end if;

			-- �J�[�\���N���[�Y
			close cr1;

			-- < �����ώ�`�c�� >
			-- �J�[�\���I�[�v��
			open cr2;
			fetch cr2 into cr2_rec;

			if cr2%found then
				l_mikessai_tegata_zan := cr2_rec.mikessai_tegata_zan;
			end if;

			-- �J�[�\���N���[�Y
			close cr2;

			-- ���������|���c�� + �����ώ�`�c�� 
			l_rtn := l_tougetu_urikake_zan + l_mikessai_tegata_zan;

			return l_rtn;

	end get_so_saiken_gaku;

	/*
		���\��z�擾	2024.08.23 J.Tanaka
		p_tokui_code	: ���Ӑ�R�[�h
		return 		: ���\��z
	*/
	function	get_saiken_yotei_gaku( p_tokui_code number ) return number is
		-- �ϐ��̐錾
		l_rtn			number	:= 0;
		l_saiken_yotei_gaku	number	:= 0;
		l_syohizei		number	:= 0;
		l_zei_hasu_kbn		number;

		-- �J�[�\���̐錾
		cursor cr1 is
			-- ����Œ[�������敪�擾
			select decode( mt.zei_hasu_kbn, 9, mk.zei_hasuu_uriage, mt.zei_hasu_kbn ) zei_hasu_kbn 
			  from m_tokui mt,
			       m_kihon mk
			 where mt.tokui_code = p_tokui_code
			   and mk.kanri_code = 0;
		cr1_rec	cr1%rowtype;

		cursor cr2 is
			-- < ���\��z >
			-- ( �o�׎w������ - �o�׎��ѐ��� - �o�׎~�ߐ��� - �L�����Z������ ) *�i �P�� + �l���P�� )
			select ds.jyutyu_no,
			       nvl(sum( lib_uriage.get_hasuu(( ds.syukka_siji_su - ds.syukka_jisseki_su - ds.jyutyuzan_su - ds.cancel_su ) * 
			                                     ( ds.tanka + ds.nebiki_tanka ), 1 )), 0 ) kingaku,
			       max( ds.syohizei_kbn ) syohizei_kbn,
			       max( ds.syohizei_ritu ) syohizei_ritu
			  from d_syukka_yotei ds
			 where ds.tokui_code           =  p_tokui_code
			   and ds.torihiki_jyoken_kbn  <> 2
			   and ds.torihiki_kbn_1       =  11
			 group by ds.jyutyu_no;
		cr2_rec	cr2%rowtype;

		begin

			-- �J�[�\���I�[�v��
			open cr1;
			fetch cr1 into cr1_rec;
			if cr1%found then
				l_zei_hasu_kbn := cr1_rec.zei_hasu_kbn;
			else
				l_zei_hasu_kbn := 1;	-- 1�F�؎̂�
			end if;
			-- �J�[�\���N���[�Y
			close cr1;

			-- �J�[�\���I�[�v��
			open cr2;
			-- �J�Ԃ�����
			loop
				fetch cr2 into cr2_rec;
				exit when cr2%notfound or cr2%notfound is null;

				if cr2_rec.kingaku = 0 then
					l_saiken_yotei_gaku := 0;
				else
					-- 1�F�P���ŕʂ͏���Ōv�Z
					l_syohizei := 0;
					if  cr2_rec.syohizei_kbn = 1 then
						l_syohizei  := lib_uriage.get_hasuu(( cr2_rec.kingaku * cr2_rec.syohizei_ritu ) / 100, l_zei_hasu_kbn );
					end if;
					l_saiken_yotei_gaku := cr2_rec.kingaku + l_syohizei;
				end if;

				l_rtn := l_rtn + l_saiken_yotei_gaku;

			end loop;

			-- �J�[�\���N���[�Y
			close cr2;

			return l_rtn;

	end get_saiken_yotei_gaku;

	/*
		Script		�F �R���\�[�����O�o��
		Author		�F H.Kintou
		Parameters	�F p_log		- �R���\�[���ɕ\�����镶����
		Return		�F
		DataWritten	�F 2023.04.19
		Modified	�F
	*/
	procedure	disp_out( p_log varchar2 ) is
		begin
			-- ORA-4068���
			-- dbms_session.reset_package();

			dbms_output.put_line( to_char( sysdate, 'yyyy.mm.dd hh24:mi:ss' ) || '�F' || p_log );
	end disp_out;
end lib_uriage;
/
