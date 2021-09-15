/*
Assigning another collection to an Associative Array
with same type will raise error although their internal datatype is same.

Since because of different names it will consider them as differnet types.

*/

DECLARE 
    TYPE items_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;
    TYPE dup_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;

    l_items_aa items_aa;
    l_dup_aa dup_aa;
BEGIN
    l_items_aa(1) := 'Treadmill';
    l_items_aa(2) := 'Bike';
    l_items_aa(3) := 'Elliptical';

    l_dup_aa := l_items_aa;

END;

 
--  Output
-- ORA-06550: line 12, column 17:
-- PLS-00382: expression is of wrong type 
