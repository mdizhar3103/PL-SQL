-- script-5.sql create courses and departments table

CREATE OR REPLACE VIEW v_Computer_science_courses AS
    SELECT d.department_name, d.department_code, 
           c.course_number, c.course_title, c.credits
    FROM departments d
    INNER JOIN courses c
    ON d.department_code = c.department_code
    WHERE c.department_code = 'CO';


SELECT * FROM v_Computer_science_courses;

RENAME departments to dept;

SELECT * FROM departments;
SELECT * FROM dept;

-- NOW LETS CHECK FROM VIEW 
SELECT * FROM v_Computer_science_courses;

-- check the data dictionary 
SELECT * FROM user_objects;
-- see the view become invalid
SELECT * FROM user_objects WHERE object_type = 'VIEW' AND status = 'INVALID';

-- Now rename the table in view and re run the above view again
-- then rerun the user_object query to see it becomes valid


-- Renaming the column in table
RENAME COLUMN department_name TO dept_name;

-- Adding columns to table
ALTER TABLE students ADD (
    immunization_form_received  VARCHAR2(1) DEFAULT 'N' NOT NULL,
    immunization_form_date      DATE        NULL
);

-- making column invisible
ALTER TABLE courses ADD(
    textbook_name    VARCHAR2(50) INVISIBLE NULL
);

-- Dropping Column
/*

1. Physical Delete of Column:
    - Views procedure will be invalidated, manually fix these
    - Oracle will update each block in table 
    - ALTER TABLE table_name DROP COLUMN (column_name1, column_name2);

2. Logical Delete of Column
    - ALTER TABLE table_name SET UNUSED (column_name1, column_name2);
    - ALTER TABLE table_name DROP UNUSED COLUMNS;
    - Logically deleted columns can't be recovered    
    - Provied ability to defer physical update of block
    - In case of relationship table:
        ALTER TABLE table_name SET UNUSED (column_name1, column_name2)
        CASCADE CONSTRAINTS;
*/


-- Changing Datatype of columns
ALTER TABLE table_name MODIFY(
    column_name new_data_type
);
