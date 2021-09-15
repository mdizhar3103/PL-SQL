SELECT * FROM account_orders;

SELECT a.act_id, b.column_value
FROM account_orders a, TABLE(a.itemslist) b 
WHERE a.act_id = 1;
-- OUTPUT
-- ACT_ID	COLUMN_VALUE
-- 1	Bike
-- 1	Treadmill


SELECT a.act_id, b.column_value itemname
FROM account_orders a, TABLE(a.itemslist) b;


SELECT a.act_id, 
       b.order_id,
       b.order_item_id
FROM account_orders a, TABLE(a.orderslist) b;
-- OUTPUT
-- ACT_ID	ORDER_ID	ORDER_ITEM_ID
-- 1	1	1
-- 1	2	2

-- performing outer join using + operator
SELECT a.act_id, 
       b.order_id,
       b.order_item_id
FROM account_orders a, TABLE(a.orderslist)(+) b;

