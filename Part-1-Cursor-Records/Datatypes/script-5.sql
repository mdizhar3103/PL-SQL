-- Script - 5 %TYPE - Anchored Type, Previously declared Variable
 
CREATE TABLE departments
(dept_id NUMBER NOT NULL PRIMARY KEY,
dept_name VARCHAR2(60));
 
DECLARE
    l_num NUMBER(5, 2) NOT NULL DEFAULT 2.21;
    l_num_vartype l_num%TYPE := 1.123;
    l_num_coltype departments.dept_id%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('l_num vartype assigned value 1.123 Final value: '|| l_num_vartype);
    DBMS_OUTPUT.PUT_LINE('l_num_coltype not assigned any value Final value: ' || l_num_coltype);
END;
