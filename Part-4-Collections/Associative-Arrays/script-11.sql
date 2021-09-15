-- Associative Array Sorting By String Index

DECLARE
    TYPE days_aa IS TABLE of NUMBER INDEX BY VARCHAR2(20);
    l_days_aa days_aa;
    l_index VARCHAR2(20);

BEGIN
    l_days_aa('Sunday') := 1;
    l_days_aa('Monday') := 2;
    l_days_aa('Tuesday') := 3;
    
    l_index := l_days_aa.FIRST;

    WHILE l_index IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Index: '|| l_index);
        l_index := l_days_aa.NEXT(l_index);
    END LOOP;
END;


-- OUTPUT

-- Index: Monday
-- Index: Sunday
-- Index: Tuesday