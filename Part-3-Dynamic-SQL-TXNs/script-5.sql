CREATE TABLE orders_queue (QUEUE_ID NUMBER NOT NULL PRIMARY KEY,
                           queue_act_id NUMBER,
                           queue_item_id NUMBER ); 
UPDATE accounts   SET act_bal = 1000  WHERE act_id = 1;
UPDATE accounts   SET act_bal = 1000  WHERE act_id = 2;
UPDATE accounts   SET act_bal = 1000  WHERE act_id = 3;

INSERT INTO orders_queue(queue_id,queue_act_id,queue_item_id) VALUES(1,1,2);
INSERT INTO orders_queue(queue_id,queue_act_id,queue_item_id) VALUES(2,20,2);
INSERT INTO orders_queue(queue_id,queue_act_id,queue_item_id) VALUES(3,3,2);
delete from orders;
commit;

INSERT INTO items(item_id,item_name,item_value) VALUES (3,'Bike',600);
COMMIT;

CREATE OR REPLACE PROCEDURE batch_processing IS
  CURSOR cur_get_orders IS
    SELECT queue_act_id,
           queue_item_id,
           item_value
      FROM orders_queue,
           items
     WHERE queue_item_id  = item_id
      ORDER BY queue_id;
BEGIN
   -- Process orders in a loop
    FOR order_var IN cur_get_orders LOOP
      SAVEPOINT savepoint_before_order;
      BEGIN
         -- Debit Account
         UPDATE accounts   SET act_bal = act_bal - order_var.item_value  WHERE act_id = order_var.queue_act_id;
         -- Place Order
         INSERT INTO orders(order_id, order_item_id, order_act_id)
                                  VALUES( order_seq.NEXTVAL, order_var.queue_item_id, order_var.queue_act_id);
         COMMIT;
         DBMS_OUTPUT.PUT_LINE('Processed order for act id '||order_var.queue_act_id);
       EXCEPTION
           WHEN OTHERS THEN
            ROLLBACK TO savepoint_before_order;
            DBMS_OUTPUT.PUT_LINE('Account id: '||order_var.queue_act_id||' Item id: '||order_var.queue_item_id||' Error '|| SQLERRM);
              
       END;
  END LOOP; 
END  batch_processing;

exec batch_processing;
select act_id,act_bal from accounts where act_id in ( 1,2,3);
select * from orders;

DROP TABLE ORDERS;
DROP TABLE ACCOUNTS;
DROP TABLE ITEMS;
DROP TABLE CUSTOMERS;
DROP TABLE TEMP_TABLE;
DROP TABLE ORDERS_QUEUE;
DROP SEQUENCE orders_seq;
DROP PACKAGE act_magmt;
DROP PROCEDURE process_order;
DROP PROCEDURE batch_processing;
