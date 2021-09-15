-- Explicit Cursor FOR Loop

DECLARE
    CURSOR cur_get_employees IS 
    SELECT emp_id, emp_sal * 0.10 bonus 
    FROM employee;
BEGIN
    FOR cur_get_employees_var IN cur_get_employees LOOP
        DBMS_OUTPUT.PUT_LINE(cur_get_employees_var.emp_id);
        DBMS_OUTPUT.PUT_LINE(cur_get_employees_var.bonus);
    END LOOP;
END;
