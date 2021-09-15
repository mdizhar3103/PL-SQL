-- Associative Array Sorting By Integer Index

DECLARE
    TYPE items_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
    l_index BINARY_INTEGER;
    l_value  VARCHAR2(60);

BEGIN
    l_items_aa(-10) := 'Treadmill';
    l_items_aa(20) := 'Bike';
    l_items_aa(3) := 'Weights';
    
    l_index := l_items_aa.FIRST;
    WHILE l_index IS NOT NULL LOOP
        l_value := l_items_aa(l_index);
        DBMS_OUTPUT.PUT_LINE('Index Counter: '|| l_index||' Value: '|| l_value);
        l_index := l_items_aa.NEXT(l_index);
    END LOOP;
END;


-- OUTPUT

-- Index Counter: -10 Value: Treadmill
-- Index Counter: 3 Value: Weights
-- Index Counter: 20 Value: Bike