CREATE TABLE world_cities(
    city_name                    VARCHAR2(40) NOT NULL,
    indigenous_city_name         NVARCHAR2(40) NOT NULL,
    indigenous_city_name_varchar VARCHAR2(40) NOT NULL
);


INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Washington', 'Washington', 'Washington');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Ottawa', 'Ottawa', 'Ottawa');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('London', 'London', 'London');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Munich', 'München ', 'München ');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Seoul', '서울시', '서울시');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Tokyo', '東京都', '東京都');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Beijing', '北京市', '北京市');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Ulan Bator', 'Улаанбаатар', 'Улаанбаатар');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('St. Petersburg', 'Санкт-Петербург', 'Санкт-Петербург');
INSERT INTO  world_cities(city_name, indigenous_city_name, indigenous_city_name_varchar)
VALUES ('Kiev', 'Київ', 'Київ');


SELECT * FROM world_cities;

SELECT city_name, indigenous_city_name,
       DUMP(city_name), DUMP(indigenous_city_name)
FROM world_cities;

