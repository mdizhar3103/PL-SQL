-- Implicit Cursor
 
DECLARE
    l_dept_id departments.dept_id%TYPE;
    l_dept_name departments.dept_name%TYPE;
BEGIN
    SELECT dept_id, dept_name
    INTO l_dept_id, l_dept_name
    FROM departments
    WHERE dept_id = 1;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ROW COUNT' || SQL%ROWCOUNT);
    END IF;
END;

-- Note:  
-- change dept_id = 10 and then execute you will get no data exception error.
-- Now again run the script without where clause and you will get more than the exact number of rows exception.

