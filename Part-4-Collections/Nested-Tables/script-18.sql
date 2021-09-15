DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND(3);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';
    l_items_nt(3) := 'Elliptical';

    l_items_nt.DELETE(2);
    DBMS_OUTPUT.PUT_LINE(l_items_nt.COUNT);

    l_items_nt.DELETE;
    DBMS_OUTPUT.PUT_LINE(l_items_nt.COUNT);
END;
/ 

-- OUTPUT
-- Statement processed.
-- 2
-- 0