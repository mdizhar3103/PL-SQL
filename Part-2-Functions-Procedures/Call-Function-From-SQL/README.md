### Function call from SQL

- Increase Efficiency of SQL
- Extends SQL
- Parallel Query Execution

Used as List query, where, having condition, values as in insert statement, set clause in update statement, group by, order by connecting by/start with
**Inbuilt function use**
```
SELECT UPPER('test') FROM dual;
```
**User-defined function**
```
SELECT emp_id, get_dept_name(emp_dept_id) FROM employee;
INSERT INTO employee(emp_id, emp_name, emp_dept_id) VALUES (5, 'John', get_dept_id('IT'));

UPDATE employee SET emp_dept_id = get_dept_id('IT') WHERE emp_id = 10;

SELECT count(*), get_dept_name(emp_dept_id), FROM employee GROUP BY get_dept_name(emp_dept_id);
```
*See script-16.sql*
