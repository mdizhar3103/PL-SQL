CREATE TABLE zip_codes
(
    zip_code      VARCHAR2(5)     NOT NULL PRIMARY KEY,
    city          VARCHAR2(30)    NOT NULL,
    state         VARCHAR2(2)     NOT NULL
);

INSERT INTO zip_codes (zip_code, city, state) VALUES ('11201', 'Brooklyn', 'NY');
INSERT INTO zip_codes (zip_code, city, state) VALUES ('75201', 'Dallas', 'TX');
INSERT INTO zip_codes (zip_code, city, state) VALUES ('80401', 'Golden', 'CO');
INSERT INTO zip_codes (zip_code, city, state) VALUES ('92101', 'San Diego', 'CA');
COMMIT;

SELECT zip_code, city, state 
FROM zip_codes; 

-- mixing with case sensitivity
SELECT Zip_Code, CITY, state 
FROM zip_codes; 
-- works fine because without quotes oracle is converting all to upper case
