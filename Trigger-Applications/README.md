## Auditing
- Trigger for value based auditing
- Use oracle's built-in auditing features

> See script-21.sql
----

## Logging
- Log information about events
- Autonomous trigger (to commit log information irrespective the parent transaction is committed or rolled back)

> See script-22.sql
> See script-23.sql (Autonomous trigger)
---

## Automate Tasks
- Open PDB's automatically in the after database startup trigger of the CDB
- Pin commonly used packages in the shared pool in the ater db startup trigger
- Set NLS session Settings, optimizer mode, plsl_compiler flag, etc
- Automatically add partitioning clause to table definition

**Enforce Referential Integrity**
- Parent & child on different nodes
- Trigger on child to enure parent key is present
- Trigger on parent to restrict, cascade or set null

> See script-24.sql
------

## Publishing Events
- Applications subscribed to system events
- Advanced Queuing 
---
## Enforcing Complex Security Checks
- create complex security check
- can't be defined using standard check constraints

> See script-25.sql
---

