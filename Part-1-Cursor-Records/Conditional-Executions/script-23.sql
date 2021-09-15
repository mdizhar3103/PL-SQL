-- CASE EXPRESSION Statement
 
DECLARE
    ticket_priority VARCHAR2(8) := 'HIGH';
    support_tier NUMBER;
BEGIN
    support_tier := 
    CASE ticket_priority
        WHEN 'HIGH' THEN 1
        WHEN 'MEDIUM' THEN 2
        WHEN 'LOW' THEN 3
        ELSE 0
    END ;
    DBMS_OUTPUT.PUT_LINE(ticket_priority || ' ' || support_tier);
END;
