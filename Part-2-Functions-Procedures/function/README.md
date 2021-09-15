## FUNCTION
- Stored Subprograms
- Returns Information
- Used in Expressions

Oracle provides inbuilt functions - refer to the [doc](https://docs.oracle.com/javadb/10.8.3.0/ref/rrefsqlj29026.html)

> Note: Privileges are the same as Procedure
```
CREATE [OR REPLACE] FUNCTION [schema.]<function_name>
    RETURN datatype IS | AS
    <declaration section>
BEGIN
    statements;
RETURN <data type>;
[EXCEPTION]
END [<function_name>];
```
> Note: compiling is the same as procedures

**Compiling Function:**
- PLSQL_CODE_TYPE-
    - NATIVE
    - INTERPRETED - improves performance by not interpreting the code
```
ALTER SESSION SET PLSQL_CODE_TYPE=NATIVE;
ALTER FUNCTION get_emp_count COMPILE PLSQL_CODE_TYPE=NATIVE;
```

- PLSQL_OPTIMIZE_LEVEL- 0-3		
```
ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL=2;
```
- DEBUG MODE
```
ALTER FUNCTION get_emp_count COMPILE DEBUG;
```
> Note: ERRORS AND WARNINGS are the same as in procedures
```
ALTER FUNCTION get_emp_count COMPILE PLSQL_WARNINGS='ENABLE:PERFORMANCE','ERROR:SEVERE','ERROR:06002'
REUSE SETTINGS;

ALTER SESSION SET PLSQL_WARNINGS='ENABLE:ALL';

SHOW ERRORS;
```
Executing Function is different from procedures because functions return value and we need to catch that value anyhow.

- **Using PL/SQL Block or Subprogram:**
```
    DECLARE
        l_return NUMBER;
    BEGIN
        l_return := get_emp_count;
    END;
```
>Note: this will cause extra operation and cause an error if oracle implicit doesn't convert it will give error;

- **Using SQL Statement:**
```
    		select get_emp_count from dual;
```    
- **Executing Function:**
```
    EXEC[UTE] :bind_varaible := <function_name>;
    
    VARIABLE l_return NUMBER;
    EXEC :l_return := get_emp_count;
    PRINT :l_return
```

--------------

### PASSING BY VALUE AND REFERENCE
- Passed by Reference: IN (Drawback - if an exception is raised inside procedure or function, the value changed for the actual parameter will remain changed) (*See script-7.sql, script-8.sql*)
- Passed by Value: OUT & IN OUT
> **Nocopy HINT** (*See script-9.sql*)
> Restrictions:
**Implicit conversion** - scalar data types with not null constraint, scalar numeric with constraints
Record with different field constraints, elements of a collection, remote procedure calls
