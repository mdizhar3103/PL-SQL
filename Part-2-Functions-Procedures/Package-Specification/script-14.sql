-- Packages Specification

CREATE OR REPLACE PACKAGE hr_mgmt AS
 g_active_status      CONSTANT VARCHAR2(1)     := 'A';
 g_inactive_status    CONSTANT VARCHAR2(1)     := 'I';
 g_bonus_pct                   NUMBER          := 0;
 
 dept_not_found_ex EXCEPTION;
 TYPE g_rec IS RECORD(p_profit NUMBER, p_dept_name departments.dept_name%TYPE);
 
 CURSOR gcur_get_deptid(p_dept_name VARCHAR2) IS 
  SELECT dept_id
  FROM departments
  WHERE dept_name = p_dept_name;
  
 FUNCTION cal_bonus(p_profit NUMBER, p_dept_id NUMBER) RETURN NUMBER;
 PROCEDURE update_emp(p_emp_id NUMBER, p_dept_name VARCHAR2);
END hr_mgmt;
/
BEGIN
    DBMS_OUTPUT.PUT_LINE('hr_mgmt.g_active IS '|| hr_mgmt.g_active_status);
    hr_mgmt.g_bonus_pct := 10;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('hr_mgmt.g_bonus_pct IS '|| hr_mgmt.g_bonus_pct);
END;
/

GRANT EXECUTE ON hr_mgmt TO <username>;
/*
This user session will not be able to see the modified value by earlier session  and copy the whole code in new session login with the different user having executed privileges,
and execute the package you will get the default value of bouns as 0.
Every session will get a default value even the user is the same in another session.
*/

DROP PACKAGE hr_mgmt;
