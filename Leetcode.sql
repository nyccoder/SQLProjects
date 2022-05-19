/*
 * pb. 175 , Combine Two Tables , Write an SQL query to report the first name, last name, city, and 
 * state of each person in the Person table. If the address of a personId is not present in the Address 
 * table, report null instead.
 * 
 Table : Person
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| personId    | int     |
| lastName    | varchar |
| firstName   | varchar |
+-------------+---------+

Table : Address
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| addressId   | int     |
| personId    | int     |
| city        | varchar |
| state       | varchar |
+-------------+---------+
 */

SELECT Person.firstName , Person.lastName , Address.city , Address.state 
FROM Person
LEFT JOIN Address
ON Person.personId = Address.personId

/* pb.176 Write an SQL query to report the second highest salary from the Employee table. 
 * If there is no second highest salary, the query should report null.
 * 
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
 */

SELECT (
    SELECT DISTINCT
        Salary
    FROM
        Employee
    ORDER BY Salary DESC
    LIMIT 1 OFFSET 1 -- LIMIT clause TO GET 2nd highest salary
) AS SecondHighestSalary;


/*
 pb.177 Write an SQL query to report the nth highest salary from the Employee table. 
 If there is no nth highest salary, the query should report null.
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+

 */
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
    DECLARE A INT; -- DECLARE Variable here
    SET A = N - 1; -- SET Variable here
  RETURN (
      # Write your MySQL query statement below.
      SELECT (
            SELECT DISTINCT salary
            FROM Employee
            ORDER BY salary DESC
            LIMIT 1 OFFSET A -- Use variable
      )
  );
END

/*
 pb. 178 , Rank Scores , Write an SQL query to rank the scores.
 
 +-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| score       | decimal |
+-------------+---------+
 */

SELECT score,
    DENSE_RANK() OVER (ORDER BY score DESC) AS 'rank'
FROM Scores;

/* bp. 180
 * Write an SQL query to find all numbers that appear at least three times consecutively.
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
*/
SELECT DISTINCT
    l1.Num AS ConsecutiveNums
FROM 
    Logs l1, -- CREATE three tables
    Logs l2,
    Logs l3
    
WHERE
    l1.Id = l2.Id - 1 AND -- CHECK it IS first consecutive id 
    l2.Id = l3.Id - 1 AND -- CHECK it IS sec consecutive id
    l1.Num = l2.Num AND -- CHECK it IS first same Number
    l2.Num = l3.Num -- CHECK it IS sec same Number.
;

/*
 * -- pb.182 , Finding Duplicate in a column  

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
*/

SELECT email AS Email
FROM Person
GROUP BY email
HAVING COUNT(email) > 1
; -- HAVING will ONLY CHECK FROM Grouped email.


/* pb.183 , Write an SQL query to report all customers who never order anything.
 * 
Table: Customers
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| customerId  | int  |
+-------------+------+
 */
SELECT name AS Customers
FROM Customers c
WHERE c.id NOT IN -- USING NOT IN syntax TO GET id not in the list OF customerId
(
    SELECT customerId
    FROM orders
);


/*
 * pb.184 , Write an SQL query to find employees who have the highest salary in each of the departments.
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
*/

SELECT d.name AS Department , e.name AS Employee , e.salary AS Salary
FROM Employee e
JOIN Department d -- JOIN will RETURN ALL ROW that MATCH 'ON' CONDITION.
ON  d.id = e.departmentId
WHERE (e.DepartmentId , e.salary) -- RESULT FROM IN (....) will be CHECK WITH ALL OF departmentId AND salary.
-- So that all of same Maximum Salary will be returned.
IN
(
    SELECT DepartmentId , MAX(Salary)
    FROM Employee
    GROUP BY DepartmentId
);

-- pb.196 , Delete Duplicate email in a column

/* Table: Person
 +-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
 */
DELETE a 
FROM Person a , Person b
WHERE   a.email = b.email AND 
        a.id > b.id
  ;

       
/* pb.197 Rising Temperature , Write an SQL query to find all dates' Id with higher temperatures compared to 
 * its previous dates (yesterday).
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
 */
SELECT w2.id
FROM Weather w1 , Weather w2
WHERE   DATEDIFF (w2.recordDate , w1.recordDate) = 1 AND -- DATEDIFF func , the FIRST PARAMETER w2 date - 
--second parameter w1 date. So, w2 is later date than w1 to get +1.
        w1.temperature < w2.temperature
  ;
       

/* pb.511 , Gameplay Analysis , Write an SQL query to report the first login date for each player.
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key of this table.
*/
       
SELECT player_id , MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id 
;

/* pb. 584. Find Customer Referee , Write an SQL query to report the IDs of the customer that are not 
 * referred by the customer with id = 2.
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
 */
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id is NULL
;

