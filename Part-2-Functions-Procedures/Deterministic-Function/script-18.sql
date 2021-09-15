-- Deterministic Function

CREATE OR REPLACE FUNCTION get_tier(p_sal NUMBER) RETURN NUMBER DETERMINISTIC AS
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

SELECT emp_id, emp_sal, get_tier(emp_sal) tier FROM employee ORDER BY emp_sal;
-- P_SAL: 50000
-- P_SAL: 40000
-- P_SAL: 70000
-- Making the function deterministic reduces the function call for same value making it efficient
