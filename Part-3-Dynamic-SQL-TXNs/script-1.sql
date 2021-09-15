CREATE OR REPLACE PROCEDURE process_order(p_act_id accounts.act_id%TYPE,
                                          p_item_id items.item_id%TYPE,
                                          p_item_value items.item_value%TYPE) IS
    BEGIN
        -- Debit Account
        UPDATE accounts 
        SET act_bal = act_bal - p_item_value
        WHERE act_id = p_act_id;
        -- Place Order
        INSERT INTO orders(order_id, order_item_id, order_act_id)
        VALUES (order_seq.NEXTVAL, p_item_id, p_act_id);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
            DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
            ROLLBACK;
            RAISE;
    END process_order;
    /
