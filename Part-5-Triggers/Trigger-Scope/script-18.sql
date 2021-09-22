SELECT sys_context('USERENV', 'CLIENT_IDENTIFIER') FROM DUAL;

CREATE OR REPLACE TRIGGER after_logon_schema
    AFTER LOGON
    ON schemaname.Schema
BEGIN
    DBMS_OUTPUT.PUT_LINE('hr_user');
EXCEPTION
    WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END after_logon_schema;
/
