## Managing Tables in Oracle Database
**Oracle Data Dictionary**
- Series of views containing metadata about all database objects in Oracle
- Three Sets of Views
    - dba_*: Information about all objects in the database
    - user_*: Information about objects owned by the current user
    - all_*: Information about all objects the current user has permission to see

**Useful Data Dictionary Views**
1. USER_OBJECTS Views 
```
SELECT * FROM user_objects;
```
2. USER_TABLES Views
```
SELECT * FROM user_tables;
```
3. USER_TAB_COLS View
4. USER_CONSTRAINTS View
5. USER_INDEXES View
6. USER_IND_COLUMNS View
7. More Views available refer to [doc](https://docs.oracle.com/cd/B19306_01/server.102/b14237/statviews_2005.htm#i1583352)

**Life of a SQL Statement**
```
    +---------------+     +--------------------+       +-----------------+
    |  Parse Phase  | ==> | Query Optimization | ==>   | Execution Phase |
    +---------------+     +--------------------+       +-----------------+
  - Check SQL syntax      - Evaluate Statistics         - Read Blocks
  - Check Object Permis.  - Create Execution Plan       - Filter Rows
  - Query Rewrite Process                               - Sort Data
```
- Oracle Optimizer determines the most efficient plan for your SQL statement
- To estimate how much processing is required for each option

Database Statistics Gathering
    1. Automatically
        - Schedule by Oracle
        - Oracle detects objects with significant changes
    2. Manually
        - Executed by user
        - Used after large insert/delete operation
        - Useful in test environemnts

```
-- Update for one table and all indexes on table
EXEC DBMS_STATS.GATHER_TABLE_STATS(
    ownname => '<<owner_name>>',
    tabname => '<<table_name>>',
    estimate_percent => <<percent>>
);

-- Update for all objects in schema
EXEC DBMS_STATS.GATHER_SCHEMA_STATS(
    ownname => '<<schema_owner_name>>',
    estimate_percent => <<percent>>
);
```

> See script-7.sql