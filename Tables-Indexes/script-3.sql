CREATE TABLE students_simple(
    student_id      NUMBER(10) NOT NULL,
    first_name      VARCHAR(25) NOT NULL,
    last_name       VARCHAR(25) NOT NULL,
    date_of_birth   DATE,
    city            VARCHAR(25) NULL,
    state           CHAR(2) NULL,
    status_code     VARCHAR(1) DEFAULT 'A' NOT NULL,
    CONSTRAINT pk_student_simple PRIMARY KEY (student_ID)
);

INSERT INTO students_simple(student_id, first_name)
                    VALUES( 1, 'John');
-- gives error because of not null constraint

INSERT INTO students_simple(student_id, first_name, last_name)
                    VALUES( 1, 'John', 'Smith');

SELECT * FROM students_simple;

-- empty spaces are considered as null in oracle
INSERT INTO students_simple(student_id, first_name, last_name, city, state)
                    VALUES(2, 'Sally', 'Jones', 'Los Angeles', '');

SELECT * FROM students_simple;
-- see state value as null even though we pass the empty string

-- overriding default value
INSERT INTO students_simple
(student_id, first_name, last_name, city, state, status_code) VALUES
(3, 'Robert', 'Johnson', 'Dallas', 'TX', 'G');

SELECT * FROM students_simple;