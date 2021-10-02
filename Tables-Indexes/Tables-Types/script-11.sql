-- Note: demonstration will be much helpful if we have 1000's of records in a table

select * from courses where department_code = 'CO';

-- creating non unique index
CREATE INDEX ix_courses_cnumber 
ON courses(course_number);

select * from courses where department_code = 'CO';

