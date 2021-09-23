 /* Trigger to update to item value
Effect on logging with rollback
Autnomous trigger
*/

CREATE TABLE item_log(ilog_item_id NUMBER,
                      ilog_item_new_value NUMBER,
                      ilog_item_old_value NUMBER,
                      ilog_os_user VARCHAR2(60),
                      ilog_db_user VARCHAR2(60),
                      ilog_insert_time TIMESTAMP);

CREATE OR REPLACE TRIGGER items_ar_upd_trig 
    AFTER UPDATE OF item_value ON items 
    FOR EACH ROW
    BEGIN
        INSERT INTO item_log(ilog_item_id,
                             ilog_item_new_value,
                             ilog_item_old_value,
                             ilog_os_user,
                             ilog_db_user,
                             ilog_insert_time)
                    VALUES(:OLD.item_id,
                           :NEW.item_value,
                           :OLD.item_value,
                           SYS_CONTEXT('USERENV', 'OS_USER'),
                           USER,
                           SYSTIMESTAMP);
    END;
/

SELECT * FROM items;
UPDATE items SET item_value = 110 WHERE item_id = 2;
SELECT * FROM item_log;
ROLLBACK;
SELECT * FROM item_log;

