SELECT * FROM departments
WHERE UPPER(department_code) = UPPER('CS');

-- running with creating index
CREATE INDEXE fx_departments_dept_code
ON departments 
(UPPER(department_code)));

SELECT * FROM departments
WHERE UPPER(department_code) = UPPER('CS');
