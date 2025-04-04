create or replace package edi1_zaiko_hikiate is
    function main (
        p_syori_kbn         in number,
        p_ra_kbn            in number,
        p_ba_kbn            in number,
        p_edi_jyusin_no     in d_edi_jyutyu.edi_jyusin_no%type,
        p_kyoten_code       in d_edi_jyutyu.kyoten_code%type,
        p_okuri_tokui_code  in d_edi_jyutyu.okuri_tokui_code%type,
        p_syukka_date       in d_edi_jyutyu.syukka_date%type,
        p_entry_user_id     in d_edi_jyutyu.entry_user_id%type,
        p_user_id           in d_edi_jyutyu.kousin_user_id%type,
        p_client_id         in d_edi_jyutyu.kousin_client_id%type
    ) return number;

end edi1_zaiko_hikiate;
/
create or replace package body edi1_zaiko_hikiate is
	/*	Script		： 出荷メイン
					： 呼出用
		Author		： K.Sakamoto
		Parameters	： p_syori_kbn          - 処理区分（1：在庫引当、2：在庫引当取消、3：全キャンセル、4：全欠品）
                    ： p_ra_kbn             - リザーブ引当（1：ON、0：OFF）
                    ： p_ba_kbn             - 均等引当（1：ON、0：OFF）
                    ： p_edi_jyusin_no      - EDI受信番号
                    ： p_kyoten_code        - （出荷）拠点コード
					： p_okuri_tokui_code   - 送り得意先コード
                    ： p_syukka_date        - 出荷日
					： p_entry_user_id      - 処理者コード
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（-1：異常、0：正常）
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function main (
        p_syori_kbn         in number,
        p_ra_kbn            in number,
        p_ba_kbn            in number,
        p_edi_jyusin_no     in d_edi_jyutyu.edi_jyusin_no%type,
        p_kyoten_code       in d_edi_jyutyu.kyoten_code%type,
        p_okuri_tokui_code  in d_edi_jyutyu.okuri_tokui_code%type,
        p_syukka_date       in d_edi_jyutyu.syukka_date%type,
        p_entry_user_id     in d_edi_jyutyu.entry_user_id%type,
        p_user_id           in d_edi_jyutyu.kousin_user_id%type,
        p_client_id         in d_edi_jyutyu.kousin_client_id%type
    ) return number
    is
        -- 処理単位カーソル
        cursor cur is
        select rowid,
               d_edi_jyutyu.edi_jyusin_no,
               d_edi_jyutyu.jyutyu_no
          from d_edi_jyutyu
         where d_edi_jyutyu.edi_jyusin_no = p_edi_jyusin_no
           and d_edi_jyutyu.okuri_tokui_code = p_okuri_tokui_code
           and d_edi_jyutyu.syukka_date = p_syukka_date
           and (
                (p_syori_kbn = 1 and d_edi_jyutyu.jyotai_kbn in (4, 5, 6)) or
                (p_syori_kbn = 2 and d_edi_jyutyu.jyotai_kbn in (5)) or
                (p_syori_kbn in (3, 4) and d_edi_jyutyu.jyotai_kbn in (4, 5, 6, 7))
                )
        ;
        l_jyotai_kbn        d_edi_jyutyu.jyotai_kbn%type;
        l_result            number;
    begin
        case p_syori_kbn
        when 1 then
            l_jyotai_kbn := 5;
        when 2 then
            l_jyotai_kbn := 4;
        when 3 then
            l_jyotai_kbn := 5;
        when 4 then
            l_jyotai_kbn := 5;
        else
            -- 上記以外はエラー
            return -1;
        end case;

        -- 状態区分を変更
        for rec in cur loop
            update d_edi_jyutyu
            set
                jyotai_kbn = l_jyotai_kbn
            where
                rowid = rec.rowid
            ;
        end loop;

        return 0;
    end main;

end edi1_zaiko_hikiate;
/