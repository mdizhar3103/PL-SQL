SELECT * FROM account_orders WHERE act_id=1;

BEGIN
    INSERT INTO TABLE(SELECT orderslist FROM account_orders WHERE act_id = 1)
                VALUES(3, 3);
    COMMIT;
END;
/

SELECT * FROM account_orders WHERE act_id = 1;

BEGIN
    UPDATE TABLE(SELECT orderslist FROM account_orders WHERE act_id = 1)
    SET order_id = 4, order_item_id = 4
    WHERE order_id = 3 AND order_item_id = 3;
    COMMIT;
END;
/

BEGIN
    UPDATE TABLE(SELECT orderslist FROM account_orders WHERE act_id = 1) a
    SET VALUE(a) = order_ot(5,5)
    WHERE a.order_id = 4 AND a.order_item_id = 4;
    COMMIT;
END;
/

BEGIN
    DELETE FROM TABLE(SELECT orderslist FROM account_orders WHERE act_id = 1) a
    WHERE a.order_id = 5;
    COMMIT;
END;
/



