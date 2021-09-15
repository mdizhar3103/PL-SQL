-- Executing DDL statement using DBMS_SQL


CREATE OR REPLACE PROCEDURE drop_table(p_table_name VARCHAR2) IS
        l_sql       VARCHAR2(100);
        l_cursor_id INTEGER;
        l_return    INTEGER;
    BEGIN
        l_sql := 'DROP TABLE '||p_table_name;
        l_cursor_id := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(l_cursor_id, l_sql, DBMS_SQL.NATIVE);
        l_return := DBMS_SQL.EXECUTE(l_cursor_id);
        DBMS_SQL.CLOSE_CURSOR(l_cursor_id);
    END drop_table;
/

CREATE TABLE temptable(a NUMBER);
DESC temptable;
EXEC drop_table('temptable');
DESC temptable;
