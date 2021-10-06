CREATE TABLE number_test(
    number_value    NUMBER(6, 2)
);

SELECT * FROM number_test;

INSERT INTO number_test(number_value) VALUES (103.77);
INSERT INTO number_test(number_value) VALUES (99.545);
INSERT INTO number_test(number_value) VALUES (99.544);
INSERT INTO number_test(number_value) VALUES (99.985543345);

-- inserting maximum and minimum values
INSERT INTO number_test(number_value) VALUES (9999.99);
INSERT INTO number_test(number_value) VALUES (-9999.99);

SELECT * FROM number_test;

-- gives error if we exceed the precision
INSERT INTO number_test(number_value) VALUES (10000);
INSERT INTO number_test(number_value) VALUES (9999.999);
