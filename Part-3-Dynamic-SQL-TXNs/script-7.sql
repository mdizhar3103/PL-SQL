
DELETE FROM orders;
DELETE FROM log_table;
UPDATE accounts SET act_bal=1000;
SELECT * FROM accounts;

CREATE OR REPLACE PROCEDURE
    log_msg (p_act_id accounts.act_id%TYPE,
             p_msg    VARCHAR2) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
    SAVEPOINT first;
        INSERT INTO log_table(log_id, log_act_id, log_msg, log_insert_time)
              VALUES (log_seq.NEXTVAL, p_act_id, p_msg, SYSTIMESTAMP);
        COMMIT;
    END log_msg;
/

BEGIN
    SAVEPOINT first;
    INSERT INTO accounts(act_id, act_cust_id, act_bal)
                VALUES (10, 3, 2000);
    log_msg(10, 'Create');
    ROLLBACK TO first;
END log_msg;
/
-- since autonomous transaction doesn't share the transaction the first save point in the autonomous transaction is different and independent of this anonymous block's savepoint first.
-- So in this case rollback will take back to anonymous block savepoint first, and the autonomous transaction is not rollback.


SELECT * FROM accounts;
SELECT * FROM log_table;
