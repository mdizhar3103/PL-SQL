CREATE OR REPLACE PROCEDURE update_dept AS
    l_emp_id employee.emp_id%TYPE := 10;
BEGIN
    UPDATE employee
    SET emp_dept_id = 2
    WHERE emp_id = l_emp_id;
    DBMS_OUTPUT.PUT_LINE('Rows updated ' || SQL%ROWCOUNT);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
     DBMS_OUTPUT.PUT_LINE(SQLERRM);
     DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
     ROLLBACK;
     RAISE;
END update_dept;
/

select dbms_warning.get_warning_setting_string from dual;
ALTER SESSION SET PLSQL_WARNINGS='ENABLE:ALL';
CALL dbms_warning.add_warning_setting_cat('ALL', 'ENABLE', 'SESSION');
select dbms_warning.get_warning_setting_string from dual;
