-- Assigning Value to an Unspecified index range Associative Array

DECLARE 
    TYPE items_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
BEGIN
    l_items_aa(-10) := 'Treadmill';
    l_items_aa(20) := 'Bike';
    DBMS_OUTPUT.PUT_LINE('Value at index counter 20 in l_items_aa array initially '||l_items_aa(20));

    l_items_aa(3) := 'Elliptical';
    l_items_aa(20) := 'Elliptical';
    DBMS_OUTPUT.PUT_LINE('New Value at index counter 20 in l_items_aa array initially '||l_items_aa(20));

END;

--  OUTPUT

-- Value at index counter 20 in l_items_aa array initially Bike
-- New Value at index counter 20 in l_items_aa array initially Elliptical