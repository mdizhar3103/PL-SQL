## Tables and Indexes Basics
**Naming Rules for Objects**
- Objects are complete refrence to Tables, Indexes, Functions, Procedures, Views, Synonyms, Sequences, Triggers, Types, etc.
- Maximum length 30 characters for all objects
- Names must be unique within schema or tables
- SQL reserved words avoid
- Allowable characters for naming are:
    - Alphanumeric characters 
    - Underscore character
    - $ and # characters 

> See script-1.sql
> Working with quotes naming
> See script-2.sql

**Column Definition Rules**
- Maximum of 1000 columns per table
- Over 255 columns result in row chaining
- 30 characters maximum for column naming
- Must be unique in table
- Names can be reused in different table
- Name and datatype must be specified
- NULL and an default clause are optional

> See script-3.sql

**Virtual Columns**
- Introduced in oracle 11g
- __Normal column:__ Data is physically stored on disk by oracle
- __Virtual column:__ 
    - Value is computed from other columns in the table
    - Cannot INSERT into or UPDATE virtual columns
    - Can only make use of columns in same table
    - Indexes can be created over virtual column values

> See script-4.sql

---

## Table Constraints
- Primary key
- Foreign key
- Check constraint

**Primary Key**
Uniquely identify each row
- Natural Key: Combinaion of naturally occuring columns that form as unique key
- Surrogate Key: A unique value is generated for each row.

Syntax for creating:
```
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
    CONSTRAINT pk_courses PRIMARY KEY (department_code, course_number)
);


ALTER TABLE courses CONSTRAINT pk_courses PRIMARY KEY (department_code, course_number);

```
*Note: Generally CONSTRAINT keyword is optional is we dont specify it oracle will generate for us and name starts with prefix sys_[number]*

> Primary Key Recommendations:
> Every table should have a primary key defined
> Values of primary key should be immutable

*ROWID*
- Represents the address of the row in the table
- Dont use as primary key 

**Foreign key**
- It's refrential integerity constraint
- Its kind of primary key in referenced table

```
CREATE TABLE courses (
    department_code       VARCHAR2(2)     NOT NULL,
    course_number         NUMBER(3,0)     NOT NULL,
    course_title          VARCHAR2(64)    NOT NULL,
    course_description    VARCHAR2(512)   NOT NULL,
    credits               NUMBER(3,1)     NOT NULL,
    CONSTRAINT pk_courses PRIMARY KEY (department_code, course_number),
    CONSTRAINT fk_courses_department_code FOREIGN KEY (department_code) REFERENCES departments(department_code)
);

ALTER TABLE courses
CONSTRAINT fk_courses_department_code 
ADD FOREIGN KEY (department_code)
REFERENCES departments (department_code);
```
> See script-5.sql

**On Delete Cascade**
- Using this option if we delete the primary key in parent table it will also delete its values in child table
- Using without this option will require to first delete from child table and then from the parent table

```
CREATE TABLE courses (
    department_code       VARCHAR2(2)     NOT NULL,
    course_number         NUMBER(3,0)     NOT NULL,
    course_title          VARCHAR2(64)    NOT NULL,
    course_description    VARCHAR2(512)   NOT NULL,
    credits               NUMBER(3,1)     NOT NULL,
    CONSTRAINT pk_courses PRIMARY KEY (department_code, course_number),
    CONSTRAINT fk_courses_department_code FOREIGN KEY (department_code) REFERENCES departments(department_code) ON DELETE CASCADE
);

```
*prefer To delete a primary key value, no child records can exist*

**Deferred Constraints**
```
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
```
__Using a Deferred Constraint__
```
set constraint fk_courses_departmen_code deferred;

UPDATE departments SET department_code = 'CO'
WHERE department_code = 'CS';

UPDATE courses SET department_code = 'CO'
WHERE department_code = 'CS';

COMMIT;
```
This will make the the statement deferre till transaction is complete.

> See script-6.sql

**Check Constraints**
- Check that a value is wihtin given range
- Compare two values in different columns
- Validate the format of a value using regex
- Check constraints are useful in enforcing integrity rules
***Check value within range***
```
CREATE TABLE courses (
    department_code       VARCHAR2(2)     NOT NULL,
    course_number         NUMBER(3,0)     NOT NULL,
    course_title          VARCHAR2(64)    NOT NULL,
    credits               NUMBER(3,1)     NOT NULL,
    CONSTRAINT pk_courses PRIMARY KEY (department_code, course_number),
    CONSTRAINT fk_courses_department_code FOREIGN KEY (department_code) REFERENCES departments(department_code),
    CONSTRAINT ck_courses_course_number 
    CHECK (course_number BETWEEN 100 AND 999)
);
```
***Check value within a domain***
```
CREATE TABLE states(
    state_code        VARCHAR2(2)     NOT NULL,
    state_name        VARCHAR2(30)    NOT NULL,
    region            VARCHAR2(2)     NOT NULL,
    CONSTRAINT pk_states PRIMARY KEY (state_code),
    CONSTRAINT ck_states_regions
    CHECK (region IN ('NE', 'SE', 'MW', 'SC', 'NW','SW'))
);
```
***Emulate a boolean column***
```
CREATE TABLE students(
    student_id        NUMBER(2)       NOT NULL,
    first_name        VARCHAR2(30)    NOT NULL,
    last_name         VARCHAR2(30)    NOT NULL,
    email_address     VARCHAR2(128)   NOT NULL,
    likes_ice_cream   NUMBER(1)       NULL,
    CONSTRAINT pk_studentS PRIMARY KEY (student_id),
    CONSTRAINT ck_studentS_ice_cream
    CHECK (likes_ice_cream IN (0,1))
);

```
***Comparing two values***
```
CREATE TABLE orders(
    order_id        NUMBER(9)    NOT NULL,
    customer_id     NUMBER(6)    NOT NULL,
    order_date      DATE         NOT NULL,
    ship_date       DATE  NOT NULL,
    order_status   NUMBER(1)       NULL,
    CONSTRAINT pk_orders PRIMARY KEY (order_id),
    CONSTRAINT ck_orders_order_ship_date
    CHECK (ship_date > order_date)
);

```
***Validate format using Regex***
```
CREATE TABLE zip_Codes(
    zip_code       VARCHAR2(5)    NOT NULL,
    city           VARCHAR2(30)   NOT NULL,
    state_code     VARCHAR2(30)   NOT NULL,
    CONSTRAINT pk_codes PRIMARY KEY (zip_code),
    CONSTRAINT ck_zip_code_format
    CHECK (REGEXP_LIKE(zip_code, '^[0-9]{5}$'))
);
```
***Adding Constraints to an existing table***
```
ALTER TABLE zip_codes
ADD CONSTRAINT ck_zip_code_format
CHECK (REGEXP_LIKE(zip_code, '^[0-9]{5}$'));
```
**Disabling and Enable Constraints**
```
ALTER TABLE courses
DISABLE CONSTRAINT fk_courses_department_code;

ALTER TABLE courses
ENABLE CONSTRAINT fk_courses_department_code;
```
------

## Table Storage Options
See folder Table-Storage

---

## Managing Table
See folder Table-Manage

---
