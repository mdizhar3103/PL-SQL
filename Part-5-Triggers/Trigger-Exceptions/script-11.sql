-- Raising exception in Exception 

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
    EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error '||SQLERRM);
        RAISE;
END orders_br_upd_trig;
/

UPDATE orders SET order_item_id = 2 WHERE order_id = 1000;
SELECT * FROM orders;
SELECT * FROM log_orders;