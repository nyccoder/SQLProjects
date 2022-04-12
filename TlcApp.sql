SELECT * FROM newdriverstatus n ;

-- Figuring out the distinct column values.
SELECT DISTINCT Status
FROM newdriverstatus n ;

-- Finding total value group by general status .
SELECT Status , COUNT(Status) AS Total
FROM newdriverstatus n
GROUP BY Status ;

-- Figuring out the distinct Defensive Driving column values.
SELECT DISTINCT `Defensive Driving`
FROM newdriverstatus n ;

-- Figuring out the distinct Defensive Driving column values.
SELECT DISTINCT `Driver Exam`
FROM newdriverstatus n ;

-- Figuring out the distinct Defensive Driving column values.
SELECT DISTINCT `Medical Clearance Form`
FROM newdriverstatus n ;

-- Figuring out the distinct Defensive Driving column values.
SELECT DISTINCT `Drug Test`
FROM newdriverstatus n ;

-- Finding Reasons for Incomplete status Total of Defensive Driving.
SELECT COUNT(`Defensive Driving`) , COUNT(`Driver Exam`) , COUNT(`Medical Clearance Form`) , COUNT(`Drug Test`)
FROM newdriverstatus n 
GROUP BY `Defensive Driving`
HAVING `Defensive Driving` = 'Needed' ;

-- Finding Reasons for Incomplete status Total of Multiple types.
SELECT COUNT(*),
    CASE 
    WHEN `Defensive Driving` = 'Needed' THEN 'Defensive_Driving'
    WHEN `Driver Exam` = 'Needed' THEN 'Driver_Exam'
    WHEN `Medical Clearance Form` = 'Needed' THEN 'Medical_Clearance_Form'
    WHEN `Drug Test` = 'Needed' THEN 'Drug_Test'
    ELSE 'Others'
    END AS 'Incomplete_Status'
FROM newdriverstatus n 
GROUP BY Incomplete_Status ;
