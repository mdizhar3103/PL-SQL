## Conditional Statements
- CASE Statements
- IF Statements

``` 
IF <condition> THEN
    statements
END IF;
``` 
**Complex IF:**
```
IF (a>b AND b > c) OR (b> a AND c > a) THEN
    statements
END IF;
``` 
**IF ELSE**
```
IF <condition> THEN
    statements
ELSE
    statements
END IF;
```    
**IF ELSIF ELSE**
```
IF <condition> THEN
    statements
ELSIF <condition> THEN
    statements
    ELSE
    statements
END IF;
``` 
> Note: We can nest if elsif else statements
*See script-20.sql*
---------------
**CASE Statements**
```
CASE {variable or expression}
    WHEN value_1 THEN
        statements_1
    WHEN value_n THEN
        statements_n
        
    [ELSE statements_default]
END CASE;
``` 
> Note: CASE_NOT_FOUND exception is raised if case error is occurred
*See script-21.sql to script-23.sql*