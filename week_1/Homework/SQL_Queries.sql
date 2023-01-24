--
-- How many taxi trips were totally made on January 15?
SELECT
	CAST(lpep_pickup_datetime AS DATE) AS "day_pu",
	CAST(lpep_dropoff_datetime AS DATE) AS "day_do",
    COUNT(1) AS "count"
FROM
	green_taxi_data t
GROUP BY
	1, 2
HAVING
	CAST(lpep_pickup_datetime AS DATE) = '2019-01-15' AND
	CAST(lpep_dropoff_datetime AS DATE) = '2019-01-15'
ORDER BY
	"day_pu" ASC, "day_do" ASC;

--
-- Which was the day with the largest trip distance?
SELECT
	CAST(lpep_pickup_datetime AS DATE) AS "day",
	MAX(trip_distance) AS "max_distance"
FROM
	green_taxi_data t
GROUP BY
	"day"
ORDER BY
	"max_distance" DESC
LIMIT
	1;

--
-- In 2019-01-01 how many trips had 2 and 3 passengers?
SELECT
	CAST(lpep_pickup_datetime AS DATE) AS "day",
	passenger_count,
	COUNT(1)
FROM
	green_taxi_data t
GROUP BY
	1, 2
HAVING
	(passenger_count = 2 OR
	passenger_count = 3)
	AND CAST(lpep_pickup_datetime AS DATE) = '2019-01-01';

--
-- For the passengers picked up in the Astoria Zone which was the drop up zone that had the largest tip?
SELECT
	t.tip_amount,
	t."PULocationID",
	t."DOLocationID",
	z1."Zone" AS "PU_Zone",
	z2."Zone" AS "DO_Zone"
FROM
	green_taxi_data t
	LEFT JOIN zones z1
	ON t."PULocationID" = z1."LocationID"
	LEFT JOIN zones z2
	ON t."DOLocationID" = z2."LocationID"
WHERE z1."Zone" = 'Astoria'
ORDER BY
	t.tip_amount DESC;

--
-- 