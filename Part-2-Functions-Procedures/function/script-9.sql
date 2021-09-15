CREATE OR REPLACE PROCEDURE
update_emp(p_emp_id IN NUMBER,
          p_dept_id   NUMBER,
          p_location OUT NOCOPY VARCHAR2,
          p_status IN OUT NOCOPY NUMBER) AS l_number NUMBER;
 BEGIN
    UPDATE employee
    SET emp_dept_id = p_dept_id
    WHERE emp_id = p_emp_id
    RETURNING emp_loc INTO p_location;
    p_status := 1;
    l_number := 'CHAR';   -- doing because we want to raise exception
    COMMIT;
 EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    ROLLBACK;
    RAISE;
 END update_emp;
/

DECLARE
    l_emp_id     NUMBER(10)    := 50;
    l_dept_id    NUMBER        := 1;
    l_location   VARCHAR2(10)  := 'CA';
    l_status     NUMBER        := -1;
BEGIN
    update_emp(l_emp_id, l_dept_id, l_location, l_status);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE('LOCATION: ' || l_location);
        DBMS_OUTPUT.PUT_LINE('STATUS: ' || l_status);
END;


-- Procedure created.

-- Statement processed.
-- ORA-06502: PL/SQL: numeric or value error: character to a number conversion error
-- ORA-06512: at "SQL_EGYTXQEHAROKJJTDCUOXWMKVY.UPDATE_EMP", line 12

-- ORA-06502: PL/SQL: numeric or value error: character to a number conversion error
-- LOCATION: CA
-- STATUS: 1
