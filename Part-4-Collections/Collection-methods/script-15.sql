-- WHILE LOOP 

DECLARE
    TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa    items_aa;
    l_index       BINARY_INTEGER;
    l_value       VARCHAR2(60);
BEGIN
    l_items_aa(4) := 'Treadmill';
    l_items_aa(6) := 'Bike';
    l_items_aa(8) := 'Elliptical';

    l_index := l_items_aa.FIRST;
    WHILE l_index IS NOT NULL LOOP
        l_value := l_items_aa(l_index);
        DBMS_OUTPUT.PUT_LINE('Current Index  is '||l_index||' Value is '||l_value);
        l_index := l_items_aa.NEXT(l_index);
        DBMS_OUTPUT.PUT_LINE('Next Index is '||l_index);
    END LOOP;
END;

/*
OUTPUT

Statement processed.
Current Index  is 4 Value is Treadmill
Next Index is 6
Current Index  is 6 Value is Bike
Next Index is 8
Current Index  is 8 Value is Elliptical
Next Index is 
*/

-- RUNNING THE LOOP IN REVERSE

DECLARE
    TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa    items_aa;
    l_index       BINARY_INTEGER;
    l_value       VARCHAR2(60);
BEGIN
    l_items_aa(4) := 'Treadmill';
    l_items_aa(6) := 'Bike';
    l_items_aa(8) := 'Elliptical';

    l_index := l_items_aa.LAST;
    WHILE l_index IS NOT NULL LOOP
        l_value := l_items_aa(l_index);
        DBMS_OUTPUT.PUT_LINE('Current Index  is '||l_index||' Value is '||l_value);
        l_index := l_items_aa.PRIOR(l_index);
        DBMS_OUTPUT.PUT_LINE('Next Index is '||l_index);
    END LOOP;
END;

/*
OUTPUT

Statement processed.
Current Index  is 8 Value is Elliptical
Next Index is 6
Current Index  is 6 Value is Bike
Next Index is 4
Current Index  is 4 Value is Treadmill
Next Index is 
*/