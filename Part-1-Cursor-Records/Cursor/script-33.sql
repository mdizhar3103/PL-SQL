-- Cursor For Update

SELECT * FROM employee;

DECLARE
    CURSOR cur_move_emp(p_emp_loc employee.emp_loc%TYPE) IS
     SELECT emp_id, dept_name 
     FROM employee, departments
     WHERE dept_id = emp_dept_id
     AND emp_loc = p_emp_loc
     FOR UPDATE OF emp_loc NOWAIT;
BEGIN
    FOR cur_move_up_var IN cur_move_emp('CA') LOOP
        UPDATE employee
        SET emp_loc = 'WA'
        WHERE CURRENT OF cur_move_emp;
    END LOOP;
    COMMIT;
END;

