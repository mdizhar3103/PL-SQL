--  SEARCH CASE Statement
DECLARE
    ticket_priority VARCHAR2(8) := 'HIGH';
    support_tier NUMBER;
BEGIN
    CASE ticket_priority
        WHEN ticket_priority = 'HIGH' THEN
            support_tier := 1;
        WHEN ticket_priority = 'MEDIUM' THEN
            support_tier := 2;
        WHEN ticket_priority = 'LOW' THEN
            support_tier := 3;
        ELSE
            support_tier := 0;
    END CASE;
    DBMS_OUTPUT.PUT_LINE(ticket_priority || ' ' || support_tier);
END;
