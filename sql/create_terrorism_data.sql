DROP TABLE IF EXISTS terrorism;
CREATE TABLE terrorism (

	id SERIAL,
	date DATE,
	year SMALLINT,
	month SMALLINT,
	target_city_id INT REFERENCES city (id),
	fatalities INT,
	injured INT,
	perpetrator_group VARCHAR(128),
	target_type VARCHAR(128),
	attack_intensity INT
);
