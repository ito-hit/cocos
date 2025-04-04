drop table d_edi_jyutyu_dcm;

create table d_edi_jyutyu_dcm(
	edi_kyoten_code			number(3)			default 0,
	edi_jyusin_no			number(10)			default 0,
	edi_jyusin_date			number(8)			default 0,
	edi_tokui_code			number(6)			default 0,
	edi_rec_no				number(10)			default null,
	dath001					varchar2(2)			default null,
	dath002					varchar2(6)			default null,
	dath003					varchar2(6)			default null,
	dath004					varchar2(9)			default null,
	dath005					varchar2(16)		default null,
	dath006					varchar2(8)			default null,
	dath007					varchar2(8)			default null,
	dath008					varchar2(8)			default null,
	dath009					varchar2(8)			default null,
	dath010					varchar2(8)			default null,
	dath011					varchar2(12)		default null,
	dath012					varchar2(8)			default null,
	dath013					varchar2(44)		default null,
	dath014					varchar2(9)			default null,
	dath015					varchar2(230)		default null,
	dath016					varchar2(150)		default null,
	dath017					varchar2(664)		default null,
	dath018					varchar2(2)			default null,
	dath019					varchar2(17)		default null,
	dath020					varchar2(2)			default null,
	dath021					varchar2(46)		default null,
	dath022					varchar2(2)			default null,
	dath023					varchar2(1)			default null,
	dath024					varchar2(8)			default null,
	dath025					varchar2(2)			default null,
	dath026					varchar2(2)			default null,
	dath027					varchar2(8)			default null,
	dath028					varchar2(5)			default null,
	dath029					varchar2(15)		default null,
	dath030					varchar2(45)		default null,
	dath031					varchar2(15)		default null,
	dath032					varchar2(90)		default null,
	dath033					varchar2(2)			default null,
	dath034					varchar2(8)			default null,
	dath035					varchar2(3)			default null,
	dath036					varchar2(1)			default null,
	dath037					varchar2(15)		default null,
	dath038					varchar2(15)		default null,
	dath039					varchar2(30)		default null,
	dath040					varchar2(30)		default null,
	dath041					varchar2(2)			default null,
	dath042					varchar2(41)		default null,
	dath043					varchar2(30)		default null,
	dath044					varchar2(185)		default null,
	dath045					varchar2(13)		default null,
	dath046					varchar2(13)		default null,
	dath047					varchar2(2)			default null,
	dath048					varchar2(11)		default null,
	dath049					varchar2(20)		default null,
	dath050					varchar2(40)		default null,
	dath051					varchar2(4)			default null,
	dath052					varchar2(9)			default null,
	dath053					varchar2(15)		default null,
	dath054					varchar2(15)		default null,
	dath055					varchar2(30)		default null,
	dath056					varchar2(120)		default null,
	dath057					varchar2(2)			default null,
	dath058					varchar2(99)		default null,
	dath059					varchar2(4)			default null,
	dath060					varchar2(9)			default null,
	dath061					varchar2(15)		default null,
	dath062					varchar2(15)		default null,
	dath063					varchar2(30)		default null,
	dath064					varchar2(30)		default null,
	dath065					varchar2(2)			default null,
	dath066					varchar2(69)		default null,
	dath067					varchar2(6)			default null,
	dath068					varchar2(6)			default null,
	dath069					varchar2(1)			default null,
	dath070					varchar2(60)		default null,
	dath071					varchar2(60)		default null,
	dath072					varchar2(260)		default null,
	dath073					varchar2(6)			default null,
	dath074					varchar2(7)			default null,
	dath075					varchar2(6)			default null,
	dath076					varchar2(114)		default null,
	dath077					varchar2(9)			default null,
	dath078					varchar2(53)		default null,
	dath079					number(5,3)			default 0,
	dath080					varchar2(90)		default null,
	dath081					varchar2(2)			default null,
	dath082					varchar2(48)		default null,
	datd001					varchar2(2)			default null,
	datd002					varchar2(13)		default null,
	datd003					number(3)			default 0,
	datd004					varchar2(59)		default null,
	datd005					varchar2(8)			default null,
	datd006					varchar2(22)		default null,
	datd007					varchar2(10)		default null,
	datd008					varchar2(36)		default null,
	datd009					varchar2(26)		default null,
	datd010					varchar2(14)		default null,
	datd011					varchar2(62)		default null,
	datd012					varchar2(5)			default null,
	datd013					varchar2(35)		default null,
	datd014					varchar2(70)		default null,
	datd015					varchar2(35)		default null,
	datd016					varchar2(70)		default null,
	datd017					varchar2(12)		default null,
	datd018					varchar2(69)		default null,
	datd019					varchar2(1)			default null,
	datd020					varchar2(16)		default null,
	datd021					varchar2(1)			default null,
	datd022					varchar2(4)			default null,
	datd023					number(9,2)			default 0,
	datd024					varchar2(1)			default null,
	datd025					number(5)			default 0,
	datd026					number(5)			default 0,
	datd027					varchar2(40)		default null,
	datd028					number(10)			default 0,
	datd029					number(10)			default 0,
	datd030					varchar2(11)		default null,
	datd031					number(9,2)			default 0,
	datd032					varchar2(11)		default null,
	datd033					number(7)			default 0,
	datd034					varchar2(21)		default null,
	datd035					number(3)			default 0,
	datd036					varchar2(9)			default null,
	datd037					varchar2(21)		default null,
	jyotai_kbn				number(1)			default 0,
	touroku_date			date				default sysdate,
	touroku_user_id			varchar2(10)		default null,
	touroku_client_id		varchar2(40)		default null,
	touroku_pg_id			varchar2(40)		default null,
	henkou_date				date				default null,
	henkou_user_id			varchar2(10)		default null,
	henkou_client_id		varchar2(40)		default null,
	henkou_pg_id			varchar2(40)		default null,
	kousin_date				date				default null,
	kousin_user_id			varchar2(10)		default null,
	kousin_client_id		varchar2(40)		default null,
	kousin_pg_id			varchar2(40)		default null,
	haita_flg				number(1)			default 0,

	constraint d_edi_jyutyu_dcm_pidx_1
	primary key ( edi_rec_no )
)
/

