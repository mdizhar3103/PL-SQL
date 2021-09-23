CREATE OR REPLACE TRIGGER items_ar_upd_trig 
    AFTER UPDATE OF item_value ON items 
    FOR EACH ROW
    DECLARE
        PRAGMA AUTONOMOUS_TRANSACTION;
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
        COMMIT;
    END;
/

SELECT * FROM items;
UPDATE items SET item_value = 110 WHERE item_id = 2;
SELECT * FROM item_log;
ROLLBACK;
SELECT * FROM item_log;

