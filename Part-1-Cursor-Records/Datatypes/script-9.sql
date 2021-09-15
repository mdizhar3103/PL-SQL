create table departments (dept_id number not null primary key, dept_name varchar2(60));
 
DECLARE
    TYPE emp_rec IS RECORD (emp_name varchar(60),
                            dept_id departments.dept_id%TYPE,
                            loc varchar2(10) DEFAULT 'CA');
    l_emprec emp_rec;
BEGIN
    l_emprec.emp_name := 'John';
    l_emprec.dept_id := 10;
    dbms_output.put_line('Employee Name: ' || l_emprec.emp_name);
    dbms_output.put_line('Employee Name: ' || l_emprec.dept_id);
    dbms_output.put_line('Employee Name: ' || l_emprec.loc);
END;
-- Script - 10 %ROWTYPE
    -- record based on Table, View, Cursor
    
DECLARE
    l_dept_rec departments%ROWTYPE;
BEGIN
    l_dept_rec.dept_id := 10;
    dbms_output.put_line('Department Id is: ' || l_dept_rec.dept_id);
END;
