SELECT * FROM items;
/

DECLARE 
    TYPE item_rec IS RECORD(item_id NUMBER, inc_factor NUMBER);
    TYPE items_aa IS TABLE OF item_rec INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
BEGIN
    l_items_aa(1).item_id := 1;
    l_items_aa(1).inc_factor := 1.10; 
    l_items_aa(1).item_id := 2;
    l_items_aa(1).inc_factor := 1.15; 

    FORALL i IN l_items_aa.FIRST .. l_items_aa.LAST 
        UPDATE items 
        SET item_value = item_value * l_items_aa(i).inc_factor
        WHERE item_id IN l_items_aa(i).item_id;
    DBMS_OUTPUT.PUT_LINE('Rows Updated '||SQL%ROWCOUNT);
END;
/

-- 