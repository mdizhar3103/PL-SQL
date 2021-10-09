### Sequence
- Used to generate unique integer values
- Guaranteed to be thread safe 

*Syntax for creating*
```
CREATE SEQUENCE <<sequence_name>>
[INCREMENT BY <<interval>>]
[START WITH <<starting_value>>]
[CACHE <<value>> | NOCACHE]
[MINVALUE <<minimum_value>>]
[MAXVALUE <<maximum_value>>]
[CYCLE];
```
**Sequences Options**
|Options | Purpose | Default value|
|--------|---------|--------------|
|INCREMENT BY | Interval between generated values| 1 |
| START WITH | Starting value of sequence | 1 |
| CACHE | Number of values to cached in memory| 20 |
| MINVALUE | Minimum value of the sequence | 1 or -10^26 |
| MAXVALUE | Maximum value of the sequence | 10^27 or -1 |

**Retrieving Sequences Values**
```
<!-- next value of sequence -->
SELECT my_sequence.nextval FROM dual;

<!-- current value from the sequence -->
SELECT my_sequence.currval FROM dual;
```

**Using Sequences in an INSERT statement**
```
INSERT INTO students (
    student_id, first_name, last_name, email, city, state, zip)
VALUES (
    seq_student.nextval, 'Mohd', 'Izhar', 'abc@gmail.com', 'Mumbai', 'IN', '123434');
```

