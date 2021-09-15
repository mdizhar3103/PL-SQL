CREATE SEQUENCE queue_seq START WITH 1 INCREMENT BY 1;
CREATE OR REPLACE FUNCTION generate_order(p_loc VARCHAR2, p_act_id NUMBER, p_item_id NUMBER)
        RETURN NUMBER IS
       l_count NUMBER;
       l_id NUMBER;
       l_item_val NUMBER;
       no_table_exists EXCEPTION;
       PRAGMA EXCEPTION_INIT(no_table_exists, -942);
       CURSOR get_item_val IS
         SELECT item_value 
         FROM items
         WHERE item_id = p_item_id;
    BEGIN 
        BEGIN 
            -- first check if table exists if not create it for that location
            EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM orders_queue_'|| p_loc INTO l_count;
        EXCEPTION
            WHEN no_table_exists THEN 
            EXECUTE IMMEDIATE 'CREATE TABLE orders_queue_'||p_loc||'(queue_id NUMBER, queue_act_id NUMBER, queue_item_id NUMBER)';
        END;
        EXECUTE IMMEDIATE 'INSERT INTO orders_queue_'||p_loc||'(queue_id, queue_act_id, queue_item_id) VALUES '||
                          '(:p_id, :p_act_id, :p_item) RETURNING queue_id INTO :l_id'
                          USING queue_seq.NEXTVAL,p_act_id,p_item_id RETURN INTO l_id;
        DBMS_OUTPUT.PUT_LINE('QUEUE ID IS '||l_id);
        OPEN get_item_val;
        FETCH get_item_val INTO l_item_val; 
        CLOSE get_item_val;
        EXECUTE IMMEDIATE 'CALL process_order(:p_act_id, :p_item_id, :p_item_value) ' USING p_act_id, p_item_id, l_item_val;
        RETURN l_id;
    END generate_order;
/

SELECT * FROM orders_queue_ca;

DELETE FROM ORDERS;
COMMIT;

DECLARE 
    l_id NUMBER;
BEGIN
    l_id := generate_order('CA',1, 1);
END;
/

SELECT * FROM orders_queue_ca;
SELECT * FROM orders;
