-- Session Persistance/Visibility

-- pacakge spec
CREATE OR REPLACE PACKAGE globals IS
    TYPE items_aa IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    g_items_aa items_aa;
    TYPE order_count_rec IS RECORD(item_id NUMBER, order_count NUMBER);
    TYPE order_count_aa IS TABLE OF order_count_rec INDEX by PLS_INTEGER;
END globals;
/

-- procedure 
CREATE OR REPLACE PROCEDURE set_items IS
    CURSOR items_cur IS
      SELECT item_id 
        FROM items;
    l_counter NUMBER := 0;
BEGIN
    FOR items_var IN items_cur LOOP
        l_counter := l_counter + 1;
        globals.g_items_aa(l_counter) := items_var.item_id;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Items Set Count: '||l_counter);
END set_items;
/

-- function
CREATE OR REPLACE FUNCTION get_order_count RETURN globals.order_count_aa IS
    CURSOR order_count_cur(p_item_id items.item_id%TYPE) IS
        SELECT count(*)
        FROM orders
        WHERE order_item_id = p_item_id;

    l_order_count_aa  globals.order_count_aa;
    l_index           NUMBER;
    l_item_id         NUMBER;
    l_counter         NUMBER:=0;

BEGIN 
    l_index := globals.g_items_aa.FIRST;
    WHILE l_index IS NOT NULL LOOP
        l_item_id := globals.g_items_aa(l_index);
        l_counter := l_counter + 1;
        l_order_count_aa(l_counter).item_id := l_item_id;
        OPEN order_count_cur(l_item_id);
        FETCH order_count_cur INTO l_order_count_aa(l_counter).order_count;
        CLOSE order_count_cur;
        l_index := globals.g_items_aa.NEXT(l_index);
    END LOOP;
    RETURN l_order_count_aa;
END get_order_count;
/


-- Anonymous Block
DECLARE 
    l_order_aa globals.order_count_aa;
    l_index NUMBER := 0;
BEGIN 
    -- populates globals.g_items_aa
    set_items;
    l_order_aa := get_order_count;
    l_index := l_order_aa.FIRST;
    DBMS_OUTPUT.PUT_LINE('COUNT '|| l_order_aa.count);
    WHILE l_index IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('Item id: '||l_order_aa(l_index).item_id||' Order Count '|| l_order_aa(l_index).order_count);
        l_index := l_order_aa.NEXT(l_index);
    END LOOP;
END;
/

-- OUTPUT

-- Statement processed.
-- Items Set Count: 3
-- COUNT 3
-- Item id: 1 Order Count 1
-- Item id: 2 Order Count 2
-- Item id: 3 Order Count 3
