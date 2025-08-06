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




