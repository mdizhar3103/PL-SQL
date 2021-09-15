-- Visbility of Variables

CREATE OR REPLACE PROCEDURE determine_tiers AS
 l_salary  NUMBER := 50000;
 l_tier    NUMBER;

 FUNCTION get_tier RETURN NUMBER IS
  l_salary  NUMBER := 30000;  --overrides the visibility of global variable run without this cmnt
  l_return NUMBER;
  BEGIN
        IF l_salary < 40000 THEN
            l_return := 1;
        ELSIF l_salary < 60000 THEN
            l_return := 2;
        ELSE
            l_return := 3;
        END IF;
        RETURN l_return;
  EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM ||''|| DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
            RAISE;
  END get_tier;
 BEGIN
    l_tier := get_tier;
    DBMS_OUTPUT.PUT_LINE(l_tier);
    l_salary := 120000;
    l_tier := get_tier;
    DBMS_OUTPUT.PUT_LINE(l_tier);
 EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    RAISE;
 END determine_tiers;
/
BEGIN
    determine_tiers;
END;
