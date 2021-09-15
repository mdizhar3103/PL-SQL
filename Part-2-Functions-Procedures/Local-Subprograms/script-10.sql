--  Local Procedure in Stored Procedure

CREATE OR REPLACE PROCEDURE
update_dept(p_emp_id employee.emp_id%TYPE) AS l_dept_id departments.dept_id%TYPE := 2;

 PROCEDURE display_message(p_location IN VARCHAR2, p_msg VARCHAR2) IS 
     BEGIN
        DBMS_OUTPUT.PUT_LINE('****'||p_location||'****');
        DBMS_OUTPUT.PUT_LINE(p_msg);
     END display_message;
 BEGIN
    display_message('Before updating', 'Input Employee ID: '|| p_emp_id);
    UPDATE employee
    SET emp_dept_id = l_dept_id
    WHERE emp_id = p_emp_id;
    display_message('After updating', 'Rows Updated:'||SQL%ROWCOUNT);
 EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    RAISE;
 END update_dept;
/

DECLARE
    l_emp_id NUMBER := 10;
BEGIN
    update_dept(l_emp_id);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

Statement processed.
****Before updating****
Input Employee ID: 10
****After updating****
Rows Updated:1
