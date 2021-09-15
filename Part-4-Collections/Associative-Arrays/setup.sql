CREATE TABLE CUSTOMERS(cust_id NUMBER NOT NULL PRIMARY KEY,
                       cust_name VARCHAR2(100) NOT NULL,
                       cust_location Varchar2(2) NOT NULL);
                       
CREATE TABLE ACCOUNTS
   (act_id NUMBER NOT NULL PRIMARY KEY,
    act_cust_id NUMBER NOT NULL,
    act_bal NUMBER(10, 2),
    CONSTRAINT act_cust_fk FOREIGN KEY (act_cust_id) 
    REFERENCES customers(cust_id));
                      
CREATE TABLE ITEMS(item_id NUMBER NOT NULL PRIMARY KEY,
                   item_name VARCHAR2(100)  NOT NULL,
                   item_value NUMBER(5,2) NOT NULL);
                   
CREATE TABLE ORDERS(order_id NUMBER NOT NULL PRIMARY KEY,
                    order_item_id NUMBER NOT NULL,
                    order_act_id  NUMBER NOT NULL,
                    CONSTRAINT order_item_fk FOREIGN KEY (order_item_id) REFERENCES items(item_id),
                    CONSTRAINT order_act_fk FOREIGN KEY (order_act_id) REFERENCES accounts(act_id));
                    
CREATE TABLE TEMP_TABLE(dummy NUMBER);

-- Insert into the customer table
INSERT INTO customers(cust_id, cust_name, cust_location) VALUES (1, 'John', 'WA');
INSERT INTO customers(cust_id, cust_name, cust_location) VALUES (2, 'Jack', 'CA');
INSERT INTO customers(cust_id, cust_name, cust_location) VALUES (3, 'Jill', 'CA');

-- Insert into accounts table
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (1, 1, 1000);
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (2, 2, 1000);
INSERT INTO accounts(act_id, act_cust_id, act_bal) VALUES (3, 3, 1000);

-- Insert into items table
INSERT INTO items(item_id, item_name, item_value) VALUES (1, 'Treadmill', 100);
INSERT INTO items(item_id, item_name, item_value) VALUES (2, 'Elliptical', 600);
INSERT INTO items(item_id, item_name, item_value) VALUES (3, 'Bike', 600);


--  Insert into orders table
INSERT INTO ORDERS VALUES(3,3,3);
INSERT INTO ORDERS VALUES(1,1,1);
INSERT INTO ORDERS VALUES(2,2,2);

-- create a sequence
CREATE SEQUENCE orders_seq START WITH 1 INCREMENT BY 1;
COMMIT;


