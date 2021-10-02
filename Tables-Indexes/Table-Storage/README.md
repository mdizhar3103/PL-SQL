## Table Storage Options
**Data Blocks**
```
    +--------------------+        +-----------------+         +------------------+
    | client application |  <==>  | Oracle Instance |  <===>  | Physical Storage |
    +--------------------+        +-----------------+         +------------------+
                            /|\                         /|\
                             |                           |
                    Application are designed        Oracle reads and write
                    with rows in mind               database blocks to disk
                                                    (2KB to 32 KB in size)                            
```
- A data block is like a shipping container
- A Block Header has:
    - Block type information: contains information about what object it stores, if block is table like (table name, etc)
    - Object assignment: only one object assignment is there in block
    - Row directory: Contains actual data
    - Free Space: Allows for update to rows

```
    +------------------+
    |  Database Block  |
    |                  |
    | +==============+ |
    | | Block Header | |
    | +--------------+ |
    | |     Row      | |
    | +--------------+ |
    | |     Row      | |
    | +--------------+ |
    | |     Row      | |
    | +--------------+ |
    | |     Row      | |
    | +--------------+ |
    | |  Free Space  | |
    | +--------------+ |
    | |     Row      | |
    | +--------------+ |
    | |     Row      | |
    | +--------------+ |
    | |              | |
    | |  Free Space  | |
    | |              | |
    | +==============+ |
    +------------------+
```
---
### How Oracle Perform Data Access

1. Full Table Scan
2. Index operation with row lookup

```
 +-------------------------+
 | TABLE                   |
 |  +===+===+===+===+      |
 |  | D | D | D | D |      |
 |  | A | A | A | A |      |
 |  | T | T | T | T |      |
 |  | A | A | A | A |....  |
 |  | B | B | B | B |      |
 |  | L | L | L | L |      |
 |  | O | O | O | O |      |
 |  | C | C | C | C |      |
 |  | K | K | K | K |      |
 |  +===+===+===+===+      |
 |                         | 
 +-------------------------+
```

**Full Table Scan**
- Oracle scans through every block in the table
- Comparable to linear search of an array
- Scan is expensive:
    - First block is searching
    - Row searching

**Index Operation and Row Lookup**
- Based on Index operation (tree like datastructure)
- Traverses the index tree to find matching keys

-------
**Tablespace Introduction**

```
                                                            +-----------+
                                   +------------+     +===> | Datafiles |
   +--------------------+          |            |    /      +-----------+
   |                    |          | Tablespace |   /
   | Tables and Indexes |          |            |  /        +-----------+
   |                    | =====>   |            | |======>  | Datafiles |
   +--------------------+          |            |  \        +-----------+
                                   |            |   \
                                   |            |    \      +-----------+
                                   +------------+     +===> | Datafiles |
                                                            +-----------+
```

- We specify the tablespace to put data and oracle takes care of putting data on disk files

**Segment Space Management**
1. __Manual Segment Space Management (MSSM)__
    - Original space management implementation in oracle
    - We are responsible for managing all parameters for space management
2. __Automatic Segment Space Management(ASSM)__
    - Introduced in oracle 9i
    - We specify value for PCTFREE
    - Oracle manages all other parameters

**Oracle Contains Mulitple Tablespace**
1. SYSTEM AND SYSAUX
    - Data about oracle instance
    - Reserved for use by Oracle
2. TEMP
    - Data in temporay tables
    - Sorts and joins that do not fit in memory
3. User Tablespaces
    - Data for your applications
    - May be one per applications, group of application
4. Default Tablespace
    - Every user has a default tablespace
    - Some objects may be created in alternate tablespace

*Specifying Tablespace for a table*
```
CREATE TABLE course_enrollments(
    course_enrollment_id     NUMBER      NOT NULL,
    course_offering_id       NUMBER(20)  NOT NULL,
    student_id               NUMBER(10)  NOT NULL,
    grade_code               VARCHAR2(1) NULL,
    CONSTRAINT pk_course_enrollments PRIMARY KEY (course_enrollment_id),
    CONSTRAINT fk_enrollments_student FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_enrollments_grades FOREIGN KEY (grade_code) REFERNCES grade (grade_code) 
) TABLESPACE student_data;
```

**High Water Mark**
- It is a term used in oracle that is the highest number of block ever contain data in a table, as we insert data it moves ahead.
- When we delete data High water mark remains at the position it was, which means that high water mark is the block which hasn't got data.
- Low High Water Mark - (ASSM) It is the position where the data is deleted and points just ahead of filled block and block may or may not be formatted.
- Impacts of High Water Mark
    - During a full table scan oracle reads all the block below the high water mark
    - If many of the blocks are empty, this is lots of waste work

