DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
    l_copy_nt items_nt;
BEGIN
    l_items_nt.EXTEND(3);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';
    l_items_nt(3) := 'Elliptical';

    l_copy_nt := l_items_nt;
    DBMS_OUTPUT.PUT_LINE(l_copy_nt(2));
END;
/ 
-- OUTPUT - Treadmill

-- Assigning Empty Table
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
    l_copy_nt items_nt;
BEGIN
    l_items_nt.EXTEND(3);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';
    l_items_nt(3) := 'Elliptical';

    l_items_nt := l_copy_nt;
END;
/ 

-- Same type
-- Assigning Empty Table
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    TYPE dup_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
    l_dup_nt dup_nt;
BEGIN
    l_items_nt.EXTEND(3);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';
    l_items_nt(3) := 'Elliptical';

-- gives error same type of different are consider different tables
    l_dup_nt := l_items_nt;
END;
/ 

-- OUTPUT
-- ORA-06550: line 13, column 17:
-- PLS-00382: expression is of wrong type 

