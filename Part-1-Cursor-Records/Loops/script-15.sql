-- Continue Keyword
 
BEGIN
    FOR l_counter in 1..5 LOOP
        IF l_counter = 3 THEN
            CONTINUE;
        END IF;
        DBMS_OUTPUT.PUT_LINE(' l_counter: ' || l_counter);
    END LOOP;
END;
