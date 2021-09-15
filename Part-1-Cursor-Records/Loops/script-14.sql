-- SQL Query For Loop
 
CREATE TABLE departments
(dept_id NUMBER NOT NULL PRIMARY KEY,
dept_name VARCHAR2(60));
 
INSERT INTO departments (dept_id, dept_name) VALUES (1, 'Sales');
INSERT INTO departments (dept_id, dept_name) VALUES (2, 'IT');
 
DECLARE
    l_dept_count NUMBER;
BEGIN
    SELECT count(*) 
    INTO l_dept_count 
    FROM departments;
    FOR l_counter in 1..l_dept_count LOOP
        DBMS_OUTPUT.PUT_LINE(' l_counter: ' || l_counter);
    END LOOP;
END;
 
 
