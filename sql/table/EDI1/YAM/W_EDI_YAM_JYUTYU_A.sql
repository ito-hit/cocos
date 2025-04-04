--------------------------------------------------------------------------------
-- 0) テーブル削除
--------------------------------------------------------------------------------
DROP TABLE W_EDI_YAM_JYUTYU_A;

--------------------------------------------------------------------------------
-- 1) テーブル作成
--------------------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE W_EDI_YAM_JYUTYU_A (
    -- 行番号1
    LINE1    NUMBER(4),       -- 行番号1

    -- 1～8 の項目
    DATA001  VARCHAR2(1),     -- 識別子(A)
    DATA002  VARCHAR2(13),    -- 支払法人コード
    DATA003  VARCHAR2(13),    -- 支払法人GLN
    DATA004  VARCHAR2(13),    -- 発注者コード
    DATA005  VARCHAR2(13),    -- 発注者GLN
    DATA006  VARCHAR2(40),    -- 発注者名称
    DATA007  VARCHAR2(20),    -- 発注者名称カナ
    CONSTRAINT PK_W_EDI_YAM_JYUTYU_A PRIMARY KEY (LINE1) ENABLE
)
ON COMMIT DELETE ROWS;

--------------------------------------------------------------------------------
-- 2) テーブルコメント
--------------------------------------------------------------------------------
COMMENT ON TABLE W_EDI_YAM_JYUTYU_A IS 'EDI受注データ（流通BMS）Aレコードワーク';

--------------------------------------------------------------------------------
-- 3) カラムコメント
--------------------------------------------------------------------------------
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.LINE1   IS '行番号1';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.DATA001 IS '識別子(A)';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.DATA002 IS '支払法人コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.DATA003 IS '支払法人GLN';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.DATA004 IS '発注者コード';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.DATA005 IS '発注者GLN';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.DATA006 IS '発注者名称';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_A.DATA007 IS '発注者名称カナ';
