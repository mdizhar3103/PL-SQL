/*
1) Suppliers table to store supplier information for each item_id
2) Distributed database
3) Enforce referential integrity using triggers
4) Trigger on parent table to restrict delete
*/

CREATE TABLE suppliers(supp_id NUMBER PRIMARY KEY,
                       supp_name VARCHAR(100),
                       supp_item_id NUMBER);

SELECT * FROM ITEMS;
INSERT INTO suppliers(supp_id,supp_name,supp_item_id) VALUES(1, 'Supplier1', 10);
ROLLBACK;

CREATE OR REPLACE TRIGGER supp_br_ins_upd_trig
    BEFORE INSERT OR UPDATE ON suppliers
    FOR EACH ROW
    DECLARE
        CURSOR check_item(p_item_id NUMBER) IS
          SELECT 1 FROM items
          WHERE item_id = p_item_id;
        l_dummy NUMBER;
    BEGIN
        OPEN check_item(:NEW.supp_item_id);
        FETCH check_item INTO l_dummy;
        CLOSE check_item;
        IF l_dummy IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'No corresponding item was foundwith item_id '|| :NEW.supp_item_id);
        END IF;
    END;
/

SELECT * FROM suppliers;
INSERT INTO suppliers(supp_id,supp_name,supp_item_id) VALUES(1, 'Supplier1', 10);

-- Parent trigger

INSERT INTO items(item_id,item_name,item_value) VALUES(10, 'Trampoline', 50);
INSERT INTO suppliers(supp_id,supp_name,supp_item_id) VALUES(1, 'Supplier1', 10);
COMMIT;

CREATE OR REPLACE TRIGGER parent_trig
    BEFORE DELETE ON items
    FOR EACH ROW
    DECLARE
        CURSOR check_item(p_item_id NUMBER) IS
          SELECT 1 FROM suppliers
          WHERE supp_item_id = p_item_id;
        l_dummy NUMBER;
    BEGIN
        OPEN check_item(:OLD.item_id);
        FETCH check_item INTO l_dummy;
        CLOSE check_item;
        IF l_dummy = 1 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Child element for item_id '|| :OLD.item_id||' exists in the suppliers table');
        END IF;
    END;
/

DELETE FROM items WHERE item_id = 10;
ROLLBACK;

