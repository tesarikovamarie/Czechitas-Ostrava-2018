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

INSERT INTO terrorism
	(date, target_city_id, fatalities, injured, perpetrator_group, target_type)
VALUES
	('2017-08-25',1,1,2,'Islamic State of Iraq and the Levant (ISIL)','Brussels police officers'),
	('2017-06-20',1,1,0,'Unknown','Central train station, Citizens'),
	('2016-12-23',1,0,0,'Unknown','Private Citizens & Property'),
	('2016-10-05',1,0,4,'Muslim extremists','Police'),
	('2016-08-29',1,0,0,'Unknown','Government (General)'),
	('2016-03-22',1,17,135,'Islamic State of Iraq and the Levant (ISIL)','Private Citizens & Property,Transportation'),
	('2016-03-22',2,18,135,'Islamic State of Iraq and the Levant (ISIL)','Airports and Aircraft,Private Citizens & Property'),
	('2014-09-16',1,0,3,'Unknown','Religious Figures/Institutions'),
	('2014-05-24',1,4,0,'Islamic State of Iraq and the Levant (ISIL)','Private Citizens & Property');

UPDATE
	terrorism
SET
	year = date_part('year', date),
	month = date_part('month', date), 
	attack_intensity = fatalities * 10 + injured;
