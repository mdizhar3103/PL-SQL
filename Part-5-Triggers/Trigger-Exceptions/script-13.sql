/*
Problem:

One customer can have a maximum of 2 accounts
customer table have foreign key with accounts table
*/

CREATE OR REPLACE TRIGGER act_br_ins_upd_trig
   BEFORE INSERT OR UPDATE OF act_cust_id
   ON accounts
   FOR EACH ROW
   DECLARE
    CURSOR get_act_count(p_cust_id NUMBER) IS
        SELECT COUNT(*) 
        FROM accounts
        WHERE act_cust_id = p_cust_id;
    l_count NUMBER := 0;
BEGIN
    OPEN get_act_count(:NEW.act_cust_id);
    FETCH get_act_count INTO l_count;
    CLOSE get_act_count;
    DBMS_OUTPUT.PUT_LINE('Existing Count of accounts for cust_id '||:OLD.act_cust_id||' is '||l_count);
    IF l_count >= 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Max. Number of accounts exceeded');
    END IF;
END;
/

DELETE FROM orders;
DELETE FROM accounts;
COMMIT;

INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (1, 1, 100);
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (2, 1, 100);
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (3, 1, 100);

DELETE FROM accounts;
COMMIT;

INSERT INTO accounts(act_id, act_cust_id, act_bal) SELECT 1,1, 100 FROM dual;
DELETE FROM accounts;
COMMIT;
SELECT * FROM accounts;

INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (1, 1, 100);
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (2, 1, 100);
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (3, 2, 100);
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (4, 2, 100);

SELECT * FROM accounts;
UPDATE accounts SET act_cust_id = 3 WHERE act_cust_id = 1;
SELECT * FROM accounts;