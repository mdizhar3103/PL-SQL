## Procedure and Functions

**Learning Flow Guide:**
1. Procedures
2. Functions
3. Local-Subprograms
4. Package Specification
5. Call Function From SQL
6. Deterministic Functions


## PL/SQL Optimization Level:

PLSQL_OPTIMIZE_LEVEL
- Level 0 - Pre 10g Optimization
- Level 1 - Remove Unnecessary Computation
- Level 2 - Code Refactoring
- Level 3 - Code Inlining (increase performance)
```
ALTER SESSION SET PLSQL_OPTIMIZE_LEVEL=2;

SELECT PLSQL_OPTIMIZE_LEVEL, PLSQL_CODE_TYPE
FROM ALL_PLSQL_OBJECT_SETTINGS 
WHERE NAME='UPDATE_DEPT';
```
**Compile for Debug:**
```
ALTER PROCEDURE <procedure_name> COMPILE DEBUG;
```
**ERRORS:**
- Invalid Object Name
- Syntax Errors

**WARNINGS:**
- Severe - unexpected results    [Can set to Enable]
- Performance - can slow the performance [Can set to Disable]
- Informational - Unreachable code [Error]

**Setting Warning Levels:**
```
ALTER SESSION SET PLSQL_WARNINGS='ENABLE:ALL';
ALTER SESSION SET PLSQL_WARNINGS='DISABLE:ALL';
ALTER SESSION SET PLSQL_WARNINGS='ENABLE:PERFORMANCE','ENABLE:SEVERE','DISABLE:INFORMATIONAL';

ALTER PROCEDURE update_dept COMPILE PLSQL_WARNINGS='ENABLE:PERFORMANCE','ERROR:SEVERE','ERROR:06002'
REUSE SETTINGS;

SHOW ERRORS;
```
**DBMS_WARNING Package:**
```
add_warning_setting_cat(warning_category IN VARCHAR2,
                        warning_value IN VARCHAR2,
                        scope IN VARCHAR2);
                        
call dbms_warning.add_warning_setting_cat('INFORMATIONAL','DISABLE','SESSION');
call dbms_warning.add_warning_setting_cat('SEVERE','ENABLE','SESSION');
call dbms_warning.add_warning_setting_cat('PERFORMANCE','ENABLE','SESSION');
call dbms_warning.add_warning_setting_cat('ALL','ENABLE','SESSION');

call dbms_warning.add_warning_setting_cat('ALL','DISABLE','SYSTEM');

SELECT call dbms_warning.add_warning_setting_string FROM dual;
```
*See warning.sql*

---------------
## PARAMETERS IN PROCEDURE & FUNCTION

- [schema.]<function_or_procedure_name>(parameter1,.....,parameterN)
- <param_name> <param_mode{IN | OUT}> <param_datatype> {:= | DEFAULT} def_val
```
CREATE OR REPLACE FUNCTION get_tier(p_salary IN NUMBER) RETURN NUMBER AS
```
- **IN mode:** Default Mode, Read-Only (raise an error if the value is assigned to parameter) (*See script-4*)
- **OUT mode:** Read-Write, Actual parameter value is ignored, Can’t be literal or constant (*See script-5*)
- **IN OUT mode:**  Can’t be literal or constant,  Read-Write, Actual parameter value passed (*See script-6*)
------------

### Positional & Named Parameter
```
update_emp(p_emp_id => l_emp_id, p_dept_id => l_dept_id, p_location => l_location, p_status => l_status);
update_emp(l_emp_id, l_dept_id, p_location => l_location, p_status => l_status);
```
### Local Subprograms

- Declaration Section, Scope from Point of Declaration to End of Block, End of Declaration
- Parent Block Variables Visible (can access the variable of parent block), Eliminate Repetition, Multiple

> **Local Procedure in Stored Procedure** (*See script-10.sql*)
> **Local Procedure in Anonymous Block** (*See script-11.sql*)
> **Local Function in Stored Procedure** (*See script-12.sql*)
> **Visbility of Variables** (*See script-13.sql)
---------

### AUTHID
Defines the privileges set under which the program runs and schema external references in the internal program are resolved

**AUTHID Clause**
- STANDALONE PROCEDURE
```
CREATE OR REPLACE PROCEDURE update_emp AUTHID DEFINER IS 
```
- STANDALONE FUNCTION 
```
CREATE OR REPLACE FUNCTION get_count AUTHID CURRENT_USER IS 
```
- PACKAGE SUBPROGRAMS
```
CREATE OR REPLACE PACKAGE hr_mgmt AUTHID CURRENT_USER AS
   FUNCTION get_tier(p_sal NUMBER) RETURN NUMBER;
   PROCEDURE update_emp(p_emp_id NUMBER, p_location VARCHAR2) RETURN NUMBER;
END hr_mgmt;
```
> Note: we can't put authid in the package body, all the package functions and procedures will have the same authid as of package

**AUTHID DEFINER**
- Default Value
- External References Resolved in the schema of the Owner
>Note: when we run the function or procedure in authid definer defined in other schema and session is executing on another schema the changes will be applied to that schema in which authid default is defined if we want to execute the same function in another schema we need to take the copy of that function.

**AUTHID CURRENT_USER**
*Note: In this case its the vice-versa of DEFINER, the code will be invoked only on the invoker side i.e specific schema user only*

***Direct Grants VS Roles***
Explicitly Granting Privileges to User Directly
```
GRANT SELECT, UPDATE, INSERT, DELETE on demo.employee TO <username>;
GRANT EXECUTE ON [schema_name].<procedure_or_function> TO <username>;
```
**Roles**
The role is a mechanism granting multiple privileges to Users using role name
- Can be granted to another role
- Based on function or Business Role
```
CREATE ROLE human_resource;
GRANT SELECT, UPDATE, INSERT, DELETE ON [schema_name].<table_name> TO human_resource;
GRANT EXECUTE ON [schema_name].<procedure_or_function> TO human_resource;
GRANT human_resource TO <username>;
```
**Privileges for AUTHID DEFINER**
- Roles Disabled
- Only Direct Grants Work

**Privileges for AUTHID DEFINER**
- Roles enabled for RUNTIME Evaluation 
- Compilation Requires Direct Grants in compiling schema
