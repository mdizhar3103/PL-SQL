DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt;
BEGIN
    DBMS_OUTPUT.PUT_LINE(l_items_nt.COUNT);
END;
/

/*
The above output give error because nested table is initialized to null (items_nt)
ORA-06531: Reference to uninitialized collection ORA-06512: at line 5
ORA-06512: at "SYS.DBMS_SQL", line 1721
*/


-- Initializing to constructor with no arguments
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt := items_nt();
BEGIN
    DBMS_OUTPUT.PUT_LINE(l_items_nt.COUNT);
END;
/

/*
OUTPUT

0
*/

-- Initializing with constructor with arguments
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:=items_nt('Bike', 'Treadmill');
BEGIN
    DBMS_OUTPUT.PUT_LINE(l_items_nt.COUNT);
END;
/


/*
OUTPUT

2
*/

