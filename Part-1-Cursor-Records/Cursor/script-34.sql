-- Strongly-Typed Cursor Variables

DECLARE
    TYPE rc_dept IS REF CURSOR RETURN departments%ROWTYPE;
    rc_dept_cur rc_dept;
    l_dept_rowtype departments%ROWTYPE;
    l_id departments.dept_id%TYPE := 1;
    l_dept_id departments.dept_id%TYPE;
    l_dept_name departments.dept_name%TYPE;
BEGIN
    OPEN rc_dept_cur FOR
     SELECT * 
     FROM departments
     WHERE dept_id = l_id;
    l_id := 2;
    LOOP
     FETCH rc_dept_cur INTO l_dept_rowtype;
     EXIT WHEN rc_dept_cur%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(l_dept_rowtype.dept_id);
    END LOOP;
    
    OPEN rc_dept_cur FOR 
     SELECT *
     FROM departments
     WHERE dept_name = 'Accounting';
    LOOP
     FETCH rc_dept_cur INTO l_dept_id, l_dept_name;
     EXIT WHEN rc_dept_cur%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(l_dept_id);
    END LOOP;
     CLOSE rc_dept_cur;
END;
