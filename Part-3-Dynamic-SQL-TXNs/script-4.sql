DECLARE
  l_act_id1_bal NUMBER;
  l_act_id2_bal NUMBER;
BEGIN
   -- Debit Account
   UPDATE accounts   SET act_bal = act_bal - 600  WHERE act_id = 1 RETURNING act_bal INTO l_act_id1_bal;
    DBMS_OUTPUT.PUT_LINE('Debited act_id 1 for 600 dollars new balance is '||l_act_id1_bal);
  -- Place Order
    DBMS_OUTPUT.PUT_LINE('Inserting order ');
    INSERT INTO orders(order_id, order_item_id, order_act_id)
                             VALUES( 1, 2, 1);
    DBMS_OUTPUT.PUT_LINE('Establishing savepoint_after_first_order ');
    SAVEPOINT savepoint_after_first_order;

   -- Debit Account
   UPDATE accounts   SET act_bal = act_bal - 600  WHERE act_id = 2  RETURNING act_bal INTO l_act_id2_bal;
    DBMS_OUTPUT.PUT_LINE('Debited act_id 2 for 600 dollars new balance is '||l_act_id2_bal);
  -- Place Order
    DBMS_OUTPUT.PUT_LINE('Inserting order ');
    INSERT INTO orders(order_id, order_item_id, order_act_id)
                             VALUES( 2, 10, 2);
 
 COMMIT;
 EXCEPTION
 WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error inserting order for second transaction '||DBMS_UTILITY.FORMAT_ERROR_STACK);
    DBMS_OUTPUT.PUT_LINE('Rolling back to savepoint_after_first_order');
    DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_BACKTRACE);
    ROLLBACK to savepoint_after_first_order;
    DBMS_OUTPUT.PUT_LINE('Committing');
    COMMIT;
    RAISE;
END ;
/
select act_id,act_bal from accounts where act_id in ( 1,2);
select * from orders;
