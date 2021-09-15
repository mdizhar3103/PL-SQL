CREATE OR REPLACE TYPE mytype_va IS VARRAY(5) OF VARCHAR2(60);
/

DECLARE
    TYPE items_va IS VARRAY(5) OF VARCHAR2(60);
    l_items_va items_va := items_va();
    l_mytype_va mytype_va :=  mytype_va('Bike', 'Treadmill');
BEGIN
    DBMS_OUTPUT.PUT_LINE('l_items_va count is '||l_items_va.COUNT);
    DBMS_OUTPUT.PUT_LINE('l_mytype_va count is '||l_mytype_va.COUNT);
END;
/