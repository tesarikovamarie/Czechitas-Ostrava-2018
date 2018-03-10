DROP TABLE IF EXISTS tourism_arrivals;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS country;
DROP TABLE IF EXISTS tourism_category;

CREATE TABLE country
(
	code VARCHAR(2) PRIMARY KEY, /* ISO 3166 code */
	name VARCHAR(128)
);
/* todo: import all countries from wiki */
INSERT INTO country VALUES 
	('BE', 'Belgium'),
	('BR', 'Brazil'),
	('CN', 'China'),
	('DE', 'Germany'),
	('RU', 'Russian Federation'),
	('IT', 'Italy'),
	('US', 'United States of America'),
	('ES', 'Spain'),
	('FR', 'France'),
	('GB', 'United Kingdom of Great Britain and Northern Ireland'),
	('IN', 'India'),
	('NL', 'Netherlands'),
	('XX', 'Other')
;
CREATE TABLE city
(
	id SERIAL PRIMARY KEY,
	country_code VARCHAR(2) REFERENCES country (code),
	name VARCHAR(128)
);
INSERT INTO city VALUES (1, 'BE', 'Brussel');

CREATE TABLE tourism_category
(
	id SERIAL PRIMARY KEY,
	name VARCHAR(64)
);
INSERT INTO tourism_category VALUES (1, 'All'),(2, 'Leisure'),(3, 'Meetings'),(4, 'Other business reasons');

CREATE TABLE tourism_arrivals (
	id SERIAL PRIMARY KEY,
	year SMALLINT,
	month SMALLINT,
	city_id INT REFERENCES city (id),
	tourism_category_id INT REFERENCES tourism_category (id),
	tourist_country_code VARCHAR(2) REFERENCES country (code),
	tourist_count INT,
	UNIQUE (year, month, city_id, tourism_category_id, tourist_country_code)
);

TRUNCATE TABLE tourism_arrivals;
COPY tourism_arrivals(year, month, city_id, tourism_category_id, tourist_country_code, tourist_count)
FROM '/Users/marietesarikova/Desktop/Projekt_Brno/weather/Czechitas-Ostrava-2018/brussel_tourism_for_sql.csv' (DELIMITER ',');