comment on column d_edi_jyutyu_dcm.edi_kyoten_code is 'EDI���_�R�[�h�iEDI�f�[�^����荞�񂾋��_�̃R�[�h�j';
comment on column d_edi_jyutyu_dcm.edi_jyusin_no is 'EDI��M�ԍ��iEDI�f�[�^��M�P�ʂɕt�Ԃ���i��{���}�X�^�[�̏�����+seq_edi_jyusin_no�j�j';
comment on column d_edi_jyutyu_dcm.edi_jyusin_date is 'EDI��M���iEDI�f�[�^����荞�񂾓��j';
comment on column d_edi_jyutyu_dcm.edi_tokui_code is 'EDI���Ӑ�R�[�h�iEDI���Ӑ�R�[�h�i��\���Ӑ�j�j';
comment on column d_edi_jyutyu_dcm.edi_rec_no is 'EDI���R�[�h�ԍ��i���ʎ󒍃f�[�^���R�[�h�Ƃ̕R�t���ԍ��iseq_edirec_no�j�j����L�[�@';
comment on column d_edi_jyutyu_dcm.dath001 is '�^�OHD�i�^�O�iHD�j�w�b�_�[���j';
comment on column d_edi_jyutyu_dcm.dath002 is '���b�Z�[�WID';
comment on column d_edi_jyutyu_dcm.dath003 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath004 is '�����`�[�ԍ�';
comment on column d_edi_jyutyu_dcm.dath005 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath006 is '����������';
comment on column d_edi_jyutyu_dcm.dath007 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath008 is '�[�i�J�n��';
comment on column d_edi_jyutyu_dcm.dath009 is '�[�i�I����';
comment on column d_edi_jyutyu_dcm.dath010 is '������';
comment on column d_edi_jyutyu_dcm.dath011 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath012 is '�[�i�w���';
comment on column d_edi_jyutyu_dcm.dath013 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath014 is '�����R�[�h';
comment on column d_edi_jyutyu_dcm.dath015 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath016 is '�x������';
comment on column d_edi_jyutyu_dcm.dath017 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath018 is '�`�[���';
comment on column d_edi_jyutyu_dcm.dath019 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath020 is '�`�[�敪';
comment on column d_edi_jyutyu_dcm.dath021 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath022 is '������ʋ敪';
comment on column d_edi_jyutyu_dcm.dath023 is '�[�i�敪';
comment on column d_edi_jyutyu_dcm.dath024 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath025 is '��z�敪';
comment on column d_edi_jyutyu_dcm.dath026 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath027 is '������ƃR�[�h';
comment on column d_edi_jyutyu_dcm.dath028 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath029 is '������Ɩ��́i�J�i�j';
comment on column d_edi_jyutyu_dcm.dath030 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath031 is '������Ɩ��́i�����j';
comment on column d_edi_jyutyu_dcm.dath032 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath033 is '���_�R�[�h';
comment on column d_edi_jyutyu_dcm.dath034 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath035 is '����R�[�h';
comment on column d_edi_jyutyu_dcm.dath036 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath037 is '���喼�i�J�i�j';
comment on column d_edi_jyutyu_dcm.dath038 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath039 is '���喼�i�����j';
comment on column d_edi_jyutyu_dcm.dath040 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath041 is '�]�[���R�[�h';
comment on column d_edi_jyutyu_dcm.dath042 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath043 is '�]�[�����i�����j';
comment on column d_edi_jyutyu_dcm.dath044 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath045 is 'GLN������ƃR�[�h';
comment on column d_edi_jyutyu_dcm.dath046 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath047 is '�u���b�N�R�[�h';
comment on column d_edi_jyutyu_dcm.dath048 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath049 is '�u���b�N�R�[�h���́i�J�i�j';
comment on column d_edi_jyutyu_dcm.dath050 is '�u���b�N�R�[�h���́i�����j';
comment on column d_edi_jyutyu_dcm.dath051 is '�[�i��R�[�h';
comment on column d_edi_jyutyu_dcm.dath052 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath053 is '�[�i�於�́i�J�i�j';
comment on column d_edi_jyutyu_dcm.dath054 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath055 is '�[�i�於�́i�����j';
comment on column d_edi_jyutyu_dcm.dath056 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath057 is '�[�i�Z���^�[�u���b�N�R�[�h';
comment on column d_edi_jyutyu_dcm.dath058 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath059 is '�[�i�����R�[�h';
comment on column d_edi_jyutyu_dcm.dath060 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath061 is '�[�i�������́i�J�i�j';
comment on column d_edi_jyutyu_dcm.dath062 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath063 is '�[�i�������́i�����j';
comment on column d_edi_jyutyu_dcm.dath064 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath065 is '�ٔԍ�';
comment on column d_edi_jyutyu_dcm.dath066 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath067 is '���ʎ����R�[�h';
comment on column d_edi_jyutyu_dcm.dath068 is '���ʎ���搧��R�[�h';
comment on column d_edi_jyutyu_dcm.dath069 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath070 is '����於�́i�J�i�j';
comment on column d_edi_jyutyu_dcm.dath071 is '����於�́i�����j';
comment on column d_edi_jyutyu_dcm.dath072 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath073 is '�ʎ����R�[�h';
comment on column d_edi_jyutyu_dcm.dath074 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath075 is '�����R�[�h';
comment on column d_edi_jyutyu_dcm.dath076 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath077 is '�\���[�ԍ�';
comment on column d_edi_jyutyu_dcm.dath078 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath079 is '�ŗ�';
comment on column d_edi_jyutyu_dcm.dath080 is '���g�p';
comment on column d_edi_jyutyu_dcm.dath081 is '�ŋ敪';
comment on column d_edi_jyutyu_dcm.dath082 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd001 is '�^�ODT�i�^�O�iDT�j���׏��j';
comment on column d_edi_jyutyu_dcm.datd002 is 'JAN�R�[�h';
comment on column d_edi_jyutyu_dcm.datd003 is '�����`�[�s�ԍ�';
comment on column d_edi_jyutyu_dcm.datd004 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd005 is '���i�R�[�h';
comment on column d_edi_jyutyu_dcm.datd006 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd007 is '����';
comment on column d_edi_jyutyu_dcm.datd008 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd009 is '�p�^�[��NO�D';
comment on column d_edi_jyutyu_dcm.datd010 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd011 is '�p�^�[������';
comment on column d_edi_jyutyu_dcm.datd012 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd013 is '���i���i�J�i�j';
comment on column d_edi_jyutyu_dcm.datd014 is '���i���i�����j';
comment on column d_edi_jyutyu_dcm.datd015 is '���i�K�i���́i�J�i�j';
comment on column d_edi_jyutyu_dcm.datd016 is '���i�K�i���́i�����j';
comment on column d_edi_jyutyu_dcm.datd017 is '�S���h���ԍ�';
comment on column d_edi_jyutyu_dcm.datd018 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd019 is '�����P�ʋ敪';
comment on column d_edi_jyutyu_dcm.datd020 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd021 is '�`��敪';
comment on column d_edi_jyutyu_dcm.datd022 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd023 is '��������';
comment on column d_edi_jyutyu_dcm.datd024 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd025 is '�����P�ʐ�';
comment on column d_edi_jyutyu_dcm.datd026 is '�����P�ʓ���';
comment on column d_edi_jyutyu_dcm.datd027 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd028 is '�����������z';
comment on column d_edi_jyutyu_dcm.datd029 is '�����������z';
comment on column d_edi_jyutyu_dcm.datd030 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd031 is '���P��';
comment on column d_edi_jyutyu_dcm.datd032 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd033 is '���P��';
comment on column d_edi_jyutyu_dcm.datd034 is '���g�p';
comment on column d_edi_jyutyu_dcm.datd035 is '�����X�ܐ�';
comment on column d_edi_jyutyu_dcm.datd036 is '�����`�[�ԍ�';
comment on column d_edi_jyutyu_dcm.datd037 is '���g�p';
comment on column d_edi_jyutyu_dcm.jyotai_kbn is '��ԋ敪�i1����M��9���폜�j';
comment on column d_edi_jyutyu_dcm.touroku_date is '�o�^���i���R�[�h�V�K�o�^���ɏo�́j';
comment on column d_edi_jyutyu_dcm.touroku_user_id is '�o�^���[�U�[ID�i�V�j';
comment on column d_edi_jyutyu_dcm.touroku_client_id is '�o�^�N���C�A���gID�i�V�j';
comment on column d_edi_jyutyu_dcm.touroku_pg_id is '�o�^�v���O����ID�i�V�j';
comment on column d_edi_jyutyu_dcm.henkou_date is '�ύX���i���[�U�[���o�^�������e��ύX����ꍇ�̂ݍX�V�i���R�[�h�V�K�o�͎���NULL�l�j�j';
comment on column d_edi_jyutyu_dcm.henkou_user_id is '�ύX���[�U�[ID�i�V�j';
comment on column d_edi_jyutyu_dcm.henkou_client_id is '�ύX�N���C�A���gID�i�V�j';
comment on column d_edi_jyutyu_dcm.henkou_pg_id is '�ύX�v���O����ID�i�V�j';
comment on column d_edi_jyutyu_dcm.kousin_date is '�X�V���i���R�[�h�X�V���͏�ɍX�V�i���R�[�h�V�K�o�͎���NULL�l�j�j';
comment on column d_edi_jyutyu_dcm.kousin_user_id is '�X�V���[�U�[ID�i�V�j';
comment on column d_edi_jyutyu_dcm.kousin_client_id is '�X�V�N���C�A���gID�i�V�j';
comment on column d_edi_jyutyu_dcm.kousin_pg_id is '�X�V�v���O����ID�i�V�j';
comment on column d_edi_jyutyu_dcm.haita_flg is '�r���t���O�i1�����[�U�[�܂��̓V�X�e���ɂ��r����ԁi�ߊσ��b�N�j�j';

/
