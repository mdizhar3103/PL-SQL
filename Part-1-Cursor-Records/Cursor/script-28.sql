-- Cursor - Multi Row Select-2

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
        DBMS_OUTPUT.PUT_LINE(cur_get_employees%ROWCOUNT);
    END LOOP;
    IF cur_get_employees%ISOPEN THEN
        CLOSE cur_get_employees;
    END IF;
END;
