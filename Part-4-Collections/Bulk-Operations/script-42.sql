--Delete from the orders table
DELETE FROM orders;
﻿--Delete all the items from the items table
DELETE FROM items;
COMMIT;
/
DECLARE
   TYPE  number_aa IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
   TYPE  varchar_aa IS TABLE OF VARCHAR2(60) INDEX BY BINARY_INTEGER;
   l_itemid_aa number_aa;
   l_itemname_aa varchar_aa;
   l_itemvalue_aa number_aa;
   l_start_time NUMBER;
   l_end_time NUMBER;
   l_time_normal NUMBER;
   l_time_forall NUMBER;
BEGIN
  -- First let us fill the associative arrays  
   FOR i IN 1..100000 LOOP
     l_itemid_aa(i):= i;
     l_itemname_aa(i) := 'Item'||i;
     l_itemvalue_aa(i):= 600;
   END LOOP;
   
  -- First let us insert using a normal for loop
  --Start Timing
  l_start_time := DBMS_UTILITY.GET_TIME;
   FOR i IN 1..50000  LOOP
     INSERT INTO items(item_id, item_name, item_value)
                VALUES(l_itemid_aa(i),l_itemname_aa(i),l_itemvalue_aa(i));
   END LOOP;
   --End Timing
  l_end_time := DBMS_UTILITY.GET_TIME;
  l_time_normal := (l_end_time-l_start_time)/100;
  DBMS_OUTPUT.PUT_LINE('Elapsed time for normal loop insert '||l_time_normal);
   COMMIT;
   
  -- Nxt let us insert using a forall loop
  --Start Timing
  l_start_time := DBMS_UTILITY.GET_TIME;
   FORALL i IN 50001..100000 
     INSERT INTO items(item_id, item_name, item_value)
                VALUES(l_itemid_aa(i),l_itemname_aa(i),l_itemvalue_aa(i));
   --End Timing
  l_end_time := DBMS_UTILITY.GET_TIME;
  l_time_forall :=  (l_end_time-l_start_time)/100;
  DBMS_OUTPUT.PUT_LINE('Elapsed time for a forall loop insert '||l_time_forall);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Normal for loop insert took '||trunc(l_time_normal/l_time_forall) ||' times more time then forall insert');
END;
