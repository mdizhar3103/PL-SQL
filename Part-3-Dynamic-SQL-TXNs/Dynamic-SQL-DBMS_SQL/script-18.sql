--  Binding variable to select statements

CREATE OR REPLACE PROCEDURE print_results(p_query   VARCHAR2,
                                          p_key     VARCHAR2,
                                          p_value   VARCHAR2) AUTHID DEFINER IS
        l_cursor_id     INTEGER;
        l_return        INTEGER;
        l_no_of_columns INTEGER;
        l_desc_tab2     DBMS_SQL.DESC_TAB2;
        l_desc_rec2     DBMS_SQL.DESC_REC2;
        l_number        NUMBER;
        l_date          DATE;
        l_varchar2      VARCHAR2(100);
    BEGIN
        l_no_of_columns := desc_columns(p_query, l_cursor_id, l_desc_tab2);
        -- Define columns
        FOR i IN 1..l_no_of_columns
        LOOP
            l_desc_rec2  := l_desc_tab2(i);
            IF l_desc_rec2.col_type = 2 THEN 
                DBMS_SQL.DEFINE_COLUMN(l_cursor_id, i, l_number);
            ELSIF l_desc_rec2.col_type = 12 THEN
                DBMS_SQL.DEFINE_COLUMN(l_cursor_id, i, l_date);
            ELSE
                DBMS_SQL.DEFINE_COLUMN(l_cursor_id, i, l_varchar2, 100);
            END IF;
        END LOOP;
        DBMS_SQL.BIND_VARIABLE(l_cursor_id, p_key, p_value);
        l_return     :=  DBMS_SQL.EXECUTE(l_cursor_id);
        WHILE DBMS_SQL.FETCH_ROWS(l_cursor_id) > 0
        LOOP 
           FOR i IN 1..l_no_of_columns
           LOOP
               IF (l_desc_tab2(i).col_type = 1) THEN 
                    DBMS_SQL.COLUMN_VALUE(l_cursor_id, i, l_varchar2);
                    DBMS_OUTPUT.PUT_LINE('Col Name '||l_desc_tab2(i).col_name||' Value '||l_varchar2);
                ELSIF (l_desc_tab2(i).col_type = 2) THEN 
                    DBMS_SQL.COLUMN_VALUE(l_cursor_id, i, l_number);
                    DBMS_OUTPUT.PUT_LINE('Col Name '||l_desc_tab2(i).col_name||' Value '||l_number);
                ELSIF (l_desc_tab2(i).col_type = 12) THEN 
                    DBMS_SQL.COLUMN_VALUE(l_cursor_id, i, l_date);
                    DBMS_OUTPUT.PUT_LINE('Col Name '||l_desc_tab2(i).col_name||' Value '||l_date);
                END IF;
            END LOOP;
        END LOOP;
        DBMS_SQL.CLOSE_CURSOR(l_cursor_id);
END print_results;
/

EXEC print_results('SELECT item_id, item_name FROM ITEMS WHERE item_value > :pvalue',':pvalue','100');

-- Statement processed.
-- Column Name ITEM_ID Column Type 2
-- Column Name ITEM_NAME Column Type 1
-- Col Name ITEM_ID Value 1
-- Col Name ITEM_NAME Value Treadmill
-- Col Name ITEM_ID Value 2
-- Col Name ITEM_NAME Value Elliptical
-- Col Name ITEM_ID Value 3
-- Col Name ITEM_NAME Value Bike

