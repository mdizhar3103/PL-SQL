--  Nested Cursor FOR Loop

DECLARE
    CURSOR cur_get_dept_info(p_rownum NUMBER) IS
     SELECT dept_id 
     FROM departments
     WHERE ROWNUM <= p_rownum;
    
    CURSOR cur_get_emp_info(p_dept_id employee.emp_dept_id%TYPE) IS
     SELECT emp_name 
     FROM employee
     WHERE emp_dept_id = p_dept_id;
BEGIN
    <<dept_loop>>
    FOR cur_get_dept_info_var IN cur_get_dept_info(2) LOOP
        DBMS_OUTPUT.PUT_LINE('Dept ID: ' || cur_get_dept_info_var.dept_id);
        <<emp_loop>>
        FOR cur_get_emp_info_var IN cur_get_emp_info(cur_get_dept_info_var.dept_id) LOOP
            DBMS_OUTPUT.PUT_LINE('Emp NAME: ' || cur_get_emp_info_var.emp_name);
        END LOOP emp_loop;
    END LOOP dept_loop;
END;

