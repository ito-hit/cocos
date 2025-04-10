create or replace package lib_calendar is

	-- 営業日取得
	function	get_eigyo_date( p_kyoten_code number, p_kijyun_date number, p_lt number, p_leadtime_keisan_kbn number) return number;

end lib_calendar;
/

create or replacE package body lib_calendar is

	/*
		営業日取得	2025.03.11 Y.Yamashita
		p_kyoten_code		: 拠点コード
		p_kijyun_date		: 基準日
		p_lt				: リードタイム 0:当日
		p_leadtime_keisan_kbn	: 1:暦日で計算 2:当社営業日で計算 3:土日祝日を除いて計算 4:金融機関営業日で計算
		return 		: 日付
	*/
	function	get_eigyo_date( p_kyoten_code number, p_kijyun_date number, p_lt number, p_leadtime_keisan_kbn number) return number is
		-- 変数の宣言
		l_rtn		number	:= 0;
		l_date		date ;
		l_calendar_kbn	number ;

		begin
			
			l_rtn := null ;
			
			-- 基準日が 0 or 99999999 の場合はnullを返す
			if p_kijyun_date = 0 or p_kijyun_date = 99999999 then
				return l_rtn ;
			end if ;
			-- 日付ではない
			if fnc.isdate( p_kijyun_date ) = 0 then
				return l_rtn ;
			end if ;

			-- 1:暦日で計算 カレンダー関係ない
			if p_leadtime_keisan_kbn = 1 then
				l_date := to_date( to_char( p_kijyun_date ), 'yyyymmdd' ) ;
				l_date := l_date + p_lt ;
				l_rtn  := to_number( to_char( l_date, 'yyyymmdd' ) ) ;
			-- 3:土日祝日を除いて計算
			elsif p_leadtime_keisan_kbn = 3 then
				case
					when p_lt >= 0 then
						begin
							select to_number( to_char( base_date, 'yyyymmdd' ) )
							  into l_rtn
							  from ( select dense_rank() over ( order by base_date ) row_num, base_date
							           from ( select to_date( to_char( p_kijyun_date ), 'yyyymmdd' ) + level - 1 base_date
							                    from dual
							                 connect by level <= p_lt + 365
							                )
							          where not exists ( select *
							                               from ( select mc.kyoten_code,
																	       mc.hizuke,
																	       max(mc.taisyo_flg) taisyo_flg,
																	       max(mc.nen) nen,
																	       max(mc.tuki) tuki,
																	       max(mc.hi) hi
																	  from m_calendar mc
																	 where mc.calendar_kbn in ( '1','2' )
																	 group by mc.kyoten_code,
																	       mc.hizuke
							                                      ) m_calender
							                              where taisyo_flg		= 1
							                                and kyoten_code		= p_kyoten_code
							                                and nen				= extract( year  from base_date )
							                                and tuki			= extract( month from base_date )
							                                and hi				= extract( day   from base_date )
							                           )
							       )
							 where row_num = (p_lt + 1) ;			
						exception
							when others then
								l_rtn	:= null ;
						end;
					when p_lt < 0 then
						begin
							select to_number( to_char( base_date, 'yyyymmdd' ) )
							  into l_rtn
							  from ( select dense_rank() over ( order by base_date desc) row_num, base_date
							           from ( select to_date( to_char( p_kijyun_date ), 'yyyymmdd' ) - level base_date
							                    from dual
							                 connect by level <= abs(p_lt) + 365
							                )
							          where not exists ( select *
							                               from ( select mc.kyoten_code,
																	       mc.hizuke,
																	       max(mc.taisyo_flg) taisyo_flg,
																	       max(mc.nen) nen,
																	       max(mc.tuki) tuki,
																	       max(mc.hi) hi
																	  from m_calendar mc
																	 where mc.calendar_kbn in ( '1','2' )
																	 group by mc.kyoten_code,
																	       mc.hizuke
							                                      ) m_calender
							                              where taisyo_flg		= 1
							                                and kyoten_code		= p_kyoten_code
							                                and nen				= extract( year  from base_date )
							                                and tuki			= extract( month from base_date )
							                                and hi				= extract( day   from base_date )
							                           )
							       )
							 where row_num = abs(p_lt) ;			
						exception
							when others then
								l_rtn	:= null ;
						end;
				end case;
			-- 2:当社営業日で計算
			else
				if p_leadtime_keisan_kbn = 2 then
					l_calendar_kbn := 3 ;
				elsif p_leadtime_keisan_kbn = 4 then
					l_calendar_kbn := 4 ;
				end if ;
				case
					when p_lt >= 0 then
						begin
							select to_number( to_char( base_date, 'yyyymmdd' ) )
							  into l_rtn
							  from ( select dense_rank() over ( order by base_date ) row_num, base_date
							           from ( select to_date( to_char( p_kijyun_date ), 'yyyymmdd' ) + level - 1 base_date
							                    from dual
							                 connect by level <= p_lt + 365
							                )
							          where exists ( select *
							                               from m_calendar
							                              where taisyo_flg		= 1
							                                and kyoten_code		= p_kyoten_code
							                                and calendar_kbn	= l_calendar_kbn
							                                and nen				= extract( year  from base_date )
							                                and tuki			= extract( month from base_date )
							                                and hi				= extract( day   from base_date )
							                           )
							       )
							 where row_num = (p_lt + 1) ;			
						exception
							when others then
								l_rtn	:= null ;
						end;
					when p_lt < 0 then
						begin
							select to_number( to_char( base_date, 'yyyymmdd' ) )
							  into l_rtn
							  from ( select dense_rank() over ( order by base_date desc) row_num, base_date
							           from ( select to_date( to_char( p_kijyun_date ), 'yyyymmdd' ) - level + 1 base_date
							                    from dual
							                 connect by level <= abs( p_lt ) + 365
							                )
							          where exists ( select *
							                               from m_calendar
							                              where taisyo_flg		= 1
							                                and kyoten_code		= p_kyoten_code
							                                and calendar_kbn	= l_calendar_kbn
							                                and nen				= extract( year  from base_date )
							                                and tuki			= extract( month from base_date )
							                                and hi				= extract( day   from base_date )
							                           )
							       )
							 where row_num = abs( p_lt );
						exception
							when others then
								l_rtn	:= null ;
						end;
				end case;
			end if ;

			return l_rtn ;

	end get_eigyo_date;


end lib_calendar;
/
