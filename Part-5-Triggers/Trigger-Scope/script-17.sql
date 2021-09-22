CREATE OR REPLACE TRIGGER after_logon_db
    AFTER LOGON
    ON DATABASE
BEGIN
    IF ora_login_user = 'USERNAME' THEN
        execute immediate 'alter session set plsql_warnings=''ENABLE:ALL''';
    END IF;
EXCEPTION
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

-- LOGOUT AND LOGIN WITH THE USER
-- RE RUN SCRIPT-16.SQL