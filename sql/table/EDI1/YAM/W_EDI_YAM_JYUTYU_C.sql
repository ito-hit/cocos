--------------------------------------------------------------------------------
-- 0) テーブル削除
--------------------------------------------------------------------------------
DROP TABLE W_EDI_YAM_JYUTYU_C;

--------------------------------------------------------------------------------
-- 1) テーブル作成
--------------------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE W_EDI_YAM_JYUTYU_C (
    LINE1   NUMBER(4),          -- 行番号1
    LINE2   NUMBER(4),          -- 行番号2
    LINE3   NUMBER(4),          -- 行番号3
    DATC001 VARCHAR2(1),        -- 識別子"C"
    DATC002 VARCHAR2(4),        -- 取引明細番号
    DATC003 VARCHAR2(4),        -- 取引付属明細番号
    DATC004 VARCHAR2(10),       -- 商品分類（小）
    DATC005 VARCHAR2(10),       -- 商品分類（細）
    DATC006 VARCHAR2(8),        -- 配達予定日
    DATC007 VARCHAR2(8),        -- 納品期限
    DATC008 VARCHAR2(2),        -- センター納品詳細指示
    DATC009 VARCHAR2(13),       -- メーカーコード
    DATC010 VARCHAR2(14),       -- 商品コード（GTIN）
    DATC011 VARCHAR2(14),       -- 商品コード（発注用）
    DATC012 VARCHAR2(14),       -- 商品コード（取引先）
    DATC013 VARCHAR2(3),        -- 商品コード区分
    DATC014 VARCHAR2(50),       -- 商品名
    DATC015 VARCHAR2(25),       -- 商品名カナ
    DATC016 VARCHAR2(50),       -- 規格
    DATC017 VARCHAR2(25),       -- 規格カナ
    DATC018 NUMBER(4,0),        -- 入数
    DATC019 VARCHAR2(3),        -- 都道府県コード
    DATC020 VARCHAR2(3),        -- 国コード
    DATC021 VARCHAR2(40),       -- 産地名
    DATC022 VARCHAR2(2),        -- 水域コード
    DATC023 VARCHAR2(40),       -- 水域名
    DATC024 VARCHAR2(60),       -- 原産エリア
    DATC025 VARCHAR2(16),       -- 等級
    DATC026 VARCHAR2(16),       -- 階級
    DATC027 VARCHAR2(60),       -- 銘柄
    DATC028 VARCHAR2(60),       -- 商品ＰＲ
    DATC029 VARCHAR2(2),        -- バイオ区分
    DATC030 VARCHAR2(2),        -- 品種コード
    DATC031 VARCHAR2(2),        -- 養殖区分
    DATC032 VARCHAR2(2),        -- 解凍区分
    DATC033 VARCHAR2(2),        -- 商品状態区分
    DATC034 VARCHAR2(5),        -- 形状・部位
    DATC035 VARCHAR2(40),       -- 用途
    DATC036 VARCHAR2(2),        -- 法定管理義務商材区分
    DATC037 VARCHAR2(10),       -- カラーコード
    DATC038 VARCHAR2(40),       -- カラー名称
    DATC039 VARCHAR2(20),       -- カラー名称カナ
    DATC040 VARCHAR2(10),       -- サイズコード
    DATC041 VARCHAR2(60),       -- サイズ名称
    DATC042 VARCHAR2(30),       -- サイズ名称カナ
    DATC043 NUMBER(10,2),       -- 原単価
    DATC044 NUMBER(10,0),       -- 原価金額
    DATC045 NUMBER(10,0),       -- 売単価
    DATC046 NUMBER(10,0),       -- 売価金額
    DATC047 NUMBER(10,0),       -- 税額
    DATC048 NUMBER(7,1),        -- 発注数量（バラ）
    DATC049 NUMBER(4,0),        -- 発注単位
    DATC050 NUMBER(6,0),        -- 発注数量（発注単位数）
    DATC051 VARCHAR2(2),        -- 発注単位コード
    DATC052 VARCHAR2(2),        -- 発注荷姿コード
    DATC053 NUMBER(10,3),       -- 発注重量
    DATC054 NUMBER(10,3),       -- 取引単位重量
    DATC055 VARCHAR2(2),        -- 単価登録単位
    DATC056 NUMBER(8,3),        -- 商品重量
    CONSTRAINT PK_W_EDI_YAM_JYUTYU_C PRIMARY KEY (LINE1, LINE2, LINE3) ENABLE
)
ON COMMIT DELETE ROWS;

--------------------------------------------------------------------------------
-- 2) テーブルコメント
--------------------------------------------------------------------------------
COMMENT ON TABLE W_EDI_YAM_JYUTYU_C IS 'EDI受注データ（流通BMS）Cレコードワーク';

--------------------------------------------------------------------------------
-- 3) カラムコメントs
--------------------------------------------------------------------------------
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.LINE1   IS '行番号1';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.LINE2   IS '行番号2';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.LINE3   IS '行番号3';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC001 IS '識別子"C"';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC002 IS '取引明細番号';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC003 IS '取引付属明細番号';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC004 IS '商品分類（小）';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC005 IS '商品分類（細）';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC006 IS '配達予定日';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC007 IS '納品期限';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC008 IS 'センター納品詳細指示';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC009 IS 'メーカーコード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC010 IS '商品コード（GTIN）';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC011 IS '商品コード（発注用）';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC012 IS '商品コード（取引先）';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC013 IS '商品コード区分';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC014 IS '商品名';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC015 IS '商品名カナ';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC016 IS '規格';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC017 IS '規格カナ';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC018 IS '入数';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC019 IS '都道府県コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC020 IS '国コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC021 IS '産地名';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC022 IS '水域コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC023 IS '水域名';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC024 IS '原産エリア';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC025 IS '等級';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC026 IS '階級';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC027 IS '銘柄';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC028 IS '商品ＰＲ';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC029 IS 'バイオ区分';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC030 IS '品種コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC031 IS '養殖区分';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC032 IS '解凍区分';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC033 IS '商品状態区分';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC034 IS '形状・部位';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC035 IS '用途';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC036 IS '法定管理義務商材区分';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC037 IS 'カラーコード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC038 IS 'カラー名称';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC039 IS 'カラー名称カナ';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC040 IS 'サイズコード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC041 IS 'サイズ名称';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC042 IS 'サイズ名称カナ';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC043 IS '原単価';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC044 IS '原価金額';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC045 IS '売単価';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC046 IS '売価金額';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC047 IS '税額';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC048 IS '発注数量（バラ）';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC049 IS '発注単位';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC050 IS '発注数量（発注単位数）';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC051 IS '発注単位コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC052 IS '発注荷姿コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC053 IS '発注重量';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC054 IS '取引単位重量';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC055 IS '単価登録単位';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_C.DATC056 IS '商品重量';
