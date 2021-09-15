-- current timezone for the database
select current_timestamp,systimestamp from dual;
 
alter session set time_zone = 'EST';
 
select current_timestamp,systimestamp from dual;
 
declare
    l_date DATE := current_date;
    l_systimestamp timestamp with time zone := systimestamp;
    l_currenttimestamp timestamp with time zone := current_timestamp;
    l_timestamp timestamp := current_timestamp;
begin
    dbms_output.put_line('l_date: ' || l_date);
    dbms_output.put_line('l_systimestamp: ' || l_systimestamp);
    dbms_output.put_line('l_currenttimestamp: ' || l_currenttimestamp);
    dbms_output.put_line('l_timestamp: ' || l_timestamp);
end;
