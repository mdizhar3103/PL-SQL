DROP TABLE Courses;

CREATE TABLE courses (
    department_code       VARCHAR2(2)     NOT NULL,
    course_number         NUMBER(3,0)     NOT NULL,
    course_title          VARCHAR2(64)    NOT NULL,
    credits               NUMBER(3,1)     NOT NULL,
    CONSTRAINT pk_courses PRIMARY KEY (department_code, course_number),
    CONSTRAINT fk_courses_department_code FOREIGN KEY (department_code) REFERENCES departments(department_code)
    DEFERRABLE INITIALLY IMMEDIATE
    -- INITIALLY DEFERRABLE
);

SELECT * FROM departments;
SELECT * FROM courses;

INSERT INTO courses (department_code, course_number, course_title, credits)
VALUES ('MA', '101', 'Calculus 1', 4);
INSERT INTO courses (department_code, course_number, course_title, credits)
VALUES ('MA', '102', 'Calculus 2', 4);
INSERT INTO courses (department_code, course_number, course_title, credits)
VALUES ('PH', '101', 'Physics 1', 4);
INSERT INTO courses (department_code, course_number, course_title, credits)
VALUES ('PH', '102', 'Physics 2', 4);
INSERT INTO courses (department_code, course_number, course_title, credits)
VALUES ('CS', '101', 'Introductory Programming', 3);
INSERT INTO courses (department_code, course_number, course_title, credits)
VALUES ('CS', '102', 'Data Structures', 3);

SELECT * FROM courses;

-- performing update
UPDATE departments
SET department_code = 'CO'
WHERE department_code = 'CS';
/*This will fail because of child entries found*/

-- since we defined the deferred 
-- we will tell oracle to hold till the transaction commits
SET CONSTRAINT fk_courses_department_code deferred;

UPDATE departments
SET department_code = 'CO'
WHERE department_code = 'CS';
/* now the query succeeds*/

SELECT * FROM courses;
SELECT * FROM departments;
/* But our work is not complete since it only updates in parent table*/

-- 
UPDATE courses
SET department_code = 'CO'
WHERE department_code = 'CS';

-- now commit the transaction
COMMIT;