CREATE OR REPLACE TRIGGER accounts_br_ins_upd_del_trig
    BEFORE INSERT
    OR UPDATE OF act_bal, act_cust_id
    OR DELETE ON accounts
    REFERENCING NEW AS NEWER OLD AS OLDER
    FOR EACH ROW
    WHEN (NEWER.act_bal < 1000)
BEGIN
    IF INSERTING THEN 
        DBMS_OUTPUT.PUT_LINE('Inserting');
        :NEWER.act_insert_user := USER;
        :NEWER.act_insert_datetime := SYSTIMESTAMP;
    END IF;
    
    IF DELETING THEN 
        DBMS_OUTPUT.PUT_LINE('Deleting');
    END IF;

    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('Updating');
        :NEWER.act_update_user := USER;
        :NEWER.act_update_datetime := SYSTIMESTAMP;
    END IF; 
END;
/

-- AFTER UPDATE OF COLUMN CONDITION TO ACT_BAL
UPDATE accounts SET act_bal = 1001  WHERE act_id = 1;
SELECT  * FROM accounts;

UPDATE accounts SET act_bal = 999  WHERE act_id = 1;
SELECT  * FROM accounts;
