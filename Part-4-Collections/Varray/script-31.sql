CREATE OR REPLACE TYPE items_va AS VARRAY(5) OF VARCHAR2(60);
/

CREATE TYPE orders_ot AS OBJECT(order_id NUMBER, orders_item_id NUMBER);
/

CREATE OR REPLACE TYPE orders_va IS VARRAY(5) OF orders_ot;
/

CREATE TABLE act_orders(
    act_id NUMBER,
    act_month VARCHAR2(8),
    itemslist  items_va   DEFAULT items_va(),
    orderslist orders_va DEFAULT orders_va());


DECLARE
    l_items_va  items_va := items_va();
    l_orders_va orders_va := orders_va();
    l_orders_ot orders_ot := orders_ot(1, 1);

BEGIN
    l_items_va.EXTEND(2);
    l_items_va(1) := 'Bike';
    l_items_va(2) := 'Treadmill';

    l_orders_va.EXTEND(2);
    l_orders_va(1) := l_orders_ot;
    l_orders_va(2) := orders_ot(2, 2);

    INSERT INTO act_orders(act_id, act_month, itemslist, orderslist)
    VALUES(1, 'JANUARY', l_items_va, l_orders_va);
    COMMIT;
END;
/

SELECT * FROM act_orders;


-- updating 
DECLARE
    l_items_va  items_va := items_va();
    l_orders_va orders_va := orders_va();
    l_orders_ot orders_ot := orders_ot(1, 1);

BEGIN
    l_items_va.EXTEND(1);
    l_items_va(1) := 'Elliptical';

    l_orders_va.EXTEND(2);
    l_orders_va(1) := l_orders_ot;
    l_orders_va(2) := orders_ot(2, 2);

    UPDATE act_orders SET itemslist = l_items_va, orderslist = l_orders_va
    WHERE act_id = 1
    AND act_month = 'JANUARY';
    COMMIT;
END;
/

SELECT * FROM act_orders;

-- DELETING
BEGIN
    DELETE FROM act_orders ;
    COMMIT;
END;
/

SELECT * FROM act_orders;

-- Refer to doc for more info