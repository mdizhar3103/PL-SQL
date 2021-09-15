CREATE OR REPLACE FUNCTION update_emp(p_emp_id IN NUMBER,
                                      p_dept_name VARCHAR2)
 RETURN NUMBER AS
 CURSOR cursor_get_dept_id IS
  SELECT dept_id
  FROM departments
  WHERE dept_name = p_dept_name;
  
  l_dept_id departments.dept_id%TYPE;
  BEGIN
    OPEN cursor_get_dept_id;
    FETCH cursor_get_dept_id INTO l_dept_id;
    CLOSE cursor_get_dept_id;
    UPDATE employee
    SET emp_dept_id = l_dept_id
    WHERE emp_id = p_emp_id;
    COMMIT;
    RETURN 1;
  EXCEPTION
    WHEN OTHERS THEN
        IF cursor_get_dept_id%ISOPEN THEN
            CLOSE cursor_get_dept_id;
        END IF;
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        ROLLBACK;
        RETURN 0;
  END update_emp;
/

DECLARE
    l_emp_id NUMBER(10) := 50;
    l_dept_name VARCHAR2(10) := 'IT';
    l_status NUMBER;
BEGIN
    l_status := update_emp(l_emp_id, l_dept_name);
END;

