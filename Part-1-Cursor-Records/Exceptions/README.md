## Exceptions
Types of Exception:
- **Internally Defined Exception:** Start with ORA-n syntax (followed by negative error code)
, Raised Implicitly (*See script-39.sql*)  
- __WHEN OTHERS Exception__ (*See script-40.sql*)
----------
### SQLCODE & SQLERRM
- Built in function for Error information
- Cannot Be used directly in SQL Statements
- SQLERRM has length of 512 bytes
- Used by assigning to a variable

**SQLCODE:**
- Returns the Last Error Code
- Negative Numbers for internally Defined Errors (NO_DATA_FOUND: +100)
- Value of 0 Outside the exception Section
- User Defined Exception: 1 or Internal Error Code

**SQLERRM:**
- ***Used without Arguments***
    - Internally Defined Exception: Error Message
    - User Defined Exception: "In string" or Error Message
    - Outside Exception Section: "Normal, Successful completion
- ***Used with Arguments***
    - Negative Internal Error Code => Error Message
    - +100 => "no data found"
    - 0 => ""Normal, Successful completion"
    - Outside Exception Section: "Normal, Successful completion

*See script-41.sql*

------------------
### Predefined Exceptions
Named Internal Exceptions - Catched explicitly
- CASE_NOT_FOUND         -6592
- TOO_MANY_ROWS          -1422
- INVLID_CURSOR          -1001
- CURSOR_ALREADY_OPEN    -6511
- DUP_VALUE_ON_INDEX     -1
- NOT_LOGGED_ON          -1012   

*See script-42.sql*

---------------
### User Defined Exceptions
- Raised Explicitly (*See script-43.sql*)
```
<exception_name> EXCEPTION;
```
- Pragma EXCEPTION_INIT - (executes at compile time not at runtime)
- PRAGMA EXCEPTION_INIT(<exception_name, -Oracle error number>)

*See script-43.sql*