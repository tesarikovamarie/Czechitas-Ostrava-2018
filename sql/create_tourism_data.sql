DROP TABLE IF EXISTS tourism_arrivals;
DROP TABLE IF EXISTS tourism_category;

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
FROM '/Users/marietesarikova/Desktop/Projekt_Brno/weather/Czechitas-Ostrava-2018/data/brussel_tourism_for_sql.csv' (DELIMITER ',');

