CREATE TABLE _result_tourism_by_country AS
SELECT
	ta.tourist_country_code, SUM(ta.tourist_count)
FROM
	tourism_arrivals ta
	JOIN tourism_category tc ON tc.id = ta.tourism_category_id
WHERE
	tc.name = 'All'
GROUP BY
	ta.tourist_country_code
ORDER BY
	SUM(ta.tourist_count) DESC;


CREATE TABLE _result_tourism_by_country_and_year AS 
SELECT
	year, ta.tourist_country_code, SUM(ta.tourist_count)
FROM
	tourism_arrivals ta
	JOIN tourism_category tc ON tc.id = ta.tourism_category_id
WHERE
	tc.name = 'All'
GROUP BY
	year, ta.tourist_country_code
ORDER BY
	year, SUM(ta.tourist_count) DESC;


CREATE TABLE _result_good_weather_days_in_month AS 
SELECT
	date_part('year', datetime_column) AS year,
	date_part('month', datetime_column) AS month,
	COUNT(NULLIF(good_weather, false))
FROM
	weather
GROUP BY
	year,
	month
ORDER BY
	year,
	month;
