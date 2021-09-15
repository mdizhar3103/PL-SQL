-- Nesting Associative Array to Another Associative Array

DECLARE
    TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    TYPE orders_rec IS RECORD(order_id NUMBER, items items_aa);
    TYPE orders_aa IS TABLE OF orders_rec INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
    l_orders_aa orders_aa;
BEGIN
    l_items_aa(1)           := 'Bike';
    l_items_aa(2)           := 'Treadmill';
    l_orders_aa(1).order_id := 1;
    l_orders_aa(1).items    := l_items_aa;
    l_items_aa(1)           := 'Weights';
    l_items_aa(2)           := 'Elliptical';
    l_orders_aa(2).order_id := 2;
    l_orders_aa(2).items    := l_items_aa;
    
    -- Access 2nd element of the items collection from the first orders
    DBMS_OUTPUT.PUT_LINE('First order''s 2nd item is '|| l_orders_aa(1).items(2));

    -- Replace 2nd element of the items collection from the first order
    l_orders_aa(1).items(2) := 'Weights';
    DBMS_OUTPUT.PUT_LINE('First order''s 2nd item is '|| l_orders_aa(1).items(2));

    -- Add a third items to second order
    l_orders_aa(2).items(3) := 'Swing';
    DBMS_OUTPUT.PUT_LINE('Count of items for the second order is '|| l_orders_aa(2).items.COUNT);

    -- Remove the second item of the second order
    l_orders_aa(2).items.DELETE(2);
    DBMS_OUTPUT.PUT_LINE('Count of items for the second order is '|| l_orders_aa(2).items.COUNT);
END;
/

/*OUTPUT
Statement processed.
First order's 2nd item is Treadmill
First order's 2nd item is Weights
Cost of items for the second order is 3
Cost of items for the second order is 2
*/

