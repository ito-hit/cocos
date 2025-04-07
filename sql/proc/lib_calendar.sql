create or replace package lib_calendar is

	-- �c�Ɠ��擾
	function	get_eigyo_date( p_kyoten_code number, p_kijyun_date number, p_lt number, p_leadtime_keisan_kbn number) return number;

end lib_calendar;
/

create or replacE package body lib_calendar is

	/*
		�c�Ɠ��擾	2025.03.11 Y.Yamashita
		p_kyoten_code		: ���_�R�[�h
		p_kijyun_date		: ���
		p_lt				: ���[�h�^�C�� 0:����
		p_leadtime_keisan_kbn	: 1:����Ōv�Z 2:���Љc�Ɠ��Ōv�Z 3:�y���j���������Čv�Z 4:���Z�@�։c�Ɠ��Ōv�Z
		return 		: ���t
	*/
	function	get_eigyo_date( p_kyoten_code number, p_kijyun_date number, p_lt number, p_leadtime_keisan_kbn number) return number is
		-- �ϐ��̐錾
		l_rtn		number	:= 0;
		l_date		date ;
		l_calendar_kbn	number ;

		begin
			
			l_rtn := null ;
			
			-- ����� 0 or 99999999 �̏ꍇ��null��Ԃ�
			if p_kijyun_date = 0 or p_kijyun_date = 99999999 then
				return l_rtn ;
			end if ;
			-- ���t�ł͂Ȃ�
			if fnc.isdate( p_kijyun_date ) = 0 then
				return l_rtn ;
			end if ;

			-- 1:����Ōv�Z �J�����_�[�֌W�Ȃ�
			if p_leadtime_keisan_kbn = 1 then
				l_date := to_date( to_char( p_kijyun_date ), 'yyyymmdd' ) ;
				l_date := l_date + p_lt ;
				l_rtn  := to_number( to_char( l_date, 'yyyymmdd' ) ) ;
			-- 3:�y���j���������Čv�Z
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
			-- 2:���Љc�Ɠ��Ōv�Z
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
