## Working with Nested Tables 
[Doc](https://docs.oracle.com/cd/A97630_01/appdev.920/a96624/05_colls.htm)

- Defined at Database level
- Define in Anonymous blocks, Stored subprograms, etc

Syntax for defining PL/SQL
```
TYPE <type_name> IS TABLE OF <element_type> [NOT NULL]; 
```
SQL syntax for defining
```
CREATE [OR REPLACE] TYPE <type_name> IS/AS TABLE OF <element_type> [NOT NULL]; 
```
**Note:** We can't access nested table directly we need to variable to access them

    Declare type ----> Declare variable 
## Initializing Nested Table
Using Constructor - *See script-16.sql*
- can be used in directlyat the time declaring variable
- normally in begin block
**Note:** Using Constructor without arguments initalize to empty array
## Adding Elements
Extend method - *See script-17.sql*
## Delete Elements
- Delete(n)
- Delete
*See script-18.sql*
## Assigning another nested table to Nested table
*See script-19.sql*
## Exceptions During Assignment
- Not Null constraint
- Uninitialized collection
- Subscript beyond count
- No data found
- Value Error
- Subscript outside of limit
*See script-20.sql*
## TRIM Method (Reducing Size)
Works on inner collection size
*See script-21.sql*
## Schema level Nested Table
- Available throughtout the system
- Columns of database tables
- Easier information retrieval
Syntax
```
CREATE OR REPLACE TYPE items_nt AS TABLE OF VARCHAR2(60);
--------------------------------------------------------------------------
CREATE TYPE orders_ot AS OBJECT(order_id NUMBER, order_item_id NUMBER);
CREATE OR REPLACE TYPE orders_nt IS TABLE OF orders_ot;
```
Altering Size of Schema Nested Table
```
ALTER TYPE <NESTED_TABLE> MODIFY ELEMENT TYPE <new_datatype_size> CASCADE|INVALIDATE;
```
## DML on Nested Table Columns
*See script-22.sql*
## Unnesting Using Table Expression
```
SELECT a.act_id, b.column_value FROM account_order a, TABLE(a.itemslist) b WHERE a.act_id = 1;
```
*See: script-23.sql*
## Piecewise DML
*See: script-24.sql*
## MULTISET Operators
- Transforming Nested Tables
- Same Nested Table Type
|Multiset Operator|Equivalent SQL Operator|
|----------------|-----------------------|
|MULTISET UNION| UNION ALL|
|MULTISET UNION DISTINCT| UNION|
|MULTISET INTERSECT| INTERSECT |
|MULTISET EXCEPT| MINUS|
*See: script-25.sql, script-26.sql*
## Comparing Nested Tables
Compare for equality or non-equality, not for greater than, less than, etc
- = or !=
- IS [NOT] A SET
- CARDINALITY - returns count of element in set
- [NOT] MEMBER [OF]
- IS [NOT] EMPTY
- SUBMULTISET [OF]
*See: script-27.sql*
