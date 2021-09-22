CREATE OR REPLACE PROCEDURE TEST_PROC AS
    l_number NUMBER := 1;
BEGIN
    IF l_number > 1 THEN 
        DBMS_OUTPUT.PUT_LINE('l_number is greater than 1');
    ELSE
        DBMS_OUTPUT.PUT_LINE('l_number is less than 1');
    END IF;
END;
/

ALTER SESSION set plsql_warnings='ENABLE:ALL';
