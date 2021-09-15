-- OUT MODE Script
CREATE OR REPLACE 
 FUNCTION update_emp(p_emp_id IN NUMBER,
                     p_dept_id NUMBER,
                     p_location OUT VARCHAR2)
 RETURN NUMBER AS
 BEGIN
    DBMS_OUTPUT.PUT_LINE('LOCATION INTIALLY ' || p_location);
    UPDATE employee
    SET emp_dept_id = p_dept_id
    WHERE emp_id = p_emp_id
    RETURNING emp_loc INTO p_location;
    COMMIT;
    RETURN 1;
 EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_backtrace);
        ROLLBACK;
        RETURN 0;
END update_emp;
/

DECLARE
    l_emp_id NUMBER(10) := 50;
    l_dept_id NUMBER := 1;
    l_location VARCHAR2(10) := 'CA';
    l_status NUMBER;
BEGIN
    l_status := update_emp(l_emp_id,
                           l_dept_id,
                           l_location);
    DBMS_OUTPUT.PUT_LINE('LOCATION: ' || l_location);
    DBMS_OUTPUT.PUT_LINE('STATUS: ' || l_status);
END;

