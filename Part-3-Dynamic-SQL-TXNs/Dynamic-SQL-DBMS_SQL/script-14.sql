-- Executing DML Statements

CREATE OR REPLACE PROCEDURE insert_record(p_table_name VARCHAR2,
                                          p_col1_name  VARCHAR2,
                                          p_col1_value NUMBER,
                                          p_col2_name  VARCHAR2,
                                          p_col2_value NUMBER) IS
                                          
        l_sql        VARCHAR2(100);
        l_cursor_id  INTEGER;
        l_return     INTEGER;
    BEGIN
        l_sql := 'INSERT INTO '||p_table_name||'('||
                  p_col1_name||','||
                  p_col2_name||') '||
                  'VALUES(:col1_value,:col2_value');
        l_cursor_id := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(l_cursor_id, l_sql, DBMS_SQL.NATIVE);
        DBMS_SQL.BIND_VARIABLE(l_cursor_id,':col1_value',p_col1_value);
        DBMS_SQL.BIND_VARIABLE(l_cursor_id,':col2_value',p_col2_value);
        l_return := DBMS_SQL.EXECUTE(l_cursor_id);
        DBMS_OUTPUT.PUT_LINE('Rows Processed'|| l_return);
        DBMS_SQL.CLOSE_CURSOR(l_cursor_id);
        COMMIT;
    END insert_record;
/













-- Returning Into Clause

DECLARE
    l_item_value      items.item_value%TYPE := 100;
    l_item_id         items.item_id%TYPE    := 1;
    l_item_name       items.item_name%TYPE :='Maximum Item Length Name';
  
    l_sql       VARCHAR2(200);
    l_cursor_id INTEGER;
    l_return    INTEGER;
BEGIN
    l_sql := 'UPDATE items SET item_value = :p_item_val'||
             'WHERE item_id = :p_item_id RETURNING item_name INTO :l_name';
    l_cursor_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(l_cursor_id, l_sql, DBMS_SQL.NATIVE);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':p_item_val', l_item_value);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':p_item_id', l_item_id);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':l_name', l_item_name, 60);
    l_return := DBMS_SQL.EXECUTE(l_cursor_id);
    DBMS_SQL.VARIABLE_VALUE(l_cursor_id,':l_name',l_item_name);
    DBMS_OUTPUT.PUT_LINE('Rows Processed '||l_return||'item name '|| l_item_name);
    DBMS_SQL.CLOSE_CURSOR(l_cursor_id);
    COMMIT;
END;
/
















DECLARE 
    l_act_id      accounts.act_id%TYPE := 1;
    l_act_bal     accounts.act_bal%TYPE;
    l_tier        NUMBER;
    l_out         NUMBER;
    l_sql         VARCHAR2(200);
    l_cursor_id   INTEGER;
    l_return      INTEGER;
BEGIN
    l_sql  := ' BEGIN :l_out := get_tier(:act_id, :act_bal, :tier); END; ';
    l_cursor_id := DBMS_SQL.OPEN_CURSOR;
    DBMS_SQL.PARSE(l_cursor_id, l_sql, DBMS_SQL.NATIVE);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':act_id', l_act_id);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':act_bal', l_act_bal);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':tier', l_tier);
    DBMS_SQL.BIND_VARIABLE(l_cursor_id, ':l_out', l_out);
    l_return := DBMS_SQL.EXECUTE(l_cursor_id);
    DBMS_SQL.VARIABLE_VALUE(l_cursor_id, ':act_bal', l_act_bal);
    DBMS_SQL.VARIABLE_VALUE(l_cursor_id, ':tier', l_tier);
    DBMS_SQL.VARIABLE_VALUE(l_cursor_id, ':l_out', l_out);
    DBMS_OUTPUT.PUT_LINE('Act Bal: '||l_act_bal||' Tier: '||l_tier||' l_out: '||l_out);
    DBMS_SQL.CLOSE_CURSOR(l_cursor_id);
END;
/
