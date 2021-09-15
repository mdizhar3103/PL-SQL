SELECT count(*) FROM items;


DECLARE 
    TYPE itemid_nt IS TABLE OF PLS_INTEGER;
    l_itemid_nt itemid_nt;
    TYPE item_name_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_item_name_aa item_name_aa;
BEGIN
    SELECT item_id,
           item_name
    BULK COLLECT INTO l_itemid_nt,
                      l_item_name_aa
    FROM items;

    DBMS_OUTPUT.PUT_LINE(l_itemid_nt.COUNT);
    DBMS_OUTPUT.PUT_LINE(l_item_name_aa.COUNT);
END;
/

-- putting where clause
DECLARE 
    TYPE itemid_nt IS TABLE OF PLS_INTEGER;
    l_itemid_nt itemid_nt;
    TYPE item_name_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_item_name_aa item_name_aa;
BEGIN
    SELECT item_id,
           item_name
    BULK COLLECT INTO l_itemid_nt,
                      l_item_name_aa
    FROM items
    WHERE item_value = -1;

    DBMS_OUTPUT.PUT_LINE(l_itemid_nt.COUNT);
    DBMS_OUTPUT.PUT_LINE(l_item_name_aa.COUNT);
END;
/