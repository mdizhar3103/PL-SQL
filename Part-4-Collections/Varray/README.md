## Collection type - Varray
- Variable size array 
- Maximum size specified at declaration
- Always dense (doesn't allow gaps)
- Database level
- Piecewise operation not allowed (need to swap whole array with new one)
- Equivalent to array type in other programming languages
**Declare at:**
- Anonymous block
- Stored subprograms
- Schema Type
- Table column
**Usage Guidelines:**
- Max number of elements is known
- Element are accessed sequentially
- Fewer number os rows
- Maintaining order of elements is important
**Defining Varrays**
```
TYPE <type_name> IS VARRAY(szie_limit) OF <element_type> [NOT NULL];

Declare type ===> Declare variable
```
**Initializing Varrays**
```
*Using Constructor with arguments*
>TYPE items_va IS VARRAY(5) OF VARCHAR2(60);
>l_items_va items_va;
>l_items_va := items_va('Bike', 'Treadmill');
*Using Constructor without args*
>TYPE items_va IS VARRAY(5) OF VARCHAR2(60);
>l_items_va items_va := items_va();
```
*See script-28.sql*
**Adding/Deleting Elements**
- Extend
- Extend(n)
- Extend(n, i)
- Delete
- Reducing size using TRIM, TRIM(n)
- Reassignment will override the value
- Assigning empty array
*See script-29.sql*
**Exceptions During Assignment in Varrays**
- Value Error
- Uninitialized collection
- Not null constraint
- Subscript beyond count
*See script-30.sql*
**Schema Level Varrays**
*See script-31.sql*
