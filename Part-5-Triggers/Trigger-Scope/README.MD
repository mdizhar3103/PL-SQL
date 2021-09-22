## System Triggers: DDL Events
- Both Database and schema
- Existing transaction context
- Both before and after
- Some DDL events are:
    - Alter
    - Analyze
    - Audit
    - Comment
    - Create
    - Associate Statistics
    - Drop
    - DDL
    - Rename
    - Revoke
    - Grant
    - Noaudit
    - Dissociate Statistics
- Applicable at Both Database and schema except
    - After Startup at Database only
    - Before Shutdown at Database only
    - After DB_role_change
    - After servererror
    - After Logon
- Separate transaction Context 
    - Before Logoff
    - After Suspend
    - After Clone (at Container Database only)
    - Before Unplug (at Container Database only)
    - Before/After Set Container (at Container Database only)

**Oracle Multitenant Architecture**
```
    +=====================================================+
    |             Container Database (CDB)                |
    |                     +----------+                    |
    |                     |   Root   |                    |
    |                     +----------+                    |
    |                                                     |
    |    +----------+     +----------+     +----------+   |
    |    |   Seed   |     |   PDB 1  |     |   PDB 2  |   |
    |    +----------+     +----------+     +----------+   |
    |                                                     |
    +=====================================================+

    Common User                                 Local User
```
- **Root:** Maintains Common Dictionary views for PDB's
- **PDB's:** Mulitple individual database called plugable databases
- **Seed:** Temporarily database to create new plugable databases
- These plugable database share the server resources like CPU, memory and have common background processes. Some may be utilizing the resources and some might be failing due to lack of resources. Each however maintains independent files and set of schema.
- **Common User:** Has a single login and access acroos the root and the pluggable databases
- **Local User:** Have access to local PDB's, they are assigned to.
- **Container Database (CDB)**
    - Log in as common user
    - ADMINISTER DATABASE TRIGGER
    - After DB_role_change event is used to defined at this level only
- **plugable Database**
    - Log in as common/local user
    - ADMINISTER DATABASE TRIGGER in PDB context 
    - After Clone and Before Unplug (are triggers handled at this level)

--------------------
> To get list of Event Attributes refer to [doc](https://docs.oracle.com/cd/B12037_01/appdev.101/b10795/adfns_ev.htm)
> See scripts-16.sql

----------------------

**Instead of Triggers**
- Instead of Create Trigger
    - Are System Trigger
    - Used when to add partitioning clause
    - To automatically add additional columns/ attributes
    - Can be create at database and schema level
    - See script-19.sql
- Instead of DML Trigger
    - DML against non-editioning views
    - Nested table column of non-editioning view
    - Only way to issue dml against a non-updatable view
    - **Non-update Views**
        - If query has Aggregate function like sum, min, etc
        - DISTINCT
        - GROUP BY
        - UNION OR UNION ALL
        - Uses subquery in select list
        - Some sort of joints
        - Updation is performed on Key preserved table basis
        - User_updatable_columns (function to check which columns of views are updatable or deletable)
    - Doesn't have after/before
    - See script-20.sql