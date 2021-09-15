## DEBUGGING
> **DEBUG MESSAGE**

- DBMS_OUTPUT.PUT_LINE(msg in VARCHAR2);
message length 32767 Bytes

- DBMS_OUTPUT.PUT(msg in VARCHAR2);
message length 32767 Bytes
 This does not allow new line marker.

- DBMS_OUTPUT.NEW_LINE;
Puts End of Line marker.
Needed to get line with PUT statements.

- DBMS_OUTPUT.GET_LINE;
GET_LINE(line OUTVARCHAR2, status OUTINTEGER);
Gets a single Line
Status  0: Successful Fetch
Status  1: Nothing More to Fetch

- DBMS_OUTPUT.GET_LINES;
GET_LINES(lines OUT CHARARR, numlines IN OUT INTEGER);
GET_LINES(lines OUT DBMSOUTOUT_LINESARRAY, numlines IN OUT INTEGER);
 get multiple lines
 
- DBMS_OUTPUT.ENABLE;
ENABLE(buffer IN INTEGER DEFAULT 20000);
 Enables Calls to Other Procedures
 Buffer Size:
    Default: 20000
    Minimum: 2000
    Maximum: Unlimited with 10.2 version
    
- DBMS_OUTPUT.DISABLE;
 to disable outputs or procedure calls

- DBMS_UTILITY.FORMAT_ERROR_STACK
- DBMS_UTILITY.FORMAT_ERROR_BACKTRACE - GIVES LINE NUMBER WHERE ERROR OCCURED

*See script-45.sql*