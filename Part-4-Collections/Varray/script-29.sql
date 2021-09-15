DECLARE
    TYPE items_rec IS RECORD(item_name items.item_name%TYPE,
                             count NUMBER);
    TYPE items_va IS VARRAY(5) OF items_rec;
    l_items_va items_va := items_va();

BEGIN 
    l_items_va.EXTEND;
    l_items_va(l_items_va.LAST).item_name := 'Bike';
    l_items_va(l_items_va.LAST).count := 1;

    l_items_va.EXTEND;
    l_items_va(l_items_va.LAST).count := 2;
    l_items_va(l_items_va.LAST).item_name := 'Treadmill';

    DBMS_OUTPUT.PUT_LINE(l_items_va(1).item_name);
    DBMS_OUTPUT.PUT_LINE(l_items_va.COUNT);
END;
/

-- SECOND FORM EXTEND
DECLARE
    TYPE items_rec IS RECORD(item_name items.item_name%TYPE,
                             count NUMBER);
    TYPE items_va IS VARRAY(5) OF items_rec;
    l_items_va items_va := items_va();

BEGIN 
    l_items_va.EXTEND(2);
    l_items_va(1).item_name := 'Bike';
    l_items_va(1).count := 1;

    l_items_va(2).count := 2;
    l_items_va(2).item_name := 'Treadmill';

    DBMS_OUTPUT.PUT_LINE(l_items_va(1).item_name);
    DBMS_OUTPUT.PUT_LINE(l_items_va.COUNT);
END;
/

-- THRIRD FORM EXTEND
DECLARE
    TYPE items_rec IS RECORD(item_name items.item_name%TYPE,
                             count NUMBER);
    TYPE items_va IS VARRAY(5) OF items_rec;
    l_items_va items_va := items_va();

BEGIN 
    l_items_va.EXTEND(2);
    l_items_va(1).item_name := 'Bike';
    l_items_va(1).count := 1;

    l_items_va(2).count := 2;
    l_items_va(2).item_name := 'Treadmill';

    l_items_va.EXTEND(2, 2);
    DBMS_OUTPUT.PUT_LINE(l_items_va(3).item_name);
    DBMS_OUTPUT.PUT_LINE(l_items_va.COUNT);
END;
/

-- Assigning varray to varray type
DECLARE
    TYPE items_rec IS RECORD(item_name items.item_name%TYPE,
                             count NUMBER);
    TYPE items_va IS VARRAY(5) OF items_rec;
    l_items_va items_va := items_va();
    l_copy_va items_va := items_va();

BEGIN 
    l_items_va.EXTEND(2);
    l_items_va(1).item_name := 'Bike';
    l_items_va(1).count := 1;

    l_items_va(2).count := 2;
    l_items_va(2).item_name := 'Treadmill';

    l_items_va.EXTEND(2, 2);
    l_copy_va := l_items_va;
    DBMS_OUTPUT.PUT_LINE(l_copy_va(3).item_name);
    DBMS_OUTPUT.PUT_LINE(l_copy_va.COUNT);
END;
/

-- REMOVING THE ELEMENTS
DECLARE
    TYPE items_rec IS RECORD(item_name items.item_name%TYPE,
                             count NUMBER);
    TYPE items_va IS VARRAY(5) OF items_rec;
    l_items_va items_va := items_va();

BEGIN 
    l_items_va.EXTEND(2);
    l_items_va(1).item_name := 'Bike';
    l_items_va(1).count := 1;

    l_items_va(2).count := 2;
    l_items_va(2).item_name := 'Treadmill';

    l_items_va.EXTEND(2, 2);

    l_items_va.TRIM;
    DBMS_OUTPUT.PUT_LINE(l_items_va.COUNT);

    l_items_va.DELETE;
    DBMS_OUTPUT.PUT_LINE(l_items_va.COUNT);
END;
/

-- FETCHING FROM DATABASE
SELECT * FROM items;

DECLARE
    TYPE items_va IS VARRAY(5) OF VARCHAR2(60);
    l_items_va items_va := items_va();
    CURSOR cur_get_items IS
        SELECT * FROM items 
        WHERE ROWNUM < 6;
BEGIN
    FOR get_items_var IN cur_get_items LOOP
        l_items_va.EXTEND;
        l_items_va(l_items_va.LAST) := get_items_var.item_name;
    END LOOP;
    FOR i IN l_items_va.FIRST .. l_items_va.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_items_va(i));
    END LOOP;
END;
/