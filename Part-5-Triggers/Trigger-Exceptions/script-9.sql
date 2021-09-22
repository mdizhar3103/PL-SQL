CREATE OR REPLACE PACKAGE test_package IS 
    g_number NUMBER := 0;
END test_package;
/



CREATE TABLE log_orders (
    log_order_id NUMBER(3),
    log_old_item_id NUMBER,
    log_new_item_id NUMBER,
    log_user VARCHAR2(60),
    log_time TIMESTAMP
);

ALTER TABLE orders disable all triggers;

DELETE FROM orders;
INSERT INTO orders(order_id, order_item_id, order_act_id) VALUES (1, 1, 1);
INSERT INTO orders(order_id, order_item_id, order_act_id) VALUES (2, 1, 1);
INSERT INTO orders(order_id, order_item_id, order_act_id) VALUES (1000, 1, 1);
COMMIT;


CREATE OR REPLACE TRIGGER orders_br_upd_trig
    BEFORE UPDATE OF order_item_id ON orders
    FOR EACH ROW
    DECLARE
        l_index NUMBER := 0;
    BEGIN
        l_index := l_index + 1;
        test_package.g_number := test_package.g_number + 1;
        DBMS_OUTPUT.PUT_LINE('Inside before row triger to update order id: '|| :NEW.order_id||'l_index: '|| l_index||
        ' test_package.g_number: '|| test_package.g_number);

        INSERT INTO log_orders (log_order_id,
                                log_old_item_id, 
                                log_new_item_id, 
                                log_user,
                                log_time)
                        VALUES (:OLD.order_id, 
                                :OLD.order_item_id,
                                :NEW.order_item_id,
                                USER,
                                SYSTIMESTAMP);
        DBMS_OUTPUT.PUT_LINE('Inserted into log_orders for order id ' ||:OLD.order_id);
    END orders_br_upd_trig;
/

UPDATE orders SET order_item_id = 2WHERE order_id = 1;
-- Inside before row triger to update order id: 1l_index: 1 test_package.g_number: 1
-- Inserted into log_orders for order id 1
SELECT * FROM orders;
SELECT * FROM log_orders;

-- Both update to orders table and insert into log_orders will be rolled back
UPDATE orders SET order_item_id = 10 WHERE order_id = 2;
SELECT * FROM orders;
SELECT * FROM log_orders;

-- Update to order not violate the foreign key constraint but insert into log_orders would fail
-- because max length of log_order is 3. Nothing gets inserted
UPDATE orders SET order_item_id = 10 WHERE order_id = 1000;
SELECT * FROM orders;
SELECT * FROM log_orders;


