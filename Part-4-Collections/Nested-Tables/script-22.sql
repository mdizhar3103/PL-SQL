CREATE OR REPLACE TYPE items_nt AS TABLE OF VARCHAR2(60);
/

DESC ITEMS_NT;

CREATE TYPE orders_ot AS OBJECT (order_id NUMBER, order_item_id NUMBER);
/

CREATE OR REPLACE TYPE orders_nt IS TABLE OF orders_ot;
/

CREATE TABLE account_orders (
    act_id NUMBER,
    act_month VARCHAR2(8),
    itemslist  items_nt   DEFAULT items_nt(),
    orderslist orders_nt  DEFAULT orders_nt())
    NESTED TABLE itemslist STORE AS itemslist_store
    NESTED TABLE orderslist STORE AS orderslist_store;


DECLARE
    l_items_nt  items_nt := items_nt();
    l_orders_nt orders_nt := orders_nt();
    l_orders_ot orders_ot := orders_ot(1, 1);
BEGIN
    l_items_nt.EXTEND(2);
    l_items_nt(1) := 'Bike';
    l_items_nt(2) := 'Treadmill';

    l_orders_nt.EXTEND(2);
    l_orders_nt(1) := l_orders_ot;
    l_orders_nt(2) := orders_ot(2,2);

    INSERT INTO account_orders (act_id, act_month, itemslist, orderslist)
                VALUES (1, 'JANUARY', l_items_nt, l_orders_nt);
    COMMIT;
END;
/

SELECT * FROM account_orders;

INSERT INTO  
     account_orders (act_id, 
                     act_month,
                     itemslist,     
                     orderslist)  
            VALUES ( 2, 
                     'MARCH',     
                     items_nt('Weights'), 
                     orders_nt(orders_ot(5,5),orders_ot(6,6)));
COMMIT;
/


SELECT * FROM account_orders;


DECLARE
  l_items_nt      items_nt := items_nt();
  l_orders_nt    orders_nt:= orders_nt();
  l_orders_ot    orders_ot := orders_ot(1,1);
 
BEGIN
  l_items_nt.EXTEND(1); 
  l_items_nt(1) := 'Elliptical';

  l_orders_nt.EXTEND(2);
  l_orders_nt(1) := l_orders_ot;
  l_orders_nt(2) := orders_ot(3,3);
  UPDATE account_orders SET  itemslist  = l_items_nt,
                             orderslist = l_orders_nt
                       WHERE     act_id = 1
                         AND  act_month = 'JANUARY';
  COMMIT;
END;
/


SELECT * FROM account_orders
        WHERE act_id    = 1  
          AND act_month = 'JANUARY'; 


BEGIN
 DELETE FROM account_orders
        WHERE  act_id = 1
        AND        act_month =  'JANUARY';
   COMMIT;
END;
/


SELECT * FROM account_orders
        WHERE act_id    = 1  
          AND act_month = 'JANUARY';