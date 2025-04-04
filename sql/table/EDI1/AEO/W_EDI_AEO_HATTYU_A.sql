--------------------------------------------------------------------------------
-- 0) テーブル削除
--------------------------------------------------------------------------------
DROP TABLE W_EDI_AEO_HATTYU_A;

--------------------------------------------------------------------------------
-- 1) テーブル作成
--------------------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE W_EDI_AEO_HATTYU_A (
    -- 行番号1
    LINE1    NUMBER(4),       -- 行番号1（小数桁0なので NUMBER(4) としています）

    -- 1～8 の項目
    BMSA001  VARCHAR2(1),     -- 識別子(A)
    BMSA002  VARCHAR2(13),    -- 支払法人コード
    BMSA003  VARCHAR2(13),    -- 支払法人GLN
    BMSA004  VARCHAR2(13),    -- 発注者コード
    BMSA005  VARCHAR2(13),    -- 発注者GLN
    BMSA006  VARCHAR2(40),    -- 発注者名称
    BMSA007  VARCHAR2(20),    -- 発注者名称カナ
    BMSA008  VARCHAR2(1087),  -- 予備
    CONSTRAINT PK_W_EDI_AEO_HATTYU_A PRIMARY KEY (LINE1) ENABLE
)
ON COMMIT DELETE ROWS;

--------------------------------------------------------------------------------
-- 2) テーブルコメント
--------------------------------------------------------------------------------
COMMENT ON TABLE W_EDI_AEO_HATTYU_A IS 'EDI発注データ（流通BMS）Aレコードワーク';

--------------------------------------------------------------------------------
-- 3) カラムコメント
--------------------------------------------------------------------------------

COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.LINE1   IS '行番号1';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA001 IS '識別子(A)';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA002 IS '支払法人コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA003 IS '支払法人GLN';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA004 IS '発注者コード';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA005 IS '発注者GLN';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA006 IS '発注者名称';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA007 IS '発注者名称カナ';
COMMENT ON COLUMN W_EDI_AEO_HATTYU_A.BMSA008 IS '予備';
