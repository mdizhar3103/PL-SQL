-- Dynamic Way of Using Associative Array

SELECT * FROM items ORDER BY item_id;

DECLARE
    TYPE items_aa IS TABLE of items%ROWTYPE INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
    counter    NUMBER:=0;

    CURSOR get_items_cur IS 
          SELECT * FROM items ORDER BY item_id;

BEGIN
    FOR get_items_var in get_items_cur 
    LOOP
        counter := counter + 1;
        l_items_aa(counter).item_id := get_items_var.item_id;
        l_items_aa(counter).item_name := get_items_var.item_name;
        l_items_aa(counter).item_value := get_items_var.item_value;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('At counter 1: Item id is '||l_items_aa(1).item_id||' Item name is '||l_items_aa(1).item_name);
    DBMS_OUTPUT.PUT_LINE('At counter 2: Item id is '||l_items_aa(2).item_id||' Item name is '||l_items_aa(2).item_name);

END;

-- OUTPUT
-- Statement processed.
-- At counter 1: Item id is 1 Item name is Treadmill
-- At counter 2: Item id is 2 Item name is Elliptical
