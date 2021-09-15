CREATE OR REPLACE FUNCTION get_emp_count RETURN NUMBER AS
 CURSOR cursor_get_dept_id IS
  SELECT dept_id
  FROM departments
  WHERE dept_name = 'IT';
  
  l_dept_id departments.dept_id%TYPE;
  l_count NUMBER := 0;
 BEGIN
    OPEN cursor_get_dept_id;
    FETCH cursor_get_dept_id INTO l_dept_id;
    CLOSE cursor_get_dept_id;
    SELECT count(*)
    INTO l_count
    FROM employee
    WHERE emp_dept_id = l_dept_id;
    RETURN l_count;
 EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        RAISE;
 END get_emp_count; 
/

