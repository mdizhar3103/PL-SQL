-- Drop a table
DROP TABLE departments;

-- Dropping foreign key relationship tables
-- Drop dependent tables first
DROP TABLE degree;
DROP TABLE courses;

-- Now drop parent table
DROP TABLE departments;

-- Making Table Read-Only and Read-write mode
/*
- No DML allowed (insert/delete/update)
- Truncate not allowed
- Can't modify, add, remove columns
- Indexing is allowed
*/

ALTER TABLE table_name READ ONLY;
ALTER TABLE table_name READ WRITE;

-- Renaming a Table
RENAME <old_table_name> TO <new_table_name>
/*
Note: Incase of table all constraints and indexes will be managed
automatically by oracle

Incase of View, stored procedures, functions, synoyms they will become
invalid, so they need to be fixed manually.
*/


