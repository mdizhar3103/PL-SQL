-- error for not initializing
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt;
BEGIN
    l_items_nt(1) := 'Bike';
END;
/ 

-- Error after initializing empty nested table
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt(1) := 'Bike';
END;
/ 

-- value error after extending nested table and adding NULL
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60) NOT NULL;
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND;
    l_items_nt(1) := NULL;
END;
/ 

-- no data found error 
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(60);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND;
    l_items_nt(1) := 'Bike';
    l_items_nt.DELETE(1);
    DBMS_OUTPUT.PUT_LINE(l_items_nt(1));
END;
/ 

-- string over length error
DECLARE
    TYPE items_nt IS TABLE of VARCHAR2(2);
    l_items_nt   items_nt:= items_nt();
BEGIN
    l_items_nt.EXTEND;
    l_items_nt(1) := 'Bike';
    -- l_items_nt('a') := 'Bike';
    -- l_items_nt(0) := 'Bike';
    DBMS_OUTPUT.PUT_LINE(l_items_nt(1));
END;
/ 
