SELECT * FROM items WHERE item_id in (5, 6, 7, 8);
/

DECLARE 
    TYPE itemid_aa IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
    l_itemid_aa itemid_aa;
BEGIN
    l_itemid_aa(1) := 5;
    l_itemid_aa(5) := 6;
    l_itemid_aa(7) := 7;
    l_itemid_aa(9) := 8;

    FORALL i IN INDICES OF l_itemid_aa 
        UPDATE items
        SET item_value = item_value * 1.10
        WHERE item_id = l_itemid_aa(i);
    DBMS_OUTPUT.PUT_LINE('Rows updated '||SQL%ROWCOUNT);
END;
/