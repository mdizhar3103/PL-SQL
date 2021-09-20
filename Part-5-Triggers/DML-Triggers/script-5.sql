-- Adding codition for specific columns trigger

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

    IF UPDATING('act_cust_id') THEN
        DBMS_OUTPUT.PUT_LINE('Updating Customer id');
    END IF; 
END;
/

UPDATE accounts SET act_bal = 999, act_cust_id = 1  WHERE act_id = 1;
-- Both trigger will fired

UPDATE accounts SET act_bal = 1001, act_cust_id = 1  WHERE act_id = 1;
-- no triggers fired as condition fails for one of the assignment

