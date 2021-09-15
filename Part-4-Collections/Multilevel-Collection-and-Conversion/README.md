## Multilevel Collection
***Nesting Collections:*** Collection within collection
- Associative Array within another Associative Array
*See script-32.sql*
- Nested Table within another Nested Table
*See script-33.sql*
- Nested Table within a Varray

**CAST AND COLLECT FUNCTION**
- Convert Varray to Nested Table or vice versa
*See script-34.sql*
- Convert Inner subquery to named collection type
> Syntax:
```
CAST(
    (expr)/
    MULTISET (subquery)
    AS <type name>
)
```