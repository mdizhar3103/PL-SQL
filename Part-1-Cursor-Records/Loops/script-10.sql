-- Simple Loop
 
DECLARE
    l_counter NUMBER := 0;
    l_sum NUMBER := 0;
BEGIN
    LOOP
        l_sum := l_sum + l_counter;
        l_counter := l_counter + 1;
        EXIT WHEN l_counter > 3;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Loop Result: ' || l_sum);
END;
