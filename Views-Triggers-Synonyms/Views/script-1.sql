CREATE OR REPLACE VIEW computer_science_courses_view AS
SELECT c.department_code, c.course_number, c.course_title, c.credits
FROM courses c
WHERE c.department_code = 'CO';

SELECT * FROM computer_science_courses_view
WHERE department_code = 'CO';

UPDATE computer_science_courses_view
SET credits = 4
WHERE department_code = 'CO';

SELECT * FROM computer_science_courses_view;

rollback;

INSERT INTO computer_science_courses_view(department_code, course_number, course_title, credits)
VALUES('CO', 103, 'Advance Data Structures', 6);

SELECT * FROM computer_science_courses_view;

-- this will not be reflected in view (but reflected in parent table guess why?)
INSERT INTO computer_science_courses_view(department_code, course_number, course_title, credits)
VALUES('CS', 103, 'Advance Data Structures', 6);

SELECT * FROM computer_science_courses_view;

DELETE FROM computer_science_courses_view
WHERE course_title='Advance Data Structures';

SELECT * FROM computer_science_courses_view;

