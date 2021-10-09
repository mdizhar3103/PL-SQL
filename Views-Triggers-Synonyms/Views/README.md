**What is view?**
- A view act as a virtual table, logically representing data from one or more tables
- A select statement defines what data will be availaible in the view
- View can contain data that is joined together from multiple tables, filter using a where clause pr summarized using ad aggregate function
- Only selected columns or rows can be exposed in a view

*Creating View*
```
CREATE OR REPLACE VIEW compsci_degree_requirements AS
SELECT d.department_code, c.course_number,
       c.course_title AS course_name,
       c.credits
FROM degrees d
INNER JOIN degree_requirements r
ON d.degree_id = r._degree_id
INNER JOIN courses c 
ON r.department_code = c.department_code
AND r.course_number = c.course_number
WHERE
d.department_code = 'CS' 
AND d.degree_type_code = 'BS';
```

**Read Only View**
```
CREATE OR REPLACE VIEW <table_name> AS
SELECT statement...
WITH READ ONLY;
```

**DML Against View**
- Allowed in some select situations
- Can't be used against a view that contains:
    - DISTINCT keyword
    - Aggregate or analytic function
    - GROUP BY, ORDER BY, CONNECT BY OR STARTS WITH clause
    - A subquery value as a column

> See script-1.sql

**View Using with Check Options**
```
CREATE OR REPLACE VIEW <view_name>
SELECT statement
..
WITH CHECK OPTION;
```
> Rows affected by a DML statement must still meet the criteria of the view

