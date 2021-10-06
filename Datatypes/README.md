## Datatypes in Oracle
- Incorrect data type may require more storage
- Datatype may impacts performance
- Everything is VARCHAR2

**DUMP() Function**
Outputs a string that describes the raw bytes stored in column.
- Indicator of the column data type
- Length of value stored in row (in bytes)
- Array of the bytes Oracle stores for the value

*Syntax*
```
>>> SELECT column1, DUMP(column2), column3, DUMP(column4, 16) FROM <table_name>;

```

### Character Datatypes

- CHAR: Stores default character set, are space padded
- VARCHAR2: Stores default character set
- NCHAR: Stores unicode character set, are space padded
- NVARCHAR2: Stores unicode character set
- CHAR, NCHAR have limit of 2000 bytes
- VARCHAR2,NVARCHAR2 have limit of 4000 bytes, using MAX_STRING_SIZE=EXTENDED limit can be increased to 32,767 bytes

```
CREATE TABLE world_cities(
    country_code CHAR(2),
    country_name VARCHAR2(40 byte),
    capital_city VARCHAR2(40 char),
    national_country_name  NCHAR(2),
    national_capital_name  NVARCHAR2(40)
)

Note: NCHAR, NVARCHAR2 are specified as number of characters
```

**National Character Sets (NLS)**

```
SELECT * FROM nls_database_parameters
WHERE parameter IN
('NLS_CHARACTERSET', 'NLS_NCHAR_CHARACTERSET');
```

> See script-2.sql

**Raw Datatype**
- Store raw binary data (an array of bytes)
- Max size: 2000, extended to 32,767

```
CREATE TABLE data_transfer_files(
    file_id          NUMBER(6),
    file_recive_time DATE,
    file_size        NUMBER(10),
    file_checksum    RAW(64),
    file_checksum_base64 VARCHAR2(44),
    file_checksum_hex   VARCHAR2(64)
);
```
----

### Numeric Datatypes

- NUMBER(p,s)
    - Precision (p): Total number of digits in the number (Maximum of 38)
    - Scale (s): Digits to the right of the decimal place (Can be from -84 to 127)
    - Defaults: Number is stored as given if no precision/scale is specified (Scale defaults to 0)
- Negative Scale: NUMBER(8, -2) this will round to the left of the decimal point by 2 digits
- Any calculation done is on software not on hardware.

**Identity Columns**
- Oracle will auto-generate a sequential value for a numeric field
- Useful for surrogate primary keys
- If we supply value explicitly oracle will give error, also give error if insert NULL is performed, on passing NULL will generate value by default

*Syntax*
```
CREATE TABLE students(
    student_id      NUMBER(10)  GENERATED ALWAYS AS IDENTITY START WITH 100,
    first_name      VARCHAR2(40) NOT NULL,
    middle_name     VARCHAR2(40) NOT NULL,
    last_name       VARCHAR2(40) NOT NULL,
    gender          VARCHAR2(40) NOT NULL,
    street_address  VARCHAR2(40) NOT NULL,
    city            VARCHAR2(40) NOT NULL,
    state           VARCHAR2(40) NOT NULL
);
```
Identity Value Options:
- START WITH <value>
- INCREMENT BY <value>
- CACHE <value>

**Binary Float/Double**
- BINARY_FLOAT:  Range of +/-3.4E+38, precision of 6-7 digits
- BINARY_DOUBLE: Range of +/-1.79E+308, precision of 15 digits
- These are hardware based.
- Not suitable for financial calculation
- Can store smaller/larger numbers than NUMBER type

### Date and Time Date datatypes

|Data Type|Description|
|---------|-----------|
| DATE | Date/time values with precision of one second |
| TIMESTAMP(n) | Date/time values with upto n digits of fractional second precision |
| TIMESTAMP(n) WITH TIMEZONE | Date/time values with upto n digits of fractional seconds precision and an associated timezone for the value|
| TIMESTAMP(n) WITH LOCAL TIMEZONE | Date/time values with upto n digits of fractional seconds. Value is converted to local timezone of the database|

```
CREATE TABLE log_messages(
    message_id                      NUMBER(10) NOT NULL,
    msg_time_as_date                DATE,
    msg_time_as_timestamp           TIMESTAMP,
    msg_time_as_timestamp_ms        TIMESTAMP(3),
    msg_time_as_timestamp_with_tz   TIMESTAMP(9) WITH TIME ZONE,
    msg_time_as_timestamp_with_ltz  TIMESTAMP(9) WITH LOCAL TIME ZONE,
    message                         VARCHAR2(512) NOT NULL
);
```

