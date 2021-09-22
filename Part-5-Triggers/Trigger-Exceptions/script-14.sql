CREATE OR REPLACE PACKAGE global_package IS
    TYPE g_cust_id_tbl IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
    g_cust_id g_cust_id_tbl;
END global_package;
/

CREATE OR REPLACE TRIGGER act_bs_ins_upd_trig
    BEFORE INSERT OR UPDATE OF act_cust_id
    ON accounts
BEGIN
    global_package.g_cust_id.DELETE;
END act_bs_ins_upd_trig;
/

CREATE OR REPLACE TRIGGER act_br_ins_upd_trig
    BEFORE INSERT OR UPDATE OF act_cust_id
    ON accounts
    FOR EACH ROW
BEGIN
    global_package.g_cust_id(global_package.g_cust_id.COUNT + 1) := :NEW.act_cust_id;
END;
/

CREATE OR REPLACE TRIGGER act_as_ins_upd_trig
    AFTER INSERT OR UPDATE OF act_cust_id
    ON accounts
DECLARE 
    CURSOR get_act_count(p_cust_id NUMBER) IS
    SELECT COUNT(*) FROM accounts
    WHERE act_cust_id = p_cust_id;
    l_count NUMBER := 0;
BEGIN
    FOR i IN 1..global_package.g_cust_id.COUNT LOOP
        OPEN get_act_count(global_package.g_cust_id(i));
        FETCH get_act_count INTO l_count;
        CLOSE get_act_count;
        DBMS_OUTPUT.PUT_LINE('Count for accounst for cust_id '|| global_package.g_cust_id(i)||' is '||l_count);
        IF l_count > 2 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Max. Number of accounts exceeded');
        END IF;
    END LOOP;
END;
/


UPDATE accounts SET act_cust_id = 3  WHERE act_cust_id = 1;
SELECT * FROM accounts;
UPDATE accounts SET act_cust_id = 2;
SELECT * FROM accounts;