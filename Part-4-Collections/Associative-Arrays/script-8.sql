-- Error with overlength value

DECLARE
    TYPE items_aa IS TABLE of VARCHAR2(4) NOT NULL INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
BEGIN
    l_items_aa(1) := 'Mohd Izhar';

END;

-- OUTPUT

-- ORA-06502: PL/SQL: numeric or value error: character string buffer too small ORA-06512: at line 5
-- ORA-06512: at "SYS.DBMS_SQL", line 1721