**Formatting of Date/Time Data**
Using TO_CHAR():
```
SELECT TO_CHAR(
    msg_time_as_date, 'YYYY-MM-DD HH24:MI:SS') AS msg_time_date,
    TO_CHAR(msg_time_as_timestamp, 'MONTH DD, YYYY  HH24:MI') AS msg_time_timestamp
FROM log_messages;
```

***Date Format Code for TO_CHAR***
- YYYY: Four digit year (2014)
- YY:   Two digit year (14 for 2014)
- MM:   Numeric Month 01-12
- MONTH: Full Month name
- MON:  Abbreviation for Month
- DD: Day of the month (01-31)
- DAY: Name of week day

***Time Format Code for TO_CHAR***
- HH24: Hour of day-24 hour format (0-23)
- HH:  Hour of day-12 hour format (1-12)
- AM: Meridian (AM or PM)
- MI: Minutes 
- SS: Seconds 
- FFn: Fractional seconds, n=number of fractional seconds
- TZH: Timezone hours offset from GMT 
- TZM: Timezone minutes offset from GMT 

***Other Useful Format Codes for TO_CHAR***
- Q: Quarter of the year (1-4)
- WW: Week of the year
- IW: ISO standard week of the year
- W: Week of the month
- D: Day of the week (1-7)
- DDD: Day of the year (1-366)

**Time Functions**
- SYSDATE: Current date/time on the Oracle Server
- CURRENT_DATE: Current date/time in the session
- SYSTIMESTAMP: Current date/time on the Oracle Server as timestamp

*Specifying Date literals*
```
SELECT * FROM log_messages
WHERE message_time >=
TO_DATE('2014-11-15 17:00', 'YYYY-MM-DD HH24:MI')
AND message_time <=
TO_DATE('2014-11-15 18:30', 'YYYY-MM-DD HH24:MI');
```
*Specifying Timestamp literals*
```
SELECT * FROM log_messages
WHERE message_time >=
TIMESTAMP('2014-11-15 17:00:00.000000')
AND message_time <=
TIMESTAMP('2014-11-15 17:10:30.500000');
```
*Specifying Timestamp literals with Time zone*
```
SELECT * FROM log_messages
WHERE message_time >=
TIMESTAMP('2014-11-15 17:00:00.000000 -06:00');


SELECT * FROM log_messages
WHERE message_time >=
TIMESTAMP('2014-11-15 17:00:00.000000 America/Chicago');
```

> Timezone Names
> Allowed timezone names: V$TIMEZONE_NAMES view

> See script-4.sql

**NLS Setting Related to Date/Time Values**
- To view settings: NLS_DATEBASE_PARAMETERS view
- To change setting for a session: ALTER SESSION SET parameter_name=new_value
- Important NLS settings:
    1. NLS_DATE_FORMAT: Default formatting of date values
    2. NLS_TIMESTAMP_FORMAT: Default formatting of timestamp values
    3. NLS_DATE_LANGUAGE: Control languages of names of days, months
    4. NLS_TERRITORY: Control what day is considered first day of the week

**Functions to use with Date**
- TRUNC(): Remove the time component from a Date or timestamp value
```
SELECT TO_CHAR(
    TRUNC(sysdate), 'YYYY-MM-DD HH24:MI:SS') AS my_date
FROM dual;
```
- LAST_DAY(): Find the last day of the current month the date is in
```
SELECT 
LAST_DAY( TO_DATE('2014-07-15 17:00', 'YYYY-MM-DD HH24:MI')) AS my_date
FROM dual;
```
- NEXT_DAY(): Find the next named weekday followin the given date
```
SELECT 
NEXT_DAY( TO_DATE('2014-07-15 8:00', 'YYYY-MM-DD HH24:MI'), 'FRIDAY') AS my_date
FROM dual;
```

**Performing Date Arithmetic**
Add, subtract number from __data or timestamp__ value
> See script-5.sql

**Interval Data Types**
- Interval Year to Month 
- Interval Day to Second
*Syntax*
```
INTERVAL YEAR(<<precision>>) TO MONTH

Note: Default precision is 2 and range from 0-9

<!-- Literal Format -->
INTERVAL '<<years>>-<<months>>'  YEAR(<<precision>>) TO MONTH

--

INTERVAL DAY(<<precision>>) TO SECOND(<<precision>>)
Note: Day precision defaults to 2 and range 0-9 digits and Second precision defaults to 6 

<!-- literal format -->
INTERVAL '<days> <hh>:<mi>:<sec>.<ff>' DAY(<<precision>>) TO SECOND(<<precision>>)
```

