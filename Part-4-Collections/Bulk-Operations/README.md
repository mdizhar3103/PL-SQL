## Bulk Operations
- Bulk collect: Fetching data from database in bulk
- FORALL: Inserting/Updating/Deleting data in the database in bulk
**Context Switches**
[Link](https://blogs.oracle.com/oraclemagazine/bulk-processing-with-bulk-collect-and-forall)
***Benefits of Bulk Operations***
- Performance optimization
- Reducing network roundtrips
**Syntax**
```
BULK COLLECT INTO <collection_name>
```
- Fetch can be done in all three collection types
- Fetched collection is dense
- Erases previous values
*Memory Considerations is important in bulk collect*
### SELECT INTO Clause
- This clause doesn't raise exception
- Mulitple Columns with Individual Collection
- Mulitple Columns with Collection of Records
- Can Limit Rows Fetched 
*See script-35.sql*
### FETCH INTO Clause using LIMIT Clause
*See script-36.sql*
### RETURNING INTO Clause
*See script-37.sql*
-------
## BULK Operations: FORALL
```
FORALL index_counter IN <bounds> [SAVE EXCEPTIONS] sql_statement
```
- FORALL iterator declared implicitly as integer
- One DML per FORALL
*See script-38.sql*
- IN low_value..high_value usage needs dense collection
### INDICES OF Clause
- Iterating over collection will give error if element doesnt found at that index, to avoid that use indices clause to get index of existing element
*See script-39.sql*
### VALUES OF Clause
- Iterate over specific elements
- Iterate in specific order
- Iterate over certain elements more than once
*See script-40.sql*
**SQL%BULK_ROWCOUNT**
- Stores rows affected by each iteration of the DML statement
## EXCEPTIONS
- Unhandle exception rolls back all previous changes
- Handling exception doesn't rolls back all previous changes 

> **Save Exceptions:** save exceptions and continue processing
> **SQL%BULK_EXCEPTION** [ERROR_INDEX| ERROR_CODE]
*See script-41.sql*
**Performance Gain** 
*See script-42.sql*