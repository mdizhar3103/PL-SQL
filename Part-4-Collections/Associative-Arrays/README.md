# Working with Associative Arrays in PL/SQL

- Associative array is also known as PL/SQL Table or Index-By-Table
- Associative array is a collection of key value pair. [Key being index, value is data stored at that index]
- Key can be String or Integer type.
- It is only PL/SQL datatype. 
- In memory table. 

**Note: The bigger the size, of table the more memory the session will consume.**

## Defining Associative Array
```
TYPE <type_name> IS TABLE OF <element_type> [NOT NULL]
INDEX BY [BINARY_INTEGER | PLS_INTEGER | VARCHAR2(size_limit)]
```

## Declaring Associative Array
```
Declare Type --> Declare Varaible 

DECLARE 
    TYPE items_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
    l_items_aa items_aa;
```
**Note: Initialized as an empty array but not null**

## Associative Array Index 
- Maximum size unspecified:
    - BINARY_INTEGER  -2147483647..2147483647
    - See script-6.sql

## Exceptions During Array value Assignment

- Not Null constraint - Assigning NULL to array index if array is declared NOT NULL (See script-7.sql )
- Vaue Error - Assigning wrong datatype value (See script-8.sql)
- No data found - Get value from index that has no value (See script-9.sql)
- Numeric Overflow - Assigning index  out of array range

## Collection Methods

**Syntax**
```
<collection_variable>.<collection_method>
```
FIRST - First index counter in collection
NEXT - Next index counter in collection

**Note: Helps in sorting by index (See script-10.sql, script-11.sql)**

## Associative Array Visibility

Local declaration - Local visibility scope
Package specification - Global visibility scope
(See script-12.sql)

## Oracle Supplied Arrays 

- DBMS_UTILITY
    - NAME_ARRAY - TYPE name_array IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
    - NUMBER_ARRAY - TYPE number_array IS TABLE OF VARCHAR2(30) INDEX BY BINARY_INTEGER;
- DBMS_SQL 
    - VARCHAR2A - TYPE varchar2a IS TABLE OF VARCHAR2(32767) INDEX BY BINARY_INTEGER;
    - DATE_TABLE - TYPE date_table IS TABLE OF DATE INDEX BY BINARY_INTEGER;

