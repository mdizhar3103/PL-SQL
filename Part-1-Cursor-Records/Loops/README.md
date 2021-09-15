## Loops in PL/SQL
- Simple Loop
- For loop
- While Loop

**Loop Termination**
- Implicit Exit
    - For loop
    - While loop
- Explicit Exit
    - EXIT
    - EXIT WHEN <condition>
    - RETURN
    - GOTO    - transferred to the statement labeled named (generally it is avoided
    - EXCEPTION
----------
**FOR LOOP**
```
[label] FOR loop_counter IN [REVERSE] lower_bound..upper_bound LOOP
        group_of_statements
    END LOOP[label];

```
*See script-11.sql*
> **Reverse for loop:** See script-12.sql
> **For loop using expression:** See script-13.sql
> **SQL query for loop:** See script-14.sql
> **Continue keyword:** See script-15.sql
> **Nested Loops with labels:** See script-16.sql
> **Nested Loops with labels and when condition:** See script-17.sql
> **Nested Loops with labels and continue condition:** See script-18.sql
----------
**WHILE LOOP**
*See script-19.sql*
