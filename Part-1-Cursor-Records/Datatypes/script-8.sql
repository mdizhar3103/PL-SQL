declare
    l_tmsp TIMESTAMP(2);
    l_tmsp_tz TIMESTAMP(2) WITH TIME ZONE;
    l_tmsp_new TIMESTAMP(2);
    l_tmsp_tz_new TIMESTAMP(2) WITH TIME ZONE;
    l_int INTERVAL DAY(2) TO SECOND(2) := '7 00:00:00.00';
begin
    l_tmsp := TO_TIMESTAMP('02-NOV-2013 10:00:00.00','DD-MON-RRRR HH24:MI:SS.FF');
    l_tmsp_tz := TO_TIMESTAMP_TZ('02-NOV-2013 10:00:00.00 PST PDT','DD-MON-RRRR HH24:MI:SS.FF TZR TZD');
    
    -- Add y days
    l_tmsp_new := l_tmsp + l_int;
    l_tmsp_tz_new := l_tmsp_tz + l_int;
    
    dbms_output.put_line('New Timstamp is :' || TO_CHAR(l_tmsp_new,'DD-MON-RRRR HH24:MI:SS.FF'));
    dbms_output.put_line('New Timstamp with timezone is :' || TO_CHAR(l_tmsp_tz_new,'DD-MON-RRRR HH24:MI:SS.FF TZR TZD'));
end;
