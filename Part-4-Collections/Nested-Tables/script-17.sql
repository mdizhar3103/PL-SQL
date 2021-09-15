DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();

BEGIN
    l_items_nt.EXTEND;
    l_items_nt(l_items_nt.LAST) := 'Bike';

    l_items_nt.EXTEND;
    l_items_nt(l_items_nt.LAST) := 'Treadmill';

    DBMS_OUTPUT.PUT_LINE(l_items_nt.COUNT);
END;
/

-- OUTPUT - 2


-- Adding element to nested table composed of more complex type RECORD
DECLARE
    TYPE items_rec IS RECORD(item_name items.item_name%TYPE,
                            count NUMBER);
    TYPE items_nt IS TABLE of items_rec;
    l_items_nt   items_nt:= items_nt();

BEGIN
    l_items_nt.EXTEND;
    l_items_nt(l_items_nt.LAST).item_name := 'Bike';
    l_items_nt(l_items_nt.LAST).count := 1;

    l_items_nt.EXTEND;
    l_items_nt(l_items_nt.LAST).item_name := 'Treadmill';
    l_items_nt(l_items_nt.LAST).count := 2;

    DBMS_OUTPUT.PUT_LINE(l_items_nt(1).item_name);
END;
/

-- OUTPUT- Bike

-- Adding  element using CURSOR
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
    CURSOR get_items IS 
       SELECT * FROM items;
BEGIN
    FOR get_items_var IN get_items LOOP  
        l_items_nt.EXTEND;
        l_items_nt(l_items_nt.LAST) := get_items_var.item_name;
    END LOOP;
END;
/

-- OUTPUT


-- Adding element if we know the quantity n
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND(2);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';

END;
/

-- Adding elements N of copy i
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND(2);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';

-- extend the copy of element 1 (2 times)
    l_items_nt.EXTEND(2, 1);

    DBMS_OUTPUT.PUT_LINE(l_items_nt(3));
    DBMS_OUTPUT.PUT_LINE(l_items_nt(4));
END;
/ 

/*
OUTPUT

Bike
Bike
*/