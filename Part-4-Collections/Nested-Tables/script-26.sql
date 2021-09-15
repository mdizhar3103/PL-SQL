CREATE TABLE items_orders (
    act_month VARCHAR2(8),
    store1_items items_nt DEFAULT items_nt(),
    store2_items items_nt DEFAULT items_nt())
    NESTED TABLE store1_items STORE AS store1
    NESTED TABLE store2_items STORE AS store2;

INSERT INTO items_orders(act_month, store1_items, store2_items)
VALUES ('JANUARY',
        items_nt('Bike', 'Bike', 'Treadmill','Elliptical'),
        items_nt('Elliptical', 'Elliptical'));
COMMIT;

SELECT * FROM items_orders;

DECLARE 
    l_final_nt items_nt;
    CURSOR cur_get_items IS
     SELECT store1_items MULTISET UNION store2_items
     FROM items_orders
     WHERE act_month = 'JANUARY';
BEGIN 
    OPEN cur_get_items;
    FETCH cur_get_items INTO l_final_nt;
    CLOSE cur_get_items;
    FOR i IN l_final_nt.FIRST .. l_final_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_final_nt(i));
    END LOOP;
END;
/

-- Try for
/*
MULTISET UNION DISTINCT
MULTISET INTERSECT
MULTISET INTERSECT DISTINCT
MULTISET EXECPT
MULTISET EXECPT DISTINCT
*/