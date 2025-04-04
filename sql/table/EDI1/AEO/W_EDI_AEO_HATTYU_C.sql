--------------------------------------------------------------------------------
-- 0) テーブル削除
--------------------------------------------------------------------------------
DROP TABLE W_EDI_AEO_HATTYU_C;

--------------------------------------------------------------------------------
-- 1) テーブル作成
--------------------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE W_EDI_AEO_HATTYU_C (
    LINE1   NUMBER(4),          -- 行番号1
    LINE2   NUMBER(4),          -- 行番号2
    LINE3   NUMBER(4),          -- 行番号3
    BMSC001 VARCHAR2(1),        -- 識別子"C"
    BMSC002 VARCHAR2(4),        -- 取引明細番号
    BMSC003 VARCHAR2(4),        -- 取引付属明細番号
    BMSC004 VARCHAR2(10),       -- 商品分類（小）
    BMSC005 VARCHAR2(10),       -- 商品分類（細）
    BMSC006 CHAR(8),            -- 配達予定日
    BMSC007 VARCHAR2(8),        -- 納品期限
    BMSC008 VARCHAR2(2),        -- センター納品詳細指示
    BMSC009 VARCHAR2(13),       -- メーカーコード
    BMSC010 VARCHAR2(14),       -- 商品コード（GTIN）
    BMSC011 VARCHAR2(14),       -- 商品コード（発注用）
    BMSC012 VARCHAR2(14),       -- 商品コード（取引先）
    BMSC013 VARCHAR2(3),        -- 商品コード区分
    BMSC014 VARCHAR2(50),       -- 商品名
    BMSC015 VARCHAR2(25),       -- 商品名カナ
    BMSC016 VARCHAR2(50),       -- 規格
    BMSC017 VARCHAR2(25),       -- 規格カナ
    BMSC018 NUMBER(4,0),        -- 入数
    BMSC019 VARCHAR2(3),        -- 都道府県コード
    BMSC020 VARCHAR2(3),        -- 国コード
    BMSC021 VARCHAR2(40),       -- 産地名
    BMSC022 VARCHAR2(2),        -- 水域コード
    BMSC023 VARCHAR2(40),       -- 水域名
    BMSC024 VARCHAR2(60),       -- 原産エリア
    BMSC025 VARCHAR2(8),        -- 等級
    BMSC026 VARCHAR2(8),        -- 階級
    BMSC027 VARCHAR2(60),       -- 銘柄
    BMSC028 VARCHAR2(60),       -- 商品ＰＲ
    BMSC029 VARCHAR2(2),        -- バイオ区分
    BMSC030 VARCHAR2(2),        -- 品種コード
    BMSC031 VARCHAR2(2),        -- 養殖区分
    BMSC032 VARCHAR2(2),        -- 解凍区分
    BMSC033 VARCHAR2(2),        -- 商品状態区分
    BMSC034 VARCHAR2(10),       -- 形状・部位
    BMSC035 VARCHAR2(40),       -- 用途
    BMSC036 VARCHAR2(2),        -- 法定管理義務商材区分
    BMSC037 VARCHAR2(10),       -- カラーコード
    BMSC038 VARCHAR2(40),       -- カラー名称
    BMSC039 VARCHAR2(20),       -- カラー名称カナ
    BMSC040 VARCHAR2(10),       -- サイズコード
    BMSC041 VARCHAR2(60),       -- サイズ名称
    BMSC042 VARCHAR2(30),       -- サイズ名称カナ
    BMSC043 NUMBER(12,2),       -- 原単価
    BMSC044 NUMBER(10,0),       -- 原価金額
    BMSC045 NUMBER(10,0),       -- 売単価
    BMSC046 NUMBER(10,0),       -- 売価金額
    BMSC047 NUMBER(10,0),       -- 税額
    BMSC048 NUMBER(8,1),        -- 発注数量（バラ）
    BMSC049 NUMBER(4,0),        -- 発注単位
    BMSC050 NUMBER(6,0),        -- 発注数量（発注単位数）
    BMSC051 VARCHAR2(2),        -- 発注単位コード
    BMSC052 VARCHAR2(2),        -- 発注荷姿コード
    BMSC053 NUMBER(13,3),       -- 発注重量
    BMSC054 NUMBER(13,3),       -- 取引単位重量
    BMSC055 VARCHAR2(2),        -- 単価登録単位
    BMSC056 NUMBER(11,3),        -- 商品重量
    BMSC057 VARCHAR2(324),      -- （空白）
    CONSTRAINT PK_W_EDI_AEO_HATTYU_C PRIMARY KEY (LINE1, LINE2, LINE3) ENABLE
)
ON COMMIT DELETE ROWS;

--------------------------------------------------------------------------------
-- 2) テーブルコメント
--------------------------------------------------------------------------------
COMMENT ON TABLE W_EDI_AEO_HATTYU_C IS 'EDI発注データ（流通BMS）Cレコードワーク';

--------------------------------------------------------------------------------
-- 3) カラムコメントs
--------------------------------------------------------------------------------
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.LINE1   IS '行番号1';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.LINE2   IS '行番号2';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.LINE3   IS '行番号3';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC001 IS '識別子"C"';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC002 IS '取引明細番号';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC003 IS '取引付属明細番号';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC004 IS '商品分類（小）';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC005 IS '商品分類（細）';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC006 IS '配達予定日';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC007 IS '納品期限';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC008 IS 'センター納品詳細指示';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC009 IS 'メーカーコード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC010 IS '商品コード（GTIN）';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC011 IS '商品コード（発注用）';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC012 IS '商品コード（取引先）';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC013 IS '商品コード区分';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC014 IS '商品名';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC015 IS '商品名カナ';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC016 IS '規格';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC017 IS '規格カナ';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC018 IS '入数';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC019 IS '都道府県コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC020 IS '国コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC021 IS '産地名';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC022 IS '水域コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC023 IS '水域名';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC024 IS '原産エリア';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC025 IS '等級';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC026 IS '階級';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC027 IS '銘柄';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC028 IS '商品ＰＲ';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC029 IS 'バイオ区分';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC030 IS '品種コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC031 IS '養殖区分';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC032 IS '解凍区分';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC033 IS '商品状態区分';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC034 IS '形状・部位';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC035 IS '用途';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC036 IS '法定管理義務商材区分';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC037 IS 'カラーコード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC038 IS 'カラー名称';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC039 IS 'カラー名称カナ';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC040 IS 'サイズコード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC041 IS 'サイズ名称';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC042 IS 'サイズ名称カナ';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC043 IS '原単価';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC044 IS '原価金額';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC045 IS '売単価';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC046 IS '売価金額';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC047 IS '税額';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC048 IS '発注数量（バラ）';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC049 IS '発注単位';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC050 IS '発注数量（発注単位数）';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC051 IS '発注単位コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC052 IS '発注荷姿コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC053 IS '発注重量';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC054 IS '取引単位重量';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC055 IS '単価登録単位';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC056 IS '商品重量';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_C.BMSC057 IS '（空白）';
