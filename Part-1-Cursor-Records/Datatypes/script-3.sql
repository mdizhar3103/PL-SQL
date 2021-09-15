-- Script-3 Number Precision Negative
 
DECLARE
    l_num NUMBER(5, -2) := 12345.678;
BEGIN
    DBMS_OUTPUT.PUT_LINE('l_num Assigned 12345.678 Final: ' || l_num);
    l_num := 156.456;
    DBMS_OUTPUT.PUT_LINE('l_num Assigned 123.789 Final: ' || l_num);
END;
