DROP TABLE IF EXISTS pocasi;

CREATE TABLE pocasi (
    city_id VARCHAR(24),
    city_name VARCHAR (32)
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
    CONSTRAINT city_datetime PRIMARY KEY(city_id, datetime_column)
) ;

COPY pocasi
FROM '/Users/marietesarikova/Downloads/weather_prague_2017_fixed.csv' DELIMITER ',' CSV HEADER;
