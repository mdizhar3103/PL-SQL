-- <!-- add 1 day to current time -->
SELECT sysdate + 1  dual;

-- <!-- get date/time for 30 days ago -->
SELECT * FROM log_messages
WHERE message_time > sysdate - 30;

-- <!-- Adding Fractional Values -->
UPDATE column_name
SET column_name_date_datatye = sysdate + 1/24
WHERE column_name = value;

-- <!-- who has logged in the last 12 hours -->
SELECT * FROM system_logins
WHERE login_date >= sysdate - 0.5;

-- <!-- Adding Months to Date or Timestamp -->
SELECT 
ADD_MONTHS(DATE '2012-02-01', 12) AS twelve_months_added,
DATE '2012-02-01' + 365 AS added_365_days
FROM dual;

-- <!-- Subtracting dates -->
SELECT 
TO_DATE('2014-02-01 15:32', 'YYYY-MM-DD HH24:MI') - 
TO_DATE('2014-01-17 9:32', 'YYYY-MM-DD HH24:MI')
AS diff 
FROM dual;

-- <!-- Subtracting Timestamp values -->
SELECT 
TIMESTAMP '2014-11-30 22:00:00.000000' -
TIMESTAMP '2014-11-30 21:36:14.23'
AS diff
FROM dual;

-- <!-- Calculating month beteen two dates -->
SELECT
MONTHS_BETWEEN (DATE '2014-4-08', DATE '2001-08-24') 
AS diff
FROM dual;
