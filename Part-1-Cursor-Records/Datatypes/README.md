## PLS_INTEGER/BINARY_INTEGER (faster)
**PLS_INTEGER SUBTYPES**
- NATURAL: Positive values including Zero
- NATURALN: Positive Not Null Values including Zero
- POSITIVE: Positive Non-Zero Values
- POSITIVEN: Positive Not Null Non-Zero Values
- SIGNTYPE: -1, 0, 1
- SIMPLE_INTEGER: Not Null Values. Allows Overflows +2147483647 +1 -> -2147483648

**BINARY_DOUBLE/BINARY_FLOAT**
- BINARY_DOUBLE has 64 Bit precision
- BINARY_FLOAT has 32 Bit precision
- They gives better performance than NUMBER
- Special Predefined Constants
    - BINARY_[DTYPE]_NAN
    - BINARY_[DTYPE]_INFINITY
    - BINARY_[DTYPE]_MAX_NORMAL
    - BINARY_[DTYPE]_MIN_NORMAL
- rounding errors
*See script-1.sql to script-2.sql*
--------------------------------------------------------
**Character Datatypes**
- Database character Set: CHAR, VARCHAR2, CLOB
- National character Set: NCHAR, NVARCHAR2, NCLOB (Store French character, etc i.e Nation specific)
- NCHAR[(size[char])] , CHAR[(size[bytes|char])] - 4 bytes, default to 1 size, fixed width CHAR(4)
- NVARCHAR[(size[char])] , VARCCHAR[(size[bytes|char])] - max size: 32767 Bytes, max size table column 4000 Bytes
*See script-6.sql*
--------------------------------------------------------
**Datetime**
```
select * from nls_instance_parameters where parameter = 'NLS_DATE_FORMAT';
```
- TO_DATE('10-NOV-2013 15:25:34', 'DD-MON-RRRR HH24:MI:SS');
- TO_DATE('11/10/2013 15:25:34', 'MM/DD/RRRR HH24:MI:SS');
- CURRENT_DATE    : returns Session Date
- SYSDATE         : returns Database Server Date
- TIMESTAMP(3)    : specifying fractional seconds
> Range 0-9, default 6, also specifies Timezone
*See script-7.sql*
--------------------------------------------------------
**Interval**
*See script-8.sql*
--------------------------------------------------------
**Records**
*See script-9.sql*
--------------------------------------------------------
**Other data types** 
- Large Objects
    - CLOB    - for text files
    - BLOB    - images, binary files, audio, video, etc
    - BFILE   - for binary files outside the database and it is a link or locator to those files 
- Collections
    - VARRAYS: Used to define the length of collection at the time of declaration
    - ASSOCIATIVE ARRAYS: they are indexed
    - NESTED TABLES       
- ROWID/UROWID