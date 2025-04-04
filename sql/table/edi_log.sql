create table edi_log
(
    touroku_date                   timestamp default systimestamp,
    touroku_client_id              varchar2(32),
    message                        clob
)
/

create or replace trigger trg_edi_log
before insert
on edi_log
referencing old as old new as new
for each row
declare
		l_sid			number			:= 0;
		l_serial		number			:= 0;
		l_audsid		number			:= 0;
		l_client_id		varchar2(64)	:= ' ';
		l_program		varchar2(64)	:= ' ';
	begin
		begin
			select sid,serial#,audsid,
			       decode( terminal, 'unknown', substr( machine, instr( machine, '\', -1 ) + 1 ), terminal ) client_id,
			       program
			  into l_sid,l_serial,l_audsid,l_client_id,l_program
			  from v$session
			 where audsid = userenv( 'sessionid' );
		exception
			when others then
				l_sid			:= 0;
				l_serial		:= 0;
				l_audsid		:= 0;
				l_client_id		:= ' ';
				l_program		:= ' ';
		end;
		:new.touroku_date := sysdate;
		:new.touroku_client_id	:= l_client_id;
end;
/
