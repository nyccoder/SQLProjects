SELECT * FROM film_permits fp ;

-- Getting Total Activies within NYC separated by borough.
SELECT COUNT(*) AS Total_Permits ,
    CASE 
    WHEN Borough = 'Brooklyn' THEN 'Bk'
    WHEN Borough = 'Queens' THEN 'Qn'
    WHEN Borough = 'Manhattan' THEN 'Mh'
    WHEN Borough = 'Bronx' THEN 'Bx'
    ELSE 'SI'
    END AS 'City_Boroughs'
FROM film_permits fp 
GROUP BY City_Boroughs ;