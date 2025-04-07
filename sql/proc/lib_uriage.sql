create or replace package lib_uriage is

	-- 端数処理
	function	get_hasuu( p_number number,p_hasuu number ) return number;
	-- 与信限度額取得
	function	get_yosin_gendo_gaku( p_seikyu_code number ) return number;
	-- 総債権額取得
	function	get_so_saiken_gaku( p_seikyu_code number ) return number;
	-- 債権予定額取得
	function	get_saiken_yotei_gaku( p_tokui_code number ) return number;

	procedure	disp_out( p_log varchar2 );
end lib_uriage;
/

create or replace package body lib_uriage is
	err_num		number		:= 0;
	err_msg		varchar2(300)	:= ' ';

	/*
		端数処理	2024.08.23 J.Tanaka
		p_number	: 値
		p_hasuu		: 端数処理区分（1：切捨て 2：四捨五入 3：切上げ）
		return 		: 端数処理後の値
	*/
	function	get_hasuu( p_number number,p_hasuu number ) return number is
		-- 変数の宣言
		l_rtn		number	:= 0;
		l_number	number	:= 0;
		l_flg		number	:= 1;

		begin

			-- 端数処理は絶対値で行う！
			if p_number < 0 then
				l_flg := -1;
			end if;
			l_number := p_number * l_flg;

			-- 1：切捨て
			if p_hasuu = 1 then
				l_rtn := trunc( l_number, 0 );
			-- 2：四捨五入
			elsif p_hasuu = 2 then
				l_rtn := round( l_number, 0 );
			-- 3：切上げ
			elsif p_hasuu = 3 then
				l_rtn := ceil( l_number );
			end if;

			return l_rtn * l_flg ;

	end get_hasuu;

	/*
		与信限度額取得	2024.08.23 J.Tanaka
		p_seikyu_code	: 請求先コード
		return 		: 与信限度額
	*/
	function	get_yosin_gendo_gaku( p_seikyu_code number ) return number is
		-- 変数の宣言
		l_rtn			number;

		-- カーソルの宣言
		cursor cr1 is
			select mt.yosin_gendo_gaku 
			  from m_tokui mt
			 where mt.tokui_code  = p_seikyu_code;
		cr1_rec	cr1%rowtype;

		begin

			-- カーソルオープン
			open cr1;
			fetch cr1 into cr1_rec;

			if cr1%found then
				l_rtn := cr1_rec.yosin_gendo_gaku;
			else
				l_rtn := 0;
			end if;

			-- カーソルクローズ
			close cr1;

			return l_rtn;

	end get_yosin_gendo_gaku;

	/*
		総債権額取得	2024.08.23 J.Tanaka
		p_seikyu_code	: 請求先コード
		return 		: 総債権額
	*/
	function	get_so_saiken_gaku( p_seikyu_code number ) return number is
		-- 変数の宣言
		l_rtn			number	:= 0;
		l_tougetu_urikake_zan	number	:= 0;
		l_mikessai_tegata_zan	number	:= 0;

		-- カーソルの宣言
		cursor cr1 is
			-- < 当月末売掛金残高 >
			-- 前月末売掛金残高 + 売上金額 + 返品金額 + 値増金額 + 値引金額 + 歩引金額 + 消費税金額 - 入金金額
			select nvl( sum( du.zengetu_urikake_zan +
			                 du.uriage_kingaku +
			                 du.henpin_kingaku +
			                 du.nemasi_kingaku +
			                 du.nebiki_kingaku +
			                 du.bubiki_kingaku +
			                 du.syohizei_kingaku  -
			                 du.nyukin_kingaku ), 0 ) tougetu_urikake_zan
			  from d_urikake du
			 where du.sime_flg    = 0		-- 0：月次締め未処理
			   and du.seikyu_code = p_seikyu_code;
		cr1_rec	cr1%rowtype;

		cursor cr2 is
			-- < 未決済手形残高 >
			-- 券面金額（入金金額） - 決済金額
			select nvl( sum( dt.tegata_kingaku -
			                 dt.kessai_kingaku ), 0 ) mikessai_tegata_zan 
			  from d_tegata dt
			 where ( dt.tegata_kingaku - dt.kessai_kingaku ) > 0
			   and dt.seikyu_code = p_seikyu_code;
		cr2_rec	cr2%rowtype;

		begin

			-- < 当月末売掛金残高 >
			-- カーソルオープン
			open cr1;
			fetch cr1 into cr1_rec;

			if cr1%found then
				l_tougetu_urikake_zan := cr1_rec.tougetu_urikake_zan;
			end if;

			-- カーソルクローズ
			close cr1;

			-- < 未決済手形残高 >
			-- カーソルオープン
			open cr2;
			fetch cr2 into cr2_rec;

			if cr2%found then
				l_mikessai_tegata_zan := cr2_rec.mikessai_tegata_zan;
			end if;

			-- カーソルクローズ
			close cr2;

			-- 当月末売掛金残高 + 未決済手形残高 
			l_rtn := l_tougetu_urikake_zan + l_mikessai_tegata_zan;

			return l_rtn;

	end get_so_saiken_gaku;

	/*
		債権予定額取得	2024.08.23 J.Tanaka
		p_tokui_code	: 得意先コード
		return 		: 債権予定額
	*/
	function	get_saiken_yotei_gaku( p_tokui_code number ) return number is
		-- 変数の宣言
		l_rtn			number	:= 0;
		l_saiken_yotei_gaku	number	:= 0;
		l_syohizei		number	:= 0;
		l_zei_hasu_kbn		number;

		-- カーソルの宣言
		cursor cr1 is
			-- 消費税端数処理区分取得
			select decode( mt.zei_hasu_kbn, 9, mk.zei_hasuu_uriage, mt.zei_hasu_kbn ) zei_hasu_kbn 
			  from m_tokui mt,
			       m_kihon mk
			 where mt.tokui_code = p_tokui_code
			   and mk.kanri_code = 0;
		cr1_rec	cr1%rowtype;

		cursor cr2 is
			-- < 債権予定額 >
			-- ( 出荷指示数量 - 出荷実績数量 - 出荷止め数量 - キャンセル数量 ) *（ 単価 + 値引単価 )
			select ds.jyutyu_no,
			       nvl(sum( lib_uriage.get_hasuu(( ds.syukka_siji_su - ds.syukka_jisseki_su - ds.jyutyuzan_su - ds.cancel_su ) * 
			                                     ( ds.tanka + ds.nebiki_tanka ), 1 )), 0 ) kingaku,
			       max( ds.syohizei_kbn ) syohizei_kbn,
			       max( ds.syohizei_ritu ) syohizei_ritu
			  from d_syukka_yotei ds
			 where ds.tokui_code           =  p_tokui_code
			   and ds.torihiki_jyoken_kbn  <> 2
			   and ds.torihiki_kbn_1       =  11
			 group by ds.jyutyu_no;
		cr2_rec	cr2%rowtype;

		begin

			-- カーソルオープン
			open cr1;
			fetch cr1 into cr1_rec;
			if cr1%found then
				l_zei_hasu_kbn := cr1_rec.zei_hasu_kbn;
			else
				l_zei_hasu_kbn := 1;	-- 1：切捨て
			end if;
			-- カーソルクローズ
			close cr1;

			-- カーソルオープン
			open cr2;
			-- 繰返し処理
			loop
				fetch cr2 into cr2_rec;
				exit when cr2%notfound or cr2%notfound is null;

				if cr2_rec.kingaku = 0 then
					l_saiken_yotei_gaku := 0;
				else
					-- 1：単価税別は消費税計算
					l_syohizei := 0;
					if  cr2_rec.syohizei_kbn = 1 then
						l_syohizei  := lib_uriage.get_hasuu(( cr2_rec.kingaku * cr2_rec.syohizei_ritu ) / 100, l_zei_hasu_kbn );
					end if;
					l_saiken_yotei_gaku := cr2_rec.kingaku + l_syohizei;
				end if;

				l_rtn := l_rtn + l_saiken_yotei_gaku;

			end loop;

			-- カーソルクローズ
			close cr2;

			return l_rtn;

	end get_saiken_yotei_gaku;

	/*
		Script		： コンソールログ出力
		Author		： H.Kintou
		Parameters	： p_log		- コンソールに表示する文字列
		Return		：
		DataWritten	： 2023.04.19
		Modified	：
	*/
	procedure	disp_out( p_log varchar2 ) is
		begin
			-- ORA-4068回避
			-- dbms_session.reset_package();

			dbms_output.put_line( to_char( sysdate, 'yyyy.mm.dd hh24:mi:ss' ) || '：' || p_log );
	end disp_out;
end lib_uriage;
/
