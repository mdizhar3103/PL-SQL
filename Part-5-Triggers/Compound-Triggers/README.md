## Follows & Precedes Clause in Triggers
**Follows Clause**
- Conventional triggers
- Enabled trigger (trigger should be enabled)
- Defined on the same table
- Defined on the same timing point
- Forward crossedition triggers (after 11g, can update application with zero downtime)

**Preceds Clause**
- Applicable for reverse crossedition triggers only

> See script-7.sql

------------------------
## Compound Triggers
- Easier Code organization
- All timing points in one trigger
    - Before statement
    - Before each row
    - After each row
    - After statement
- Share common data
- Increases performance: Accumulate Rows for Bulk DML
- Avoid mutating table error

***Compound Triggers Restrictions***
- DML triggers defined on the table or view
- Can't be autonomous
- No initalizing or exception block
- Exception in one section can't be handled by another
- :OLD, :NEW, :PARENT can't appear in the declarative part, the BEFORE STATEMENT section, or the AFTER STATEMENT section.
- only the BEFORE EACH ROW section can change the value
- Can exsit with simple triggers with indeterminate firing
- Exceptions rollback the dml statement but side effects

> See script-8.sql
