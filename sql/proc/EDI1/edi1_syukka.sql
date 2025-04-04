create or replace package edi1_syukka is
    function main (
        p_syori_kbn         in number,
        p_edi_jyusin_no     in d_edi_jyutyu.edi_jyusin_no%type,
        p_kyoten_code       in d_edi_jyutyu.kyoten_code%type,
        p_okuri_tokui_code  in d_edi_jyutyu.okuri_tokui_code%type,
        p_syukka_date       in d_edi_jyutyu.syukka_date%type,
        p_jitu_nohin_date   in d_edi_jyutyu.jitu_nohin_date%type,
        p_edi_haiso_nissu   in d_edi_jyutyu.edi_haiso_nissu%type,
        p_entry_user_id     in d_edi_jyutyu.entry_user_id%type,
        p_user_id           in d_edi_jyutyu.kousin_user_id%type,
        p_client_id         in d_edi_jyutyu.kousin_client_id%type
    ) return number;

end edi1_syukka;
/
create or replace package body edi1_syukka is
	/*	Script		： 出荷メイン
		Author		： K.Sakamoto
		Parameters	： p_syori_kbn          - 処理区分（１：出荷、２：出荷取消）
                    ： p_edi_jyusin_no      - EDI受信番号
                    ： p_kyoten_code        - （出荷）拠点コード
					： p_okuri_tokui_code   - 送り得意先コード
                    ： p_syukka_date        - 出荷日
                    ： p_jitu_nohin_date    - 実納品日
                    ： p_edi_haiso_nissu    - EDI配送日数
					： p_entry_user_id      - 処理者コード
                    ： p_user_id            - ユーザーID
                    ： p_client_id          - クライアントID
		Return		： 成否判定（-1：異常、0：正常）
		DataWritten	： 2025/03/12
		Modified	：
	*/
    function main (
        p_syori_kbn         in number,
        p_edi_jyusin_no     in d_edi_jyutyu.edi_jyusin_no%type,
        p_kyoten_code       in d_edi_jyutyu.kyoten_code%type,
        p_okuri_tokui_code  in d_edi_jyutyu.okuri_tokui_code%type,
        p_syukka_date       in d_edi_jyutyu.syukka_date%type,
        p_jitu_nohin_date   in d_edi_jyutyu.jitu_nohin_date%type,
        p_edi_haiso_nissu   in d_edi_jyutyu.edi_haiso_nissu%type,
        p_entry_user_id     in d_edi_jyutyu.entry_user_id%type,
        p_user_id           in d_edi_jyutyu.kousin_user_id%type,
        p_client_id         in d_edi_jyutyu.kousin_client_id%type
    ) return number
    is
        -- 伝票番号発番単位カーソル
        cursor cur1 is
        select d_edi_jyutyu.edi_jyusin_no,
               d_edi_jyutyu.jyutyu_no
          from d_edi_jyutyu
         where d_edi_jyutyu.edi_jyusin_no = p_edi_jyusin_no
           and d_edi_jyutyu.okuri_tokui_code = p_okuri_tokui_code
           and d_edi_jyutyu.edi_haiso_nissu = p_edi_haiso_nissu
        group by
               d_edi_jyutyu.edi_jyusin_no,
               d_edi_jyutyu.jyutyu_no
        order by
               d_edi_jyutyu.edi_jyusin_no,
               d_edi_jyutyu.jyutyu_no
        ;

        cursor cur2(v_edi_jyusin_no d_edi_jyutyu.edi_jyusin_no%type, v_jyutyu_no d_edi_jyutyu.jyutyu_no%type) is
        select rowid,
               jyutyu_gyo_no,
               nohin_sitei_date,
               edi_error_flg_1,
               jyotai_kbn
          from d_edi_jyutyu
         where d_edi_jyutyu.edi_jyusin_no = v_edi_jyusin_no
           and d_edi_jyutyu.jyutyu_no = v_jyutyu_no
        order by
               jyutyu_gyo_no
        ;
        l_syohizei_ritu     d_edi_jyutyu.syohizei_ritu%type;
        l_denpyo_no         d_edi_jyutyu.denpyo_no%type;
        l_denpyo_gyo_no     d_edi_jyutyu.denpyo_gyo_no%type;
        l_jyotai_kbn        d_edi_jyutyu.jyotai_kbn%type;
        l_result            number;
    begin
        -- 出荷のとき
        if p_syori_kbn = 1 then
            -- 出荷日時点の税率を取得する
            begin
                select m_zeiritu.syohizei_ritu
                  into l_syohizei_ritu
                  from m_zeiritu
                 where m_zeiritu.torihiki_kbn = 1      -- ★1固定？
                   and m_zeiritu.zeiritu_kbn = 1       -- ★1固定？
                   and (p_syukka_date between m_zeiritu.zeiritu_str_date and m_zeiritu.zeiritu_end_date)
                ;
            exception
                when no_data_found then
                    -- ★設定無い場合はエラー？
                    l_syohizei_ritu := 0;
                when others then
                    raise;
            end;

            -- 一行ずつ反映
            for rec in cur1 loop
                -- 伝票番号採番
                l_denpyo_no := seq_nohin_no_wms.nextval;
                for rec_m in cur2(rec.edi_jyusin_no, rec.jyutyu_no) loop
                    l_denpyo_gyo_no := rec_m.jyutyu_gyo_no;
                    -- 実納品日
                    if p_jitu_nohin_date is not null then
                        rec_m.nohin_sitei_date := p_jitu_nohin_date;
                    end if;
                    -- 状態区分
                    if rec_m.edi_error_flg_1 = 1 or rec_m.jyotai_kbn in (2,3) then
                        l_jyotai_kbn := rec_m.jyotai_kbn;
                    else
                        l_jyotai_kbn := 4;
                    end if;

                    update d_edi_jyutyu
                    set
                        kyoten_code = p_kyoten_code,
                        syukka_date = p_syukka_date,
                        SYOHIZEI_RITU = l_syohizei_ritu,
                        jitu_nohin_date = rec_m.nohin_sitei_date,
                        denpyo_no = l_denpyo_no,
                        denpyo_gyo_no = l_denpyo_gyo_no,
                        jyotai_kbn = l_jyotai_kbn
                    where
                        rowid = rec_m.rowid
                    ;
                end loop;
            end loop;

            return 0;
        end if;

        -- 出荷取消のとき
        if p_syori_kbn = 2 then
            for rec in cur1 loop
                for rec_m in cur2(rec.edi_jyusin_no, rec.jyutyu_no) loop
                    update d_edi_jyutyu
                    set
                        syukka_date = 0,
                        jitu_nohin_date = 0,
                        denpyo_no = 0,
                        denpyo_gyo_no = 0,
                        jyotai_kbn = decode(rec_m.jyotai_kbn, 4, 1, rec_m.jyotai_kbn)
                    where
                        rowid = rec_m.rowid
                    ;
                end loop;
            end loop;

            return 0;
        end if;

        -- 上記以外はエラー
        return -1;
    end main;

end edi1_syukka;
/