--[1]
SELECT 
  game_id,
  name,
  year
FROM games
WHERE
  name LIKE "%Christmas%" OR
  name LIKE "%Santa%";
  
--[2]
SELECT 
  DISTINCT species,
  island
FROM penguins
GROUP BY island
ORDER BY island, species;

--[3]
SELECT
  title
FROM film
WHERE
  rating IN ("R" , "NC-17") AND
  title NOT LIKE "%A";
  
--[4]
SELECT 
  local,
  count(station_id) as num_stations
FROM station
GROUP BY
  local
ORDER BY num_stations;

--[5]
SELECT
  DISTINCT page_location
FROM ga
WHERE page_location NOT LIKE "%\_%" ESCAPE "\"
ORDER BY page_location;

--[6]
SELECT 
  c.name
FROM
{
SELECT 
  publish_id
FROM games
GROUP BY publisher_id
HAVING count(game_id) >=10
} as g
LEFT JOIN companies as c
ON c.id = g.publish_id;

--[7]
SELECT ROUND((SELECT count(*) FROM artworks) / 
             (SELECT count(*) 
              FROM artworks 
              WHERE LOWER(credit) LIKE "%gift%"), 3) as ratio;

--[8]
SELECT 
  STRFTIME("%y-%m",o.order_date) as other_month,
  SUM(oi.quantity * oi.price) as total_amount,
  SUM(CASE WHEN o.order_id NOT LIKE "C%" 
      THEN oi.quantity * oi.price END) as ordered_amount,
  SUM(CASE WHEN o.order_id LIKE "C%" 
      THEN oi.quantity * oi.price END) as canceled_amount
FROM orders as o
INNER JOIN other_items as oi
ON o.order_id = oi.order_id
GROUP BY other_month
ORDER BY other_month;

--[9]
SELECT id
FROM points
WHERE
  x = SELECT MAX(x) FROM points OR
  y = SELECT MAX(y) FROM points;

--[10]
SELECT 
  CASE STRFTIME("%u",measured_at) 
    WHEN '1' THEN 'MON'
    WHEN '2' THEN 'TUE'
    WHEN '3' THEN 'WED'
    WHEN '4' THEN 'THU'
    WHEN '5' THEN 'FRI'
    WHEN '6' THEN 'SAT'
    WHEN '7' THEN 'SUN'
    END AS weekday,
  ROUND(AVG(no2),2) AS no2,
  ROUND(AVG(co2),2) AS co2
FROM measurements
GROUP BY weekday
ORDER BY STRFTIME("%u",measured_at);

--[11]
SELECT 
  classification,
  SUM(CASE WHEN acquisition_date 
      BETWEEN '2014-01-01' AND '2014-12-31' 
      THEN 1 ELSE 0) AS '2014'
FROM artworks
GROUP BY classification;

--[12]
SELECT
  CASE WHEN measured_at BETWEEN '2022-03-01' AND '2022-05-31' THEN 'spring'
       WHEN measured_at BETWEEN '2022-06-01' AND '2022-08-31' THEN 'spring'
       WHEN measured_at BETWEEN '2022-09-01' AND '2022-11-30' THEN 'spring'
       ELSE 'winter' END AS season,
  AVG(pm10) AS pm10_average
FROM measured_at
GROUP BY season;
