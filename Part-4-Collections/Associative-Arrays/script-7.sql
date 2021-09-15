-- Error with NULL

DECLARE
    TYPE items_aa IS TABLE of VARCHAR2(4) NOT NULL INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
BEGIN
    l_items_aa(1) := NULL;

END;

-- OUTPUT
-- ORA-06550: line 5, column 22:
-- PLS-00382: expression is of wrong type 