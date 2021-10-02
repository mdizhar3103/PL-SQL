-- Create the directory object
CREATE DIRECTORY data_import AS
'C:\Users\dfbfd\dffdb\PL-SQL\Tables-Indexes\Tables-Types\';

-- Grant persmission so that user can use
GRANT READ ON DIRECTORY data_import TO izhar;

CREATE TABLE prospective_student_import_fw(
    first_name      VARCHAR2(50),
    last_name       VARCHAR2(50),
    street_address  VARCHAR2(50),
    city            VARCHAR2(30),
    state           VARCHAR2(2),
    email_address   VARCHAR2(50),
    date_of_birth   DATE,
    gpa             NUMBER(3,2)
)
ORGANIZATION EXTERNAL
(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY data_import
    ACCESS PARAMETERS
    (
        RECORDS DELIMITED BY NEWLINE
        LOGFILE data_import:'prospective_students_fw.log'
        BADFILE data_import:'prospective_students_fw.bad'
        SKIP 0
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
        MISSING FIELD VALUES ARE NULL
        REJECT ROWS WITH ALL NULL FIELDS
        (
            first_name,
            middle_init,
            last_name,
            street_address,
            city,
            state,
            email_address,
            date_of_birth DATE "MM/DD/YYYY",
            gpa
        )
    )
    LOCATION ('student.csv')
)
REJECT LIMIT UNLIMITED;

SELECT * FROM prospective_student_import_fw;

DROP TABLE prospective_student_import_fw;
DROP DIRECTORY data_import;