/*
Previous script invloves complexity
for handling mutating table error.
To avoid that complexity lets use compound triggers
*/
ALTER TABLE accounts DISABLE ALL TRIGGERS;

CREATE OR REPLACE TRIGGER act_ins_upd_cmpd_trig
    FOR INSERT OR UPDATE OF act_cust_id
    ON accounts
    COMPOUND TRIGGER
      TYPE g_cust_id_tbl IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
      g_cust_id g_cust_id_tbl;

    CURSOR get_act_count(p_cust_id NUMBER) IS
      SELECT COUNT(*) FROM accounts
      WHERE act_cust_id = p_cust_id;
    l_count NUMBER := 0;

    AFTER EACH ROW IS
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Putting '||:NEW.act_cust_id||' in the plsql table which has a current count of '||g_cust_id.COUNT);
            g_cust_id(g_cust_id.COUNT + 1) := :NEW.act_cust_id;
    END AFTER EACH ROW;

    AFTER STATEMENT IS 
        BEGIN
            FOR i IN 1..g_cust_id.COUNT LOOP
                OPEN get_act_count(g_cust_id(i));
                FETCH get_act_count INTO l_count;
                CLOSE get_act_count;
                DBMS_OUTPUT.PUT_LINE('Count of accounts for cust_id '|| g_cust_id(i)||' is '||l_count );
                IF l_count > 2 THEN
                    RAISE_APPLICATION_ERROR(-20001, 'Max. Number of accounts exceeded');
                END IF;
            END LOOP;
    END AFTER STATEMENT;
END;
/

SELECT * FROM accounts ORDER BY act_cust_id;
UPDATE accounts SET act_cust_id = 1 WHERE act_cust_id = 3;
SELECT * FROM accounts ORDER BY act_cust_id;
UPDATE accounts SET act_cust_id = 2;
SELECT * FROM accounts ORDER BY act_cust_id;