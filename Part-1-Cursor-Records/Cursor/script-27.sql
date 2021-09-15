--  Cursor - Multi Row Select

DECLARE
    CURSOR cur_get_employees IS 
    SELECT emp_id, emp_sal * 0.10 bonus 
    FROM employee;
    cur_get_employees_var cur_get_employees%ROWTYPE;
BEGIN
    OPEN cur_get_employees;
    LOOP
        FETCH cur_get_employees INTO cur_get_employees_var;
        EXIT WHEN cur_get_employees%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(cur_get_employees_var.emp_id);
        DBMS_OUTPUT.PUT_LINE(cur_get_employees_var.bonus);
    END LOOP;
    CLOSE cur_get_employees;
END;
