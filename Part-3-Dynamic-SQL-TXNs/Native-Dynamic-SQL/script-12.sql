CREATE OR REPLACE PROCEDURE delete_order(p_column VARCHAR2,
                                         p_value VARCHAR2) IS
        l_query VARCHAR2(200);
    BEGIN
        l_query := 'DELETE FROM orders WHERE '||p_column ||' = '||p_value;
        DBMS_OUTPUT.PUT_LINE(l_query);
        EXECUTE IMMEDIATE l_query;
        DBMS_OUTPUT.PUT_LINE('Rows Deleted: '||SQL%ROWCOUNT);
    END delete_order;
/


SELECT * FROM orders;

EXEC delete_order('order_act_id', '1');
ROLLBACK;

EXEC delete_order('order_act_id', '1 OR 1=1');
ROLLBACK;


-- PREVENTING INJECTION USING BNID VARIABLE

CREATE OR REPLACE PROCEDURE delete_order(p_column VARCHAR2,
                                         p_value VARCHAR2) IS
        l_query VARCHAR2(200);
    BEGIN
        l_query := 'DELETE FROM orders WHERE '||p_column ||' =:p_value';
        DBMS_OUTPUT.PUT_LINE(l_query);
        EXECUTE IMMEDIATE l_query USING p_value;;
        DBMS_OUTPUT.PUT_LINE('Rows Deleted: '||SQL%ROWCOUNT);
    END delete_order;
/


SELECT * FROM orders;

EXEC delete_order('order_act_id', '1');
ROLLBACK;

EXEC delete_order('order_act_id', '1 OR 1=1');
ROLLBACK;
