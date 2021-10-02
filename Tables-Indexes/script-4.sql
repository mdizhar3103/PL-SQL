CREATE TABLE orders(
    order_id       NUMBER(10)   NOT NULL,
    order_date     DATE         NOT NULL,
    customer_id    NUMBER(10),
    subtotal       NUMBER(10,2),
    tax            NUMBER(10,2),
    shipping       NUMBER(10,2),
    grand_total    NUMBER(10,2)  AS (subtotal + tax + shipping) VIRTUAL
);

-- Note: By default virtual columns datatype are optional
-- oracle compute datatype from expression and assign it.

-- Using functions in virtusl columns
CREATE TABLE students5
(
    student_id       NUMBER(10)    NOT NULL,
    first_name       VARCHAR2(30)  NOT NULL,
    middle_name      VARCHAR2(30)  NOT NULL,
    last_name        VARCHAR2(30)  NOT NULL,
    email_address    VARCHAR2(60)  NOT NULL,
    email_domain     VARCHAR2(60)  AS (
        SUBSTR(email_address, INSTR(email_address, '@', 1, 1) + 1) 
    ) VIRTUAL
);
