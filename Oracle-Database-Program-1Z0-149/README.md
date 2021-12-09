### Oracle Database Programming with PL/SQL

__Exam Information__
- Exam Number: 1Z0-149
- MCQ based
- Duration 90 minutes
- Number of Question 65 (passing 66%)

**PL/SQL Lexical Units**
- Identifiers:
    - Name a varaible, sub-program or package
    - Letters, numbers, underscores, and dollar signs are allowed
    - Spaces, hyphens, and slashes are not allowed
    - Identifier`emp num` is invalid, while `emp_num` or `emp$num` or `"emp nuum"` are valid
- Literals
    - Represents an explicit value
    - Integer literal
    - Real literal
    - Character literal
    - String literal
    - Boolean literal
    - Datatime literal
- Comments
    - Single line comments -> --
    - Block comments -> /* */
    - Nested comments not allowed
- Delimiters
    - Symbols with special meaning
    - Simple Symbols -> +, -, * 
    - Compound Symbols -> =:, ||, &&


*See lexical_units.sql*

--------

### Using Built-in Functions and Expressions

- **Scalar Functions:**
    - Numeric Functions: abs(), sqrt(), trunc(), round(), etc
    - Text Functions: length(), lower(), substr(), upper(), etc
    - Date Functions: sysdate(), add_months(), months_between(), etc
    - Conversion Functions: to_char(), to_number(), to_date(), etc
- **Grouping Functions:**
    - count(), max(), min(), etc

**Implicit Datatype Conversion Rules**
- The type of the value to the right of the equal sign is converted to the datatype to its left
- An insert and update will convert the value to the type of the destination column
- A select will convert the value of the column to the type defined in the program
- A concatenation operation converts a non character datatype to a character datatype
- A built-in function converts a parameter to the accepted format before performing the operation
- Drawbacks are:
    - Harder to interpret
    - Affects the runtime performance
    - Underlying conversion algorithm may change across releases

*See built_exp.sql*

---------

### Simplifying a PL/SQL Program Using Nested Blocks

__General Naming Standards__
- Avoid using alphabet variables
- Use an underscore in longer variable names
    - Prefix the local variables with l_
    - Prefix the global variables with g_
    - Prefix constants with c_
- Capitalize all SQL keywords and built-in functions
- Use three spaces for indenting your code
- Avoid using __tab__ character
- Maintain a space before and after the relational operators
- Add a header comment that includes description, author name, and the version number

```SQL
/*
==========================
Author      : Izhar
Version     : 1.0
Description : Demo Program
==========================
*/

```

*See nested.sql*

> For more info refer Oracle documentation
