CREATE TABLE customer_profile(cprof_cust_id NUMBER PRIMARY KEY,
                              cprof_rating NUMBER,
                              CONSTRAINT cust_fk FOREIGN KEY (cprof_cust_id) REFERENCES customers(cust_id));


INSERT INTO customers(cust_id, cust_name, cust_location) VALUES(5, 'ABC Inc', 'WA');
INSERT INTO customer_profile(cprof_cust_id, cprof_rating) VALUES (5, 2);

CREATE OR REPLACE TRIGGER check_bal_trig
    BEFORE INSERT OR UPDATE OF act_bal ON accounts
    FOR EACH ROW
    DECLARE
        CURSOR get_cust_profile(p_cust_id NUMBER) IS
            SELECT cprof_rating
            FROM customer_profile
            WHERE cprof_cust_id = p_cust_id;
        l_rating NUMBER;
    BEGIN
        OPEN get_cust_profile(:NEW.act_cust_id);
        FETCH get_cust_profile INTO l_rating;
        CLOSE get_cust_profile;
        IF l_rating < 3 AND :NEW.act_bal < 100 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Low Balance');
        END IF;
    END;
/

INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES(10, 5, 50);
-- ORA -20001 Low Balance
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES(10, 5, 100);

SELECT * FROM accounts;