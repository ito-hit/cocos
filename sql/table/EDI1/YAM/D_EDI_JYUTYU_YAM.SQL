drop table d_edi_jyutyu_yam;

create table d_edi_jyutyu_yam(
	edi_kyoten_code			number(3)			default 0,
	edi_jyusin_no			number(10)			default 0,
	edi_jyusin_date			number(8)			default 0,
	edi_tokui_code			number(6)			default 0,
	edi_rec_no				number(10)			default null,
	dath001					varchar2(1)			default null,
	dath002					varchar2(20)		default null,
	dath003					varchar2(20)		default null,
	dath004					varchar2(20)		default null,
	dath005					varchar2(20)		default null,
	dath006					varchar2(2)			default null,
	dath007					varchar2(50)		default null,
	dath008					varchar2(10)		default null,
	dath009					varchar2(19)		default null,
	dath010					varchar2(10)		default null,
	dath011					varchar2(20)		default null,
	dath012					varchar2(50)		default null,
	dath013					varchar2(8)			default null,
	dath014					varchar2(8)			default null,
	dath015					varchar2(8)			default null,
	dath016					number(7)			default 0,
	data001					varchar2(1)			default null,
	data002					varchar2(13)		default null,
	data003					varchar2(13)		default null,
	data004					varchar2(13)		default null,
	data005					varchar2(13)		default null,
	data006					varchar2(40)		default null,
	data007					varchar2(20)		default null,
	datb001					varchar2(1)			default null,
	datb002					varchar2(10)		default null,
	datb003					varchar2(10)		default null,
	datb004					varchar2(13)		default null,
	datb005					varchar2(13)		default null,
	datb006					varchar2(40)		default null,
	datb007					varchar2(20)		default null,
	datb008					varchar2(13)		default null,
	datb009					varchar2(13)		default null,
	datb010					varchar2(40)		default null,
	datb011					varchar2(20)		default null,
	datb012					varchar2(13)		default null,
	datb013					varchar2(13)		default null,
	datb014					varchar2(20)		default null,
	datb015					varchar2(13)		default null,
	datb016					varchar2(40)		default null,
	datb017					varchar2(20)		default null,
	datb018					varchar2(13)		default null,
	datb019					varchar2(13)		default null,
	datb020					varchar2(40)		default null,
	datb021					varchar2(20)		default null,
	datb022					varchar2(13)		default null,
	datb023					varchar2(13)		default null,
	datb024					varchar2(40)		default null,
	datb025					varchar2(20)		default null,
	datb026					varchar2(2)			default null,
	datb027					varchar2(4)			default null,
	datb028					varchar2(13)		default null,
	datb029					varchar2(2)			default null,
	datb030					varchar2(2)			default null,
	datb031					varchar2(2)			default null,
	datb032					varchar2(2)			default null,
	datb033					varchar2(6)			default null,
	datb034					varchar2(13)		default null,
	datb035					varchar2(10)		default null,
	datb036					varchar2(10)		default null,
	datb037					varchar2(10)		default null,
	datb038					varchar2(120)		default null,
	datb039					varchar2(60)		default null,
	datb040					varchar2(10)		default null,
	datb041					varchar2(10)		default null,
	datb042					varchar2(8)			default null,
	datb043					varchar2(8)			default null,
	datb044					varchar2(8)			default null,
	datb045					varchar2(8)			default null,
	datb046					varchar2(8)			default null,
	datb047					varchar2(8)			default null,
	datb048					varchar2(8)			default null,
	datb049					varchar2(2)			default null,
	datb050					varchar2(2)			default null,
	datb051					varchar2(2)			default null,
	datb052					varchar2(2)			default null,
	datb053					varchar2(2)			default null,
	datb054					varchar2(2)			default null,
	datb055					varchar2(2)			default null,
	datb056					varchar2(2)			default null,
	datb057					varchar2(2)			default null,
	datb058					varchar2(2)			default null,
	datb059					varchar2(2)			default null,
	datb060					varchar2(2)			default null,
	datb061					number(3,1)			default 0,
	datb062					varchar2(120)		default null,
	datb063					varchar2(60)		default null,
	datb064					number(10)			default 0,
	datb065					number(10)			default 0,
	datb066					number(10)			default 0,
	datb067					number(6)			default 0,
	datb068					number(6)			default 0,
	datb069					number(13,3)		default 0,
	datc001					varchar2(1)			default null,
	datc002					varchar2(4)			default null,
	datc003					varchar2(4)			default null,
	datc004					varchar2(10)		default null,
	datc005					varchar2(10)		default null,
	datc006					varchar2(8)			default null,
	datc007					varchar2(8)			default null,
	datc008					varchar2(2)			default null,
	datc009					varchar2(13)		default null,
	datc010					varchar2(14)		default null,
	datc011					varchar2(14)		default null,
	datc012					varchar2(14)		default null,
	datc013					varchar2(3)			default null,
	datc014					varchar2(50)		default null,
	datc015					varchar2(25)		default null,
	datc016					varchar2(50)		default null,
	datc017					varchar2(25)		default null,
	datc018					number(4)			default 0,
	datc019					varchar2(3)			default null,
	datc020					varchar2(3)			default null,
	datc021					varchar2(40)		default null,
	datc022					varchar2(2)			default null,
	datc023					varchar2(40)		default null,
	datc024					varchar2(60)		default null,
	datc025					varchar2(16)		default null,
	datc026					varchar2(16)		default null,
	datc027					varchar2(60)		default null,
	datc028					varchar2(60)		default null,
	datc029					varchar2(2)			default null,
	datc030					varchar2(2)			default null,
	datc031					varchar2(2)			default null,
	datc032					varchar2(2)			default null,
	datc033					varchar2(2)			default null,
	datc034					varchar2(5)			default null,
	datc035					varchar2(40)		default null,
	datc036					varchar2(2)			default null,
	datc037					varchar2(10)		default null,
	datc038					varchar2(40)		default null,
	datc039					varchar2(20)		default null,
	datc040					varchar2(10)		default null,
	datc041					varchar2(60)		default null,
	datc042					varchar2(30)		default null,
	datc043					number(10,2)		default 0,
	datc044					number(10)			default 0,
	datc045					number(10)			default 0,
	datc046					number(10)			default 0,
	datc047					number(10)			default 0,
	datc048					number(7,1)			default 0,
	datc049					number(4)			default 0,
	datc050					number(6)			default 0,
	datc051					varchar2(2)			default null,
	datc052					varchar2(2)			default null,
	datc053					number(10,3)		default 0,
	datc054					number(10,3)		default 0,
	datc055					varchar2(2)			default null,
	datc056					number(8,3)			default 0,
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

	constraint d_edi_jyutyu_yam_pidx_1
	primary key ( edi_rec_no )
	using index pctfree 20 tablespace hanbai_index_1
	storage( initial 9k next 8k )
)
tablespace hanbai_data_1
storage( initial 2m next 128k );
/

