-- TRIM Method
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND(3);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';
    l_items_nt(3) := 'Elliptical';
    DBMS_OUTPUT.PUT_LINE('COUNT before trim '||l_items_nt.COUNT);

    l_items_nt.TRIM;
    DBMS_OUTPUT.PUT_LINE('COUNT after trim '||l_items_nt.COUNT);
END;
/ 

/*
OUTPUT
Statement processed.
COUNT before trim 3
COUNT after trim 2
*/

-- TRIM with argument
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND(3);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';
    l_items_nt(3) := 'Elliptical';
    DBMS_OUTPUT.PUT_LINE('COUNT before trim '||l_items_nt.COUNT);

    l_items_nt.TRIM(2);
    DBMS_OUTPUT.PUT_LINE('COUNT after trim '||l_items_nt.COUNT);
END;
/ 

/*
OUTPUT
Statement processed.
COUNT before trim 3
COUNT after trim 1
*/
