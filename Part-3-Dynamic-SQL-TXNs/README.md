## Transaction & Dynamic SQL

**ACID Properties**
- Atomicity - Either all or nothing
- Consistency - Transition from one valid state to another
- Isolation - Concurrent Transaction Leading to the same state as serial execution
- Durability - Commit makes changes permanent

**Transaction**
- atomic unit of work
- Begins with DML, DDL. Set transaction statement
- Ends with Commit, Rollback, or DDL  statement, Normal User Exit, and Abnormal Termination

*See script-1.sql*

---------------
**Transaction Names**
```
SET TRANSACTION NAME 'txn_name';
```
- User Specified Name
- First Statement of transaction
- Name is Optional
- Useful for monitoring Long-Running Transactions
- **Redo Logs:**  insert transaction in redo logs which can be utilized using utility miner
- **V$TRANSACTION:** a table which dba can query to monitor the status of the long-running transaction, this table has txn_name, status, consistent read gets, physical io, undo record held, and other information for the transaction, shown information about an only active transaction

*See script-2.sql*

--------------

**Read OnlyTransaction**
```
SET TRANSACTION READ ONLY NAME 'txn_name';
```
- We use this when we want to read snapshots of data from when the transaction started.
- In a typical statement, the select statement will read data which is the committed data in point time when the select statement started,
- First Statement
- Ends with Commit or Rollback

### Commit 
- Changes Made Permanent
- System Change Number (SCN) is - Generated - logical internal timestamp used by an oracle to keep track of events and the order in which they occurred
- Transaction places lock on the rows it affects and commit release the locks and freed are resources.
- Savepoints are deleted when commits are performed
- Uncommit changes are not visible to other sessions
- DDL statements Issue an implicit commit

### Rollback
- Changes undone
- Ends Transaction
- Releases Lock and Resources
- Erases Savepoints
- Statement Level Atomicity
    - Statement Error Causes Only work done by the statement to be rolled back
- Other Rollback Consideration
    - Abnormal Termination
    - Package Variable Change - (set them manually rollback)

*See script-3.sql*

----------
### Savepoint
```
SAVEPOINT  'savepoint_name';
```
- User-Defined Marker
- Logical Break
- Multiple savepoints are possible
- Partial Rollback

*See script-4.sql, script-5.sql*

-----------
### Explicit Locks
**Using Cursor FOR UPDATE statements**
When we open the cursor and fetch the set of rows, based on the queries, oracle doesn't lock them away from it only locks them when we have changed them, this helps in reducing the locking time to a minimum and increases general availability, but there is a chance that other session may obtain the same row and changed the data and commit it before our session get the chance to issue an update and lock the row. The cursor will have the snapshot of the data from the point of time it was opened and it will not be able to see the comitted data outside our session. If our change is based on a certain column having certain values and if it was changed by another session cursor will still see the old data and make the update based on that thus causing a wrong update. So to avoid this we want the explicit lock to control rows or cursor to ensure no one can changes it outside your session. These record will be available to others if our session commits or roll back. 

**Lock Table**
Oracle tries to minimize locking to ensure high availability and concurrency and same time ensuring data integrity.
- Shared Lock
- Exclusive Lock

Many users can have a shared lock on the table but only one user can have an exclusive lock, if one is having exclusive locks it prevents other users from performing Insert, Delete, Update in the table. If other users want to change the same row it has to wait until the lock is released (i.e. committed/rollback) 
```
LOCK TABLE accounts IN ROW SHARE MODE NOWAIT;
LOCK TABLE accounts IN ROW EXCLUSIVE MODE;
```
-------------------------
### AUTONOMOUS TRANSACTION

Allows initiating independent transactions within parent transaction, that have a usage in logging, monitoring, and a lot of other tasks which otherwise takes lots of complex coding and requires a complex setup of database pipes, etc.

