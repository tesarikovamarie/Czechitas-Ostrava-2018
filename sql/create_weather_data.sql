DROP TABLE IF EXISTS weather;

CREATE TABLE weather (
    airport_code VARCHAR(24),
    city_name VARCHAR (64),
    datetime_column DATE,
    temp_high INT,
    temp_avg INT,
    temp_low INT,
    dew_point_high INT,
    dew_point_avg INT,
    dew_point_low INT,
    humidity_high INT,
    humidity_avg INT,
    humidity_low INT,
    sea_level_press_high INT,
    sea_level_press_avg INT,
    sea_level_press_low INT,
    visibility_high INT,
    visibility_avg INT,
    visibility_low INT,
    wind_high INT,
    wind_avg INT,
    wind_low INT,
    precip FLOAT,
    events VARCHAR(255),
    good_weather BOOLEAN,
    UNIQE city_datetime (city_id, datetime_column)
) ;

COPY weather
FROM '/Users/marietesarikova/Downloads/weather_prague_2017_fixed.csv' DELIMITER ',' CSV HEADER;


UPDATE weather SET good_weather = false;
UPDATE weather SET good_weather = true
WHERE
	temp_avg >= 12 AND
	temp_avg < 31 AND
	precip < 5 AND
	wind_avg < 20 AND
	humidity_avg >= 35 AND
	humidity_avg < 85 AND
	(events IS NULL OR events = '');
