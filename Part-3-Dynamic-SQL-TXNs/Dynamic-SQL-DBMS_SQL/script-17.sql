-- Unknown Number of columns

CREATE OR REPLACE FUNCTION desc_columns(
            p_query              VARCHAR2,
            p_cursor_id   IN OUT INTEGER,
            p_desc_tab2   IN OUT DBMS_SQL.DESC_TAB2)
        RETURN NUMBER AUTHID DEFINER IS
         l_no_of_columns NUMBER;
         l_desc_rec2 DBMS_SQL.DESC_REC2;
    BEGIN
        p_cursor_id := DBMS_SQL.OPEN_CURSOR;
        SYS.DBMS_SQL.PARSE(p_cursor_id, p_query, DBMS_SQL.NATIVE);
        DBMS_SQL.DESCRIBE_COLUMNS2(p_cursor_id, l_no_of_columns, p_desc_tab2);
        -- Define columns
        FOR i IN 1..l_no_of_columns
        LOOP
           l_desc_rec2 := p_desc_tab2(i);
           DBMS_OUTPUT.PUT_LINE('Column Name '||l_desc_rec2.col_name||' Column Type '||l_desc_rec2.col_type);
        END LOOP;
        RETURN l_no_of_columns;
    END desc_columns;
/
    
DECLARE 
    l_cursor_id     INTEGER;
    l_desc_tab2     DBMS_SQL.DESC_TAB2;
    l_no_of_columns NUMBER;
BEGIN
    l_no_of_columns := desc_columns('SELECT order_act_id, item_name FROM orders, items WHERE order_item_id = item_id',
    l_cursor_id,
    l_desc_tab2);
END;
/

-- Statement processed.
-- Column Name ORDER_ACT_ID Column Type 2
-- Column Name ITEM_NAME Column Type 1

