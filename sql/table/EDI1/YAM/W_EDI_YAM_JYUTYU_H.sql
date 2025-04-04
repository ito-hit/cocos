--------------------------------------------------------------------------------
-- 0) テーブル削除
--------------------------------------------------------------------------------
DROP TABLE W_EDI_YAM_JYUTYU_H;

--------------------------------------------------------------------------------
-- 1) テーブル作成
--------------------------------------------------------------------------------
CREATE GLOBAL TEMPORARY TABLE W_EDI_YAM_JYUTYU_H (
    -- 行番号1
    LINEH    NUMBER(4),       -- 行番号1

    -- 1～16 の項目
    DATH001  VARCHAR2(1),                   -- データ区分
    DATH002  VARCHAR2(20),                  -- 送信者ID
    DATH003  VARCHAR2(20),                  -- 送信者ID発行元
    DATH004  VARCHAR2(20),                  -- 受信者ID
    DATH005  VARCHAR2(20),                  -- 受信者ID発行元
    DATH006  VARCHAR2(2),                   -- バージョン
    DATH007  VARCHAR2(50),                  -- インスタンスID
    DATH008  VARCHAR2(10),                  -- メッセージ種
    DATH009  VARCHAR2(19),                  -- 作成日時
    DATH010  VARCHAR2(10),                  -- テスト区分ID
    DATH011  VARCHAR2(20),                  -- 最終送信先ID
    DATH012  VARCHAR2(50),                  -- メッセージ識別ID
    DATH013  VARCHAR2(8),                   -- 送信者ステーションアドレス
    DATH014  VARCHAR2(8),                   -- 最終受信者ステーションアドレス
    DATH015  VARCHAR2(8),                   -- 直接受信者ステーションアドレス
    DATH016  NUMBER(7,0)                    -- 取引数
)
ON COMMIT DELETE ROWS;

--------------------------------------------------------------------------------
-- 2) テーブルコメント
--------------------------------------------------------------------------------
COMMENT ON TABLE W_EDI_YAM_JYUTYU_H IS 'EDI受注データ（流通BMS）Hレコードワーク';

--------------------------------------------------------------------------------
-- 3) カラムコメント
--------------------------------------------------------------------------------
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.LINEH   IS '行番号H';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH001 IS 'データ区分';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH002 IS '送信者ID';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH003 IS '送信者ID発行元';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH004 IS '受信者ID';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH005 IS '受信者ID発行元';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH006 IS 'バージョン';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH007 IS 'インスタンスID';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH008 IS 'メッセージ種';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH009 IS '作成日時';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH010 IS 'テスト区分ID';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH011 IS '最終送信先ID';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH012 IS 'メッセージ識別ID';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH013 IS '送信者ステーションアドレス';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH014 IS '最終受信者ステーションアドレス';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH015 IS '直接受信者ステーションアドレス';
COMMENT ON COLUMN W_EDI_YAM_JYUTYU_H.DATH016 IS '取引数';
