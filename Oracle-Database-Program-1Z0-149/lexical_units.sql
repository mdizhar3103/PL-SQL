set SERVEROUTPUT ON;
declare
    v_employee number := 100;
    start_date date := DATE '2021-12-31';
    "start date" date := DATE '2021-12-09'; -- valid identifier
    first_name varchar(30) := 'Izhar';
    initials char := 'M';
    is_developer boolean := true;
begin
    dbms_output.put_line('Employee Number is '||v_employee);
    dbms_output.put_line('Date is '||start_date);
    dbms_output.put_line('Date is '||"start date");
    dbms_output.put_line('Your Name is '||initials||first_name);
    dbms_output.put_line('Is employee a developer '||is_developer); -- gives error because concatenation is of string not of other literals
    dbms_output.put_line('Is employee a developer '||sys.DIUTIL.bool_to_int(is_developer)); 
end;
/