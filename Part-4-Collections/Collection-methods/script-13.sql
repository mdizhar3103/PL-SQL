DECLARE
    TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa  items_aa;
BEGIN
    l_items_aa(-10) := 'Treadmill';
    l_items_aa(10) := 'Treadmill';
    l_items_aa(20) := 'Bike';
    l_items_aa(25) := 'Elliptical';
    l_items_aa(27) := 'Weights';

    DBMS_OUTPUT.PUT_LINE('Initial count '|| l_items_aa.COUNT||' Initial last index counter '||l_items_aa.LAST);
    DBMS_OUTPUT.PUT_LINE('Index counter prior to last one is '||l_items_aa.PRIOR(l_items_aa.LAST));

    l_items_aa.DELETE(20, 27);
    DBMS_OUTPUT.PUT_LINE('After deleting index counters from 20 to 27 new count is '||l_items_aa.COUNT||' new last index counter is '||l_items_aa.LAST);

    IF NOT l_items_aa.EXISTS(25) THEN
        DBMS_OUTPUT.PUT_LINE('Index 25 does not exist');
    END IF;

    l_items_aa.DELETE;
    DBMS_OUTPUT.PUT_LINE('After deleting all items using DELETE with no argument new count is '||l_items_aa.COUNT||' new last index counter is '||l_items_aa.LAST);
END;


-- OUTPUT
-- Statement processed.
-- Initial count 5 Initial last index counter 27
-- Index counter prior to last one is 25
-- After deleting index counters from 20 to 27 new count is 2 new last index counter is 10
-- Index 25 does not exist
-- After deleting all items using DELETE with no argument new count is 0 new last index counter is 
