--  SQLCODE & SQLERRM

DECLARE
    l_num PLS_INTEGER;
    l_sqlcode NUMBER;
    l_sqlerrm VARCHAR2(512);
BEGIN
    l_num := 2147483648;
EXCEPTION
    WHEN OTHERS THEN
        l_sqlcode := SQLCODE;
        l_sqlerrm := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || l_sqlcode);
        DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || l_sqlerrm);
END;
