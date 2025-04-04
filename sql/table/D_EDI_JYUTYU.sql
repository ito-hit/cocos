CREATE TABLE D_EDI_JYUTYU
(
    EDI_KYOTEN_CODE                NUMBER(3,0) DEFAULT 0,
    EDI_JYUSIN_NO                  NUMBER(10,0) DEFAULT 0,
    EDI_JYUSIN_DATE                NUMBER(8,0) DEFAULT 0,
    EDI_TOKUI_CODE                 NUMBER(6,0) DEFAULT 0,
    EDI_SYORI_ID                   CHAR(3) DEFAULT null,
    EDI_KONPO_KBN                  NUMBER(1,0) DEFAULT 0,
    EDI_NOHIN_KBN                  NUMBER(1,0) DEFAULT 0,
    EDI_HAISO_NISSU                NUMBER(1,0) DEFAULT 0,
    EDI_HATYU_NO                   VARCHAR2(30) DEFAULT null,
    EDI_HATYU_DATE                 NUMBER(8,0) DEFAULT 0,
    EDI_NOHIN_SITEI_DATE           NUMBER(8,0) DEFAULT 0,
    EDI_MISE_CODE                  NUMBER(5,0) DEFAULT 0,
    EDI_MISE_MEI                   VARCHAR2(40) DEFAULT null,
    EDI_OKURI_MISE_CODE            NUMBER(5,0) DEFAULT 0,
    EDI_OKURI_MISE_MEI             VARCHAR2(40) DEFAULT null,
    EDI_SYOHIN_CODE                VARCHAR2(15) DEFAULT null,
    EDI_SYOHIN_MEI                 VARCHAR2(50) DEFAULT null,
    EDI_SYOHIN_KIKAKU              VARCHAR2(50) DEFAULT null,
    EDI_HATYU_SU                   NUMBER(9,2) DEFAULT 0,
    EDI_TANKA                      NUMBER(7,0) DEFAULT 0,
    EDI_BAIKA                      NUMBER(7,0) DEFAULT 0,
    EDI_RESERVE_KBN                NUMBER(1,0) DEFAULT 0,
    EDI_RESERVE_JYUTYU_NO          NUMBER(10,0) DEFAULT 0,
    EDI_GENBUTU_KBN                NUMBER(1,0) DEFAULT 0,
    EDI_JYUTYUZAN_KBN              NUMBER(1,0) DEFAULT 0,
    EDI_ERROR_FLG                  AS (CASE  WHEN "EDI_ERROR_FLG_1">0 THEN 1 WHEN "EDI_ERROR_FLG_2">0 THEN 1 WHEN "EDI_ERROR_FLG_3">0 THEN 1 WHEN "EDI_ERROR_FLG_4">0 THEN 1 WHEN "EDI_ERROR_FLG_5">0 THEN 1 ELSE 0 END) VIRTUAL,
    EDI_ERROR_FLG_1                NUMBER(1,0) DEFAULT 0,
    EDI_ERROR_FLG_2                NUMBER(1,0) DEFAULT 0,
    EDI_ERROR_FLG_3                NUMBER(1,0) DEFAULT 0,
    EDI_ERROR_FLG_4                NUMBER(1,0) DEFAULT 0,
    EDI_ERROR_FLG_5                NUMBER(1,0) DEFAULT 0,
    EDI_KEIKOKU_FLG                AS (CASE  WHEN "EDI_KEIKOKU_FLG_1">0 THEN 1 WHEN "EDI_KEIKOKU_FLG_2">0 THEN 1 WHEN "EDI_KEIKOKU_FLG_3">0 THEN 1 WHEN "EDI_KEIKOKU_FLG_4">0 THEN 1 WHEN "EDI_KEIKOKU_FLG_5">0 THEN 1 ELSE 0 END) VIRTUAL,
    EDI_KEIKOKU_FLG_1              NUMBER(1,0) DEFAULT 0,
    EDI_KEIKOKU_FLG_2              NUMBER(1,0) DEFAULT 0,
    EDI_KEIKOKU_FLG_3              NUMBER(1,0) DEFAULT 0,
    EDI_KEIKOKU_FLG_4              NUMBER(1,0) DEFAULT 0,
    EDI_KEIKOKU_FLG_5              NUMBER(1,0) DEFAULT 0,
    JYUTYU_NO                      NUMBER(10,0) NOT NULL,
    JYUTYU_DATE                    NUMBER(8,0) DEFAULT 0,
    JYUTYU_TIME                    NUMBER(6,0) DEFAULT 0,
    JYUTYU_KBN                     NUMBER(1,0) DEFAULT 0,
    JYUTYU_HOUHOU                  NUMBER(1,0) DEFAULT 0,
    JYUSIN_NO                      NUMBER(10,0) DEFAULT 0,
    ENTRY_USER_ID                  VARCHAR2(10) DEFAULT null,
    ENTRY_USER_MEI                 VARCHAR2(20) DEFAULT null,
    TOKUI_CODE                     NUMBER(6,0) DEFAULT 0,
    MISE_CODE                      NUMBER(5,0) DEFAULT 0,
    TORIHIKI_JYOKEN_KBN            NUMBER(1,0) DEFAULT 0,
    SYUKKA_DATE                    NUMBER(8,0) DEFAULT 0,
    DENPYO_DATE                    NUMBER(8,0) DEFAULT 0,
    DENPYO_SYUBETU                 NUMBER(1,0) DEFAULT 0,
    SYUKKA_KBN                     NUMBER(1,0) DEFAULT 0,
    SYUKKA_HOUHOU                  NUMBER(1,0) DEFAULT 0,
    NIGUMI_NO                      NUMBER(10,0) DEFAULT 0,
    JYUTYU_GYO_NO                  NUMBER(3,0) NOT NULL,
    SYUKKA_KAISU                   NUMBER(3,0) DEFAULT 0,
    JYUTYU_GYO_SORT_NO             NUMBER(3,0) DEFAULT 0,
    KYOTEN_CODE                    NUMBER(3,0) DEFAULT 0,
    TORIHIKI_KBN_1                 NUMBER(2,0) DEFAULT 0,
    TORIHIKI_KBN_2                 NUMBER(2,0) DEFAULT 0,
    SYOHIN_CODE                    NUMBER(7,0) DEFAULT 0,
    IRO_NO                         NUMBER(3,0) DEFAULT 0,
    SKU_CODE                       NUMBER(13,0) DEFAULT 0,
    HIN_BAN                        VARCHAR2(20) DEFAULT null,
    HIN_MEI                        VARCHAR2(60) DEFAULT null,
    IRO_MEI                        VARCHAR2(30) DEFAULT null,
    SIZE_MEI                       VARCHAR2(10) DEFAULT null,
    JYUTYU_SU                      NUMBER(9,2) DEFAULT 0,
    HIKIATE_SU                     NUMBER(9,2) DEFAULT 0,
    JYUTYU_ZAN_SU                  NUMBER(9,2) DEFAULT 0,
    SYUKKA_SIJI_SU                 NUMBER(9,2) DEFAULT 0,
    SYUKKA_SUMI_SU                 NUMBER(9,2) DEFAULT 0,
    CANCEL_SU                      NUMBER(9,2) DEFAULT 0,
    KEPPIN_SU                      NUMBER(9,2) DEFAULT 0,
    TANKA                          NUMBER(11,2) DEFAULT 0,
    NEBIKI_TANKA                   NUMBER(11,2) DEFAULT 0,
    GENKA_TANKA                    NUMBER(11,2) DEFAULT 0,
    SYOHIZEI_KBN                   NUMBER(1,0) DEFAULT 0,
    KAZEI_KBN                      NUMBER(1,0) DEFAULT 0,
    SYOHIZEI_RITU                  NUMBER(5,2) DEFAULT 0,
    ZEIBETU_TANKA                  AS (CASE  WHEN "TANKA"=0 THEN 0 WHEN "SYOHIZEI_KBN"=1 THEN "TANKA" WHEN "SYOHIZEI_KBN"=2 THEN "TANKA"-TRUNC("TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0) ELSE 0 END) VIRTUAL,
    ZEIBETU_NEBIKI_TANKA           AS (CASE  WHEN "NEBIKI_TANKA"=0 THEN 0 WHEN "SYOHIZEI_KBN"=1 THEN "NEBIKI_TANKA" WHEN "SYOHIZEI_KBN"=2 THEN "NEBIKI_TANKA"-TRUNC("NEBIKI_TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0) ELSE 0 END) VIRTUAL,
    KINGAKU                        AS (TRUNC("HIKIATE_SU"*(CASE  WHEN ("TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN "TANKA"-TRUNC("TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0) ELSE 0 END +CASE  WHEN ("NEBIKI_TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "NEBIKI_TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN ("NEBIKI_TANKA"-TRUNC("NEBIKI_TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0)) ELSE 0 END ),0)) VIRTUAL,
    GENKA_KINGAKU                  AS (CASE "ARARI_KEISAN_FLG" WHEN 1 THEN TRUNC("HIKIATE_SU"*"GENKA_TANKA",0) ELSE TRUNC("HIKIATE_SU"*(CASE  WHEN ("TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN "TANKA"-TRUNC("TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0) ELSE 0 END +CASE  WHEN ("NEBIKI_TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "NEBIKI_TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN ("NEBIKI_TANKA"-TRUNC("NEBIKI_TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0)) ELSE 0 END ),0) END) VIRTUAL,
    ARARI_KINGAKU                  AS (TRUNC("HIKIATE_SU"*(CASE  WHEN ("TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN "TANKA"-TRUNC("TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0) ELSE 0 END +CASE  WHEN ("NEBIKI_TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "NEBIKI_TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN ("NEBIKI_TANKA"-TRUNC("NEBIKI_TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0)) ELSE 0 END ),0)-CASE "ARARI_KEISAN_FLG" WHEN 1 THEN TRUNC("HIKIATE_SU"*"GENKA_TANKA",0) ELSE TRUNC("HIKIATE_SU"*(CASE  WHEN ("TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN "TANKA"-TRUNC("TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0) ELSE 0 END +CASE  WHEN ("NEBIKI_TANKA"=0) THEN 0 WHEN ("SYOHIZEI_KBN"=1) THEN "NEBIKI_TANKA" WHEN ("SYOHIZEI_KBN"=2) THEN ("NEBIKI_TANKA"-TRUNC("NEBIKI_TANKA"/(1+"SYOHIZEI_RITU"/100)*("SYOHIZEI_RITU"/100),0)) ELSE 0 END ),0) END) VIRTUAL,
    AITE_BAIKA1                    NUMBER(7,0) DEFAULT 0,
    AITE_BAIKA2                    NUMBER(7,0) DEFAULT 0,
    JYUTYU_TEKIYO                  VARCHAR2(40) DEFAULT null,
    DENPYO_TEKIYO                  VARCHAR2(40) DEFAULT null,
    BUTURYU_TEKIYO                 VARCHAR2(40) DEFAULT null,
    LOCATION_KBN                   NUMBER(1,0) DEFAULT 0,
    KAKO_SASIZU_NO                 NUMBER(10,0) DEFAULT null,
    KAKO_GYO_NO                    NUMBER(3,0) DEFAULT 0,
    SEIHIN_KAKO_KBN1               VARCHAR2(3) DEFAULT null,
    SEIHIN_KAKO_TEKIYO1            VARCHAR2(20) DEFAULT null,
    SEIHIN_KAKO_KBN2               VARCHAR2(3) DEFAULT null,
    SEIHIN_KAKO_TEKIYO2            VARCHAR2(20) DEFAULT null,
    SEIHIN_KAKO_KBN3               VARCHAR2(3) DEFAULT null,
    SEIHIN_KAKO_TEKIYO3            VARCHAR2(20) DEFAULT null,
    SEIHIN_KAKO_KBN4               VARCHAR2(3) DEFAULT null,
    SEIHIN_KAKO_TEKIYO4            VARCHAR2(20) DEFAULT null,
    SEIHIN_KAKO_KBN5               VARCHAR2(3) DEFAULT null,
    SEIHIN_KAKO_TEKIYO5            VARCHAR2(20) DEFAULT null,
    RYUTU_KAKO_KBN1                VARCHAR2(3) DEFAULT null,
    RYUTU_KAKO_TEKIYO1             VARCHAR2(20) DEFAULT null,
    RYUTU_KAKO_KBN2                VARCHAR2(3) DEFAULT null,
    RYUTU_KAKO_TEKIYO2             VARCHAR2(20) DEFAULT null,
    RYUTU_KAKO_KBN3                VARCHAR2(3) DEFAULT null,
    RYUTU_KAKO_TEKIYO3             VARCHAR2(20) DEFAULT null,
    RYUTU_KAKO_KBN4                VARCHAR2(3) DEFAULT null,
    RYUTU_KAKO_TEKIYO4             VARCHAR2(20) DEFAULT null,
    RYUTU_KAKO_KBN5                VARCHAR2(3) DEFAULT null,
    RYUTU_KAKO_TEKIYO5             VARCHAR2(20) DEFAULT null,
    BUKKEN_CODE                    NUMBER(5,0) DEFAULT null,
    EDI_REC_NO                     NUMBER(10,0) DEFAULT 0,
    SAMPLE_KBN                     NUMBER(1,0) DEFAULT 0,
    MOTO_JYUTYU_NO                 NUMBER(10,0) DEFAULT 0,
    MOTO_JYUTYU_GYO_NO             NUMBER(3,0) DEFAULT 0,
    JYUTYUZAN_FLG                  NUMBER(1,0) DEFAULT 0,
    SYOKUTI_SYOHIN_FLG             NUMBER(1,0) DEFAULT 0,
    SURYO_KEISAN_FLG               NUMBER(1,0) DEFAULT 0,
    KINGAKU_KEISAN_FLG             NUMBER(1,0) DEFAULT 0,
    ARARI_KEISAN_FLG               NUMBER(1,0) DEFAULT 0,
    HAKO_KEISAN_FLG                NUMBER(1,0) DEFAULT 0,
    KENPIN_TAISYO_FLG              NUMBER(1,0) DEFAULT 0,
    OKURI_TOKUI_CODE               NUMBER(6,0) DEFAULT 0,
    OKURI_MISE_CODE                NUMBER(5,0) DEFAULT 0,
    KOBETU_HAISO_FLG               NUMBER(1,0) DEFAULT 0,
    TODOFUKEN_CODE                 NUMBER(2,0) DEFAULT 0,
    SIKUTYOSON_CODE                NUMBER(5,0) DEFAULT 0,
    YUBIN_NO                       VARCHAR2(10) DEFAULT null,
    JYUSYO1                        VARCHAR2(40) DEFAULT null,
    JYUSYO2                        VARCHAR2(40) DEFAULT null,
    JYUSYO3                        VARCHAR2(40) DEFAULT null,
    OKURI_TOKUI_MEI                VARCHAR2(40) DEFAULT null,
    OKURI_MEI1                     VARCHAR2(40) DEFAULT null,
    OKURI_MEI2                     VARCHAR2(40) DEFAULT null,
    TEL_NO                         VARCHAR2(15) DEFAULT null,
    UNSO_CODE                      NUMBER(2,0) DEFAULT 0,
    HAITATU_SITEI_DATE             NUMBER(8,0) DEFAULT 0,
    HAITATU_SITEI_JIKOKU           VARCHAR2(2) DEFAULT null,
    TYAKUTEN_CODE                  VARCHAR2(10) DEFAULT null,
    TYAKUTEN_TOME_FLG              NUMBER(1,0) DEFAULT 0,
    NIFUDA_BIKOU                   VARCHAR2(100) DEFAULT null,
    NIOKURININ_CODE                NUMBER(5,0) DEFAULT null,
    NOHINSYO_SYUBETU               NUMBER(1,0) DEFAULT 0,
    NOHINSYO_HAKKOU_KBN            NUMBER(1,0) DEFAULT 0,
    NOHINSYO_KINGAKU_FLG           NUMBER(1,0) DEFAULT 0,
    HATYU_DATE                     NUMBER(8,0) DEFAULT 0,
    NOHIN_SITEI_DATE               NUMBER(8,0) DEFAULT 0,
    JITU_NOHIN_DATE                NUMBER(8,0) DEFAULT 0,
    IRAIMOTO_MEI                   VARCHAR2(40) DEFAULT null,
    NOHINSYO_BIKOU                 VARCHAR2(100) DEFAULT null,
    NAIYOU_MEISAI_BIKOU            VARCHAR2(100) DEFAULT null,
    AITE_HATYU_NO                  VARCHAR2(30) DEFAULT null,
    AITE_HATYU_NO_CD               VARCHAR2(1) DEFAULT null,
    AITE_DENPYO_KBN                VARCHAR2(10) DEFAULT null,
    AITE_DENPYO_KBN_MEI            VARCHAR2(20) DEFAULT null,
    AITE_BUMON_CODE                VARCHAR2(10) DEFAULT null,
    AITE_BUMON_MEI                 VARCHAR2(20) DEFAULT null,
    AITE_HATYU_KBN                 VARCHAR2(10) DEFAULT null,
    AITE_HATYU_KBN_MEI             VARCHAR2(20) DEFAULT null,
    AITE_SYUKKA_KBN                VARCHAR2(10) DEFAULT null,
    AITE_SYUKKA_KBN_MEI            VARCHAR2(20) DEFAULT null,
    AITE_KONPO_KBN                 VARCHAR2(10) DEFAULT null,
    AITE_KONPO_KBN_MEI             VARCHAR2(20) DEFAULT null,
    AITE_SONOTA_KBN                VARCHAR2(10) DEFAULT null,
    AITE_SONOTA_KBN_MEI            VARCHAR2(20) DEFAULT null,
    ZBIN_FLG                       NUMBER(1,0) DEFAULT 0,
    SYOBUN_FLG                     NUMBER(1,0) DEFAULT 0,
    DENPYO_DATE_FLG                NUMBER(1,0) DEFAULT 0,
    KYAKUTYU_FLG                   NUMBER(1,0) DEFAULT 0,
    GAITYU_TYOKUSO_FLG             NUMBER(1,0) DEFAULT 0,
    DENPYO_NO                      NUMBER(10,0) DEFAULT 0,
    DENPYO_GYO_NO                  NUMBER(3,0) DEFAULT 0,
    DENPYO_GYO_SORT_NO             NUMBER(3,0) DEFAULT 0,
    NOHINSYO_GYO_NO                NUMBER(2,0) DEFAULT 0,
    NOHINSYO_RETU_NO               NUMBER(1,0) DEFAULT 0,
    AITE_DENPYO_NO                 VARCHAR2(30) DEFAULT null,
    AITE_DENPYO_NO_CD              VARCHAR2(1) DEFAULT null,
    AITE_DENPYO_GYO_NO             NUMBER(3,0) DEFAULT 0,
    AITE_NOHIN_NO                  VARCHAR2(30) DEFAULT null,
    NOHINSYO_PRT_FLG               NUMBER(1,0) DEFAULT 0,
    SENDEN_PRT_FLG                 NUMBER(1,0) DEFAULT 0,
    TENKIHYO_PRT_FLG               NUMBER(1,0) DEFAULT 0,
    OKURIJYO_PRT_FLG               NUMBER(1,0) DEFAULT 0,
    SYUKKA_SIJISYO_PRT_FLG         NUMBER(1,0) DEFAULT 0,
    NOHINDATA_CRT_FLG              NUMBER(1,0) DEFAULT 0,
    EOS_FLG                        NUMBER(1,0) DEFAULT 0,
    BATCH_NO                       NUMBER(3,0) DEFAULT 0,
    SYUKKA_NO                      NUMBER(15,0) DEFAULT 0,
    KINKYU_HOJYU_KBN               NUMBER(1,0) DEFAULT 0,
    KENPIN_KEIKOKU1                VARCHAR2(40) DEFAULT null,
    KENPIN_KEIKOKU2                VARCHAR2(40) DEFAULT null,
    KENPIN_KEIKOKU3                VARCHAR2(40) DEFAULT null,
    KENPIN_KEIKOKU4                VARCHAR2(40) DEFAULT null,
    KENPIN_KEIKOKU5                VARCHAR2(40) DEFAULT null,
    NOHINSYO_FLG                   NUMBER(1,0) DEFAULT 0,
    NAIYOU_MEISAI_FLG              NUMBER(1,0) DEFAULT 0,
    OKURIJYO_FLG                   NUMBER(1,0) DEFAULT 0,
    LABEL_FLG                      NUMBER(1,0) DEFAULT 0,
    SOUSIN_SUMI_FLG                NUMBER(1,0) DEFAULT 0,
    SOUSIN_SUMI_SU                 NUMBER(9,2) DEFAULT 0,
    SOUSIN_KAISU                   NUMBER(2,0) DEFAULT 0,
    JYOTAI_KBN                     NUMBER(1,0) DEFAULT 0,
    TOUROKU_DATE                   DATE DEFAULT sysdate,
    TOUROKU_USER_ID                VARCHAR2(10) DEFAULT null,
    TOUROKU_CLIENT_ID              VARCHAR2(40) DEFAULT null,
    TOUROKU_PG_ID                  VARCHAR2(40) DEFAULT null,
    HENKOU_DATE                    DATE DEFAULT null,
    HENKOU_USER_ID                 VARCHAR2(10) DEFAULT null,
    HENKOU_CLIENT_ID               VARCHAR2(40) DEFAULT null,
    HENKOU_PG_ID                   VARCHAR2(40) DEFAULT null,
    KOUSIN_DATE                    DATE DEFAULT null,
    KOUSIN_USER_ID                 VARCHAR2(10) DEFAULT null,
    KOUSIN_CLIENT_ID               VARCHAR2(40) DEFAULT null,
    KOUSIN_PG_ID                   VARCHAR2(40) DEFAULT null,
    HAITA_FLG                      NUMBER(1,0) DEFAULT 0,
    CONSTRAINT D_EDI_JYUTYU_PIDX_1 PRIMARY KEY (JYUTYU_NO, JYUTYU_GYO_NO) USING INDEX
        ENABLE
)
/
COMMENT ON TABLE D_EDI_JYUTYU IS 'EDI�󒍃f�[�^�i���ʁj'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KYOTEN_CODE IS 'EDI���_�R�[�h(EDI�f�[�^����荞�񂾋��_�̃R�[�h)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_JYUSIN_NO IS 'EDI��M�ԍ�(EDI�f�[�^��M�P�ʂɕt�Ԃ���i��{���}�X�^�[�̏�����+seq_edi_jyusin_no�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_JYUSIN_DATE IS 'EDI��M��(EDI�f�[�^����荞�񂾓�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_TOKUI_CODE IS 'EDI���Ӑ�R�[�h(EDI���Ӑ�R�[�h�i��\���Ӑ�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYORI_ID IS 'EDI����ID(EDI�����P�ʂȂǂɕt��ID�iDCM�AVAL�AARC�AUFO�Ȃǁj)�����̋敪��260'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KONPO_KBN IS 'EDI����敪(1�����ʈꊇ�@2���X�ʍ���)�����̋敪��298'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_NOHIN_KBN IS 'EDI�[�i�敪(1���Z���^�[�[�i�@2���X�ܒ���)�����̋敪��258'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HAISO_NISSU IS 'EDI�z������(�z�������i�G���[�`�F�b�N�ɂĒ萔�}�X�^�[����t�����݁j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HATYU_NO IS 'EDI�����ԍ�(EDI�����f�[�^�ɂĎ�M�������蔭���ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HATYU_DATE IS 'EDI������(�V�@���蔭����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_NOHIN_SITEI_DATE IS 'EDI�[�i�w���(�V�@�[�i�w���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_MISE_CODE IS 'EDI�X�R�[�h(�V�@�X�R�[�h)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_MISE_MEI IS 'EDI�X��(�V�@�X��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_OKURI_MISE_CODE IS 'EDI����X�R�[�h(�V�@�����̓X�R�[�h)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_OKURI_MISE_MEI IS 'EDI����X��(�V�@�����̓X��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYOHIN_CODE IS 'EDI���i�R�[�h(�V�@���i�R�[�h�iJAN�^�C���X�g�A�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYOHIN_MEI IS 'EDI���i��(�V�@���i��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYOHIN_KIKAKU IS 'EDI���i�K�i(�V�@���i�K�i�i�F�E�T�C�Y���j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HATYU_SU IS 'EDI��������(�V�@��������)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_TANKA IS 'EDI���P��(�V�@�����P��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_BAIKA IS 'EDI���P��(�V�@�����P��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_RESERVE_KBN IS 'EDI���U�[�u�敪(1���Ȃ��@2������@3��������w��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_RESERVE_JYUTYU_NO IS 'EDI���U�[�u�󒍔ԍ�(EDI���U�[�u�敪��3�̏ꍇ�̈�����󒍔ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_GENBUTU_KBN IS 'EDI���������敪(1������@2���Ȃ�)�����̋敪��270'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_JYUTYUZAN_KBN IS 'EDI�󒍎c�����敪(1������@2���Ȃ��@3�������Ȃ�)�����̋敪��271'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG IS 'EDI�G���[�t���O(1���G���[����)��"AS (CASE WHEN ERROR_FLG_1 > 0 THEN 1 WHEN ERROR_FLG_2 > 0 THEN 1 WHEN ERROR_FLG_3 > 0 THEN 1 WHEN ERROR_FLG_4 > 0 THEN 1 WHEN ERROR_FLG_5 > 0 THEN 1 ELSE 0 END) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_1 IS 'EDI�G���[�t���O1(1���X�G���[)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_2 IS 'EDI�G���[�t���O2(1�������G���[)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_3 IS 'EDI�G���[�t���O3(1�����i�G���[)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_4 IS 'EDI�G���[�t���O4(1���P���G���[)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_5 IS 'EDI�G���[�t���O5(1�����̑��̃G���[)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG IS 'EDI�x���t���O(1���x������)��"AS (CASE WHEN KEIKOKU_FLG_1 > 0 THEN 1 WHEN KEIKOKU_FLG_2 > 0 THEN 1 WHEN KEIKOKU_FLG_4 > 0 THEN 1 WHEN KEIKOKU_FLG_5 > 0 THEN 1 ELSE 0 END) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_1 IS 'EDI�x���t���O1(1���d���̉\������)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_2 IS 'EDI�x���t���O2(1�����t�x���i�[�i�����߂Ȃǁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_3 IS 'EDI�x���t���O3(1���P���x���i�������͉��z��̏����Ɋ܂߂Ȃ��j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_4 IS 'EDI�x���t���O4(�����g�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_5 IS 'EDI�x���t���O5(1�����̑��̌x��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_NO IS '�󒍔ԍ�(�󒍔ԍ��i7���ŉ^�p�j)����L�[�@'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_DATE IS '�󒍓��t(�󒍓��t�i���ׂ�����ǉ������ꍇ���܂߁A����󒍔ԍ����͑S�ē����l�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_TIME IS '�󒍎���(�󒍎����i�@�V�@�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_KBN IS '�󒍋敪(�����g�p)�����̋敪��206'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_HOUHOU IS '�󒍕��@(2��EOS�󒍁i�Œ�j)�����̋敪��205'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSIN_NO IS '��M�ԍ�(EDI�f�[�^��M�P�ʂɕt�Ԃ���ԍ��iEDI��M�ԍ��Ɠ��l�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ENTRY_USER_ID IS '���͎҃R�[�h(�e����̓��͒S���҃R�[�h�i�������f�[�^��荞�ݒS���ҁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ENTRY_USER_MEI IS '���͎Җ�(���͒S���Җ��i������j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOKUI_CODE IS '���Ӑ�R�[�h(�����̓��Ӑ�R�[�h�i�G���[�`�F�b�N���ɃZ�b�g�A�ȍ~�͔���v��܂ŕ\���̂݁j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.MISE_CODE IS '�X�R�[�h(�����̓X�R�[�h�i��M���������f�[�^���̓X�R�[�h���Z�b�g�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TORIHIKI_JYOKEN_KBN IS '��������敪(1���|����@2����������i�挻���j)�����̋敪��105'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_DATE IS '�o�ד�(���ۂ̏o�ח\����i���o�׎w���ɂăZ�b�g�A�o�ד��ύX�ɂĕύX�\�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_DATE IS '�`�[���t(�[�i�`�[��̓��t�i���o�ד��Ɠ��l���Z�b�g�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_SYUBETU IS '�`�[���(1�Œ�)�����̋敪��217'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_KBN IS '�o�׋敪(1���ʏ�@2���ړ��o�ׁ@3���a�蔄��@4���d�������@5���a��o��)�����̋敪��209'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_HOUHOU IS '�o�ו��@(1���ʏ�@2���ʒ��w��@3���ʎw��@4���P�̎w��)�����̋敪��213'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NIGUMI_NO IS '�בg�ԍ�(�בg�w��܂��͒P�̎w�肵���ꍇ�ɔԍ����Z�b�g�����i�ʏ�͎󒍔ԍ�������j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_GYO_NO IS '�󒍍s�ԍ�����L�[�A'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_KAISU IS '�o�׉�(0�����o�ׁ@�o�ח\��f�[�^�V�K�o�͎��Ɂu1�v���Z�b�g)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_GYO_SORT_NO IS '�󒍍s�\�[�g�ԍ�'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KYOTEN_CODE IS '���_�R�[�h(�o�׋��_�R�[�h�i���ۂɏo�ׂ��鋒�_�̃R�[�h�E�o�ɋ��_�R�[�h�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TORIHIKI_KBN_1 IS '����敪�P(11������@16���Г��o�ׁ@17���Г��ԕi�@18���ړ��o�ׁ@19���a��o��)�����̋敪��200'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TORIHIKI_KBN_2 IS '����敪�Q(01���a�蔄��@02����������@05���P�������@06���o�ג���)�����̋敪��201'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOHIN_CODE IS '���i�R�[�h'
/
COMMENT ON COLUMN D_EDI_JYUTYU.IRO_NO IS '�F��'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SKU_CODE IS 'SKU�R�[�h(���i�o�^���ɍ̔Ԃ�����ӂ̓����R�[�h�i�i�v�ԍ��j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HIN_BAN IS '�i��(�}�X�^�[����Z�b�g�iEOS�̏ꍇ�A����͂ɂ͑Ή����Ȃ��j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HIN_MEI IS '�i��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.IRO_MEI IS '�F��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SIZE_MEI IS '�T�C�Y��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_SU IS '�󒍐���(�󒍑����ʁi��EOS�������ʁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HIKIATE_SU IS '��������(�݌Ɉ������ʁi�o�א��ʁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_ZAN_SU IS '�󒍎c����(�����g�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_SIJI_SU IS '�o�׎w������(���ʃV�X�e���֑��M�ς݂̏o�׎w������)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_SUMI_SU IS '�o�׍ςݐ���(���ʃV�X�e������Ԃ��ꂽ�o�׎��ѐ��ʁiI_WMS_SYUKKA_JISSEKI����j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.CANCEL_SU IS '�L�����Z������(���Ӑ旝�R�ɂ��L�����Z������)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KEPPIN_SU IS '���i����(���Ќ��i����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TANKA IS '�P��(���͗p�P���E�\���P���i�l���O�E�ō��^�ŕʂ����������j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NEBIKI_TANKA IS '�l���P��(�P���ɑ΂���l���P��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.GENKA_TANKA IS '�����P��(���̎��_�̈ړ����ό����i�[���l�̌ܓ��j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOHIZEI_KBN IS '����ŋ敪(1���P���ŕʁ@2���P���ō�)�����̋敪��104'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KAZEI_KBN IS '�ېŋ敪(1���ېŔ���@2���ƐŔ���i�����ʂ͍��L2�敪�̂ݓo�^�A�󒍓��͂́u1�v�Œ�o��)�����̋敪��039'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOHIZEI_RITU IS '����ŗ�(�m�肵������ŗ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ZEIBETU_TANKA IS '�ŕʒP��(�ō���̏ꍇ�͐ōT����̒P���i����p�P���j�A�ŕʐ�̏ꍇ��TANKA�Ɠ��l������)��"as (case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ZEIBETU_NEBIKI_TANKA IS '�ŕʒl���P��(�ŕʒP���ɑ΂���l���P���i����j)��"as (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KINGAKU IS '���z(�[���؎̂�(�������ʁ~(�ŕʒP���{�ŕʒl���P��)))��"as (trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0)) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.GENKA_KINGAKU IS '�������z(�[���؎̂�(�������ʁ~�����P��), �������e���v�Z�t���O0�̏ꍇ�����z)��"as (case when arari_keisan_flg = 1 then trunc(hikiate_su * genka_tanka,0) else trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0) end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ARARI_KINGAKU IS '�e�����z(���z�|�������z)��"as (trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0) - case when arari_keisan_flg = 1 then trunc(hikiate_su * genka_tanka,0) else trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0) end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BAIKA1 IS '���蔄���P(���Ӑ�̔����P���i�Ŕ��E�ō��Ɋւ�炸�ʏ�͂�������g�p�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BAIKA2 IS '���蔄���Q(�ō��E�ŕʗ������Z�b�g����ꍇ�́A�ō����P�A�ŕʁ��Q���g�p����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_TEKIYO IS '�󒍓E�v(�󒍓��͎҂����͂���Г��p�R�����g�i�s�P�ʁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_TEKIYO IS '�`�[�E�v(���e���׏��E�[�i���̊e�s�Ɉ󎚂���E�v�i�s�P�ʁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.BUTURYU_TEKIYO IS '�����E�v(�o�גS���҂֓`���郁�b�Z�[�W�i�s�P�ʁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.LOCATION_KBN IS '�o�׃��P�敪(1���ʏ�@2���o�׏������P�@3�����������P�@4���d����@5��������)�����̋敪��211'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KAKO_SASIZU_NO IS '���H�w�}�ԍ�(���i���H�w�}�ԍ��i�ʏ�͎󒍔ԍ��Ɠ��l�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KAKO_GYO_NO IS '���H�s�ԍ�(���i���H�s�ԍ��i�ʏ�͎󒍍s�ԍ��Ɠ��l�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN1 IS '���i���H�敪�P(���H�w�}���͂ɂē���)�����̋敪��174'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO1 IS '���i���H�E�v�P(���̃}�X�^�[���擾�������̂��ێ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN2 IS '���i���H�敪�Q(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO2 IS '���i���H�E�v�Q(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN3 IS '���i���H�敪�R(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO3 IS '���i���H�E�v�R(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN4 IS '���i���H�敪�S(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO4 IS '���i���H�E�v�S(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN5 IS '���i���H�敪�T(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO5 IS '���i���H�E�v�T(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN1 IS '���ʉ��H�敪�P(�G���[�`�F�b�N�����ɂăZ�b�g)�����̋敪��173'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO1 IS '���ʉ��H�E�v�P(���̃}�X�^�[���擾�������̂��ێ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN2 IS '���ʉ��H�敪�Q(���ʉ��H�敪�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO2 IS '���ʉ��H�E�v�Q(���ʉ��H�E�v�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN3 IS '���ʉ��H�敪�R(���ʉ��H�敪�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO3 IS '���ʉ��H�E�v�R(���ʉ��H�E�v�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN4 IS '���ʉ��H�敪�S(���ʉ��H�敪�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO4 IS '���ʉ��H�E�v�S(���ʉ��H�E�v�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN5 IS '���ʉ��H�敪�T(���ʉ��H�敪�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO5 IS '���ʉ��H�E�v�T(���ʉ��H�E�v�P�ɓ���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.BUKKEN_CODE IS '�����R�[�h(�����g�p�i�󒍎�or����v���ɉ��炩�̕��@�œ��͂������j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_REC_NO IS 'EDI���R�[�h�ԍ�(�Е�EDI�����f�[�^���R�[�h�Ƃ̕R�t���ԍ��iseq_edi_rec_no�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SAMPLE_KBN IS '�T���v���敪(1���w��Ȃ��@2���F�T���v���@3���T�C�Y�T���v��)�����̋敪��273'
/
COMMENT ON COLUMN D_EDI_JYUTYU.MOTO_JYUTYU_NO IS '�������󒍔ԍ�(�������̎󒍔ԍ��{�s�ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.MOTO_JYUTYU_GYO_NO IS '�������󒍍s�ԍ�(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYUZAN_FLG IS '�󒍎c�t���O(1���󒍎c����o��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOKUTI_SYOHIN_FLG IS '�������i�t���O(1���������i�i�i�ԓ�������͂���Ă���j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SURYO_KEISAN_FLG IS '���ʌv�Z�t���O(1�����ʂ��v�Z����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KINGAKU_KEISAN_FLG IS '���z�v�Z�t���O(1�����z���v�Z����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ARARI_KEISAN_FLG IS '�e���v�Z�t���O(1���e�����v�Z����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAKO_KEISAN_FLG IS '���v�Z�Ώۃt���O(1���v�Z�ΏۂƂ���i�{�Ё^WMS���ʉ��ł��Ȃ��\������j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_TAISYO_FLG IS '���i�Ώۃt���O(1�����i�ΏۂƂ���i�{�Ё^WMS���ʉ��ł��Ȃ��\������j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_TOKUI_CODE IS '���蓾�Ӑ�R�[�h(�����Z���^�[�ł́u���Ӑ�v�ƌ����Βʏ킱������w��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_MISE_CODE IS '����X�R�[�h(EOS�̏ꍇ�A�X���̏ꍇ�͓X�R�[�h�A�Z���^�[�[�i�̏ꍇ�̓Z���^�[�R�[�h������)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOBETU_HAISO_FLG IS '�˕ʔz���t���O(1���˕ʔz���iEOS�ł͌���g�p�\��Ȃ��j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TODOFUKEN_CODE IS '�s���{���R�[�h(01�`47�܂ł̓s���{���R�[�h�i�s�����R�[�h�̓��Q���j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SIKUTYOSON_CODE IS '�s�撬���R�[�h(�i�h�r�s�撬���R�[�h)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.YUBIN_NO IS '�X�֔ԍ�(�����̗X�֔ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSYO1 IS '�Z���P(�����̏Z���P)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSYO2 IS '�Z���Q(�����̏Z���Q)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSYO3 IS '�Z���R(�����̏Z���R)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_TOKUI_MEI IS '���蓾�Ӑ於(�����̓��Ӑ於�i�ЊO�\�����j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_MEI1 IS '����於�P(�����X���P)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_MEI2 IS '����於�Q(�����X���Q)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TEL_NO IS '�����d�b�ԍ�(�����̓d�b�ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.UNSO_CODE IS '�^���փR�[�h(�g�p����^���ւ̃R�[�h)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAITATU_SITEI_DATE IS '�z�B�w���(�z�B�w���)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAITATU_SITEI_JIKOKU IS '�z�B�w�莞��(�z�B�w�莞���i�����A�܂��́uAM�v�uPM�v�j)�����̋敪��182'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TYAKUTEN_CODE IS '���X�R�[�h(�^���֊e�Ђ̒��X�R�[�h�i�c�ƓX�R�[�h�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TYAKUTEN_TOME_FLG IS '�^���֒��X�~�߃t���O(1���^����Ђ̉c�ƓX�~�߂��w��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NIFUDA_BIKOU IS '�׎D���l(�׎D�i�����j�ֈ󎚂�����l)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NIOKURININ_CODE IS '�ב��l�R�[�h(�����֏o�͂���ב��l�̏��i�w��Ȃ��̏ꍇ�͏o�׌����_�̏�񂪃Z�b�g�����j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_SYUBETU IS '�[�i�����(�����g�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_HAKKOU_KBN IS '�����[�i�����s�敪(1���s�v�@2���ʏ픭�s�@4�����e���׏��P��)�����̋敪��118'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_KINGAKU_FLG IS '�����[�i�����z�\���t���O(1���\������i�������L���z�\���敪�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HATYU_DATE IS '������(���Ӑ�̔�����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHIN_SITEI_DATE IS '�[�i�w���(���Ӑ悩��̔[�i�w����iEOS�����f�[�^����]���j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JITU_NOHIN_DATE IS '���[�i��(�[�i�w��������̂܂܃Z�b�g�A�o�׎w���^�o�ד��ύX�����ɂĕύX�\)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.IRAIMOTO_MEI IS '�˗�����(���e���׏��Ɉ󎚂���˗�����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_BIKOU IS '�[�i�����l(�[�i���ֈ󎚂�����l�i�y�[�W�P�ʁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NAIYOU_MEISAI_BIKOU IS '���e���׏����l(���e���׏��ֈ󎚂�����l�i�y�[�W�P�ʁj)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_NO IS '���蔭���ԍ�(�󒍓��͂ɂĎ���́A�܂���EDI�����f�[�^����Z�b�g)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_NO_CD IS '���蔭���ԍ�C/D(���蔭���ԍ��̃`�F�b�N�f�B�W�b�g)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_KBN IS '����`�[�敪(���Ӑ�̓`�[�敪�i�d���E�ԕi�Ȃǁj)�����薼�̋敪��004'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_KBN_MEI IS '����`�[�敪��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BUMON_CODE IS '���蕔��R�[�h(���Ӑ�̕���܂��͕��ށi��Ɨp�i�A���|�p�i�Ȃǁj)�����薼�̋敪��003'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BUMON_MEI IS '���蕔�喼(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_KBN IS '���蔭���敪(���Ӑ�̔����敪�i��ԁA�����A�{�������Ȃǁj)�����薼�̋敪��005'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_KBN_MEI IS '���蔭���敪��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SYUKKA_KBN IS '����o�׋敪(���Ӑ�̏o�׋敪�i�X�ܒ����A�Z���^�[�[�i�Ȃǁj)�����薼�̋敪��006'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SYUKKA_KBN_MEI IS '����o�׋敪��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_KONPO_KBN IS '���荫��敪(���Ӑ�Ǝ��̋敪�ɑΉ����邽�߂́u��S�̍�������v�Ƃ��Đ݂���)�����薼�̋敪��007'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_KONPO_KBN_MEI IS '���荫��敪��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SONOTA_KBN IS '���肻�̑��敪(�\���敪�i��L�̋敪�ő���Ȃ��ꍇ�A�n�}��Ȃ��ꍇ�Ɏg�p�j)�����薼�̋敪��008'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SONOTA_KBN_MEI IS '���肻�̑��敪��(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ZBIN_FLG IS '�y�փt���O(1���y�֎w��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOBUN_FLG IS '�����t���O(1�������̔��i�󒍎��ɔC�ӎw��j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_DATE_FLG IS '�`�[���t���F�t���O(1���`�[���t�w�������)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KYAKUTYU_FLG IS '�q���t���O(�����g�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.GAITYU_TYOKUSO_FLG IS '�O�������t���O(�����g�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_NO IS '�`�[�ԍ�(���Д[�i���ԍ��i�ő�8���ŉ^�p�\��j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_GYO_NO IS '�`�[�s�ԍ�(���Д[�i���s�ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_GYO_SORT_NO IS '�`�[�s�\�[�g�ԍ�(���Д[�i���ԍ����̏o�͏�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_GYO_NO IS '�[�i���s�ԍ�(���Д[�i����̌����ڂ̍s�ԍ��i���V�d�l�͕����y�[�W����j���Ӑ摗�M�v������)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_RETU_NO IS '�[�i����ԍ�(�V�@��ԍ��i��1�`6�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_NO IS '����`�[�ԍ�(���Ӑ�w��̓`�[�ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_NO_CD IS '����`�[�ԍ�C/D(����`�[�ԍ��̃`�F�b�N�f�B�W�b�g)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_GYO_NO IS '����`�[�s�ԍ�(����`�[�ԍ��̍s�ԍ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_NOHIN_NO IS '����[�i�ԍ�(���Ӑ�e�Ђ���̗v���ɂ��ėp�I�Ɏg�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_PRT_FLG IS '�[�i�����s�σt���O(1���P�[�[�i�����s�ς݁@0�������s�@9�����s�s�v)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SENDEN_PRT_FLG IS '��p�`�[���s�σt���O(1���A���[�i�����s�ς݁@0�������s�@9�����s�s�v)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TENKIHYO_PRT_FLG IS '�]�L�\���s�σt���O(�����g�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURIJYO_PRT_FLG IS '����󔭍s�σt���O(�����g�p)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_SIJISYO_PRT_FLG IS '�o�׎w�������s�σt���O(1���o�׎w�������s�ς�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINDATA_CRT_FLG IS '�[�i�f�[�^�쐬�σt���O(1���[�i�f�[�^�쐬�ς݁@0�����쐬�@9���쐬�s�v)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EOS_FLG IS 'EOS�t���O(1�������Z���^�[�ɂ�EOS�󒍕��Ƃ��ċ�ʁi���󒍎�t������ʂ�Ȃ��󒍁j)����EOS�敪'
/
COMMENT ON COLUMN D_EDI_JYUTYU.BATCH_NO IS '�o�b�`�ԍ�(�{�Ђ͕����V�X�e�����ō̔ԁA�����Z���^�[�͏�ʃV�X�e���ō̔�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_NO IS '�o�הԍ�(�o�ד��i8���j�{�o�b�`�ԍ��i3���j�{�A�ԁi4���j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KINKYU_HOJYU_KBN IS '�ً}��[�敪(0����Ώہ@1���ً}��[�Ώہ@2����[�����i�Ĉ����ς݁j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU1 IS '���i�x���P(WMS�o�׌��i������ʂ֕\�������Ǝ҂ւ̌x�����b�Z�[�W)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU2 IS '���i�x���Q(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU3 IS '���i�x���R(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU4 IS '���i�x���S(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU5 IS '���i�x���T(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_FLG IS '�[�i�����s�t���O(1��WMS�Ŕ[�i���𔭍s����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NAIYOU_MEISAI_FLG IS '���e���׏����s�t���O(1��WMS�œ��e���׏��𔭍s����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURIJYO_FLG IS '����󔭍s�t���O(1��WMS�ő����𔭍s����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.LABEL_FLG IS '�������x�����s�t���O(1��WMS�ŕ������x���𔭍s����)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SOUSIN_SUMI_FLG IS '���M�σt���O(1���{�Е����V�X�e���^WMS�֑��M�ς݁A�D�y�c�Ə��o�׎w���ς�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SOUSIN_SUMI_SU IS '���M�ϐ�(�����V�X�e���֑��M�ς̐��ʁi�o�׎w�����ʂƂ̓���������j�����ʓI�ɓ�d�Ǘ�)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SOUSIN_KAISU IS '���M��(���M�̓s�x1�J�E���g�A�b�v�iWMS�݂̂̎d�l�ƂȂ邩�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYOTAI_KBN IS '��ԋ敪(1���󒍍ρ@2�����O�i���Ў��R�j�@3�����O�i���莖�R�j�@4���o�׎w���ρ@5���݌Ɉ����ρ@6���o�ג��@7���o�׍ρ@8���m��ρ@9���폜)�����̋敪��259'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_DATE IS '�o�^��(���R�[�h�V�K�o�^���ɏo��)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_USER_ID IS '�o�^���[�U�[ID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_CLIENT_ID IS '�o�^�N���C�A���gID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_PG_ID IS '�o�^�v���O����ID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_DATE IS '�ύX��(���[�U�[���o�^�������e��ύX����ꍇ�̂ݍX�V�i���R�[�h�V�K�o�͎���NULL�l�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_USER_ID IS '�ύX���[�U�[ID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_CLIENT_ID IS '�ύX�N���C�A���gID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_PG_ID IS '�ύX�v���O����ID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_DATE IS '�X�V��(���R�[�h�X�V���͏�ɍX�V�i���R�[�h�V�K�o�͎���NULL�l�j)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_USER_ID IS '�X�V���[�U�[ID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_CLIENT_ID IS '�X�V�N���C�A���gID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_PG_ID IS '�X�V�v���O����ID(�V)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAITA_FLG IS '�r���t���O(1�����[�U�[�܂��̓V�X�e���ɂ��r����ԁi�ߊσ��b�N�j)'
/
