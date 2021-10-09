### Triggers
- A trigger is a block of code that will be executed when an event happens in your database.
- Uses of triggers:
    - Update of administrative columns
    - Synthesize auto-increment columns
    - Audit changes to table
    - Enforce complex business constraints
    - Archiving data
- Types of Triggers:
    - Statement Level Triggers: Fires once before or after a DML statement executes
    - Row Level Triggers: Fires before or after each row is processed
    - System Triggers: Fires on system level (login, logout) or schema level (Create table, alter table) events

*Syntax*
```
CREATE OR REPLACE TRIGGER trigger_name
[BEFORE | AFTER] [INSERT |UPDATE | DELETE]
[OF column_name]
ON table_name
[FOR EACH ROW]
DECLARE
    ...
BEGIN
    ... trigger_code
EXCEPTION
    WHEN ...
    ... exception handling
END;

<!-- Trigger Conditional Predicates -->
CREATE OR REPLACE TRIGGER trigger_name
AFTER INSERT OR UPDATE OR DELETE
ON table_name
FOR EACH ROW
BEGIN
    CASE
    WHEN INSERTING THEN
        -- insert logic code
    WHEN UPDATING THEN
        -- update logic code
    WHEN UPDATING('column_name') THEN
        -- column_specific code
    WHEN DELETING THEN 
        -- delete logic code
    END CASE;
END;

<!-- Accessing old or new values -->
CREATE OR REPLACE TRIGGER trigger_name
AFTER INSERT OR UPDATE OR DELETE
ON table_name
FOR EACH ROW
BEGIN
    INSERT INTO table_name (
        column_name1, column_name2, column_name3, ...
    )
    VALUES(:OLD.column_name1, :OLD.column_name2, ...);
END;

Note: for new values replace old with NEW
```
- Tiggers can't change :OLD field values
- A BEFORE trigger can change to :NEW value of a row

**Enabling and Disabling Triggers
```
<!-- Disabling Triggers -->
ALTER TRIGGER <<trigger_name>> DISABLE;
ALTER TABLE <<table_name>> DISABLE ALL TRIGGERS;

<!-- Enabling Triggers -->
ALTER TRIGGER <<trigger_name>> ENABLE;
ALTER TABLE <<table_name>> ENABLE ALL TRIGGERS;
```
> Note: A commit or rollback statement can't be included with in a trigger body
> Triggers have the transaction scope of the firing DML statement

**Firing Order of Triggers**
```
BEFORE statement --> BEFORE each row --> Statement execution --> AFTER each row --> AFTER statement
```
**Using FOLLOWS and PRECEDES to Control Order**
```
CREATE OR REPLACE TRIGGER trigger_one
BEFORE UPDATE
    ON <table_name>
    FOR EACH ROW
BEGIN
    -- trigger_one definition
END;

CREATE OR REPLACE TRIGGER trigger_two
BEFORE UPDATE
    ON <table_name>
    FOR EACH ROW
    [FOLLOWS | PRECEDES] <trigger_name
BEGIN
    -- trigger_two definition
END;

```