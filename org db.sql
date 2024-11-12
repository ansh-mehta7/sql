CREATE DATABASE IF NOT EXISTS ORG ;
USE org;
SHOW DATABASES;
-- REFRENCE TABLE 
CREATE TABLE worker(
worker_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
f_name VARCHAR(25),
l_name VARCHAR(25),
salary INT,
join_date DATETIME,
dept VARCHAR(25));

INSERT INTO worker VALUES
(1,'rajesh','tyagi',250000,'2024-09-30 13:00:00','ecell'),
(2, 'suresh', 'kumar', 300000, '2023-06-15 09:30:00', 'cse'),
(3, 'ramesh', 'singh', 180000, '2022-12-01 10:00:00', 'ee'),
(4, 'mohan', 'verma', 280000, '2023-04-10 14:45:00', 'it'),
(5, 'pankaj', 'sharma', 220000, '2023-08-05 08:15:00', 'cse'),
(6, 'anita', 'jain', 260000, '2024-02-20 11:30:00', 'ecell'),
(7, 'neha', 'gupta', 190000, '2022-09-25 16:00:00', 'ee'),
(8, 'alok', 'mehta', 320000, '2021-11-30 12:45:00', 'it'),
(9, 'vikas', 'agrawal', 275000, '2023-01-12 17:20:00', 'cse'),
(10, 'deepa', 'bhatt', 240000, '2024-03-08 09:50:00', 'ee');


TRUNCATE TABLE worker;
SELECT * FROM worker;

-- REFRENCEING TABLE 
CREATE TABLE bonus
(worker_ref_id INT ,
bonus_amount INT,
bonus_date DATETIME,
FOREIGN KEY (worker_ref_id) REFERENCES worker(worker_id)  ON DELETE CASCADE);

INSERT INTO bonus (worker_ref_id, bonus_amount, bonus_date)
VALUES
(1, 5000, '2024-01-15 10:00:00'),
(2, 10000, '2024-02-10 14:30:00'),
(3, 7500, '2024-03-05 11:15:00'),
(4, 12000, '2024-04-20 16:45:00'),
(5, 9000, '2024-05-10 09:20:00'),
(6, 6000, '2024-06-25 13:00:00'),
(7, 8000, '2024-07-15 17:10:00'),
(8, 11000, '2024-08-05 15:00:00'),
(9, 9500, '2024-09-10 12:45:00'),
(10, 7000, '2024-10-01 08:30:00');

SELECT * FROM bonus;




-- QUERIES 
SELECT * FROM worker WHERE dept='cse' OR dept='ecell';
-- better way is IN which reduces the OR statements 
SELECT * FROM worker WHERE dept IN ('ecell','ee','cse');
-- name matching 
SELECT * FROM worker where f_name LIKE '_a%' AND l_name LIKE '%a%';
-- order by 
-- AND IS USED IN WHERE CLAUSE WHERE WE WANT THE 2 CONDITINS TO BE FULLFILLED AT THE SAME TIME HERE USING AND IS OF NO USE 
SELECT * FROM worker WHERE  f_name LIKE '_a%' ORDER BY salary ;

-- GROUPING WE USE AGGREGATION SO WE USE GROUP BY AND SQL PROVIDES US SOME AGGREGATION FUNCTION 
-- IF WE USE NOT ANY AGGREGATION FUNCTION IT WILL USE GROUP BY AS DISTINCT

SELECT dept,COUNT(dept) FROM worker GROUP BY dept;
-- distinct and group by having 



-- using bith group by and havinf together 
SELECT dept, AVG(salary) AS avg_salary
FROM worker
GROUP BY dept
HAVING AVG(salary) > 200000
ORDER BY avg_salary DESC;

-- Count the number of workers in each department and show only departments with more than 2 workers.
SELECT dept, COUNT(worker_id) AS num_workers
FROM worker
GROUP BY dept
HAVING num_workers > 2
ORDER BY num_workers DESC;

-- WHERE + ORDER BY: Filters rows first and then sorts them.
-- GROUP BY + HAVING: Groups rows, applies aggregate functions (e.g., AVG, COUNT, MAX), filters the groups with HAVING, and then sorts the grouped results.

--  Find the average salary of workers who joined after 2022, grouped by department, and sort by average salary
SELECT dept ,AVG(salary) AS avg_salary FROM worker WHERE join_date >'2022-01-01' GROUP BY dept ORDER BY avg_salary; 


