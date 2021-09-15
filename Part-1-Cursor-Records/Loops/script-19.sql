DECLARE
    l_check INTEGER := 1;
BEGIN
    WHILE l_check < 5 LOOP
        l_check := dbms_random.value(1, 10);
        DBMS_OUTPUT.PUT_LINE(l_check);
    END LOOP;
END;