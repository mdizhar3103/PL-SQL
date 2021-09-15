-- Explicit Cursor

DECLARE
    l_dept_id departments.dept_id%TYPE;
    l_dept_name departments.dept_name%TYPE;
    
    CURSOR cur_get_departments IS 
    SELECT dept_id, dept_name 
    FROM departments WHERE dept_id = 1;
BEGIN
    OPEN cur_get_departments;
    FETCH cur_get_departments INTO l_dept_id, l_dept_name;
    DBMS_OUTPUT.PUT_LINE(l_dept_name);
    CLOSE cur_get_departments;
END;
