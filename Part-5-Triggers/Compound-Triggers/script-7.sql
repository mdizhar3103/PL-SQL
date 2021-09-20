SELECT * FROM items;

-- before row trigger 
CREATE OR REPLACE TRIGGER items_br_upd_trig1
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row trigger 1 firing');
END;
/

-- before row trigger 
CREATE OR REPLACE TRIGGER items_br_upd_trig2
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row trigger 2 firing');
END;
/


-- before row trigger 
CREATE OR REPLACE TRIGGER items_br_upd_trig3
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row trigger 3 firing');
END;
/

-- update tables
UPDATE items SET item_value = item_value * 1.10;
/* OUTPUT
Before row trigger 3 firing
Before row trigger 2 firing
Before row trigger 1 firing
Before row trigger 3 firing
Before row trigger 2 firing
Before row trigger 1 firing
*/
-- ---------------MODIFYING THE ABOVE CODE ----------------
-- before row trigger 
CREATE OR REPLACE TRIGGER items_br_upd_trig1
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row trigger 1 firing');
END;
/

-- modified before row trigger  2
CREATE OR REPLACE TRIGGER items_br_upd_trig2
BEFORE UPDATE ON items
FOR EACH ROW
FOLLOWS items_br_upd_trig1
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row trigger 2 firing');
END;
/


-- modified before row trigger 3
CREATE OR REPLACE TRIGGER items_br_upd_trig3
BEFORE UPDATE ON items
FOR EACH ROW
FOLLOWS items_br_upd_trig2
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row trigger 3 firing');
END;
/

-- update tables
UPDATE items SET item_value = item_value * 1.10;
/*
Before row trigger 1 firing
Before row trigger 2 firing
Before row trigger 3 firing
Before row trigger 1 firing
Before row trigger 2 firing
Before row trigger 3 firing
*/

-- ---------------RUNNING WITH DIFFERENT TIMINGPOINT ----------------

CREATE OR REPLACE TRIGGER items_ar_upd_trig
AFTER UPDATE ON items
FOR EACH ROW
FOLLOWS items_br_upd_trig1
BEGIN
    DBMS_OUTPUT.PUT_LINE('After row trigger firing');
END;
/

-- gives the error
-- ORA-25022: cannot reference a trigger of a different type 
