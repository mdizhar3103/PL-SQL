## Collection Methods used frequently

- **LAST:** Last index in collection
- **EXISTS:** 
    - Checks for existence of index counter 
    - Returns boolean value
- **COUNT:** Returns count of elements in collection
- **DELETE:** Delete all elements from collection
    - **DELETE(n):** 
        - removes element at index n
        - if n is Null does nothing
    - **DELETE(m, n):**
        - removes elemens from m to n (both inclusive)
        - if m > n or both are null, does nothing
- **PRIOR:** Gets prior index counter

*See script-13.sql*

- **TRIM:** Used with Nested Tables and Varrays
    - Removes one element from the end
    - **TRIM(n):** 
        - Removes n elements from the end
        - Can raise subscript beyond count exception
- **EXTEND:** Used with nested Tables and Varrays
    - Adds one null element at the end of collection
    - **EXTEND(n):** Adds n null elements at the end of collection
    - **EXTEND(n,i):** Adds n elements with copy of element i at the end of collection

## Iterating over collections

- FOR LOOP
- WHILE LOOP

**FOR LOOP** - *See script-14.sql*
    - When collection is Dense
    - Wants to access all elements

**WHILE LOOP** - *See script-15.sql*
    - For Sparse Collection