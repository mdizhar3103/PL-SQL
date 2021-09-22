SELECT TO_CHAR(SYSDATE, 'HH24') FROM DUAL;

CREATE OR REPLACE TRIGGER instead_of_create_schemaname
    INSTEAD OF CREATE ON SCHEMA
    WHEN (ORA_DICT_OBJ_TYPE = 'TABLE')
DECLARE
    l_sql_text_lines ORA_NAME_LIST_T;
    l_lines PLS_INTEGER;
    l_sql_stat VARCHAR2(2000);
BEGIN
    IF TO_CHAR(SYSDATE, 'HH24') < 12 THEN
        l_lines := ORA_SQL_TEXT(l_sql_text_lines);
        FOR i IN 1..l_lines LOOP
            l_sql_stat := l_sql_stat || l_sql_text_lines(i);
        END LOOP;
    DBMS_OUTPUT.PUT_LINE('Statement is '||l_sql_stmt);
    RAISE_APPLICATION_ERROR(-20000, 'NOT ALLOWED');
    END IF;
END instead_of_create_schemaname;
/

CREATE TABLE schemaname(a NUMBER);
