CREATE OR REPLACE FUNCTION get_dept_id(p_dept_name departments.dept_name%TYPE) RETURN NUMBER IS 
  l_dept_id departments.dept_id%TYPE;
  CURSOR cur_get_dept_id IS
    SELECT dept_id
    FROM departments
    WHERE dept_name = p_dept_name;
 BEGIN
    OPEN cur_get_dept_id;
    FETCH cur_get_dept_id INTO l_dept_id;
    CLOSE cur_get_dept_id;
    RETURN l_dept_id;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM||' '||DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
        RAISE;
END;
/

SELECT get_dept_id('IT') FROM dual;
SELECT * FROM employee WHERE emp_dept_id = get_dept_id('IT');
-- Note: Function used in select statement doesn’t allow commit, DML query, rollback;
--           But the data on other table can be inserted in function

