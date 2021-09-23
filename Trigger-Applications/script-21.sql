/*
After row trigger to audit orders table
Check for reason code
*/

CREATE OR REPLACE PACKAGE order_mgmt
IS g_delete_reason VARCHAR2(60);
END order_mgmt;
/

CREATE TABLE orders_audit(
    oaud_order_id NUMBER,
    oaud_order_item_id NUMBER,
    oaud_order_act_id NUMBER,
    oaud_reason_code VARCHAR2(60),
    oaud_insert_time TIMESTAMP,
    oaud_insert_user VARCHAR2(60)
);

CREATE OR REPLACE TRIGGER orders_ar_del_trig 
    AFTER DELETE ON orders 
    FOR EACH ROW
    BEGIN
        IF order_mgmt.g_delete_reason IS NULL THEN
            RAISE_APPLICATION_ERROR(-20001, 'Order deletion resaon has to be specified');
        END IF;
    INSERT INTO orders_audit (
        oaud_order_id,
        oaud_order_item_id,
        oaud_order_act_id,
        oaud_reason_code,
        oaud_insert_time,
        oaud_insert_user
    ) VALUES (
        :OLD.order_id,
        :OLD.order_item_id,
        :OLD.order_act_id,
        order_mgmt.g_delete_reason,
        SYSTIMESTAMP,
        USER
    );
    END orders_ar_del_trig;
/


-- After statement trigger to clear out g_delete reason code
CREATE OR REPLACE TRIGGER orders_as_del_trig 
AFTER DELETE ON orders
BEGIN
    order_mgmt.g_delete_reason := NULL;
END orders_as_del_trig;
/

SELECT * FROM orders;

BEGIN 
    DELETE FROM orders WHERE order_id = 1;
    -- SQL ERROR; ORA -20001; order deletion reason has to be specified
END;
/

BEGIN
    order_mgmt.g_delete_reason := 'Defective Item';
    DELETE FROM orders WHERE order_id = 1;
END;
/

SELECT * FROM orders_audit;

BEGIN
    DELETE FROM orders WHERE order_id = 2;
    -- SQL ERROR
END;
/

BEGIN
    order_mgmt.g_delete_reason := 'No longer required';
    DELETE FROM orders WHERE order_id = 2;
END;
/

SELECT * FROM orders_audit;
SELECT * FROM orders;
ROLLBACK;

SELECT * FROM orders;
SELECT * FROM orders_audit;

