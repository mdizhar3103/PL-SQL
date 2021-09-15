
CREATE OR REPLACE PROCEDURE process_order(p_act_id accounts.act_id%TYPE,
                                          p_item_id items.item_id%TYPE,
                                          p_item_value items.item_value%TYPE) IS
    l_new_bal accounts.act_bal%TYPE;
    l_balance_again accounts.act_bal%TYPE;
    BEGIN
        SET TRANSACTION NAME 'place_order';
        -- Debit Account
        UPDATE accounts 
        SET act_bal = act_bal - p_item_value
        WHERE act_id = p_act_id;
        DBMS_OUTPUT.PUT_LINE('Account id '||p_act_id|| ' debited for '||p_item_value||' new balance is '||l_new_bal);
        act_mgmt.g_debit := 'Y';
        DBMS_OUTPUT.PUT_LINE('Pacakge vriable act_mgmt.g_debit assigned a value of Y. Now trying to insert');
        -- Place Order
        INSERT INTO orders(order_id, order_item_id, order_act_id)
        VALUES (orders_seq.NEXTVAL, p_item_id, p_act_id);
        DBMS_OUTPUT.PUT_LINE('Successful insertion in the orders table');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            SELECT act_bal INTO l_balance_again FROM accounts WHERE act_id =1;
            DBMS_OUTPUT.PUT_LINE('In Exception Section. Balance for account id 1 before rollback '||l_balance_again);
            DBMS_OUTPUT.PUT_LINE('Error: '||DBMS_UTILITY.FORMAT_ERROR_STACK||' Rolling Back');
            DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Value of package act_mgmt.g_debit variable after rollback '|| act_mgmt.g_debit);
            RAISE;
    END process_order;
/


EXEC process_order(1, 3, 200);
SELECT name, status FROM V$TRANSACTION;

EXEC process_order(1, 1, 600);
