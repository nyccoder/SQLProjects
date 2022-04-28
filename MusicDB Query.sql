-- All Table Artist , Display all.
SELECT * FROM Song s ;
SELECT * FROM Artist a ;

-- Insert data into Artist Table.
INSERT INTO Artist (id , Name)
VALUES 	(1, 'Taylor Swift'),
		(2, 'Calvin Harris'),
		(3, 'Fallout Boys'),
		(4, 'Red Hot Chilli Peppers'),
		(5, 'Eminem'),
		(6, 'Katy Perry'),
		(7, 'The Eagles');

-- Insert data into Song Table.
INSERT INTO Song (id , Title, Artist , Genre , duration , Artist_id)
VALUES 	(1 , 'Blank Space', 'Taylor Swift', 'Pop', '00:03:21', 1),
		(2, 'Irresistable', 'Fallout Boys', 'Rock', '00:04:01', 3),
		(3, 'Roar', 'Katy Perry', 'Pop', '00:03:11', 6),
		(4, 'Hotel California', 'The Eagles', 'Rock', '00:03:41', 7),
		(5, 'Lose Yourself', 'Eminem', 'Rap', '00:02:55', 5);

-- Drop Artist Colum from Song Table as it is duplicate in Artist Table.
ALTER TABLE Song 
DROP COLUMN Artist ;
	
-- Query all songs with Genre where artists' name includes letter 'a'.
SELECT Title , Genre
FROM Song
WHERE Artist_id
IN (SELECT Artist_id 
	FROM Artist a
	WHERE Name LIKE '%a%') ;
	

-- OVER function raw usage
SELECT Title, Genre , COUNT(*) OVER()
FROM Song s ;

-- OVER function with partition 
SELECT Genre , COUNT(*) OVER(PARTITION BY Genre) AS Genre_Total
FROM Song s 
ORDER BY Genre_Total ;

-- RANK function raw usage
SELECT Genre , RANK () OVER (
	ORDER BY Genre
) AS ranking
FROM Song s;

-- DENSE RANK function raw usage
SELECT Genre , DENSE_RANK () OVER (
	ORDER BY Genre
) AS ranking
FROM Song s;