**PCTFREE**
- When an update occurs the data occupies new row in free space and the amount of free space left is manged by PCTFREE.
- By default PCTFREE value is set to 10 (percent)
- Lets say we set the value to 20 (precent), which makes the oracle to insert data to 80 (percent) only and after that it will consider the block as full as we spcecied the PCTFREE to 20
- Applies to both ASSM and MSSM tablesapce
- Assigning too low PCTFREE, will cause row migrations to occur on updates
- Assigning too High PCTFREE, will cause lots of space to be wasted

Syntax 
```
CREATE TABLE <tablename>(
    ...
) PCTFREE 20;
```

**PCTUSED**
- Only applies to MSSM tablespaces
- The data is full upto  PCTFREE, after that some data i.e rows are deleted and spaces are marked as free, and then oracle will used that free space to insert data again.
- Default value of PCTUSED = 40 (precent)
- Lets say we have reached the limit of PCTFREE and now oracle will start deleting the rows till PCTUSED level, if this happens oracle will start considering block to be empty and start inserting from PCTUSED level.

Syntax 
```
CREATE TABLE <tablename>(
    ...
) PCTUSED 50;
```

**Row Migration**
Incase if data didn't fit into existing freespace of original data block, oracle will create a new data block and creates a pointer that points from old location to new location.
- Impact of Row migration
    - Row lookup operations will now require two IO.s
    - Full table scans dont incur a penalty

Types of row migration
1. __PCTFREE too low__
    - Insufficient space for rows to expand into
    - Many rows will be migrated through normal update
    - Something to be avoided
2. __Natural Row Migration__
    - Natural for a small percentage of rows to migrate
    - Nothing to worry about

***Detecting Row Migrations***
```
SELECT name, value
FROM V$sysstat
WHERE name IN ('table fetch continued row', 
               'table fetch by rowid');


Migrated and chained rows per table:
SELECT table_name, chain_cnt, num_rows, last_analyzed
FROM user_tables;

# chain_cnt is combination of both migrated rows and chained rows.
```

> Using Low PCTFREE Value
> No update activity (insert only)
> Update will not afffect the size of row
> Examples: Logging tables, Some data warehouse apps
>
> Using High PCTFREE Value
> Data added to rows incrementally
> Updates increase row size 
> Example: Tables seeded with inital value, other data added over time

**Freelists**
- List of blocks that have free space that Oracle can use to insert new rows into
- In ASSM freelists are automatically managed
- In MSSM freelists default number is 1, can be bottleneck for concurrent DML

Setting Freelists at Table Creation
```
CREATE TABLE course_enrollments(
    course_enrollment_id     NUMBER      NOT NULL,
    course_offering_id       NUMBER(20)  NOT NULL,
    student_id               NUMBER(10)  NOT NULL,
    grade_code               VARCHAR2(1) NULL,
    ...
) STORAGE (FREELISTS 12);


ALTER TABLE course_enrollments
STORAGE (FREELISTS 12);
```
*Note: The setting applied to MSSM only*

**Detecting Chained Rows**
Tables at risk for row chaining
- Tables with lots of columns (> 100 columns)
- Tables with large sized CHAR/VARCHAR2 columns
```
-- Gather statistics on the table 
EXEC DBMS_STATS.GATHER_TABLE_STATS(
    ownname => '<<Table Owner Name>>',
    tabname => '<<Table Name>>'
);
```
**Identifyinh Chained Rows**
```
CREATE TABLE chained_rows(
    owner_name          VARCHAR2(128),
    table_name          VARCHAR2(128),
    cluster_name        VARCHAR2(128),
    partition_name      VARCHAR2(128),
    subpartition_name   VARCHAR2(128),
    head_rowid          ROWID,
    analyze_timestamp   DATE
);

-- Analyze the table
ANALYZE TABLE <<table name>> LIST CHAINED ROWS;
```
**Solutions To Row chaining**
Use a sufficient block size for your table data
- Estimate row sizes for each table from logical data model
- Specify the tablespace block size based on these estimates
- Move tables with large rows to new tablespace
- Vertically partition table (using foreign key relationship)

> For more information refer to [doc](https://docs.oracle.com/cd/E11882_01/server.112/e40540/toc.htm)
[latest_doc](https://docs.oracle.com/en/database/oracle/oracle-database/21/index.html)
