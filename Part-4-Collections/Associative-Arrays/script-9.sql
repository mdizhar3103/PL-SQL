-- Error with array with no value 

DECLARE
    TYPE items_aa IS TABLE of VARCHAR2(40) NOT NULL INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
BEGIN
    l_items_aa(1) := 'Mohd Izhar';
    DBMS_OUTPUT.PUT_LINE(l_items_aa(5));
END;

-- OUTPUT
-- ORA-01403: no data found ORA-06512: at line 6
-- ORA-06512: at "SYS.DBMS_SQL", line 1721