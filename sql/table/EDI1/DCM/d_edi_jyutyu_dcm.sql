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

comment on column d_edi_jyutyu_dcm.edi_kyoten_code is 'EDI拠点コード（EDIデータを取り込んだ拠点のコード）';
comment on column d_edi_jyutyu_dcm.edi_jyusin_no is 'EDI受信番号（EDIデータ受信単位に付番する（基本情報マスターの処理日+seq_edi_jyusin_no））';
comment on column d_edi_jyutyu_dcm.edi_jyusin_date is 'EDI受信日（EDIデータを取り込んだ日）';
comment on column d_edi_jyutyu_dcm.edi_tokui_code is 'EDI得意先コード（EDI得意先コード（代表得意先））';
comment on column d_edi_jyutyu_dcm.edi_rec_no is 'EDIレコード番号（共通受注データレコードとの紐付け番号（seq_edirec_no））※主キー①';
comment on column d_edi_jyutyu_dcm.dath001 is 'タグHD（タグ（HD）ヘッダー情報）';
comment on column d_edi_jyutyu_dcm.dath002 is 'メッセージID';
comment on column d_edi_jyutyu_dcm.dath003 is '未使用';
comment on column d_edi_jyutyu_dcm.dath004 is '発注伝票番号';
comment on column d_edi_jyutyu_dcm.dath005 is '未使用';
comment on column d_edi_jyutyu_dcm.dath006 is '発注処理日';
comment on column d_edi_jyutyu_dcm.dath007 is '未使用';
comment on column d_edi_jyutyu_dcm.dath008 is '納品開始日';
comment on column d_edi_jyutyu_dcm.dath009 is '納品終了日';
comment on column d_edi_jyutyu_dcm.dath010 is '発注日';
comment on column d_edi_jyutyu_dcm.dath011 is '未使用';
comment on column d_edi_jyutyu_dcm.dath012 is '納品指定日';
comment on column d_edi_jyutyu_dcm.dath013 is '未使用';
comment on column d_edi_jyutyu_dcm.dath014 is '特売コード';
comment on column d_edi_jyutyu_dcm.dath015 is '未使用';
comment on column d_edi_jyutyu_dcm.dath016 is '支払条件';
comment on column d_edi_jyutyu_dcm.dath017 is '未使用';
comment on column d_edi_jyutyu_dcm.dath018 is '伝票種別';
comment on column d_edi_jyutyu_dcm.dath019 is '未使用';
comment on column d_edi_jyutyu_dcm.dath020 is '伝票区分';
comment on column d_edi_jyutyu_dcm.dath021 is '未使用';
comment on column d_edi_jyutyu_dcm.dath022 is '発注種別区分';
comment on column d_edi_jyutyu_dcm.dath023 is '納品区分';
comment on column d_edi_jyutyu_dcm.dath024 is '未使用';
comment on column d_edi_jyutyu_dcm.dath025 is '宅配区分';
comment on column d_edi_jyutyu_dcm.dath026 is '未使用';
comment on column d_edi_jyutyu_dcm.dath027 is '発注企業コード';
comment on column d_edi_jyutyu_dcm.dath028 is '未使用';
comment on column d_edi_jyutyu_dcm.dath029 is '発注企業名称（カナ）';
comment on column d_edi_jyutyu_dcm.dath030 is '未使用';
comment on column d_edi_jyutyu_dcm.dath031 is '発注企業名称（漢字）';
comment on column d_edi_jyutyu_dcm.dath032 is '未使用';
comment on column d_edi_jyutyu_dcm.dath033 is '拠点コード';
comment on column d_edi_jyutyu_dcm.dath034 is '未使用';
comment on column d_edi_jyutyu_dcm.dath035 is '部門コード';
comment on column d_edi_jyutyu_dcm.dath036 is '未使用';
comment on column d_edi_jyutyu_dcm.dath037 is '部門名（カナ）';
comment on column d_edi_jyutyu_dcm.dath038 is '未使用';
comment on column d_edi_jyutyu_dcm.dath039 is '部門名（漢字）';
comment on column d_edi_jyutyu_dcm.dath040 is '未使用';
comment on column d_edi_jyutyu_dcm.dath041 is 'ゾーンコード';
comment on column d_edi_jyutyu_dcm.dath042 is '未使用';
comment on column d_edi_jyutyu_dcm.dath043 is 'ゾーン名（漢字）';
comment on column d_edi_jyutyu_dcm.dath044 is '未使用';
comment on column d_edi_jyutyu_dcm.dath045 is 'GLN発注企業コード';
comment on column d_edi_jyutyu_dcm.dath046 is '未使用';
comment on column d_edi_jyutyu_dcm.dath047 is 'ブロックコード';
comment on column d_edi_jyutyu_dcm.dath048 is '未使用';
comment on column d_edi_jyutyu_dcm.dath049 is 'ブロックコード名称（カナ）';
comment on column d_edi_jyutyu_dcm.dath050 is 'ブロックコード名称（漢字）';
comment on column d_edi_jyutyu_dcm.dath051 is '納品先コード';
comment on column d_edi_jyutyu_dcm.dath052 is '未使用';
comment on column d_edi_jyutyu_dcm.dath053 is '納品先名称（カナ）';
comment on column d_edi_jyutyu_dcm.dath054 is '未使用';
comment on column d_edi_jyutyu_dcm.dath055 is '納品先名称（漢字）';
comment on column d_edi_jyutyu_dcm.dath056 is '未使用';
comment on column d_edi_jyutyu_dcm.dath057 is '納品センターブロックコード';
comment on column d_edi_jyutyu_dcm.dath058 is '未使用';
comment on column d_edi_jyutyu_dcm.dath059 is '納品ｾﾝﾀｰコード';
comment on column d_edi_jyutyu_dcm.dath060 is '未使用';
comment on column d_edi_jyutyu_dcm.dath061 is '納品ｾﾝﾀｰ名称（カナ）';
comment on column d_edi_jyutyu_dcm.dath062 is '未使用';
comment on column d_edi_jyutyu_dcm.dath063 is '納品ｾﾝﾀｰ名称（漢字）';
comment on column d_edi_jyutyu_dcm.dath064 is '未使用';
comment on column d_edi_jyutyu_dcm.dath065 is '館番号';
comment on column d_edi_jyutyu_dcm.dath066 is '未使用';
comment on column d_edi_jyutyu_dcm.dath067 is '共通取引先コード';
comment on column d_edi_jyutyu_dcm.dath068 is '共通取引先制御コード';
comment on column d_edi_jyutyu_dcm.dath069 is '未使用';
comment on column d_edi_jyutyu_dcm.dath070 is '取引先名称（カナ）';
comment on column d_edi_jyutyu_dcm.dath071 is '取引先名称（漢字）';
comment on column d_edi_jyutyu_dcm.dath072 is '未使用';
comment on column d_edi_jyutyu_dcm.dath073 is '個別取引先コード';
comment on column d_edi_jyutyu_dcm.dath074 is '未使用';
comment on column d_edi_jyutyu_dcm.dath075 is '直送コード';
comment on column d_edi_jyutyu_dcm.dath076 is '未使用';
comment on column d_edi_jyutyu_dcm.dath077 is '申込票番号';
comment on column d_edi_jyutyu_dcm.dath078 is '未使用';
comment on column d_edi_jyutyu_dcm.dath079 is '税率';
comment on column d_edi_jyutyu_dcm.dath080 is '未使用';
comment on column d_edi_jyutyu_dcm.dath081 is '税区分';
comment on column d_edi_jyutyu_dcm.dath082 is '未使用';
comment on column d_edi_jyutyu_dcm.datd001 is 'タグDT（タグ（DT）明細情報）';
comment on column d_edi_jyutyu_dcm.datd002 is 'JANコード';
comment on column d_edi_jyutyu_dcm.datd003 is '発注伝票行番号';
comment on column d_edi_jyutyu_dcm.datd004 is '未使用';
comment on column d_edi_jyutyu_dcm.datd005 is '商品コード';
comment on column d_edi_jyutyu_dcm.datd006 is '未使用';
comment on column d_edi_jyutyu_dcm.datd007 is '分類';
comment on column d_edi_jyutyu_dcm.datd008 is '未使用';
comment on column d_edi_jyutyu_dcm.datd009 is 'パターンNO．';
comment on column d_edi_jyutyu_dcm.datd010 is '未使用';
comment on column d_edi_jyutyu_dcm.datd011 is 'パターン名称';
comment on column d_edi_jyutyu_dcm.datd012 is '未使用';
comment on column d_edi_jyutyu_dcm.datd013 is '商品名（カナ）';
comment on column d_edi_jyutyu_dcm.datd014 is '商品名（漢字）';
comment on column d_edi_jyutyu_dcm.datd015 is '商品規格名称（カナ）';
comment on column d_edi_jyutyu_dcm.datd016 is '商品規格名称（漢字）';
comment on column d_edi_jyutyu_dcm.datd017 is 'ゴンドラ番号';
comment on column d_edi_jyutyu_dcm.datd018 is '未使用';
comment on column d_edi_jyutyu_dcm.datd019 is '発注単位区分';
comment on column d_edi_jyutyu_dcm.datd020 is '未使用';
comment on column d_edi_jyutyu_dcm.datd021 is '形状区分';
comment on column d_edi_jyutyu_dcm.datd022 is '未使用';
comment on column d_edi_jyutyu_dcm.datd023 is '発注数量';
comment on column d_edi_jyutyu_dcm.datd024 is '未使用';
comment on column d_edi_jyutyu_dcm.datd025 is '発注単位数';
comment on column d_edi_jyutyu_dcm.datd026 is '発注単位入数';
comment on column d_edi_jyutyu_dcm.datd027 is '未使用';
comment on column d_edi_jyutyu_dcm.datd028 is '発注原価金額';
comment on column d_edi_jyutyu_dcm.datd029 is '発注売価金額';
comment on column d_edi_jyutyu_dcm.datd030 is '未使用';
comment on column d_edi_jyutyu_dcm.datd031 is '原単価';
comment on column d_edi_jyutyu_dcm.datd032 is '未使用';
comment on column d_edi_jyutyu_dcm.datd033 is '売単価';
comment on column d_edi_jyutyu_dcm.datd034 is '未使用';
comment on column d_edi_jyutyu_dcm.datd035 is '発注店舗数';
comment on column d_edi_jyutyu_dcm.datd036 is '発注伝票番号';
comment on column d_edi_jyutyu_dcm.datd037 is '未使用';
comment on column d_edi_jyutyu_dcm.jyotai_kbn is '状態区分（1＝受信済9＝削除）';
comment on column d_edi_jyutyu_dcm.touroku_date is '登録日（レコード新規登録時に出力）';
comment on column d_edi_jyutyu_dcm.touroku_user_id is '登録ユーザーID（〃）';
comment on column d_edi_jyutyu_dcm.touroku_client_id is '登録クライアントID（〃）';
comment on column d_edi_jyutyu_dcm.touroku_pg_id is '登録プログラムID（〃）';
comment on column d_edi_jyutyu_dcm.henkou_date is '変更日（ユーザーが登録した内容を変更する場合のみ更新（レコード新規出力時はNULL値））';
comment on column d_edi_jyutyu_dcm.henkou_user_id is '変更ユーザーID（〃）';
comment on column d_edi_jyutyu_dcm.henkou_client_id is '変更クライアントID（〃）';
comment on column d_edi_jyutyu_dcm.henkou_pg_id is '変更プログラムID（〃）';
comment on column d_edi_jyutyu_dcm.kousin_date is '更新日（レコード更新時は常に更新（レコード新規出力時はNULL値））';
comment on column d_edi_jyutyu_dcm.kousin_user_id is '更新ユーザーID（〃）';
comment on column d_edi_jyutyu_dcm.kousin_client_id is '更新クライアントID（〃）';
comment on column d_edi_jyutyu_dcm.kousin_pg_id is '更新プログラムID（〃）';
comment on column d_edi_jyutyu_dcm.haita_flg is '排他フラグ（1＝ユーザーまたはシステムによる排他状態（悲観ロック））';

/
