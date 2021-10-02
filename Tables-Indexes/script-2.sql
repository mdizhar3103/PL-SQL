CREATE TABLE "ZipCodes"
(
    "zip code"    VARCHAR2(5)     NOT NULL PRIMARY KEY,
    "city.name"   VARCHAR2(30)    NOT NULL,
    "state%"      VARCHAR2(2)     NOT NULL
);

INSERT INTO "ZipCodes" ("zip code", "city.name", "state%") VALUES ('11201', 'Brooklyn', 'NY');
INSERT INTO "ZipCodes" ("zip code", "city.name", "state%") VALUES ('75201', 'Dallas', 'TX');
INSERT INTO "ZipCodes" ("zip code", "city.name", "state%") VALUES ('80401', 'Golden', 'CO');
INSERT INTO "ZipCodes" ("zip code", "city.name", "state%") VALUES ('92101', 'San Diego', 'CA');
COMMIT;

SELECT "zip code", "city.name", "state%"
FROM "ZipCodes";

-- running wihtout quotes
SELECT "zip code", "city.name", "state%"
FROM ZipCodes;
-- gives error, also with removing quotes in columns



