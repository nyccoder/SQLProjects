-- Altering Table name
RENAME TABLE citibikeApr6.JC 
TO citibikeApr6.Citibike;

-- Adding Primary Key to table.
ALTER TABLE citibikeApr6.Citibike
ADD CONSTRAINT Citibike_PK
PRIMARY KEY (ride_id);

-- Converting Varchar data to date format.
SELECT STR_TO_DATE(started_at, '%Y-%m-%d %T') AS Duration
FROM Citibike c ;

-- Query total bike usage by days.
SELECT d.start_date , COUNT(d.start_date) AS Total
FROM (
  SELECT  ride_id ,
          STR_TO_DATE(started_at ,'%Y-%m-%d') AS start_date
  FROM Citibike 
) d
GROUP BY d.start_date
ORDER BY d.start_date ASC
;

-- Querying Time difference to get loan periods of all bikes usage.
SELECT c.ride_id , dt.start_time, dt.end_time , TIMESTAMPDIFF (SECOND , dt.start_time , dt.end_time) AS duration
FROM Citibike c
INNER JOIN (
    SELECT 
    ride_id ,
    STR_TO_DATE(started_at ,'%Y-%m-%d %T') AS start_time ,
    STR_TO_DATE(ended_at  ,'%Y-%m-%d %T') AS end_time
    FROM Citibike 
) dt ON dt.ride_id  = c.ride_id
ORDER BY duration DESC
;

-- Querying to test With clause
WITH bike AS (
	SELECT ride_id AS id , rideable_type , start_station_name 
	FROM Citibike c 
) ,
bike1 AS (
	SELECT id , rideable_type AS `type`
	FROM bike
)
SELECT id
FROM bike1
;

/*
SELECT 'started_at(time)' , t.*
FROM Citibike c , (
	SELECT ride_id as id ,rideable_type 
	FROM Citibike c2 
) t
WHERE c.ride_id = t.id
;
*/

/* THIS QUERY DOESN'T WORK. LOOK REASON BELOW. */
WITH sec_diff AS (
  SELECT ride_id ,  
  TIMESTAMPDIFF(SECOND, started_at , end_lat ) AS seconds
  FROM Citibike 
),
differences AS (
  SELECT  ride_id ,
          seconds ,
          MOD(seconds, 60) AS seconds_part,
          MOD(seconds, 3600) AS minutes_part,
          MOD(seconds, 3600 * 24) AS hours_part
  FROM sec_diff
)
SELECT  c.ride_id ,
        c.rideable_type ,
        duration.days AS 'duration(Days)' ,
        duration.hours AS 'duration(Hours)' ,
        duration.minutes AS 'duration(Minutes)',
        duration.seconds AS 'duration(Seconds)'
FROM Citibike c , (
  SELECT  ride_id ,
          FLOOR(seconds / 3600 / 24) AS days ,
          FLOOR(hours_part / 3600) AS hours ,
          FLOOR(minutes_part / 60) AS minutes ,
          seconds_part AS seconds
  FROM differences -- Query return NULL for all days, holurs, minutes, sec. 
-- I think bcoz differences is call inside another bracket from 'FROM' clause.
) as duration
WHERE c.ride_id = duration.ride_id
;

-- Querying all bike's loan period and converting them to days , hours , min , sec.
WITH sec_diff AS (
 	SELECT  ride_id , 
          rideable_type ,
          member_casual ,
          TIMESTAMPDIFF(SECOND, started_at , ended_at) AS seconds
	FROM Citibike 
),-- Cannot have spaces to next line here otherwise query won't work
differences AS (
 	SELECT  ride_id ,
          rideable_type ,
          member_casual ,
          seconds ,
          MOD(seconds, 60) AS seconds_part,
          MOD(seconds, 3600) AS minutes_part,
          MOD(seconds, 3600 * 24) AS hours_part
	FROM sec_diff
) -- Cannot have spaces to next line here otherwise query won't work
SELECT  ride_id ,
        rideable_type ,
        member_casual ,
        FLOOR(seconds / 3600 / 24) AS days ,
        FLOOR(hours_part / 3600) AS hours ,
        FLOOR(minutes_part / 60) AS minutes ,
        seconds_part AS seconds
FROM differences
ORDER BY days DESC , hours DESC,  minutes DESC, seconds DESC 
;





