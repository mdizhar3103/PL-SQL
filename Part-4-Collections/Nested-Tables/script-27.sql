DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
BEGIN
    IF l_first_nt != l_second_nt THEN
        DBMS_OUTPUT.PUT_LINE('NOT EQUAL');
    END IF;
END;
/


-- NOT A SET
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
BEGIN
    IF l_first_nt IS NOT A SET THEN
        DBMS_OUTPUT.PUT_LINE('NOT A SET');
    END IF;
END;
/

-- NOT EMPTY
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
BEGIN
    IF l_first_nt IS NOT EMPTY THEN
        DBMS_OUTPUT.PUT_LINE('NOT EMPTY');
    END IF;
END;
/

-- MEMBER OF
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
BEGIN
    IF 'Bike' MEMBER OF l_first_nt THEN
        DBMS_OUTPUT.PUT_LINE('Is a member');
    END IF;
END;
/

-- SUBMULTISET OF 
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
BEGIN
    IF l_second_nt SUBMULTISET OF l_first_nt THEN
        DBMS_OUTPUT.PUT_LINE('Is submultiset');
    END IF;
END;
/

-- CARDINALITY
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
BEGIN
        DBMS_OUTPUT.PUT_LINE('Cardinality of l_first_nt '||CARDINALITY(l_first_nt));
END;
/

-- With nested columns
DECLARE 
    l_store1_items items_nt;
    CURSOR cur_get_items IS
     SELECT store1_items
     FROM items_orders
     WHERE CARDINALITY(store1_items) > 2;
    l_items_nt items_nt := items_nt('Bike');
BEGIN
    OPEN cur_get_items;
    FETCH cur_get_items INTO l_store1_items;
    CLOSE cur_get_items;
    FOR i IN l_store1_items.FIRST .. l_store1_items.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_store1_items(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cardinality '||CARDINALITY(l_store1_items));
    IF l_store1_items IS NOT A SET THEN
        DBMS_OUTPUT.PUT_LINE('l_store1_items is not a set');
    END IF;
    IF l_items_nt SUBMULTISET OF l_store1_items THEN
        DBMS_OUTPUT.PUT_LINE('l_items_nt is a submultiset of l_store1_items');
    END IF;
END;
/

