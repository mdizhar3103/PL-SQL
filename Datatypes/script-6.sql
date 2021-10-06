
-- adding 45 seconds interval
SELECT TO_CHAR(
    TO_DATE('2014-11-25 14:30:15' , 'YYYY-MM-DD HH24:MI:SS')
    + 1/1920,
    'YYYY-MM-DD HH24:MI:SS') 
AS new_time
FROM dual;

-- doing it in better way as above is not understandable

SELECT TO_CHAR(
    TO_DATE('2014-11-25 14:30:15' , 'YYYY-MM-DD HH24:MI:SS')
    + INTERVAL '0 0:00:45' DAY TO SECOND,
    'YYYY-MM-DD HH24:MI:SS') 
AS new_time
FROM dual;