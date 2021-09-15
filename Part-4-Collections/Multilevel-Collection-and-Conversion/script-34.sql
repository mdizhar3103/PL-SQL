CREATE OR REPLACE TYPE items_va AS VARRAY(5) of VARCHAR2(60);
/

CREATE OR REPLACE TYPE items_nt AS TABLE of VARCHAR2(60);
/

CREATE TYPE order_info_ot AS OBJECT (order_id NUMBER, 
                                    item_name VARCHAR2(60));
/

CREATE OR REPLACE TYPE order_info_nt IS TABLE of order_info_ot;
/

CREATE TABLE items_ordered(
    act_id NUMBER,
    act_month VARCHAR2(8),
    itemslist items_va   DEFAULT items_va()
);

INSERT INTO items_ordered(act_id, act_month, itemslist)
       VALUES(1, 'JANUARY', items_va('Bike', 'Treadmill'));

INSERT INTO items_ordered(act_id, act_month, itemslist)
       VALUES(1, 'JANUARY', items_va('Weights', 'Elliptical', 'Bike'));
       
COMMIT;

-- converting varray to nested table
SELECT CAST(itemslist AS items_nt)
FROM items_ordered;

SELECT CAST(
    MULTISET(SELECT order_id, item_name 
             FROM orders, items
             WHERE order_item_id = item_id
             AND order_act_id = 1
             ) AS order_info_nt
    )
FROM dual;

-- Using PL/SQL

DECLARE 
    CURSOR cur_info IS
        SELECT CAST(
           MULTISET(SELECT order_id, item_name 
                    FROM orders, items
                    WHERE order_item_id = item_id
                    AND order_act_id = 1
                   ) AS order_info_nt
                )
        FROM dual;
    l_order_info_nt order_info_nt;
BEGIN
    OPEN cur_info;
    FETCH cur_info INTO l_order_info_nt;
    CLOSE cur_info;
    FOR i IN l_order_info_nt.FIRST .. l_order_info_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('order id '||l_order_info_nt(i).order_id||' item name '||l_order_info_nt(i).item_name);
    END LOOP;
END;
/

/*OUTPUT
Statement processed.
order id 1 item name Treadmill
order id 2 item name Elliptical
order id 4 item name Bike
*/

-- USING COLLECT FOR SCALAR
SELECT CAST(COLLECT(item_name) AS items_nt)
FROM items;