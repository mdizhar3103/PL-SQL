-- Weak Typed Cursor Variables Sys reference

DECLARE
    TYPE rc_weak IS REF CURSOR;
    rc_weak_cur rc_weak;
    
    rc_sys_cur rc_weak;
    
    l_dept_rowtype      departments%ROWTYPE;
    l_lower             NUMBER := 1;
    l_upper             NUMBER :=10;
BEGIN
    OPEN rc_sys_cur FOR
     'SELECT * 
     FROM departments
     WHERE dept_id BETWEEN :1 AND :2'USING l_lower, l_upper;

    rc_weak_cur := rc_sys_cur;
    LOOP
     FETCH rc_weak_cur INTO l_dept_rowtype;
     EXIT WHEN rc_weak_cur%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(l_dept_rowtype.dept_name);
    END LOOP;
     CLOSE rc_weak_cur;
END;
