-- open two session
-- open one session in sqlplus terminal if possible
-- another in sql developer

CREATE GLOBAL TEMPORARY TABLE temporary_courses(
    department_code   VARCHAR2(2)  NOT NULL,
    course_number     NUMBER(3)    NOT NULL,
    course_title      VARCHAR2(64) NOT NULL,
    CONSTRAINT  pk_temp_courses PRIMARY KEY (
        department_code, course_number
    )
);

-- sql plus terminal session
DESC temporary_courses;

-- sql developer session
INSERT INTO temporary_courses
    (department_code, course_number, course_title)
    SELECT department_code, course_number, course_title
    FROM courses
    WHERE department_code = 'CO';

SELECT * FROM temporary_courses;

-- running the select query from sqlplus session
SELECT * FROM temporary_courses;
-- OUTPUT: no rows found
-- inserting different data from sqlplus session
INSERT INTO temporary_courses
    (department_code, course_number, course_title)
    SELECT department_code, course_number, course_title
    FROM courses
    WHERE department_code = 'PH';

-- see the results in both session using select query
SELECT * FROM temporary_courses;
-- we will only see session independent inserted values


-- 
-- Note: We didn't  specified any option on table so as we know 
-- default behaviour of temporary table on commit is delete rows
-- 

COMMIT;
SELECT * FROM temporary_courses;
