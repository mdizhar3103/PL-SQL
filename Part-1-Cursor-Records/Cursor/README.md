## CURSOR
The cursor is an area of memory.
**Types:**
- **Implicit Cursors:** When a DML query is performed oracle creates cursors to parse and execute the query to hold the results, handled by oracle, and have certain limitations
- **Explicit Cursors:** Based on the query,  Assigns named area in memory and gives control to close and execute
    
***Life Cycle of cursor:***
```                
                    	Area in memory Assigned
                    	SQL statement Parsed and Binded
    OPEN Phase  		SQL statement Executed
                   		Pointer Moved to the first Row
            
    FETCH Phase      	Row Fetched
     
    CLOSE Phase     	Memory is released
```

---------------
> Execute setup.sql to run scripts
---------------

### Automatically created (Implicit Cursors)
- SQL%FOUND - inbuilt implicit cursor attribute
- SQL%NOTFOUND
- SQL%ROWCOUNT

---------------
> Limitation of implicit cursors: More than rows are fetched than requested no data found exception error
---------------

*See script-24.sql*
### Commit & Rollback
- Commit - save the data to the database
- Rollback - Undoes the changes
*See script-25.sql*
### Explicit Cursors
- CURSOR <cursor_name> IS select_statement;
- Number and Type Match for Columns Selected.
- No error For No Data Found.
*See script-26.sql*

**Cursor Attributes**
- <cursor>%NOTFOUND
- <cursor>%FOUND
- <cursor>%ROWCOUNT
- <cursor>%ISOPEN
- <cursor>%ROWTYPE

------
> NOTE: Using cursor attributes before opening and closing cursor will give error
> **Cursor - Multi Row Select:** *See script-27.sql*
> **Cursor - Multi Row Select-2:** *See script-28.sql*
> **Cursor with Parameters:** *See script-29.sql*
------
### Cursor FOR Loop
```
FOR cur_record IN <cursor_name or sql_query> LOOP 
    statements;
END LOOP;
```     
**Explicit Cursor FOR Loop:** Reusable Cursor (*See script-30.sql*)
```   
FOR cur_rec IN <cursor_name> LOOP
            statements;
        END LOOP;
```     
**Implicit Cursor FOR Loop:** Query Can't be Reused (*See script-31.sql*)
```    
FOR cur_rec IN <sql_query> LOOP
    statements;
END LOOP;
```
**Nested Cursor FOR Loop:** 
*See script-32.sql*

### Cursor FOR UPDATE
```
CURSOR <cursor_name>[(param1, param2..paramN)] IS 
select_statement FOR UPDATE [of column list] [NOWAIT];
```
**Exclusive Lock:** NOWAIT prevents waiting if table is locked by some other session
```
<update_or_delete_stmt> WHERE CURRENT OF <cursor_name>
```
*See script-33.sql*
    
-------
### Reference Cursors / Cursor Variables
- Reference to cursor (a pointer to cursor)
- Multiple Queries (explicitly named)
- Subprogram Parameter
- Assigned Value
- Can't Accept Parameters
- **Two Types: Strongly/Weaked Type**
- Help to reduce network traffic
- Used to pass data to oracle forms or other servers

```
TYPE <ref_cur_name> IS REF CURSOR [RETURN return_type]
Use all cursor attributes FOUND, NOTFOUND, ISOPEN, ROWCOUNT
```
**Weak Type Cursor Variables**
- Return type Not Specified
- Flexible
- Runtime Errors
- SYS_REFCURSOR
- Can be Assigned to Each Other

------
> **Strongly-Typed Cursor Variables:** *See script-34.sql*
> **Strongly-Typed Cursor Variables Assigning to another ref cursor:** *See script-35.sql*
> **Weak Typed Cursor Variables:** *See script-36.sql*
> **Weak Typed Cursor Variables Sys reference:** *See script-37.sql*
-----

### Cursor Expression
*CURSOR(QUERY)* 
For: 
- Nested Dataset
- Outer Select Column - when column is fetched for main cursor which is another cursor which can fetch using loop
- Closure - nested cursor is closed automatically when main cursor is closed or reexcuted or exception can also close it.
*See script-38.sql*