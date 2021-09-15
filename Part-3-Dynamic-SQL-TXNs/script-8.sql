SELECT * FROM orders_queue;
DELETE FROM orders;
DELETE FROM log_table;
COMMIT;

CREATE OR REPLACE PROCEDURE process_order(p_act_id accounts.act_id%TYPE,
                                          p_item_id items.item_id%TYPE,
                                          p_item_value items.item_value%TYPE) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
    -- Debit accounts
        UPDATE accounts
        SET act_bal = act_bal - p_item_value 
        WHERE act_id = p_act_id;
    -- Place Order
        INSERT INTO orders(order_id, order_item_id, order_act_id)
                    VALUES(orders_seq.NEXTVAL, p_item_id, p_act_id);
    -- Log message
        log_msg(p_act_id, 'Order Sucessful');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        -- Log message
            log_msg(p_act_id, 'Failed'||SQLERRM);
            ROLLBACK;
            RAISE;
    END process_order;
/

DECLARE 
    CURSOR cur_get_order_queue IS 
       SELECT queue_act_id, queue_item_id, item_value
       FROM orders_queue, items
       WHERE queue_item_id = item_id;
    BEGIN
        FOR cur_info IN cur_get_order_queue LOOP
           process_order(cur_info.queue_act_id,
                         cur_info.queue_item_id,
                         cur_info.item_value);
        END LOOP;
    END;
/

SELECT * FROM orders;
SELECT * FROM log_table ORDER BY log_id;
