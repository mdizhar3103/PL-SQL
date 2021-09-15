DECLARE
    l_sales_amt NUMBER := 10000;
    l_commission NUMBER := 0;
BEGIN
    IF l_sales_amt > 50000 THEN
        l_commission := 10;
    ELSIF (l_sales_amt < 30000) AND (l_sales_amt > 20000) THEN
        l_commission := 5;
    ELSE
        l_commission := 2;
    END IF;
    DBMS_OUTPUT.PUT_LINE(l_commission);
END;