comment on column d_edi_jyutyu_yam.edi_kyoten_code is 'EDI拠点コード（EDIデータを取り込んだ拠点のコード）';
comment on column d_edi_jyutyu_yam.edi_jyusin_no is 'EDI受信番号（EDIデータ受信単位に付番する（基本情報マスターの処理日+seq_edi_jyusin_no））';
comment on column d_edi_jyutyu_yam.edi_jyusin_date is 'EDI受信日（EDIデータを取り込んだ日）';
comment on column d_edi_jyutyu_yam.edi_tokui_code is 'EDI得意先コード（EDI得意先コード（代表得意先））';
comment on column d_edi_jyutyu_yam.edi_rec_no is 'EDIレコード番号（共通受注データレコードとの紐付け番号（seq_edirec_no））※主キー①';
comment on column d_edi_jyutyu_yam.dath001 is '識別子H（SBDHレコード識別子（H））';
comment on column d_edi_jyutyu_yam.dath002 is '送信者ID';
comment on column d_edi_jyutyu_yam.dath003 is '送信者ID発行元';
comment on column d_edi_jyutyu_yam.dath004 is '受信者ID';
comment on column d_edi_jyutyu_yam.dath005 is '受信者ID発行元';
comment on column d_edi_jyutyu_yam.dath006 is 'バージョン';
comment on column d_edi_jyutyu_yam.dath007 is 'インスタンスID';
comment on column d_edi_jyutyu_yam.dath008 is 'メッセージ種';
comment on column d_edi_jyutyu_yam.dath009 is '作成日時';
comment on column d_edi_jyutyu_yam.dath010 is 'テスト区分ID';
comment on column d_edi_jyutyu_yam.dath011 is '最終送信先ID';
comment on column d_edi_jyutyu_yam.dath012 is 'メッセージ識別ID';
comment on column d_edi_jyutyu_yam.dath013 is '送信者ステーションアドレス';
comment on column d_edi_jyutyu_yam.dath014 is '最終受信者ステーションアドレス';
comment on column d_edi_jyutyu_yam.dath015 is '直接受信者ステーションアドレス';
comment on column d_edi_jyutyu_yam.dath016 is '取引数';
comment on column d_edi_jyutyu_yam.data001 is '識別子A（発注リストレコード識別子（A））';
comment on column d_edi_jyutyu_yam.data002 is '支払法人コード';
comment on column d_edi_jyutyu_yam.data003 is '支払法人GLN';
comment on column d_edi_jyutyu_yam.data004 is '発注者コード';
comment on column d_edi_jyutyu_yam.data005 is '発注者GLN';
comment on column d_edi_jyutyu_yam.data006 is '発注者名称';
comment on column d_edi_jyutyu_yam.data007 is '発注者名称カナ';
comment on column d_edi_jyutyu_yam.datb001 is '識別子B（取引レコード識別子（B））';
comment on column d_edi_jyutyu_yam.datb002 is '取引番号（発注・返品）';
comment on column d_edi_jyutyu_yam.datb003 is '取引付属番号';
comment on column d_edi_jyutyu_yam.datb004 is '直接納品先コード';
comment on column d_edi_jyutyu_yam.datb005 is '直接納品先GLN';
comment on column d_edi_jyutyu_yam.datb006 is '直接納品先名称';
comment on column d_edi_jyutyu_yam.datb007 is '直接納品先名称カナ';
comment on column d_edi_jyutyu_yam.datb008 is '最終納品先コード';
comment on column d_edi_jyutyu_yam.datb009 is '最終納品先GLN';
comment on column d_edi_jyutyu_yam.datb010 is '最終納品先名称';
comment on column d_edi_jyutyu_yam.datb011 is '最終納品先名称カナ';
comment on column d_edi_jyutyu_yam.datb012 is '計上部署コード';
comment on column d_edi_jyutyu_yam.datb013 is '計上部署GLN';
comment on column d_edi_jyutyu_yam.datb014 is '計上部署名称カナ';
comment on column d_edi_jyutyu_yam.datb015 is '陳列場所コード';
comment on column d_edi_jyutyu_yam.datb016 is '陳列場所名称';
comment on column d_edi_jyutyu_yam.datb017 is '陳列場所名称カナ';
comment on column d_edi_jyutyu_yam.datb018 is '請求取引先コード';
comment on column d_edi_jyutyu_yam.datb019 is '請求取引先GLN';
comment on column d_edi_jyutyu_yam.datb020 is '請求取引先名';
comment on column d_edi_jyutyu_yam.datb021 is '請求取引先名カナ';
comment on column d_edi_jyutyu_yam.datb022 is '取引先コード';
comment on column d_edi_jyutyu_yam.datb023 is '取引先GLN';
comment on column d_edi_jyutyu_yam.datb024 is '取引先名称';
comment on column d_edi_jyutyu_yam.datb025 is '取引先名称カナ';
comment on column d_edi_jyutyu_yam.datb026 is '枝番';
comment on column d_edi_jyutyu_yam.datb027 is '出荷先コード';
comment on column d_edi_jyutyu_yam.datb028 is '出荷場所GLN';
comment on column d_edi_jyutyu_yam.datb029 is '納品経路';
comment on column d_edi_jyutyu_yam.datb030 is '便No';
comment on column d_edi_jyutyu_yam.datb031 is '通過在庫区分';
comment on column d_edi_jyutyu_yam.datb032 is '納品区分';
comment on column d_edi_jyutyu_yam.datb033 is '指定納品時刻';
comment on column d_edi_jyutyu_yam.datb034 is 'バーコード情報';
comment on column d_edi_jyutyu_yam.datb035 is 'カテゴリー名称1（印字用）';
comment on column d_edi_jyutyu_yam.datb036 is 'カテゴリー名称2（印字用）';
comment on column d_edi_jyutyu_yam.datb037 is '最終納品先略称（印字用）';
comment on column d_edi_jyutyu_yam.datb038 is 'ラベル自由使用欄（印字用）';
comment on column d_edi_jyutyu_yam.datb039 is 'ラベル自由使用欄半角カナ（印字用）';
comment on column d_edi_jyutyu_yam.datb040 is '商品分類（大）';
comment on column d_edi_jyutyu_yam.datb041 is '商品分類（中）';
comment on column d_edi_jyutyu_yam.datb042 is '発注日';
comment on column d_edi_jyutyu_yam.datb043 is '直接納品先納品日';
comment on column d_edi_jyutyu_yam.datb044 is '最終納品先納品日';
comment on column d_edi_jyutyu_yam.datb045 is '計上日';
comment on column d_edi_jyutyu_yam.datb046 is '販促開始日';
comment on column d_edi_jyutyu_yam.datb047 is '販促終了日';
comment on column d_edi_jyutyu_yam.datb048 is '取引（発注・返品）データ有効日';
comment on column d_edi_jyutyu_yam.datb049 is '商品区分';
comment on column d_edi_jyutyu_yam.datb050 is '発注区分';
comment on column d_edi_jyutyu_yam.datb051 is '出荷データ有無区分';
comment on column d_edi_jyutyu_yam.datb052 is '取引番号区分';
comment on column d_edi_jyutyu_yam.datb053 is 'PB区分';
comment on column d_edi_jyutyu_yam.datb054 is '配送温度区分';
comment on column d_edi_jyutyu_yam.datb055 is '酒区分';
comment on column d_edi_jyutyu_yam.datb056 is 'パック区分';
comment on column d_edi_jyutyu_yam.datb057 is '不定貫区分';
comment on column d_edi_jyutyu_yam.datb058 is '処理種別';
comment on column d_edi_jyutyu_yam.datb059 is '伝票レス区分';
comment on column d_edi_jyutyu_yam.datb060 is '税区分';
comment on column d_edi_jyutyu_yam.datb061 is '税率';
comment on column d_edi_jyutyu_yam.datb062 is '自由使用欄';
comment on column d_edi_jyutyu_yam.datb063 is '自由使用欄半角カナ';
comment on column d_edi_jyutyu_yam.datb064 is '原価金額合計';
comment on column d_edi_jyutyu_yam.datb065 is '売価金額合計';
comment on column d_edi_jyutyu_yam.datb066 is '税額合計金額';
comment on column d_edi_jyutyu_yam.datb067 is '数量合計';
comment on column d_edi_jyutyu_yam.datb068 is '発注単位数量合計';
comment on column d_edi_jyutyu_yam.datb069 is '重量合計';
comment on column d_edi_jyutyu_yam.datc001 is '識別子C（取引明細レコード識別子（C））';
comment on column d_edi_jyutyu_yam.datc002 is '取引明細番号（発注・返品）';
comment on column d_edi_jyutyu_yam.datc003 is '取引付属明細番号';
comment on column d_edi_jyutyu_yam.datc004 is '商品分類（小）';
comment on column d_edi_jyutyu_yam.datc005 is '商品分類（細）';
comment on column d_edi_jyutyu_yam.datc006 is '配達予定日';
comment on column d_edi_jyutyu_yam.datc007 is '納品期限';
comment on column d_edi_jyutyu_yam.datc008 is 'センター納品詳細指示';
comment on column d_edi_jyutyu_yam.datc009 is 'メーカーコード';
comment on column d_edi_jyutyu_yam.datc010 is '商品コード（GTIN）';
comment on column d_edi_jyutyu_yam.datc011 is '商品コード（発注用）';
comment on column d_edi_jyutyu_yam.datc012 is '商品コード（取引先）';
comment on column d_edi_jyutyu_yam.datc013 is '商品コード区分';
comment on column d_edi_jyutyu_yam.datc014 is '商品名';
comment on column d_edi_jyutyu_yam.datc015 is '商品名カナ';
comment on column d_edi_jyutyu_yam.datc016 is '規格';
comment on column d_edi_jyutyu_yam.datc017 is '規格カナ';
comment on column d_edi_jyutyu_yam.datc018 is '入数';
comment on column d_edi_jyutyu_yam.datc019 is '都道府県コード';
comment on column d_edi_jyutyu_yam.datc020 is '国コード';
comment on column d_edi_jyutyu_yam.datc021 is '産地名';
comment on column d_edi_jyutyu_yam.datc022 is '水域コード';
comment on column d_edi_jyutyu_yam.datc023 is '水域名';
comment on column d_edi_jyutyu_yam.datc024 is '原産エリア';
comment on column d_edi_jyutyu_yam.datc025 is '等級';
comment on column d_edi_jyutyu_yam.datc026 is '階級';
comment on column d_edi_jyutyu_yam.datc027 is '銘柄';
comment on column d_edi_jyutyu_yam.datc028 is '商品PR';
comment on column d_edi_jyutyu_yam.datc029 is 'バイオ区分';
comment on column d_edi_jyutyu_yam.datc030 is '品種コード';
comment on column d_edi_jyutyu_yam.datc031 is '養殖区分';
comment on column d_edi_jyutyu_yam.datc032 is '解凍区分';
comment on column d_edi_jyutyu_yam.datc033 is '商品状態区分';
comment on column d_edi_jyutyu_yam.datc034 is '形状・部位';
comment on column d_edi_jyutyu_yam.datc035 is '用途';
comment on column d_edi_jyutyu_yam.datc036 is '法定管理義務商材区分';
comment on column d_edi_jyutyu_yam.datc037 is 'カラーコード';
comment on column d_edi_jyutyu_yam.datc038 is 'カラー名称';
comment on column d_edi_jyutyu_yam.datc039 is 'カラー名称カナ';
comment on column d_edi_jyutyu_yam.datc040 is 'サイズコード';
comment on column d_edi_jyutyu_yam.datc041 is 'サイズ名称';
comment on column d_edi_jyutyu_yam.datc042 is 'サイズ名称カナ';
comment on column d_edi_jyutyu_yam.datc043 is '原単価';
comment on column d_edi_jyutyu_yam.datc044 is '原価金額';
comment on column d_edi_jyutyu_yam.datc045 is '売単価';
comment on column d_edi_jyutyu_yam.datc046 is '売価金額';
comment on column d_edi_jyutyu_yam.datc047 is '税額';
comment on column d_edi_jyutyu_yam.datc048 is '発注数量（バラ）';
comment on column d_edi_jyutyu_yam.datc049 is '発注単位';
comment on column d_edi_jyutyu_yam.datc050 is '発注数量（発注単位数）';
comment on column d_edi_jyutyu_yam.datc051 is '発注単位コード';
comment on column d_edi_jyutyu_yam.datc052 is '発注荷姿コード';
comment on column d_edi_jyutyu_yam.datc053 is '発注重量';
comment on column d_edi_jyutyu_yam.datc054 is '取引単位重量';
comment on column d_edi_jyutyu_yam.datc055 is '単価登録単位';
comment on column d_edi_jyutyu_yam.datc056 is '商品重量';
comment on column d_edi_jyutyu_yam.jyotai_kbn is '状態区分（1＝受信済9＝削除）';
comment on column d_edi_jyutyu_yam.touroku_date is '登録日（レコード新規登録時に出力）';
comment on column d_edi_jyutyu_yam.touroku_user_id is '登録ユーザーID（〃）';
comment on column d_edi_jyutyu_yam.touroku_client_id is '登録クライアントID（〃）';
comment on column d_edi_jyutyu_yam.touroku_pg_id is '登録プログラムID（〃）';
comment on column d_edi_jyutyu_yam.henkou_date is '変更日（ユーザーが登録した内容を変更する場合のみ更新（レコード新規出力時はNULL値））';
comment on column d_edi_jyutyu_yam.henkou_user_id is '変更ユーザーID（〃）';
comment on column d_edi_jyutyu_yam.henkou_client_id is '変更クライアントID（〃）';
comment on column d_edi_jyutyu_yam.henkou_pg_id is '変更プログラムID（〃）';
comment on column d_edi_jyutyu_yam.kousin_date is '更新日（レコード更新時は常に更新（レコード新規出力時はNULL値））';
comment on column d_edi_jyutyu_yam.kousin_user_id is '更新ユーザーID（〃）';
comment on column d_edi_jyutyu_yam.kousin_client_id is '更新クライアントID（〃）';
comment on column d_edi_jyutyu_yam.kousin_pg_id is '更新プログラムID（〃）';
comment on column d_edi_jyutyu_yam.haita_flg is '排他フラグ（1＝ユーザーまたはシステムによる排他状態（悲観ロック））';

/
