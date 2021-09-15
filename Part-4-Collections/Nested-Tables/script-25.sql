DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
    l_final_nt items_nt;
BEGIN
    l_final_nt := l_first_nt MULTISET UNION l_second_nt;
    FOR i IN l_first_nt.FIRST .. l_first_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_first_nt(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('After applying the set operator');
    l_final_nt := SET(l_final_nt);
    FOR i IN l_final_nt.FIRST .. l_final_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_final_nt(i));
    END LOOP;
END;
/

/* OUTPUT
Statement processed.
Bike
Bike
Treadmill
Treadmill
Elliptical
Elliptical
After applying the set operator
Bike
Treadmill
Elliptical
*/

-- UNION DISTINCT
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
    l_final_nt items_nt;
BEGIN
    l_final_nt := l_first_nt MULTISET UNION DISTINCT l_second_nt;
    FOR i IN l_final_nt.FIRST .. l_final_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_final_nt(i));
    END LOOP;
 
END;
/

/*OUTPUT
Statement processed.
Bike
Treadmill
Elliptical
*/

-- INTERSECT
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
    l_final_nt items_nt;
BEGIN
    l_final_nt := l_first_nt MULTISET  INTERSECT l_second_nt;
    FOR i IN l_final_nt.FIRST .. l_final_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_final_nt(i));
    END LOOP;
 
END;
/

/*OUTPUT
Statement processed.
Ellipticall
Elliptical
*/

-- INTERSECT DISTINCT
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
    l_final_nt items_nt;
BEGIN
    l_final_nt := l_first_nt MULTISET  INTERSECT DISTINCT l_second_nt;
    FOR i IN l_final_nt.FIRST .. l_final_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_final_nt(i));
    END LOOP;
 
END;
/

/*OUTPUT
Statement processed.
Elliptical
*/

-- EXCEPT
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
    l_final_nt items_nt;
BEGIN
    l_final_nt := l_first_nt MULTISET EXCEPT  l_second_nt;
    FOR i IN l_final_nt.FIRST .. l_final_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_final_nt(i));
    END LOOP;
 
END;
/

/*OUTPUT
Statement processed.
Bike
Bike
Treadmill
Treadmill
*/

-- EXCEPT DISTINCT
DECLARE
    TYPE items_nt IS TABLE OF VARCHAR2(60);
    l_first_nt items_nt := items_nt('Bike', 'Bike', 'Treadmill','Treadmill', 'Elliptical', 'Elliptical');
    l_second_nt items_nt := items_nt('Elliptical', 'Elliptical');
    l_final_nt items_nt;
BEGIN
    l_final_nt := l_first_nt MULTISET EXCEPT  l_second_nt;
    FOR i IN l_final_nt.FIRST .. l_final_nt.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(l_final_nt(i));
    END LOOP;
 
END;
/

/*OUTPUT
Statement processed.
Bike
Treadmill
*/

