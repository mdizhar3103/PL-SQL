--  Implicit Cursor FOR Loop

DECLARE
    l_num NUMBER := 2;
BEGIN
    FOR cur_get_departments_var IN (SELECT dept_id, dept_name FROM departments WHERE ROWNUM <= l_num) LOOP
        DBMS_OUTPUT.PUT_LINE(cur_get_departments_var.dept_id);
    END LOOP;
END;
