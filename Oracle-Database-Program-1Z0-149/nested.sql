<<outer>>
DECLARE
    country varchar2(255);
BEGIN   
    <<inner>>
    DECLARE
        state_name varchar2(255) := 'TX';
    BEGIN
        dbms_output.put_line('Inner Block');
    END;
    select country_name into country from countries where country_id like '%Z';
    dbms_output.put_line(country);
    dbms_output.put_line(state_name); -- gives error because of scope visibility
EXCEPTION 
    WHEN no_data_found THEN
        dbms_output.put_line('Country not found');
END;
/