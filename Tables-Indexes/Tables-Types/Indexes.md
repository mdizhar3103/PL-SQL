Data in a table are stored in Heap form (random order)
**Index**
- An index is separate data structure design to speed up the retrieval of rows from a table.
- Most common type of index in Oracle is based is a B-tree (Balanced tree) index
- For each index, index key is defined
- Index key is a subset of columns used to organize and search the index
- Using index fetching rows is a 2-step process
    - First traversing the tree which is combination of index key and rowids and matching index key
    - Fetching the right data from the table

***Syntax for Defining Index***
```
CREATE INDEX <<index_name>>
ON TABLE <<table_name>>
(<<column_name1>>, <<column_name2>>,...)
[TABLESPACE <<index tablespace_name>>];

# syntax available in enterprise edition
# this will not lock the table for DML during index creation
CREATE INDEX <<index_name>>
ON TABLE <<table_name>>
(<<column_name1>>, <<column_name2>>,...)
ONLINE
[TABLESPACE <<index tablespace_name>>];
```
**Unique Index**
- Non-unique Indexes: Multiple indexes rows can have the same value for the columns in the index key
- Unique indexes: Every row must have unique value for the columns in the index key
***Syntax for Defining Unique Index***
```
CREATE UNIQUE INDEX <<index_name>>
ON TABLE <<table_name>>
(<<column_name1>>, <<column_name2>>,...)
[ONLINE]
[TABLESPACE <<index tablespace_name>>];
```

> See script-11.sql

**Function Based Indexes**
- Standard index: Index is created over the actual column value
- Function Based Index: Index is created over the derived value returned by the function
Example:
```
# Classic Example: Case insensitive search
SELECT * FROM <table_name>
WHERE last_name = 'Izhar'
AND first_name = 'Mohd';

# removing case sensitivity
SELECT * FROM <table_name>
WHERE UPPER(last_name) = UPPER('Izhar')
AND UPPER(first_name) = UPPER('Mohd');

<!-- Note: there is a problem this case Oracle will no longer use Index on last_name/first_name Columns-->

# Creating function based index
CREATE INDEX fx_<table_name>_<name>
ON <table_name>
(UPPER(last_name), UPPER(first_name));
```
*Function based Index Rules*
- Can use built in Oracle or user defined functions
- Functions must be deterministics
- Index can mix normal column values and derived values from functions

### Bitmap Index
- Intended to solve a very different problem than a B-tree index
- Targeted at columns with low number of distinct values
- Only suitable for datawarehouse or read-only applications
- Bitmap Index is only available in Oracle Enterprise Edition

For example:
A column (gender) have two distict values male or female, in bitmap the oracle maps these into bit array as:

|Female | Male|
|-------|-----|
|   1   |  0  |
|   0   |  1  |

where row containin gender as female marked as 1 and male as 0
Synax for creating
```
CREATE BITMAP INDEX bx_<name_you_want>
ON <table_name>
(<column_name>);

<!-- More flexible to create two indexes like this -->
CREATE BITMAP INDEX bx_customer_stats_gender
ON customer_statistics
(gender);

CREATE BITMAP INDEX bx_customer_stats_age_range
ON customer_statistics
(age_range);

<!-- Below is also Allowed but not as flexible -->
CREATE BITMAP INDEX bx_customer_stats_gender_age
ON customer_statistics
(gender, age_range);
```

> Important points to keep while creating index in database:
> Column Irder Matters in and Index
> SQL statement must use the first column to use index
> Use as many columns as possible from front of index
> Put columns most frequently used in where clause at the front of the index
> More columns, or more distinct columns helps us to identify data more uniquely
> Every index takes up  space on disk
