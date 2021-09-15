-- FOR LOOP USING SPARSE COLLECTIONS

DECLARE
    TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa  items_aa;
BEGIN
    l_items_aa(4) := 'Treadmill';
    l_items_aa(6) := 'Bike';
    l_items_aa(8) := 'Elliptical';

    FOR i IN l_items_aa.FIRST .. l_items_aa.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Index Counter is '||i);
        IF l_items_aa.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE('Counter '||i||' exists, Value is '||l_items_aa(i));
        END IF;
    END LOOP;
END;

/*
Note: if we have not used exists it will have raise exception for index not in collection 

OUTPUT
Statement processed.
Index Counter is 4
Counter 4 exists, Value is Treadmill
Index Counter is 5
Index Counter is 6
Counter 6 exists, Value is Bike
Index Counter is 7
Index Counter is 8
Counter 8 exists, Value is Elliptical
*/

-- RUNNING THE LOOP IN REVERSE

DECLARE
    TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa  items_aa;
BEGIN
    l_items_aa(4) := 'Treadmill';
    l_items_aa(6) := 'Bike';
    l_items_aa(8) := 'Elliptical';

    FOR i IN REVERSE l_items_aa.FIRST .. l_items_aa.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Index Counter is '||i);
        IF l_items_aa.EXISTS(i) THEN
            DBMS_OUTPUT.PUT_LINE('Counter '||i||' exists, Value is '||l_items_aa(i));
        END IF;
    END LOOP;
END;


/*
OUTPUT
Statement processed.
Index Counter is 8
Counter 8 exists, Value is Elliptical
Index Counter is 7
Index Counter is 6
Counter 6 exists, Value is Bike
Index Counter is 5
Index Counter is 4
Counter 4 exists, Value is Treadmill
*/