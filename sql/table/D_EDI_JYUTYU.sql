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
COMMENT ON TABLE D_EDI_JYUTYU IS 'EDI受注データ（共通）'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KYOTEN_CODE IS 'EDI拠点コード(EDIデータを取り込んだ拠点のコード)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_JYUSIN_NO IS 'EDI受信番号(EDIデータ受信単位に付番する（基本情報マスターの処理日+seq_edi_jyusin_no）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_JYUSIN_DATE IS 'EDI受信日(EDIデータを取り込んだ日)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_TOKUI_CODE IS 'EDI得意先コード(EDI得意先コード（代表得意先）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYORI_ID IS 'EDI処理ID(EDI処理単位などに付すID（DCM、VAL、ARC、UFOなど）)※名称区分＝260'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KONPO_KBN IS 'EDI梱包区分(1＝総量一括　2＝店別梱包)※名称区分＝298'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_NOHIN_KBN IS 'EDI納品区分(1＝センター納品　2＝店舗直送)※名称区分＝258'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HAISO_NISSU IS 'EDI配送日数(配送日数（エラーチェックにて定数マスターから付け込み）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HATYU_NO IS 'EDI発注番号(EDI発注データにて受信した相手発注番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HATYU_DATE IS 'EDI発注日(〃　相手発注日)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_NOHIN_SITEI_DATE IS 'EDI納品指定日(〃　納品指定日)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_MISE_CODE IS 'EDI店コード(〃　店コード)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_MISE_MEI IS 'EDI店名(〃　店名)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_OKURI_MISE_CODE IS 'EDI送り店コード(〃　送り先の店コード)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_OKURI_MISE_MEI IS 'EDI送り店名(〃　送り先の店名)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYOHIN_CODE IS 'EDI商品コード(〃　商品コード（JAN／インストア）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYOHIN_MEI IS 'EDI商品名(〃　商品名)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_SYOHIN_KIKAKU IS 'EDI商品規格(〃　商品規格（色・サイズ等）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_HATYU_SU IS 'EDI発注数量(〃　発注数量)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_TANKA IS 'EDI原単価(〃　原価単価)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_BAIKA IS 'EDI売単価(〃　売価単価)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_RESERVE_KBN IS 'EDIリザーブ区分(1＝なし　2＝あり　3＝引当先指定)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_RESERVE_JYUTYU_NO IS 'EDIリザーブ受注番号(EDIリザーブ区分＝3の場合の引当先受注番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_GENBUTU_KBN IS 'EDI現物引当区分(1＝あり　2＝なし)※名称区分＝270'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_JYUTYUZAN_KBN IS 'EDI受注残引当区分(1＝あり　2＝なし　3＝引当なし)※名称区分＝271'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG IS 'EDIエラーフラグ(1＝エラーあり)※"AS (CASE WHEN ERROR_FLG_1 > 0 THEN 1 WHEN ERROR_FLG_2 > 0 THEN 1 WHEN ERROR_FLG_3 > 0 THEN 1 WHEN ERROR_FLG_4 > 0 THEN 1 WHEN ERROR_FLG_5 > 0 THEN 1 ELSE 0 END) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_1 IS 'EDIエラーフラグ1(1＝店エラー)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_2 IS 'EDIエラーフラグ2(1＝送り先エラー)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_3 IS 'EDIエラーフラグ3(1＝商品エラー)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_4 IS 'EDIエラーフラグ4(1＝単価エラー)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_ERROR_FLG_5 IS 'EDIエラーフラグ5(1＝その他のエラー)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG IS 'EDI警告フラグ(1＝警告あり)※"AS (CASE WHEN KEIKOKU_FLG_1 > 0 THEN 1 WHEN KEIKOKU_FLG_2 > 0 THEN 1 WHEN KEIKOKU_FLG_4 > 0 THEN 1 WHEN KEIKOKU_FLG_5 > 0 THEN 1 ELSE 0 END) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_1 IS 'EDI警告フラグ1(1＝重複の可能性あり)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_2 IS 'EDI警告フラグ2(1＝日付警告（納品日超過など）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_3 IS 'EDI警告フラグ3(1＝単価警告（※ここは仮想列の条件に含めない）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_4 IS 'EDI警告フラグ4(※未使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_KEIKOKU_FLG_5 IS 'EDI警告フラグ5(1＝その他の警告)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_NO IS '受注番号(受注番号（7桁で運用）)※主キー①'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_DATE IS '受注日付(受注日付（明細を事後追加した場合も含め、同一受注番号内は全て同じ値）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_TIME IS '受注時刻(受注時刻（　〃　）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_KBN IS '受注区分(※未使用)※名称区分＝206'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_HOUHOU IS '受注方法(2＝EOS受注（固定）)※名称区分＝205'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSIN_NO IS '受信番号(EDIデータ受信単位に付番する番号（EDI受信番号と同値）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ENTRY_USER_ID IS '入力者コード(各取引の入力担当者コード（※発注データ取り込み担当者）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ENTRY_USER_MEI IS '入力者名(入力担当者名（※同上）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOKUI_CODE IS '得意先コード(売上先の得意先コード（エラーチェック時にセット、以降は売上計上まで表示のみ）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.MISE_CODE IS '店コード(売上先の店コード（受信した発注データ中の店コードをセット）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TORIHIKI_JYOKEN_KBN IS '取引条件区分(1＝掛売り　2＝現金売り（先現金）)※名称区分＝105'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_DATE IS '出荷日(実際の出荷予定日（※出荷指示にてセット、出荷日変更にて変更可能）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_DATE IS '伝票日付(納品伝票上の日付（※出荷日と同値をセット）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_SYUBETU IS '伝票種別(1固定)※名称区分＝217'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_KBN IS '出荷区分(1＝通常　2＝移動出荷　3＝預り売上　4＝仕入直送　5＝預り出荷)※名称区分＝209'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_HOUHOU IS '出荷方法(1＝通常　2＝別注指定　3＝個別指定　4＝単体指定)※名称区分＝213'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NIGUMI_NO IS '荷組番号(荷組指定または単体指定した場合に番号がセットされる（通常は受注番号が入る）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_GYO_NO IS '受注行番号※主キー②'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_KAISU IS '出荷回数(0＝未出荷　出荷予定データ新規出力時に「1」をセット)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_GYO_SORT_NO IS '受注行ソート番号'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KYOTEN_CODE IS '拠点コード(出荷拠点コード（実際に出荷する拠点のコード・出庫拠点コード）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TORIHIKI_KBN_1 IS '取引区分１(11＝売上　16＝社内出荷　17＝社内返品　18＝移動出荷　19＝預り出荷)※名称区分＝200'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TORIHIKI_KBN_2 IS '取引区分２(01＝預り売上　02＝直送売上　05＝単価訂正　06＝出荷訂正)※名称区分＝201'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOHIN_CODE IS '商品コード'
/
COMMENT ON COLUMN D_EDI_JYUTYU.IRO_NO IS '色番'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SKU_CODE IS 'SKUコード(商品登録時に採番される一意の内部コード（永久番号）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HIN_BAN IS '品番(マスターからセット（EOSの場合、手入力には対応しない）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HIN_MEI IS '品名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.IRO_MEI IS '色名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SIZE_MEI IS 'サイズ名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_SU IS '受注数量(受注総数量（＝EOS発注数量）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HIKIATE_SU IS '引当数量(在庫引当数量（出荷数量）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_ZAN_SU IS '受注残数量(※未使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_SIJI_SU IS '出荷指示数量(下位システムへ送信済みの出荷指示数量)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_SUMI_SU IS '出荷済み数量(下位システムから返された出荷実績数量（I_WMS_SYUKKA_JISSEKIから）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.CANCEL_SU IS 'キャンセル数量(得意先理由によるキャンセル数量)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KEPPIN_SU IS '欠品数量(当社欠品数量)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TANKA IS '単価(入力用単価・表示単価（値引前・税込／税別いずれもあり）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NEBIKI_TANKA IS '値引単価(単価に対する値引単価)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.GENKA_TANKA IS '原価単価(この時点の移動平均原価（端数四捨五入）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOHIZEI_KBN IS '消費税区分(1＝単価税別　2＝単価税込)※名称区分＝104'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KAZEI_KBN IS '課税区分(1＝課税売上　2＝免税売上（※当面は左記2区分のみ登録、受注入力は「1」固定出力)※名称区分＝039'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOHIZEI_RITU IS '消費税率(確定した消費税率)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ZEIBETU_TANKA IS '税別単価(税込先の場合は税控除後の単価（売上用単価）、税別先の場合はTANKAと同値が入る)※"as (case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ZEIBETU_NEBIKI_TANKA IS '税別値引単価(税別単価に対する値引単価（同上）)※"as (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KINGAKU IS '金額(端数切捨て(引当数量×(税別単価＋税別値引単価)))※"as (trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0)) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.GENKA_KINGAKU IS '原価金額(端数切捨て(引当数量×原価単価), ただし粗利計算フラグ0の場合＝金額)※"as (case when arari_keisan_flg = 1 then trunc(hikiate_su * genka_tanka,0) else trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0) end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ARARI_KINGAKU IS '粗利金額(金額－原価金額)※"as (trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0) - case when arari_keisan_flg = 1 then trunc(hikiate_su * genka_tanka,0) else trunc(hikiate_su * ((case when tanka = 0 then 0 when syohizei_kbn = 1 then tanka when syohizei_kbn = 2 then tanka - trunc(tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end) + (case when nebiki_tanka = 0 then 0 when syohizei_kbn = 1 then nebiki_tanka when syohizei_kbn = 2 then nebiki_tanka - trunc(nebiki_tanka / (1 + syohizei_ritu / 100) * (syohizei_ritu / 100),0) else 0 end)),0) end) VIRTUAL"'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BAIKA1 IS '相手売価１(得意先の売価単価（税抜・税込に関わらず通常はこちらを使用）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BAIKA2 IS '相手売価２(税込・税別両方をセットする場合は、税込＝１、税別＝２を使用する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYU_TEKIYO IS '受注摘要(受注入力者が入力する社内用コメント（行単位）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_TEKIYO IS '伝票摘要(内容明細書・納品書の各行に印字する摘要（行単位）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.BUTURYU_TEKIYO IS '物流摘要(出荷担当者へ伝えるメッセージ（行単位）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.LOCATION_KBN IS '出荷ロケ区分(1＝通常　2＝出荷準備ロケ　3＝事務所ロケ　4＝仕立場　5＝検査場)※名称区分＝211'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KAKO_SASIZU_NO IS '加工指図番号(製品加工指図番号（通常は受注番号と同値）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KAKO_GYO_NO IS '加工行番号(製品加工行番号（通常は受注行番号と同値）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN1 IS '製品加工区分１(加工指図入力にて入力)※名称区分＝174'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO1 IS '製品加工摘要１(名称マスターより取得した名称も保持)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN2 IS '製品加工区分２(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO2 IS '製品加工摘要２(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN3 IS '製品加工区分３(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO3 IS '製品加工摘要３(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN4 IS '製品加工区分４(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO4 IS '製品加工摘要４(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_KBN5 IS '製品加工区分５(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SEIHIN_KAKO_TEKIYO5 IS '製品加工摘要５(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN1 IS '流通加工区分１(エラーチェック処理にてセット)※名称区分＝173'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO1 IS '流通加工摘要１(名称マスターより取得した名称も保持)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN2 IS '流通加工区分２(流通加工区分１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO2 IS '流通加工摘要２(流通加工摘要１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN3 IS '流通加工区分３(流通加工区分１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO3 IS '流通加工摘要３(流通加工摘要１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN4 IS '流通加工区分４(流通加工区分１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO4 IS '流通加工摘要４(流通加工摘要１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_KBN5 IS '流通加工区分５(流通加工区分１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.RYUTU_KAKO_TEKIYO5 IS '流通加工摘要５(流通加工摘要１に同じ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.BUKKEN_CODE IS '物件コード(※未使用（受注時or売上計上後に何らかの方法で入力を検討）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EDI_REC_NO IS 'EDIレコード番号(個社別EDI発注データレコードとの紐付け番号（seq_edi_rec_no）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SAMPLE_KBN IS 'サンプル区分(1＝指定なし　2＝色サンプル　3＝サイズサンプル)※名称区分＝273'
/
COMMENT ON COLUMN D_EDI_JYUTYU.MOTO_JYUTYU_NO IS '分割元受注番号(分割元の受注番号＋行番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.MOTO_JYUTYU_GYO_NO IS '分割元受注行番号(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUTYUZAN_FLG IS '受注残フラグ(1＝受注残から出荷)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOKUTI_SYOHIN_FLG IS '諸口商品フラグ(1＝諸口商品（品番等が手入力されている）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SURYO_KEISAN_FLG IS '数量計算フラグ(1＝数量を計算する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KINGAKU_KEISAN_FLG IS '金額計算フラグ(1＝金額を計算する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ARARI_KEISAN_FLG IS '粗利計算フラグ(1＝粗利を計算する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAKO_KEISAN_FLG IS '箱計算対象フラグ(1＝計算対象とする（本社／WMS共通化できない可能性あり）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_TAISYO_FLG IS '検品対象フラグ(1＝検品対象とする（本社／WMS共通化できない可能性あり）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_TOKUI_CODE IS '送り得意先コード(物流センターでは「得意先」と言えば通常こちらを指す)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_MISE_CODE IS '送り店コード(EOSの場合、店直の場合は店コード、センター納品の場合はセンターコードが入る)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOBETU_HAISO_FLG IS '戸別配送フラグ(1＝戸別配送（EOSでは現状使用予定なし）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TODOFUKEN_CODE IS '都道府県コード(01～47までの都道府県コード（市町村コードの頭２桁）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SIKUTYOSON_CODE IS '市区町村コード(ＪＩＳ市区町村コード)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.YUBIN_NO IS '郵便番号(送り先の郵便番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSYO1 IS '住所１(送り先の住所１)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSYO2 IS '住所２(送り先の住所２)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYUSYO3 IS '住所３(送り先の住所３)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_TOKUI_MEI IS '送り得意先名(送り先の得意先名（社外表示名）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_MEI1 IS '送り先名１(送り先店名１)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURI_MEI2 IS '送り先名２(送り先店名２)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TEL_NO IS '送り先電話番号(送り先の電話番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.UNSO_CODE IS '運送便コード(使用する運送便のコード)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAITATU_SITEI_DATE IS '配達指定日(配達指定日)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAITATU_SITEI_JIKOKU IS '配達指定時刻(配達指定時刻（時刻、または「AM」「PM」）)※名称区分＝182'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TYAKUTEN_CODE IS '着店コード(運送便各社の着店コード（営業店コード）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TYAKUTEN_TOME_FLG IS '運送便着店止めフラグ(1＝運送会社の営業店止めを指定)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NIFUDA_BIKOU IS '荷札備考(荷札（送り状）へ印字する備考)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NIOKURININ_CODE IS '荷送人コード(送り状へ出力する荷送人の情報（指定なしの場合は出荷元拠点の情報がセットされる）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_SYUBETU IS '納品書種別(※未使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_HAKKOU_KBN IS '同送納品書発行区分(1＝不要　2＝通常発行　4＝内容明細書単位)※名称区分＝118'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_KINGAKU_FLG IS '同送納品書金額表示フラグ(1＝表示する（旧入日記金額表示区分）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HATYU_DATE IS '発注日(得意先の発注日)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHIN_SITEI_DATE IS '納品指定日(得意先からの納品指定日（EOS発注データから転送）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JITU_NOHIN_DATE IS '実納品日(納品指定日をそのままセット、出荷指示／出荷日変更処理にて変更可能)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.IRAIMOTO_MEI IS '依頼元名(内容明細書に印字する依頼元名)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_BIKOU IS '納品書備考(納品書へ印字する備考（ページ単位）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NAIYOU_MEISAI_BIKOU IS '内容明細書備考(内容明細書へ印字する備考（ページ単位）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_NO IS '相手発注番号(受注入力にて手入力、またはEDI発注データからセット)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_NO_CD IS '相手発注番号C/D(相手発注番号のチェックディジット)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_KBN IS '相手伝票区分(得意先の伝票区分（仕入・返品など）)※相手名称区分＝004'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_KBN_MEI IS '相手伝票区分名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BUMON_CODE IS '相手部門コード(得意先の部門または分類（作業用品、園芸用品など）)※相手名称区分＝003'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_BUMON_MEI IS '相手部門名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_KBN IS '相手発注区分(得意先の発注区分（定番、特売、本部発注など）)※相手名称区分＝005'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_HATYU_KBN_MEI IS '相手発注区分名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SYUKKA_KBN IS '相手出荷区分(得意先の出荷区分（店舗直送、センター納品など）)※相手名称区分＝006'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SYUKKA_KBN_MEI IS '相手出荷区分名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_KONPO_KBN IS '相手梱包区分(得意先独自の区分に対応するための「第４の梱包条件」として設ける)※相手名称区分＝007'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_KONPO_KBN_MEI IS '相手梱包区分名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SONOTA_KBN IS '相手その他区分(予備区分（上記の区分で足りない場合、ハマらない場合に使用）)※相手名称区分＝008'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_SONOTA_KBN_MEI IS '相手その他区分名(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.ZBIN_FLG IS 'Ｚ便フラグ(1＝Ｚ便指定)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYOBUN_FLG IS '処分フラグ(1＝処分販売（受注時に任意指定）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_DATE_FLG IS '伝票日付承認フラグ(1＝伝票日付指定を許可)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KYAKUTYU_FLG IS '客注フラグ(※未使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.GAITYU_TYOKUSO_FLG IS '外注直送フラグ(※未使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_NO IS '伝票番号(当社納品書番号（最大8桁で運用予定）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_GYO_NO IS '伝票行番号(当社納品書行番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.DENPYO_GYO_SORT_NO IS '伝票行ソート番号(当社納品書番号内の出力順)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_GYO_NO IS '納品書行番号(当社納品書上の見た目の行番号（※新仕様は複数ページあり）得意先送信要件あり)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_RETU_NO IS '納品書列番号(〃　列番号（※1～6）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_NO IS '相手伝票番号(得意先指定の伝票番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_NO_CD IS '相手伝票番号C/D(相手伝票番号のチェックディジット)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_DENPYO_GYO_NO IS '相手伝票行番号(相手伝票番号の行番号)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.AITE_NOHIN_NO IS '相手納品番号(得意先各社からの要求により汎用的に使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_PRT_FLG IS '納品書発行済フラグ(1＝単票納品書発行済み　0＝未発行　9＝発行不要)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SENDEN_PRT_FLG IS '専用伝票発行済フラグ(1＝連帳納品書発行済み　0＝未発行　9＝発行不要)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TENKIHYO_PRT_FLG IS '転記表発行済フラグ(※未使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURIJYO_PRT_FLG IS '送り状発行済フラグ(※未使用)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_SIJISYO_PRT_FLG IS '出荷指示書発行済フラグ(1＝出荷指示書発行済み)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINDATA_CRT_FLG IS '納品データ作成済フラグ(1＝納品データ作成済み　0＝未作成　9＝作成不要)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.EOS_FLG IS 'EOSフラグ(1＝物流センターにてEOS受注分として区別（＝受注受付処理を通らない受注）)※旧EOS区分'
/
COMMENT ON COLUMN D_EDI_JYUTYU.BATCH_NO IS 'バッチ番号(本社は物流システム側で採番、物流センターは上位システムで採番)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SYUKKA_NO IS '出荷番号(出荷日（8桁）＋バッチ番号（3桁）＋連番（4桁）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KINKYU_HOJYU_KBN IS '緊急補充区分(0＝非対象　1＝緊急補充対象　2＝補充完了（再引当済み）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU1 IS '検品警告１(WMS出荷検品処理画面へ表示する作業者への警告メッセージ)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU2 IS '検品警告２(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU3 IS '検品警告３(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU4 IS '検品警告４(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KENPIN_KEIKOKU5 IS '検品警告５(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NOHINSYO_FLG IS '納品書発行フラグ(1＝WMSで納品書を発行する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.NAIYOU_MEISAI_FLG IS '内容明細書発行フラグ(1＝WMSで内容明細書を発行する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.OKURIJYO_FLG IS '送り状発行フラグ(1＝WMSで送り状を発行する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.LABEL_FLG IS '物流ラベル発行フラグ(1＝WMSで物流ラベルを発行する)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SOUSIN_SUMI_FLG IS '送信済フラグ(1＝本社物流システム／WMSへ送信済み、札幌営業所出荷指示済み)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SOUSIN_SUMI_SU IS '送信済数(物流システムへ送信済の数量（出荷指示数量との同数が入る）※結果的に二重管理)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.SOUSIN_KAISU IS '送信回数(送信の都度1カウントアップ（WMSのみの仕様となるか）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.JYOTAI_KBN IS '状態区分(1＝受注済　2＝除外（当社事由）　3＝除外（相手事由）　4＝出荷指示済　5＝在庫引当済　6＝出荷中　7＝出荷済　8＝確定済　9＝削除)※名称区分＝259'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_DATE IS '登録日(レコード新規登録時に出力)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_USER_ID IS '登録ユーザーID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_CLIENT_ID IS '登録クライアントID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.TOUROKU_PG_ID IS '登録プログラムID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_DATE IS '変更日(ユーザーが登録した内容を変更する場合のみ更新（レコード新規出力時はNULL値）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_USER_ID IS '変更ユーザーID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_CLIENT_ID IS '変更クライアントID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HENKOU_PG_ID IS '変更プログラムID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_DATE IS '更新日(レコード更新時は常に更新（レコード新規出力時はNULL値）)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_USER_ID IS '更新ユーザーID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_CLIENT_ID IS '更新クライアントID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.KOUSIN_PG_ID IS '更新プログラムID(〃)'
/
COMMENT ON COLUMN D_EDI_JYUTYU.HAITA_FLG IS '排他フラグ(1＝ユーザーまたはシステムによる排他状態（悲観ロック）)'
/
