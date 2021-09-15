SELECT * FROM items order by item_id; --10 items 1-10
SELECT * FROM orders; --order item id 1..2..3
/
DECLARE
   TYPE id_aa  IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   l_id_aa       id_aa ;
   l_error_count NUMBER;
   l_index NUMBER;
   l_item_id NUMBER;
   
   array_dml_exception EXCEPTION;
   PRAGMA EXCEPTION_INIT (array_dml_exception, -24381);

BEGIN
   l_id_aa(1) := 21;
   l_id_aa(2) := 3;
   l_id_aa(3) := 25;
   l_id_aa(4) := 2;

   FORALL i IN l_id_aa.FIRST..l_id_aa.LAST SAVE EXCEPTIONS
      DELETE FROM items
      WHERE item_id = l_id_aa(i); 
EXCEPTION
   WHEN array_dml_exception THEN
     l_error_count := SQL%BULK_EXCEPTIONS.COUNT;
     FOR i in 1..l_error_count LOOP
           l_item_id := l_id_aa(SQL%BULK_EXCEPTIONS(i).ERROR_INDEX );
           DBMS_OUTPUT.PUT_LINE('Error occured at index '||SQL%BULK_EXCEPTIONS(i).ERROR_INDEX||' for item id '||
                                 l_item_id ||' for error message '||
                                 SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));     
    END LOOP;
END;
/
SELECT * FROM items order by item_id;
ROLLBACK;
/
SELECT * FROM orders; --order item id 1..2..3 item id count 1, item id 2 count 2, item id 3 count 3
/
DECLARE
   TYPE id_aa  IS TABLE OF PLS_INTEGER INDEX BY PLS_INTEGER;
   l_id_aa       id_aa ;
   l_error_count NUMBER;
   l_index NUMBER;
   l_item_id NUMBER;
   
   array_dml_exception EXCEPTION;
   PRAGMA EXCEPTION_INIT (array_dml_exception, -24381);

BEGIN
   l_id_aa(1) := 1;
   l_id_aa(2) := 2;
   l_id_aa(3) := 3;

   FORALL i IN l_id_aa.FIRST..l_id_aa.LAST SAVE EXCEPTIONS
      DELETE FROM orders
      WHERE order_item_id = l_id_aa(i); 
   FOR  i IN l_id_aa.FIRST..l_id_aa.LAST LOOP
     DBMS_OUTPUT.PUT_LINE('Rows affected for index '||i||' is '||SQL%BULK_ROWCOUNT(I));
   END LOOP;
EXCEPTION
   WHEN array_dml_exception THEN
     l_error_count := SQL%BULK_EXCEPTIONS.COUNT;
     FOR i in 1..l_error_count LOOP
           l_item_id := l_id_aa(SQL%BULK_EXCEPTIONS(i).ERROR_INDEX );
           DBMS_OUTPUT.PUT_LINE('Error occured at index '||SQL%BULK_EXCEPTIONS(i).ERROR_INDEX||' for item id '||
                                 l_item_id ||' for error message '||
                                 SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));     
    END LOOP;
END;
/
ROLLBACK;
