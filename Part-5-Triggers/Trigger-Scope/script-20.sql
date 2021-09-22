CREATE OR REPLACE VIEW customer_accounts AS
  SELECT act_id,
         act_bal,
         act_cust_id,          
         cust_name
    FROM accounts,
         customers
   WHERE cust_id = act_cust_id;

select * from customers;
select * from accounts order by act_id;
SELECT * FROM customer_accounts order by act_id;


INSERT INTO customer_accounts (act_id, act_cust_id,act_bal) VALUES (4,4,100); -- This will succeed because the customers table is key-preserved
select * from accounts;
SELECT * FROM customer_accounts;
select * from customers;
update customer_accounts set cust_name = 'Joe' WHERE act_cust_id = 2; --ORA-01779: cannot modify a column which maps to a non key-preserved table
--This view can be used to check which columns are updatable

SELECT * FROM USER_UPDATABLE_COLUMNS WHERE TABLE_NAME = 'CUSTOMER_ACCOUNTS';
INSERT INTO customer_accounts (act_id,act_bal,act_cust_id,cust_name) VALUES (5,1000,5,'Allen'); --Our intention here is to add a fourth customer with cust_id 4 and cust_name Allen
-- and also insert and account for that customer with act_id 5 and account balance 1000. But this will fail for 
--SQL Error: ORA-01776: cannot modify more than one base table through a join view

DELETE FROM customer_accounts where act_id = 4; -- This succeeds as there is only one key preserved table accounts from
--which it deletes. But what if our intent was also to delete from the customers table

select * from accounts;
SELECT * FROM customers;
SELECT * FROM customer_accounts;
DELETE FROM customer_accounts where act_cust_id = 4; -- Since there is only one key preserved table in the join this will succeed and will delete the corresponding row from the accounts
-- table even though our intention might have been to delete from both the customers and accounts table. Let us rollback and see how we can accomplish our objectives of say updating customer name
-- from the view, or inserting both a new customer id and an account from it using an insert statement or finally deleting both from the customers and accounts table for the delete by customer name
-- using instead of triggers

--Specifying UPDATE OF cust_name will result in ORA-04073: column list not valid for this trigger type
CREATE OR REPLACE TRIGGER customer_accounts_insteadof
   INSTEAD OF INSERT  OR UPDATE OR DELETE ON customer_accounts
   DECLARE
     l_duplicate_record EXCEPTION;
     PRAGMA EXCEPTION_INIT (l_duplicate_record, -00001);
   BEGIN
     IF INSERTING THEN
       DBMS_OUTPUT.PUT_LINE('Inside inserting');
       IF :NEW.cust_name IS NOT NULL THEN
         INSERT INTO customers(cust_id, cust_name) VALUES(:NEW.act_cust_id, :NEW.cust_name);
       END IF;
       INSERT INTO accounts (act_id, act_cust_id, act_bal) VALUES(:NEW.act_id, :NEW.act_cust_id, :NEW.act_bal);
     END IF;
     IF UPDATING THEN
       DBMS_OUTPUT.PUT_LINE('Inside updating');
       IF :NEW.cust_name IS NOT NULL AND :NEW.cust_name != :OLD.cust_name THEN 
         UPDATE customers
           SET  cust_name = :NEW.cust_name
           WHERE cust_id = :OLD.act_cust_id;
       END IF;
     END IF;     
     IF DELETING THEN
       DBMS_OUTPUT.PUT_LINE('Inside deleting');
       DELETE from accounts WHERE act_cust_id = :OLD.act_cust_id;
       DELETE from customers WHERE cust_id = :OLD.act_cust_id;
     END IF;
   EXCEPTION
     WHEN l_duplicate_record THEN
       RAISE_APPLICATION_ERROR (
         num=> -20001,
         msg=> 'Duplicate account or customer id');
   END customer_accounts_insteadof;
/


SELECT * from accounts;
SELECT * FROM customers;
INSERT INTO customer_accounts (act_id,act_bal,act_cust_id,cust_name) VALUES (5,1000,5,'Allen');
SELECT * from accounts;
SELECT * FROM customers;
UPDATE customer_accounts set cust_name = 'Jeff' WHERE act_cust_id = 2;
SELECT * FROM customer_accounts;
DELETE FROM customer_accounts WHERE act_cust_id = 5;
SELECT * FROM customer_accounts;
SELECT * from accounts;
SELECT * FROM customers;