---

### Large Object Data types (LOB)
- LOB: BLOB, CLOB, NCLOB
- Table can contain multiple LOB columns
- Max size on columns = (4 gigabytes - 1) * (database block size)
- Can't be part of an index
- Can't be used in Order by clause, group by clause or aggregate function

**How LOB Columns Work?**
LOB is a pointer to another datastructures called LOBINDEX (tree structure) which further has LOBSEGMENT where the actual data is stored. Within the LOBSEGMENT the data for each LOB value is stored in Chunks.

*Defining LOB columns*
```
CREATE TABLE courses (
    department_code    VARCHAR2(2)     NOT NULL,
    course_number      NUMBER(10)      NOT NULL,
    title              VARCHAR2(40)    NOT NULL,
    description        VARCHAR2(2048)  NOT NULL,
    credits            NUMBER(3,1)     NOT NULL,
    syllabus           BLOB            NULL
)
LOB (syllabus) STORE AS SECUREFILE (
    TABLESPACE   lob_objects
    DISABLE  STORAGE IN ROW
    CHUNK   8192
    NOCACHE
    COMPRESS HIGH
);

Note: chunk are in bytes

<!-- Multiple LOB Columns -->
CREATE TABLE products (
    product_id        NUMBER(10)     NOT NULL,
    sku               VARCHAR2(20)   NOT NULL,
    name              VARCHAR2(40)   NOT NULL,
    short_description VARCHAR2(2048) NOT NULL,
    full_description  CLOB           NULL,
    product_details   CLOB           NULL,
    technical_specs   CLOB           NULL,
    product_photo     BLOB           NULL
)
LOB (full_description) STORE AS
    (TABLESPACE lob_objects DISABLE STORAGE IN ROW),
LOB (product_details) STORE AS
    (TABLESPACE lob_objects DISABLE STORAGE IN ROW),
LOB (technical_specs) STORE AS
    (TABLESPACE lob_objects DISABLE STORAGE IN ROW),
LOB (product_photo) STORE AS
    (TABLESPACE photo_data DISABLE STORAGE IN ROW);

```
**Options in LOB columns**
- __SECUREFILE vs BASICFILE__
    - BASICFILE is original storage implementation for large objects
    - SECUREFILE offers additional features like data de-duplication and data compression
    - Data compression requires additional license
    - Check SECUREFILE configuration option (SELECT * FROM v$parameter WHERE name='db_securefile';)
    - SECUREFILE options: NEVER, PERMITTED, PREFERRED, ALWAYS, IGNORE
    - To use SECUREFILE options for storing large object data, the LOB must use a tablespace with ASSM
```
LOB (<<lob column_name>>) STORE AS [SECUREFILE | BASICFILE] 
(
    <<lob_column options>>
);
```
- __LOB TABLESPACE__
```
LOB (<<lob column_name>>) STORE AS
(
    TABLESPACE <<tablespace name>>
    ...
);
```
- __STORAGE IN ROW Option__
    - ENABLE STORAGE IN ROW: Defaul option, First 4000 bytes stored inline with row data
    - DISABLE STORAGE IN ROW: All data for LOB column will be stored in the LOBSEGMENT
```
LOB (<<lob column_name>>) STORE AS
(
    [DISABLE STORAGE IN ROW | ENABLE STORAGE IN ROW]
    ...
);
```
- __CHUNK Option__
    - Size must be multiple of tablespce data block size
    - CHUNK size too high: Space will be wasted by putting small LOB values in a large container
    - CHUNK size too low: LOBINDEX must contain large number of entries for each LOB value multiplied by number of rows
```
LOB (<<lob column_name>>) STORE AS
(
    CHUNK <<chunk size>>
    ...
);
```
- __CHCHE OR NOCHACHE Option__
    - Default is NOCHACHE
    - Objects like audio and video files are very large
    - Caching large objects can cause thrashing
    - Cache when LOB values are relatively small and frequently used
```
LOB (<<lob column_name>>) STORE AS
(
   [NOCACHE | CACHE]
    ...
);
```
- __COMPRESS Option__
```
LOB (<<lob column_name>>) STORE AS SECUREFILE
(
   [COMPRESS (HIGH | MEDIUM | LOW) | NOCOMPRESS]
    ...
);
```
- __Data Dedpulication Option__
    - Disk space savings: Only copy of the data is stored 
    - Performance: When copying LOB values, Oracle can just point to existing values
```
LOB (<<lob column_name>>) STORE AS SECUREFILE
(
   DEDUPLICATE
    ...
);
```
