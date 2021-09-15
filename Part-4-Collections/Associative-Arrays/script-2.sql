-- Assigning another collection to an Associative Array

DECLARE 
    TYPE items_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
    l_copy_aa items_aa;
BEGIN
    l_items_aa(1) := 'Treadmill';
    l_items_aa(2) := 'Bike';
    l_items_aa(3) := 'Elliptical';

    l_copy_aa := l_items_aa;

    DBMS_OUTPUT.PUT_LINE(l_copy_aa(3));
END;

 