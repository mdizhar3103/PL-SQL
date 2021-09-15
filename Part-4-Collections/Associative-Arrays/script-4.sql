-- Reinitializing Associative Array by Assigning Empty Array


DECLARE 
    TYPE items_aa IS TABLE of VARCHAR2(60) INDEX BY BINARY_INTEGER;
    
    l_items_aa items_aa;
    l_empty_aa items_aa;
BEGIN
    l_items_aa(1) := 'Treadmill';
    l_items_aa(2) := 'Bike';
    l_items_aa(3) := 'Elliptical';

    l_items_aa := l_empty_aa;

END;

-- OUTPUT
-- Statement processed.


-- NOTE: Also Can be reinitialize using the Bulk Collect Query 