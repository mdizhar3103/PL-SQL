## Triggers
```
    Triggering Event --> Trigger Target --> Trigger Action

Examaple in Database:

    Insert --> Table --> PL/SQL Code
```
Need for triggers:
- Complex Validations 
- Cental Validation 
- Security Enforcement
- Value Based Auditing
- Logging
- DML against Views
- Publishing Informatoin
- Maintenance Tasks
- Referential Integrity

DML Triggers:
- Insert/Update/Delete --> Table --> PL/SQL Code
- __Instead of Triggers__ are used to perform triggers on views (as they are directly not updatable)
- Timing Point can be Define in DML triggers (Before/After), but not applcable for Instead of Triggers

System Triggers:
- __Schema Trigger__: DDL --> Schema --> PL/SQL Code
- __Database Trigger__: Startup/Shutdown/Logon --> Database --> PL/SQL Code
- We can have timing point in system trigger also, but not applicable in certain events.

-------------

Folder Sequence:
1. DML-Triggers