Independent Transaction within another transaction. (not affected commits, rollbacks, or savepoint initiated in outer transaction and doesn't share context of the outer transactions)
Is Pragma Directive (Compiler related)

Why?
- Logging
- Usage Counters (to restrict program usage)
- Retry Counters (user trying to login)
- Module independent

Syntax:    
```
PRAGMA AUTONOMOUS_TRANSACTION;
```
**Defined in:**
- Defined in the declaration section.
- Top-level anonymous Block
- Standalone function
- Packaged Procedure and Function (defined in the package body section, not in the specification
- Database triggers

> Note: unhandled exceptions are rolled back in an autonomous transaction.

*See script-6.sql*
> **Transaction Context (independent of parent transaction)** (*See script-7.sql*)
> **Creating Atomic & Independent Work Units** (*See script-8.sql*)
--------------
## Native Dynamic SQL

SQL statement known at runtime.
**Static SQL**
- SQL knew at compile time
- Compiler Verifies Object References
- The compiler can verify packages
- Less Flexible
- Faster

**Dynamic SQL**
- SQL knew at Runtime
- The compiler can't Verify Object References
- The compiler can't verify packages
- More Flexible
- Slower

**Uses**
- Dynamic Queries
- Dynamic Sorts
- Dynamic subprogram Invocation
- Dynamic Optimization
DDL
Frameworks

***Invoking Dynamic SQL***
Native Dynamic SQL - Easy to use, better performance (faster), Support User Defined Types, Support Records
```
EXECUTE IMMEDIATE <dynamic_sql_string> 
[INTO {select_var1[, select_var2]..|record}
[USING [IN | OUT| IN OUT] bind_var1
[, [IN | OUT | IN OUT] bind_var2]...]
[{RETURNING | RETURN} INTO bind_var1
[, bind_var2]...];
```
- DBMS_SQL package 
- DDL Operations

*See script-9.sql*
**Executing Single Row and Multiple Row Selects**
- Helpful user-specified filters and can be the backend for self-defined service for reporting webpage
- Passing the bind variable name in query will raise an error in dynamic SQL

*See script-10.sql*
> **Executing DML, DDL, Function, Procedures Using Dynamic SQL** (*See script-11.sql*)
> **SQL Injection** (*See script-12.sql*)
------------

## Dynamic SQL using DBMS_SQL
- Return Results to client
- Unknown Number of Select Columns
- Unknown Number of PlaceHolders

**DBMS_SQL**
- Owned by Sys(superuser) - This package is defined by the invoker's right (so that it runs under the privileges of the invoker)
- Types of Statements execute: DML, DDL, Alter Session Statements, Anonymous Blocks, Queries, Procedure & Function

**DBMS_SQL Workflow**
- Open Cursor (allocates context area in memory and return the cursor id)
- Parse (check the syntax and semantics of the statements, in case of queries it prepares the execution plans)
- Bind Variable (binds the variable only for IN-OUT)
- Define Column (step needed for query execution)
- Execute (Returns the number of rows processed)
- Fetch Rows (applicable for queries when next row is fetched) 
- Variable Value (used when the procedure, anonymous blocks are called)
- Column Value (to get values of select columns for that query)
- Close Cursor (to release memory area)

**Executing DDL & Session Control Statements needs only a few steps as:**
- Open Cursor
- Parse
- Execute
- Close Cursor

*See script-13.sql*

**DML Statements, Subprograms, Anonymous Blocks need only the following statements**
- Open Cursor
- Parse
- Bind Variable
- Execute
- Variable Value
- Close Cursor
```
DBMS_SQL.BIND_VARIABLE( c     IN INTEGER,
                        name  IN VARCHAR2,
                        value IN VARCHAR2 CHARACTER SET ANY_CS[,out_value_size IN INTEGER]);
```
```
DBMS_SQL.VARIABLE_VALUE(c    IN INTEGER,
                        name IN VARCHAR2,
                        value OUT VARCHAR2 CHARACTER SET ANY_CS);
```

> *See script-14.sql*
> **Executing Select Statements** *See script-15.sql*
> **Executing Select Statements with error** *See script-16.sql*
> **Unknown Number of columns** *See script-17.sql*
> **Binding variable to select statements** *See script-18.sql*
--------------

## Security
DBMS_SQL security aspects
```
FUNCTION OPEN_CURSOR(security_level IN INTEGER) RETURN INTEGER;
```

**Open cursor:**
- 0 no security check
- 1 userid/Role parsing be the same as binding / executing
- 2 Most secure

**Checks:**
- Current calling user same as the recent parse user
- Enable roles on current call same as enabled roles on recent parse
- Container on current call same as a container on recent parse 
- 
If any of these checks are not true oracle will raise an error.
