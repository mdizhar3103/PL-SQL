CREATE TABLE log_table(log_id          NUMBER PRIMARY KEY,
                       log_act_id      NUMBER,
                       log_msg         VARCHAR2(400),
                       log_insert_time TIMESTAMP);
                       
CREATE SEQUENCE log_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE
    log_msg (p_act_id accounts.act_id%TYPE,
             p_msg    VARCHAR2) IS
    BEGIN
        INSERT INTO log_table(log_id, log_act_id, log_msg, log_insert_time)
              VALUES (log_seq.NEXTVAL, p_act_id, p_msg, SYSTIMESTAMP);
               
    END log_msg;
/


CREATE OR REPLACE PROCEDURE process_order(p_act_id accounts.act_id%TYPE,
                                          p_item_id items.item_id%TYPE,
                                          p_item_value items.item_value%TYPE) IS
    BEGIN
    -- Debit accounts
        UPDATE accounts
        SET act_bal = act_bal - p_item_value 
        WHERE act_id = p_act_id;
    -- log message
        log_msg(p_act_id, 'Debited');
    -- Place Order
        INSERT INTO orders(order_id, order_item_id, order_act_id)
                    VALUES(orders_seq.NEXTVAL, p_item_id, p_act_id);
    -- Log message
        log_msg(p_act_id, 'Order Placed');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
        -- Log message
            log_msg(p_act_id, SQLERRM);
            ROLLBACK;
            RAISE;
    END process_order;
/

SELECT * FROM log_table; 
-- INITIALLY EMPTY 

EXEC process_order(1, 3, 200);

SELECT * FROM log_table; 
-- The table is still empty because the  process_order value 3 passed to procedure causes exception making procedure to raise an exception and further causing to rollback.


-- Note: Now we want our log to stay even if our main transaction rollback so to achieve this make our procedure PRAGMA AUTONOMOUS AND COMMIT

CREATE OR REPLACE PROCEDURE
    log_msg (p_act_id accounts.act_id%TYPE,
             p_msg    VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        INSERT INTO log_table(log_id, log_act_id, log_msg, log_insert_time)
              VALUES (log_seq.NEXTVAL, p_act_id, p_msg, SYSTIMESTAMP);
        COMMIT;
    END log_msg;
/

Re-run the process_order procedure again.

EXEC process_order(1, 3, 200);
SELECT * FROM log_table;
