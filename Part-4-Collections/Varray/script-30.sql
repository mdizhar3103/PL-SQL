-- uninitialized collection ORA-06512:
DECLARE
    TYPE items_va IS VARRAY(2) OF VARCHAR2(4);
    l_items_va items_va;
BEGIN
    l_items_va.EXTEND(3);
END;
/

-- Subscript outside of limit ORA-06512
DECLARE
    TYPE items_va IS VARRAY(2) OF VARCHAR2(4);
    l_items_va items_va := items_va();
BEGIN
    l_items_va.EXTEND(3);
END;
/

-- Subscript outside of limit ORA-06512 (because index start from 1)
DECLARE
    TYPE items_va IS VARRAY(2) OF VARCHAR2(4);
    l_items_va items_va := items_va();
BEGIN
    l_items_va.EXTEND;
    l_items_va(0) := 'Treadmill';
END;
/

-- Subscript outside of limit ORA-06512
DECLARE
    TYPE items_va IS VARRAY(2) OF VARCHAR2(4);
    l_items_va items_va := items_va();
BEGIN
    l_items_va.EXTEND;
    l_items_va(0) := 'Treadmill';
END;
/

-- numeric or value error (length of string exceeds the declared limit)
DECLARE
    TYPE items_va IS VARRAY(2) OF VARCHAR2(4);
    l_items_va items_va := items_va();
BEGIN
    l_items_va.EXTEND;
    l_items_va(1) := 'Treadmill';
END;
/

-- Subscript beyond count ORA-06512
DECLARE
    TYPE items_va IS VARRAY(2) OF VARCHAR2(4);
    l_items_va items_va := items_va();
BEGIN
    l_items_va.EXTEND;
    l_items_va(1) := 'Bike';
    l_items_va.TRIM(2);
END;
/
