SELECT * FROM courses;

SELECT department_code, course_number, DUMP(course_title), DUMP(credits)
FROM courses;

-- dumps the ascii value of each character in row
-- Typ=1 Len=10: 67,97,108,99,117,108,117,115,32,50