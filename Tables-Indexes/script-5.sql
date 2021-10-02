CREATE TABLE departments (
    department_code     VARCHAR2(2) NOT NULL PRIMARY KEY,
    department_name     VARCHAR2(64) NOT NULL
);


CREATE TABLE courses (
    department_code       VARCHAR2(2)     NOT NULL,
    course_number         NUMBER(3,0)     NOT NULL,
    course_title          VARCHAR2(64)    NOT NULL,
    course_description    VARCHAR2(512)   NOT NULL,
    credits               NUMBER(3,1)     NOT NULL,
    CONSTRAINT pk_courses PRIMARY KEY (department_code, course_number),
    CONSTRAINT fk_courses_department_code FOREIGN KEY (department_code) REFERENCES departments(department_code)
);

INSERT INTO departments (department_code, department_name) VALUES ('MA', 'Math');
INSERT INTO departments (department_code, department_name) VALUES ('CS', 'Computer Science');
INSERT INTO departments (department_code, department_name) VALUES ('PH', 'Physics');

-- Now trying to insert with existing primary key
INSERT INTO departments (department_code, department_name) VALUES ('MA', 'Management');
-- re run by changing the primary key as
INSERT INTO departments (department_code, department_name) VALUES ('MG', 'Management');

-- Courses insert
INSERT INTO Courses (department_code, course_number, course_title, course_description, credits) 
VALUES ('MA', '101', 'Calculas 1', 'Maths Chapter-1', 4.0);

-- Inserting with non existing primary key 
INSERT INTO Courses (department_code, course_number, course_title, course_description, credits) 
VALUES ('CH', '101', 'General Chemistry', 'Chemsitry chapter-1', 4.0);

-- lets now insert the "CH" into departments 
INSERT INTO departments (department_code,department_name)
VALUES('CH', 'Chemistry');

-- re run the course uery again


select * from departments;
select * from courses;
