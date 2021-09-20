CREATE TABLE item_inventory(item_id NUMBER, 
                                          item_qty NUMBER);
                    
DELETE FROM orders;
COMMIT;

INSERT INTO item_inventory(item_id, item_qty) VALUES (1, 10);
INSERT INTO item_inventory(item_id, item_qty) VALUES (2, 10);
COMMIT;

SELECT * FROM item_inventory;

-- 
CREATE OR REPLACE TRIGGER orders_cmp_trig
  FOR INSERT OR DELETE ON orders
    COMPOUND TRIGGER
  TYPE items_rec IS RECORD (item_id NUMBER, qty NUMBER);
  TYPE items_inventory IS TABLE OF items_rec INDEX BY BINARY_INTEGER;
  l_items_inventory items_inventory;
  l_index NUMBER;
  AFTER EACH ROW IS
  BEGIN
    l_index := l_items_inventory.COUNT + 1;
    DBMS_OUTPUT.PUT_LINE('After row firing l_index '||l_index);
    IF INSERTING THEN
      l_items_inventory(l_index).item_id := :NEW.order_item_id;
      l_items_inventory(l_index).qty     := -1;
    END IF;
    IF DELETING THEN
      l_items_inventory(l_index).item_id := :OLD.order_item_id;
      l_items_inventory(l_index).qty     := 1;
    END IF;
  END AFTER EACH ROW;
  
  AFTER STATEMENT IS
  BEGIN
   DBMS_OUTPUT.PUT_LINE('After statement firing , bulk updating items_inventory');
   FORALL i IN 1..l_items_inventory.COUNT
     UPDATE item_inventory
        SET item_qty = item_qty + l_items_inventory(i).qty
        WHERE item_id = l_items_inventory(i).item_id;
  END AFTER STATEMENT;
END orders_cmp_trig;


-- 

SELECT * FROM item_inventory;

DECLARE
  TYPE orders_tab is TABLE OF orders%ROWTYPE INDEX BY POSITIVE;
  l_orders_tab  orders_tab;
BEGIN
  FOR i in 1 ..5 LOOP
    l_orders_tab(i).order_id := orders_seq.NEXTVAL;
    l_orders_tab(i).order_item_id := 1;
    l_orders_tab(i).order_act_id := 1;
  END LOOP;
  
  FOR i in 6..9 LOOP
    l_orders_tab(i).order_id := orders_seq.NEXTVAL;
    l_orders_tab(i).order_item_id := 2;
    l_orders_tab(i).order_act_id := 1;
  END LOOP;
  
  FORALL i IN 1..l_orders_tab.COUNT 
    INSERT INTO orders VALUES l_orders_tab(i);
END;
/

/*OUTPUT
After row firing l_index 1
After row firing l_index 2
After row firing l_index 3
After row firing l_index 4
After row firing l_index 5
After row firing l_index 6
After row firing l_index 7
After row firing l_index 8
After row firing l_index 9
After statement firing , bulk updating items_inventory
*/

SELECT * FROM item_inventory;

DELETE FROM orders;
/* OUTPUT
9 row(s) deleted.
After row firing l_index 1
After row firing l_index 2
After row firing l_index 3
After row firing l_index 4
After row firing l_index 5
After row firing l_index 6
After row firing l_index 7
After row firing l_index 8
After row firing l_index 9
After statement firing , bulk updating items_inventory
*/

SELECT * FROM item_inventory;
