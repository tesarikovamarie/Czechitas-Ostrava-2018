DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS country;

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
INSERT INTO
	city (country_code, name)
VALUES
	('BE', 'Brussel'),
	('BE', 'Zaventem');