SELECT * FROM items;

DECLARE
    TYPE itemid_nt is TABLE OF PLS_INTEGER;
    l_itemid_nt    itemid_nt;
BEGIN
    UPDATE items
    SET item_value = item_value * 1.10
    WHERE item_value > 400
    RETURN item_id BULK COLLECT INTO l_itemid_nt;
    DBMS_OUTPUT.PUT_LINE(l_itemid_nt.COUNT);
END;
/

SELECT * FROM items;

-- Bulk Collect with Dynamic SQL
CREATE OR REPLACE TYPE items_nt AS TABLE of VARCHAR2(60);
/

desc items_nt;
/

CREATE OR REPLACE FUNCTION get_item_ids(p_where VARCHAR2) RETURN items_nt IS
    l_items_nt items_nt;
BEGIN
    EXECUTE IMMEDIATE
        'SELECT item_name
         FROM items ' || 
         p_where
        BULK COLLECT INTO l_items_nt;
    DBMS_OUTPUT.PUT_LINE(l_items_nt.COUNT);
    RETURN l_items_nt;
END;
/

DECLARE 
    l_items_nt      items_nt;
BEGIN
    l_items_nt := get_item_ids('WHERE item_value > 400');
END;
/