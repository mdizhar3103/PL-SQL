set SERVEROUTPUT ON;
declare
    v_employee number := 100;
    "start date" date := DATE '2021-11-12';
    "end date" date := DATE '2021-11-20';
    first_name varchar(30) := 'Izhar';
    initials char := 'M';
    is_developer boolean := false;
    is_manager boolean := true;
    country varchar2(30);
    state_name varchar2(200);
    state varchar2(10) := 'TX';
begin
    dbms_output.put_line(4 / 2 + 3);
    dbms_output.put_line(( 3 + 4 ) / 2);

    dbms_output.put_line(sys.DIUTIL.bool_to_int((NOT is_developer AND is_manager)));
    -- Note: NOT has higher precedence than AND, OR

    select counrty_name into country from countries where country_id = 'US';
    dbms_output.put_line('Country Name is '||country);

    dbms_output.put_line(sys.DIUTIL.bool_to_int("end date" < "start date"));
    dbms_output.put_line(sys.DIUTIL.bool_to_int("end date" > "start date"));

    state_name := 
    CASE state
    WHEN 'TX' THEN 'Texas'
    WHEN 'CA' THEN 'California'
    END;

    dbms_output.put_line('State Name is '||state_name);

end;
/