SELECT count(*) FROM items;


DECLARE 
    TYPE itemid_aa IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    l_itemid_aa itemid_aa;
    CURSOR get_item_info_cur IS 
        SELECT item_id
        FROM items;
    l_start_time NUMBER;
    l_end_time NUMBER;
BEGIN
    l_start_time := DBMS_UTILITY.get_time;
    OPEN get_item_info_cur;
        LOOP 
            FETCH get_item_info_cur BULK COLLECT INTO l_itemid_aa LIMIT 100; 
            EXIT WHEN l_itemid_aa.COUNT = 0;
        END LOOP;
    CLOSE get_item_info_cur;
    l_end_time := DBMS_UTILITY.get_time;
    DBMS_OUTPUT.PUT_LINE('Time elapsed in seconds with bulk collect: '||(l_end_time-l_start_time)/100);
END;
/
-- Note the result will be helpful if you have 10000 rows in table


-- Using Normal Cursor fetch without bulk
DECLARE 
    TYPE itemid_aa IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    l_itemid_aa itemid_aa;
    CURSOR get_item_info_cur IS 
        SELECT item_id
        FROM items;
    l_start_time NUMBER;
    l_end_time NUMBER;
BEGIN
    l_start_time := DBMS_UTILITY.get_time;
    OPEN get_item_info_cur;
        LOOP 
            FETCH get_item_info_cur INTO l_itemid_aa(l_itemid_aa.COUNT+1); 
            EXIT WHEN get_item_info_cur%NOTFOUND;
        END LOOP;
    CLOSE get_item_info_cur;
    l_end_time := DBMS_UTILITY.get_time;
    DBMS_OUTPUT.PUT_LINE('Time elapsed in seconds with bulk collect: '||(l_end_time-l_start_time)/100);
END;
/
