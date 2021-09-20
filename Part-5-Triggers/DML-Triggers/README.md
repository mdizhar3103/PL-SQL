**Privileges to Create OR Alter Triggers**
Own the Table: 
```
>>> ALTER TABLE/ ALTER ANY TABLE
>>> CREATE TRIGGER/ CREATE ANY TRIGGER

>>> ADMINISTER DATABASE TRIGGER
```
Own the Trigger:
```
>>> ALTER TRIGGER
>>> ALTER ANY TRIGGER
```
Previlege on Referenced Objects
- EXECUTE Privilege on reference subprograms
- Object privileges on schema objects
- Privileges are granted directly and not through the role
***Syntax for Creating***
```
CREATE [OR REPLACE] TRIGGER [SCHEMA.]TRIGGER_NAME
BEFORE|AFTER
DML_EVENT(s)
ON OBJECT_NAME
[FOR EACH ROW]
<TRIGGER_BODY>

Example:

CREATE OR REPLACE TRIGGER demo.items_bs_upd_trig
  BEFORE UPDATE ON demo.items FOR EACH ROW
DECLARE
...
BEGIN
...
EXECPTION
...
END;
```
Recompiling Triggers
```
ALTER TRIGGER demo.items_bs_upd_tr COMPILE;
```
**Viewing Trigger information**
- USER_TRIGGERS
- DBA_TRIGGERS
- ALL_TRIGGERS

> See script-1.sql, example for simple statement and row triggers.
> Observer the order of execution
> Create mulitple triggers of same type

----------------------
**Pseudorecords & Correlation Names**
Applicable for row DML triggers
Correlation Names
- OLD: Before values
- NEW: After values
- PARENT: Parent row value for nested table

***Record Structure: table%ROWTYPE***
- Record level operation are not allowed 
- Trigger cann't change OLD field values 
- After trigger can't change NEW values

Creating Triggers: Referencing Clause
```
CREATE [OR REPLACE] TRIGGER [SCHEMA.]TRIGGER_NAME
BEFORE|AFTER
DML_EVENT(s)
ON OBJECT_NAME
[REFERENCING NEW AS NEW OLD AS OLD PARENT AS PARENT]
[FOR EACH ROW]
<TRIGGER_BODY>

Example:
CREATE OR REPLACE TRIGGER demo.items_br_upd_trig
  BEFORE UPDATE ON demo.items 
  REFERENCING NEW AS NEWER OLD AS OLDER
  FOR EACH ROW
BEGIN
    :NEWER.item_update_user := USER;
    :NEWER.item_update_datetime := SYSTIMESTAMP;
END;

----

CREATE [OR REPLACE] TRIGGER [SCHEMA.]TRIGGER_NAME
BEFORE|AFTER
DML_EVENT(s)
ON OBJECT_NAME
[FOR EACH ROW]
[WHEN (CONDITION)]
<TRIGGER_BODY>

Example:
CREATE OR REPLACE TRIGGER demo.accounts_br_upd_trig
  BEFORE UPDATE ON demo.accounts 
  FOR EACH ROW
  WHEN (NEW.act_bal < 1000)
BEGIN
    DBMS_OUTPUT.PUT_LINE('Old Balance: '||OLD.act_bal);
    DBMS_OUTPUT.PUT_LINE('New Balance: '||New.act_bal);
    RAISE_APPLICATION_ERROR(-20000, 'Low Balance);
END;

<!-- Specifying on columns -->
CREATE OR REPLACE TRIGGER demo.accounts_br_upd_trig
  BEFORE UPDATE OF act_bal ON demo.accounts 
  FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Old Balance: '||OLD.act_bal);
    DBMS_OUTPUT.PUT_LINE('New Balance: '||New.act_bal);
    IF :NEW.act_bal < 1000 THEN
        RAISE_APPLICATION_ERROR(-20000, 'Low Balance);
    END IF;
END;

<!-- Mulitple DML Events -->
CREATE OR REPLACE TRIGGER demo.accounts_br_ins_upd_del_trig
  BEFORE INSERT OR UPDATE OR DELETE ON demo.accounts 
  REFERENCING NEW AS NEWER OLD AS OLDER
  FOR EACH ROW
BEGIN
    ...
END;

<!-- Mulitple DML Events with conditions -->
CREATE OR REPLACE TRIGGER demo.accounts_br_ins_upd_del_trig
  BEFORE INSERT OR UPDATE OF act_bal OR DELETE ON demo.accounts 
  REFERENCING NEW AS NEWER OLD AS OLDER
  FOR EACH ROW
  WHEN (TO_CHAR(SYSDATE,'HH24')>20)
BEGIN
    ...
END;

<!-- Mulitple DML Events with Columns conditions -->
CREATE OR REPLACE TRIGGER demo.accounts_br_ins_upd_del_trig
  BEFORE INSERT OR UPDATE OF act_bal, act_cust_id OR DELETE ON demo.accounts 
  REFERENCING NEW AS NEWER OLD AS OLDER
  FOR EACH ROW
BEGIN
    IF INSERTING THEN 
    ...
    IF UPDATING('act_bal') THEN
    ...
    IF UPDATING('act_cust_id') THEN
    ...
    IF DELETING THEN
    ...

END;

```
> See script-2.sql
> Create triggers with referencing clause
> Mulitple DML events
> Conditional predicates (script-3.sql)
> Conditions (script-4.sql, script-5.sql)

-------------------------
**Enabling & Disabling Triggers**
- Disabling triggers because of large data loads
- Since Oracle 11g, triggers are enable by disable

```
>>> ALTER TRIGGER [SCHEMA.]TRIGGER_NAME DISABLE;
<!-- Disabling all triggers on the table -->
>>> ALTER TRIGGER [SCHEMA.]TABLE_NAME DISABLE ALL TRIGGERS;

<!-- For Enabling replace disable with enable -->
>>> ALTER TRIGGER [SCHEMA.]TRIGGER_NAME ENABLE;
<!-- Disabling all triggers on the table -->
>>> ALTER TRIGGER [SCHEMA.]TABLE_NAME ENABLE ALL TRIGGERS;
```
__*Dropping Triggers:*__
```
>>> DROP TRIGGER <TRIGGER_NAME>;
```
> See script-6.sql 

### Trigger Restictions
- Size can't exceed 32K
- No transaction control or DDL statements allowed
    - Except when using Autonomous Triggers (using PRAGMA)
- LONG and LONG RAW Data type restriction
    - Trigger cannot declare variables of these types
    - SQL statement in the trigger can only reference them if they can be converted to CHAR or VARCHAR2
    - Cannot use correlation names with these
- Cannot access SERIALLY_REUSABLE package
- Mutating table
