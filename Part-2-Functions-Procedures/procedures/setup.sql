-- Procedures
/*
Performing a task in certain order.
It is Named Program Unit in oracle DB
It performs Unit of Work.
Doesn't Return Anything.
*/

-- Setup

CREATE TABLE departments (dept_id NUMBER NOT NULL PRIMARY KEY,
                          dept_name VARCHAR2(60));

CREATE TABLE employee (emp_id NUMBER NOT NULL PRIMARY KEY,
                       emp_name VARCHAR2(60),
                       emp_dept_id NUMBER,
                       emp_loc VARCHAR2(2),
                       emp_sal NUMBER,
                       emp_status VARCHAR2(1),
                       CONSTRAINT empt_dept_fk FOREIGN KEY(emp_dept_id)
                       REFERENCES departments(dept_id));


/* Privileges:
CREATE PROCEDURE
CREATE ANY PROCEDURE
ALTER ANY PROCEDURE
EXECUTE 
*/

GRANT CREATE PROCEDURE TO <user_name>;
GRANT CREATE ANY PROCEDURE TO <user_name>;
GRANT ALTER ANY PROCEDURE TO <user_name>;

GRANT EXECUTE ON <schema_name>.<procedure_name> TO <user_name>;

-- Defining Procedures
/*
CREATE [OR REPLACE] PROCEDURE [schema_name].<procedure_name> IS | AS 
 <declaration_section>
BEGIN
  STATEMENTS;  
[EXCEPTION]
END [<procedure_name>]; */
