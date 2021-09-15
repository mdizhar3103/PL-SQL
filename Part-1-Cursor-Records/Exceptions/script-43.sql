-- User Defined Exception

DECLARE
    inavlid_quantity EXCEPTION;
    l_order_qty NUMBER := -2;
BEGIN
    IF l_order_qty < 0 THEN
        RAISE inavlid_quantity;
    END IF;
EXCEPTION
    WHEN inavlid_quantity THEN
        DBMS_OUTPUT.PUT_LINE('INVALID QUANTITY');
        DBMS_OUTPUT.PUT_LINE('SQLCODE: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('SQLERRM: ' || SQLERRM);
END;
