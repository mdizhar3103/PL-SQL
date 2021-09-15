--  [Single Row & Multi Rows Select Dynamic]

CREATE OR REPLACE PROCEDURE initiate_order(p_where VARCHAR2) IS
        TYPE cur_ref IS REF CURSOR;
        cur_order cur_ref;
        TYPE order_rec IS RECORD( act_id     orders_queue.queue_act_id%TYPE,
                                item_id    orders_queue.queue_item_id%TYPE);
        l_order_rec order_rec;
        l_item_rec items%ROWTYPE;
        l_query    VARCHAR2(400);
    BEGIN 
        l_query := 'SELECT queue_act_id, queue_item_id FROM orders_queue '|| p_where;
        DBMS_OUTPUT.PUT_LINE(l_query);
        OPEN cur_order FOR l_query;
        LOOP
            FETCH cur_order INTO l_order_rec;
            EXIT WHEN cur_order%NOTFOUND;
            EXECUTE IMMEDIATE 'SELECT * FROM items WHERE item_id = :item_id '
                              INTO l_item_rec USING l_order_rec.item_id;
            process_order(l_order_rec.act_id, l_order_rec.item_id, l_item_rec.item_value);
        END LOOP;
END initiate_order;
/



SELECT * FROM orders_queue ORDER BY queue_act_id;  
DELETE FROM orders_queue;  
INSERT INTO orders_queue VALUES(1, 1, 1); 
INSERT INTO orders_queue VALUES(3, 2, 1);  

SELECT * FROM orders_queue ORDER BY queue_act_id;


DELETE FROM ORDERS;

UPDATE accounts SET act_bal = 1000;
COMMIT;

EXEC initiate_order('WHERE queue_act_id = 1'); 
SELECT * FROM orders; 

DELETE FROM orders; 
COMMIT; 
EXEC initiate_order(NULL); 
SELECT * FROM orders;


