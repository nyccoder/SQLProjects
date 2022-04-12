-- All Players Above 25 with most Assists in creating goals.
SELECT Name , Age , Club , `Position` , Assists
FROM epl_20_21 e
WHERE Age  >= 25 ORDER BY Assists DESC ;

-- Aggregate All Clubs with KPI figures.
SELECT Club , SUM(Goals) , SUM(Assists) , AVG(Passes_Attempted) as AvgPasses_Attempted , AVG(Perc_Passes_Completed) AS AvgPasses_Completed,
SUM(Yellow_Cards) , SUM(Red_Cards)
FROM epl_20_21 e 
GROUP BY Club
ORDER BY Club ASC ;

-- Find the clubs with most goals > 10 or most penalty goals > 5.
SELECT Club , SUM(Goals) AS Goals , SUM(Penalty_Goals) AS Penalty_Goals
FROM epl_20_21 e  
WHERE 	Goals > 10 OR 
		Penalty_Goals > 5 
GROUP BY Club ;

-- Find the player with age > 30 and English Nationality.
SELECT Name , Nationality  
FROM epl_20_21 e 
WHERE	Age > 30 AND 
		Nationality = 'ENG' ;

