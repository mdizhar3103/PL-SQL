CREATE OR REPLACE TYPE items_nt IS TABLE of VARCHAR2(60);
/

CREATE OR REPLACE TYPE orders_ot IS OBJECT(order_id NUMBER, items items_nt);
/

CREATE OR REPLACE TYPE orders_nt IS TABLE of orders_ot;
/

DECLARE 
    l_items_nt items_nt := items_nt();
    l_orders_nt orders_nt := orders_nt();
BEGIN
    l_items_nt.EXTEND(2);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';

    l_orders_nt.EXTEND;
    l_orders_nt(1) := orders_ot(1, l_items_nt);
    l_orders_nt.EXTEND;
    l_orders_nt(2) := orders_ot(2, items_nt('Weights', 'Elliptical'));

    -- Acessing 2nd element of the items collection from the first order
    DBMS_OUTPUT.PUT_LINE('First order''s 2nd item is '|| l_orders_nt(1).items(2));

    -- Replace 2nd element of the items collection from the first order
    l_orders_nt(1).items(2) := 'Weights';
    DBMS_OUTPUT.PUT_LINE('First order''s 2nd item is '|| l_orders_nt(1).items(2));

    -- Add a third items to second order
    l_orders_nt(2).items.EXTEND;
    l_orders_nt(2).items(3) := 'Swing';
    DBMS_OUTPUT.PUT_LINE('Count of items for the second order is '|| l_orders_nt(2).items.COUNT);

    -- Remove the second item of the second order
    l_orders_nt(2).items.DELETE(2);
    DBMS_OUTPUT.PUT_LINE('Count of items for the second order is '|| l_orders_nt(2).items.COUNT);
END;
/

/*OUTPUT
Statement processed.
First order's 2nd item is Treadmill
First order's 2nd item is Weights
Count of items for the second order is 3
Count of items for the second order is 2
*/

-- Working at schema level
CREATE TABLE monthly_orders
           (act_id NUMBER,
           act_month VARCHAR2(8),
           order_info orders_nt)
    NESTED TABLE order_info STORE AS order_store
    (NESTED TABLE items STORE AS items_store);

INSERT INTO monthly_orders
           (act_id, act_month, order_info)
    VALUES (1,'JANUARY', 
             orders_nt(
                 orders_ot(1, items_nt('Bike','Treadmill')),
                 orders_ot(2, items_nt('Weights'))
                 )
            );
    COMMIT;
/

DECLARE
    CURSOR order_info_cur IS 
        SELECT act_id, 
               order_info
        FROM monthly_orders
        WHERE act_month = 'JANUARY';
    
    l_act_id monthly_orders.act_id%TYPE;
    l_order_info orders_nt;
    l_items_nt items_nt;
BEGIN
    OPEN order_info_cur;
    FETCH order_info_cur INTO l_act_id, l_order_info;
    CLOSE order_info_cur;
    FOR i IN l_order_info.FIRST .. l_order_info.LAST LOOP
        DBMS_OUTPUT.PUT_LINE('Order id: '||l_order_info(i).order_id);
        l_items_nt := l_order_info(i).items;
        FOR j IN l_items_nt.FIRST .. l_items_nt.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('Placed Order for item id :'||l_items_nt(j));
        END LOOP;
    END LOOP;
END;
/

/*OUTPUT
Statement processed.
Order id: 1
Placed Order for item id :Bike
Placed Order for item id :Treadmill
Order id: 2
Placed Order for item id :Weights
*/