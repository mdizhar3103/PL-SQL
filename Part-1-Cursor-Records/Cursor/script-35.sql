-- Strongly-Typed Cursor Variables Assigning to another ref cursor

DECLARE
    TYPE rc_dept IS REF CURSOR RETURN departments%ROWTYPE;
    rc_cur_initial      rc_dept;
    rc_cur_final        rc_dept;
    
    l_dept_rowtype      departments%ROWTYPE;
    l_choice            NUMBER := 1;
    l_lower             NUMBER := 2;
    l_upper             NUMBER := 3;
BEGIN
    IF l_choice = 1 THEN
        OPEN rc_cur_initial FOR
         SELECT * 
         FROM departments
         WHERE dept_id BETWEEN l_lower AND l_upper;
    ELSE
        OPEN rc_cur_initial FOR
         SELECT * 
         FROM departments
         WHERE dept_name = 'Accounting';
    END IF;
    rc_cur_final := rc_cur_initial
    LOOP
     FETCH rc_cur_final INTO l_dept_rowtype;
     EXIT WHEN rc_cur_final%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(l_dept_rowtype.dept_id);
    END LOOP;
     CLOSE rc_cur_final;
END;