/* pb.595 , 
 * 
 * 	A country is big if:

    it has an area of at least three million (i.e., 3000000 km2), or
    it has a population of at least twenty-five million (i.e., 25000000).

Write an SQL query to report the name, population, and area of the big countries.
 * 
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | int     |
+-------------+---------+
 */
SELECT name , population , area
FROM World
WHERE   area >= 3000000 OR
        population >= 25000000
;
       

/*
 pb.596 , Write an SQL query to report all the classes that have at least five students.

Table: Courses 
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| student     | varchar |
| class       | varchar |
+-------------+---------+
 */

SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(class) >= 5
;

/*
 * pb.601 , Write an SQL query to display the records with three or more rows with consecutive 
 * id's, and the number of people is greater than or equal to 100 for each.
 * 
 * 
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
 */

SELECT DISTINCT s1.*
FROM Stadium s1 , Stadium s2, Stadium s3
WHERE s1.people >= 100 AND s2.people >= 100 AND s3.people >= 100
AND
(
    (s1.id - s2.id = 1 AND s1.id - s3.id = 2 AND s2.id - s3.id = 1)
    OR
    (s2.id - s1.id = 1 AND s2.id - s3.id = 2 AND s1.id - s3.id = 1)
    OR
    (s3.id - s2.id = 1 AND s2.id - s1.id = 1 AND s3.id - s1.id = 2)
) -- Each and every row Check from s1 , s2 , s3 it must always satisfy condition of at least three consecutive rows eiter from s1 or s2 or s3.
ORDER BY s1.visit_date ASC
;


/* pb.607
 * Write an SQL query to report the names of all the salespersons 
 * who did not have any orders related to the company with the name "RED".
 * 
 Table: SalesPerson
+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| sales_id        | int     |
| name            | varchar |
| salary          | int     |
| commission_rate | int     |
| hire_date       | date    |
+-----------------+---------+
Table: Company
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| com_id      | int     |
| name        | varchar |
| city        | varchar |
+-------------+---------+
Table: Orders
+-------------+------+
| Column Name | Type |
+-------------+------+
| order_id    | int  |
| order_date  | date |
| com_id      | int  |
| sales_id    | int  |
| amount      | int  |
+-------------+------+
*/
SELECT name
FROM SalesPerson
WHERE sales_id NOT IN ( -- Must Choose NOT IN since it it TO remove WITH ALL sales_id that has orders FROM com_id
    SELECT sales_id
    FROM Orders
    WHERE com_id IN -- getting com_id that IS a name 'RED'
    (
        SELECT com_id
        FROM Company
        WHERE name = 'RED'
    )
);

/*
 Table: Tree , pb.608 , Write an SQL query to report the type of each node in the tree.
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| p_id        | int  |
+-------------+------+
 */

SELECT id,
CASE
    WHEN p_id is NULL THEN 'Root'
    WHEN id in (
        SELECT p_id FROM tree
    ) THEN 'Inner'
    ELSE 'Leaf'
    END AS type
FROM tree
order by id;

/*
 * pb. 620 , Not Boring Movies , Write an SQL query to report the movies with an odd-numbered ID and 
 * a description that is not "boring".
 * 
 * Table: Cinema
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
 */

SELECT *
FROM Cinema
WHERE   id % 2 = 1 AND
        description <> 'boring' 
ORDER BY rating DESC
;

/* pb.626 , Write an SQL query to swap the seat id of every two consecutive students. 
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key column for this table.
*/
SELECT CASE
WHEN id % 2 = 0 THEN id-1
WHEN id < (SELECT COUNT(*) FROM Seat) THEN id+1 -- Prev CONDITION NOT met so fall INTO this one, id IS
-- odd , so make sure it IS less than total of all id.
ELSE id -- This IS LAST one coz LAST id IS NOT < total. Eg. 5 IS NOT leass than 5.
END AS id , student
FROM Seat
ORDER BY id
;

/*
 pb.627 , Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) 
 with a single update statement and no intermediate temporary tables.
+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |
+-------------+----------+
 */
UPDATE Salary
SET sex = 	CASE sex
            	WHEN 'm' THEN 'f'
           	 	ELSE 'm'       
    		END;


/* pb.1050 , Actors and Directors Who Cooperated At Least Three Times
 +-------------+---------+
| Column Name | Type    |
+-------------+---------+
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |
+-------------+---------+
timestamp is the primary key column for this table.

Write a SQL query for a report that provides the pairs (actor_id, director_id) where 
the actor has cooperated with the director at least three times.
 */

SELECT actor_id , director_id
FROM ActorDirector
GROUP BY actor_id , director_id
HAVING COUNT(*) >= 3
;





       
       
       
       
       
       
       
       
       
       
       
       
       
       