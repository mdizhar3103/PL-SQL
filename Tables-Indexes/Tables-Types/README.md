## Specialized Table Types in Oracle
**Temporary Tables**
- Defined statically
- Table definition availables to all session
- Data is private to a session
- Act as a private workspace

Syntax for creating temporary table
```
CREATE GLOBAL TEMPORARY TABLE temporary_courses (
    department_code     VARCHAR2(2)   NOT NULL,
    course_number       NUMBER(3, 0)  NOT NULL,
    course_title        VARCHAR2(64)  NOT NULL,
    course_description  VARCHAR2(512) NOT NULL,
    credits             NUMBER(3,1)   NOT NULL,
    CONSTRAINT pk_courses PRIMARY KEY (
        department_code, course_number
    )
)
ON COMMIT DELETE ROWS
-- ON COMMIT PRESERVE ROWS;

Note: on commit delete rows option is default also,
      on commit preserve rows will delete data when session ends.
```
> Important Points:
> Temporary tables can't participate in foreign key relationship
> Indexes can be created on temporary table
> Temporary tables do not have any statistics by default
> Database stats are per session starting in Oracle 12c
> See script-9.sql

----
**External Tables**
- Common need: importing a flat file
- Allow flat file data to be processed by SQL
- Data can be filtered, joined, or inserted into other tables
- Properties of external tables:
    - Only used for importing data into oracle, not for exporting data (out of oracle)
    - Import both fixed width and delimited files
    - Files must be located on the oracle server
- To use external table we need __Directory Objects__ defined in oracle
    - Directory objects tell oracle where to find data on the server, and permission to do.
    - Steps to create a Data Directory
        1. Create a Directory in operating system
        2. Assign operating system permissions
        3. Create directory object in Oracle
        4. Give Oracle users read access to the directory object

```
<!-- Create the directory object -->
CREATE DIRECTORY data_import AS
 'path of operating system';

<!-- Grant permission so user can use -->
GRANT READ ON DIRECTORY data_import
TO <user>;
```
> Create one directory per schema/application this will protect sensitive data, clean separation between applications

> See script-10.sql

---

### Indexes
> See indexes.md