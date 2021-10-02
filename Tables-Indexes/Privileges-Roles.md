## Privileges and Roles

- Full Access to All Objects: applications could read, write data it is not suposed to 
- Schema Changes: Should an application be adding, dropping tables on the fly?
- Who is running SQL?

**GRANT AND REVOKE Commands**
Grant: Gives a user Privileges on an object
Revoke: Remove privileges on an object

*Syntax*
```
GRANT <privileges> ON <object> TO <user>;

GRANT select ON students FROM student_web, faculty_web ;
GRANT select, update ON students FROM student_web;

REVOKE update ON students FROM student_web, faculty_web ;
REVOKE insert ON courses FROM faculty_web;
```

**Privileges available for object-Table**
- ALTER
- DEBUG
- DELETE
- INDEX
- INSERT
- READ
- REFERENCES
- SELECT
- UPDATE

**Privileges available for object-View**
- DEBUG
- DELETE
- INSERT
- READ
- REFERENCES
- SELECT
- UPDATE

**Column Level Privileges**
```
GRANT update(street_address, city, state, telephone, email) ON students TO student_web;
```

> See script-13.sql

**Privileges available for object-Stored Procedure/Function**
- DEBUG
- EXECUTE

--------------------------------------------------------

### Database Roles

- **Definition**: Container to group a set of privileges together
- **Benefit:** Simplify management of permissions

```
CREATE ROLE technology_staff;

# assigning privileges
GRANT select ON departments TO technology_staff;
GRANT select ON courses TO technology_staff;
GRANT select ON students TO technology_staff;

# Assing the role to users
GRANT technology_staff TO john;
GRANT technology_staff TO erica;
GRANT technology_staff TO robert;

```