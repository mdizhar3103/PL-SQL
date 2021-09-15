Create Objects:

CREATE OR REPLACE PROCEDURE create_table(p_table_name VARCHAR2, 
                                         p_table_columns VARCHAR2) IS
    BEGIN
        EXECUTE IMMEDIATE 'CREATE TABLE'||p_table_name||p_table_columns;
    END create_table;
/

EXEC create_table('ORDERS_QUEUE_CA', 
                  '(queue_id NUMBER, queue_act_id NUMBER, queue_item_id NUMBER)'
                  );

CREATE OR REPLACE PROCEDURE create_table(p_table_name VARCHAR2, 
                                         p_table_columns VARCHAR2) IS
        l_sql VARCHAR2(400);
    BEGIN
        l_sql := 'CREATE TABLE '||p_table_name||p_table_columns;
        DBMS_OUTPUT.PUT_LINE('SQL is '||l_sql);
        EXECUTE IMMEDIATE l_sql;
    END create_table;
/
EXEC create_table('ORDERS_QUEUE_CA', '(queue_id NUMBER, queue_act_id NUMBER, queue_item_id NUMBER)');
-- the above exec fails because of user priveleges

SELECT USER FROM dual;
GRANT CREATE TABLE TO APEX_PUBLIC_USER;
                  
DESC ORDERS_QUEUE_CA;
