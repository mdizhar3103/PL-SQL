CREATE TABLE log_messages(
    message_id                      NUMBER(10) GENERATED ALWAYS AS IDENTITY START WITH 1,
    msg_time_as_date                DATE,
    msg_time_as_timestamp           TIMESTAMP,
    msg_time_as_timestamp_with_tz   TIMESTAMP(3) WITH TIME ZONE,
    msg_time_as_timestamp_with_ltz  TIMESTAMP(2) WITH LOCAL TIME ZONE,
    message                         VARCHAR2(512) NOT NULL
);

INSERT INTO log_messages(
    msg_time_as_date,
    msg_time_as_timestamp,
    msg_time_as_timestamp_with_tz,
    msg_time_as_timestamp_with_ltz,
    message)
VALUES(
    SYSDATE,
    SYSDATE,
    SYSDATE,
    SYSDATE,
    'Insert of sysdate into all fields'
);

SELECT 
message_id,
TO_CHAR(msg_time_as_date              , 'YYYY-MM-DD HH24:MI:SS') AS msg_time_as_date,
TO_CHAR(msg_time_as_timestamp         , 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp,
TO_CHAR(msg_time_as_timestamp_with_tz , 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM') AS msg_time_as_timestamp_with_tz,
TO_CHAR(msg_time_as_timestamp_with_ltz, 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp_with_ltz
FROM log_messages
ORDER BY message_id;


INSERT INTO log_messages(
    msg_time_as_date,
    msg_time_as_timestamp,
    msg_time_as_timestamp_with_tz,
    msg_time_as_timestamp_with_ltz,
    message)
VALUES(
    SYSTIMESTAMP,
    SYSTIMESTAMP,
    SYSTIMESTAMP,
    SYSTIMESTAMP,
    'Insert of systimestamp into all fields'
);

SELECT 
message_id,
TO_CHAR(msg_time_as_date              , 'YYYY-MM-DD HH24:MI:SS') AS msg_time_as_date,
TO_CHAR(msg_time_as_timestamp         , 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp,
TO_CHAR(msg_time_as_timestamp_with_tz , 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM') AS msg_time_as_timestamp_with_tz,
TO_CHAR(msg_time_as_timestamp_with_ltz, 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp_with_ltz
FROM log_messages
ORDER BY message_id;

-- inserting timestamp literal values 

INSERT INTO log_messages(
    msg_time_as_timestamp_with_tz,
    msg_time_as_timestamp_with_ltz,
    message)
VALUES(
    TIMESTAMP '1969-07-21 02:56:15 +0:00',
    TIMESTAMP '1969-07-21 02:56:15 +0:00',
    'Inserting UTC fields into table'
);

SELECT 
message_id,
TO_CHAR(msg_time_as_date              , 'YYYY-MM-DD HH24:MI:SS') AS msg_time_as_date,
TO_CHAR(msg_time_as_timestamp         , 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp,
TO_CHAR(msg_time_as_timestamp_with_tz , 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM') AS msg_time_as_timestamp_with_tz,
TO_CHAR(msg_time_as_timestamp_with_ltz, 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp_with_ltz
FROM log_messages
ORDER BY message_id;


-- modifying local timezone
ALTER SESSION SET time_zone='America/Los_Angeles';

SELECT 
message_id,
TO_CHAR(msg_time_as_date              , 'YYYY-MM-DD HH24:MI:SS') AS msg_time_as_date,
TO_CHAR(msg_time_as_timestamp         , 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp,
TO_CHAR(msg_time_as_timestamp_with_tz , 'YYYY-MM-DD HH24:MI:SS.FF TZH:TZM') AS msg_time_as_timestamp_with_tz,
TO_CHAR(msg_time_as_timestamp_with_ltz, 'YYYY-MM-DD HH24:MI:SS.FF') AS msg_time_as_timestamp_with_ltz
FROM log_messages
ORDER BY message_id;

-- watch ltz column value carefully before altering timezone and after altering also
