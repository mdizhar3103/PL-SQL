-- DEBUGGING

BEGIN
    DBMS_OUTPUT.PUT('This is partial line.');
    DBMS_OUTPUT.PUT_LINE('This is another partial line.');
    DBMS_OUTPUT.NEW_LINE;
END;
