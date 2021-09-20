SELECT  * FROM accounts;

CREATE OR REPLACE TRIGGER accounts_br_ins_upd_del_trig
    BEFORE INSERT
    OR UPDATE
    OR DELETE ON accounts
    REFERENCING NEW AS NEWER OLD AS OLDER
    FOR EACH ROW
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

-- INSERTING DATA
SELECT  * FROM accounts;
INSERT INTO accounts (act_id, act_cust_id, act_bal) VALUES ( 5, 1, 1000);

SELECT  * FROM accounts;
INSERT INTO accounts (act_id, act_cust_id, act_bal, act_insert_user) VALUES ( 6, 1, 1000, 'TOM');
SELECT  * FROM accounts;

-- DELETING DATA
DELETE FROM accounts WHERE act_id = 6;
SELECT  * FROM accounts;

-- UPDATING TABLE
UPDATE accounts SET act_cust_id = 2  WHERE act_id = 1;
SELECT  * FROM accounts;

