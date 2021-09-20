-- Before statement trigger
CREATE OR REPLACE TRIGGER items_bs_upd_trig
BEFORE UPDATE ON items
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before Statement trigger firing');
END;
/

-- before row trigger 
CREATE OR REPLACE TRIGGER items_bs_upd_trig
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row trigger firing');
END;
/

-- after row trigger 
CREATE OR REPLACE TRIGGER items_ar_upd_trig
AFTER UPDATE ON items
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('After row trigger firing');
END;
/

-- after statement trigger
CREATE OR REPLACE TRIGGER items_as_upd_trig
AFTER UPDATE ON items
BEGIN
    DBMS_OUTPUT.PUT_LINE('After Statement trigger firing');
END;
/


-- selecting items
SELECT * FROM items;

-- performing updation
UPDATE items set item_value = item_value * 1.10;

-- create another trigger
CREATE OR REPLACE TRIGGER items_br_upd_trig2
BEFORE UPDATE ON items
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Before row Trigger 2 firing');
END;
/

-- performing updation
UPDATE items set item_value = item_value * 1.10;

SELECT * FROM user_triggers;