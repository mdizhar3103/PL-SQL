--  REVERSE FOR Loop
 
DECLARE
    l_sum NUMBER := 0;
BEGIN
    FOR l_counter in REVERSE 1..3 LOOP
        l_sum := l_sum + l_counter;
        DBMS_OUTPUT.PUT_LINE('Loop Result: ' || l_sum || ' l_counter: ' || l_counter);
        EXIT WHEN l_counter > 3;
    END LOOP;
    
END;
