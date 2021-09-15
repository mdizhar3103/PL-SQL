-- Parallel Enable

CREATE OR REPLACE FUNCTION get_tier(p_sal NUMBER) RETURN NUMBER PARALLEL_ENABLE AS
   l_return NUMBER;
BEGIN
    IF p_sal < 40000 THEN
        l_return := 1;
    ELSIF p_sal < 60000 THEN
        l_return := 2;
    ELSE
        l_return := 3;
    END IF;
    DBMS_OUTPUT.PUT_LINE('P_SAL: '||p_sal);
    RETURN l_return;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        RAISE;
END get_tier;
/



-- NOTE: Oracle database allows running the java programs and C functions from PL/SQL by creating PL/SQL wrappers for them, but need to parallel enable to ensure security.
-- The table must have a parallel specification on it.

ALTER TABLE employee PARALLEL 3;
SELECT degree FROM user_tables WHERE table_name='EMPLOYEE';
SELECT /*+parallel(employee, 4)*/
       emp_id, emp_sal, get_tier(emp_sal) tier
FROM employee
ORDER BY emp_sal;

