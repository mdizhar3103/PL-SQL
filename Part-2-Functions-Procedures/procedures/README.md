## Procedures
- Performing a task in a certain order.
- It is a Named Program Unit in oracle DB
- It performs Unit of Work.
- Doesn't Return Anything.

*Note: Run setup.sql in procedures folder to exceute all scripts*

**Privileges:**
- CREATE PROCEDURE
- CREATE ANY PROCEDURE
- ALTER ANY PROCEDURE
- EXECUTE
```
GRANT CREATE PROCEDURE TO <user_name>;
GRANT CREATE ANY PROCEDURE TO <user_name>;
GRANT ALTER ANY PROCEDURE TO <user_name>;

GRANT EXECUTE ON <schema_name>.<procedure_name> TO <user_name>;
```
**Creating Procedure:**
```
CREATE [OR REPLACE] PROCEDURE [schema_name].<procedure_name> IS | AS
 <declaration_section>
BEGIN
  STATEMENTS;
[EXCEPTION]
END [<procedure_name>]; 
```
**Compiling procedure file:**
```
ALTER PROCEDURE <procedure_name> COMPILE;
-- OR
@<procedure_name>.sql
```

*See script-1.sql*

**Executing Procedure:**
- CALL update_dept();
- EXEC update_dept;
- EXECUTE update_dept();
- DROP PROCEDURE update_dept;
