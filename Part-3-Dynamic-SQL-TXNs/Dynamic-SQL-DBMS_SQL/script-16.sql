-- Executing Select Statements

-- Running with the error previous script. (putting an extra comma in the select statement)

DECLARE 
    l_item_id    items.item_id%TYPE;
    l_item_name  items.item_name%TYPE;
    l_value      items.item_value%TYPE  := 50;
    l_sql        VARCHAR2(200);
    l_cursor_id  INTEGER;
    l_return     INTEGER;
    l_errpos     NUMBER;
  
BEGIN
    l_sql := ' SELECT item_id, item_name, FROM items WHERE item_value > :p_value ';
    l_cursor_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(l_cursor_id, l_sql, DBMS_SQL.NATIVE);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':p_value', l_value);
    DBMS_SQL.DEFINE_COLUMN(l_cursor_id, 1, l_item_id);
    DBMS_SQL.DEFINE_COLUMN(l_cursor_id, 2, l_item_name, 60);
    l_return := DBMS_SQL.EXECUTE(l_cursor_id);
    LOOP
        IF DBMS_SQL.FETCH_ROWS(l_cursor_id) = 0 THEN
            EXIT;
        END IF;
        DBMS_SQL.COLUMN_VALUE(l_cursor_id, 1, l_item_id);
        DBMS_SQL.COLUMN_VALUE(l_cursor_id, 2, l_item_name);
        DBMS_OUTPUT.PUT_LINE('Item Id: '||l_item_id||' Item name: '||l_item_name);
    END LOOP;
    DBMS_SQL.CLOSE_CURSOR(l_cursor_id);
EXCEPTION
WHEN OTHERS THEN
    l_errpos := DBMS_SQL.LAST_ERROR_POSITION;
    DBMS_OUTPUT.PUT_LINE(SQLERRM || ' at pos ' || l_errpos);
    DBMS_SQL.CLOSE_CURSOR(l_cursor_id);
END;
/




DBMS_SQL.DESCRIBE_COLUMNS(c       IN INTEGER,
                             col_cnt OUT INTEGER,
                             desc_t  OUT DESC_TAB);

-- THE ABOVE IS REPLACE WITH THIS
DBMS_SQL.DESCRIBE_COLUMNS2(c       IN INTEGER,
                             col_cnt OUT INTEGER,
                             desc_t  OUT DESC_TAB2);
                             
                             
DBMS_SQL.DESCRIBE_COLUMNS3(c       IN INTEGER,
                             col_cnt OUT INTEGER,
                             desc_t  OUT DESC_TAB3);
-- 2 AND 3 gives output in associative form

TYPE desc_tab IS TABLE OF desc_rec INDEX BY BINARY_INTEGER;
TYPE desc_tab2 IS TABLE OF desc_rec2 INDEX BY BINARY_INTEGER;
TYPE desc_tab3 IS TABLE OF desc_rec3 INDEX BY BINARY_INTEGER;

DESC_REC (schema)

TYPE dec_rec IS RECORD(
col_type             binary_integer :=0,
col_max_len          binary_integer :=0,
col_name             varchar2(32) := ",
col_name_len         binary_integer :=0,
col_schema_name      varchar2(32) := ",
col_schema_name_len  binary_integer :=0,
col_precision        binary_integer :=0,
col_scale            binary_integer :=0,
col_charsetid        binary_integer :=0,
col_charsetform      binary_integer :=0,
col_null_ok          boolean := TRUE
);

use desc_rec2 because it has varchar2(32767);
desc_rec3 has two additional columns as:

col_type_name     varchar2(32767) := ",
col_type_name_len binary_integer :=0);
