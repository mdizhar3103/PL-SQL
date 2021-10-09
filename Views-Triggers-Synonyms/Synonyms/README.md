### Synonyms
- A synonym is an alias or an alternate for another object in the database
- Used to create an alias
- Synonyms can be created for tables, views, stored, procedures, funcitons, package or sequence
- Commonly used to assign a more meaningful name to an existing database object

**Types of Synonyms**
1. Private Synonym:
    - Alternate name is only available to the creating user
    - Most common type of synonym

2. Public Synonym:
    - available to all users in the oracle
    - Requires the create public synonym privilege

*Syntax for creating synonym*
```
<!-- private synonym -->
CREATE OR REPLACE SYNONYM <<synonym_name>>
FOR <<target_object_name>>;

<!-- public synonym -->
CREATE OR REPLACE PUBLIC SYNONYM <<synonym_name>>
FOR <<target_object_name>>;
```
***Example for creating synonym***
```
SELECT * FROM facilities.room
WHERE building_code = 'MH';

CREATE SYNONYM rooms 
FOR facilities.rooms;

SELECT * FROM rooms
WHERE building_code = 'MH';
```
