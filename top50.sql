-- top 50 iterview questions -- 

USE temp;
CREATE TABLE Worker (
WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
FIRST_NAME CHAR(25),
LAST_NAME CHAR(25),
SALARY INT(15),
JOINING_DATE DATETIME,
DEPARTMENT CHAR(25)
);

INSERT INTO Worker
(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');

SELECT * FROM Worker;

CREATE TABLE Bonus (
WORKER_REF_ID INT,
BONUS_AMOUNT INT(10),
BONUS_DATE DATETIME,
FOREIGN KEY (WORKER_REF_ID)
REFERENCES Worker(WORKER_ID)
ON DELETE CASCADE);


INSERT INTO Bonus
(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
(001, 5000, '16-02-20'),
(002, 3000, '16-06-11'),
(003, 4000, '16-02-20'),
(001, 4500, '16-02-20'),
(002, 3500, '16-06-11');

select * from bonus;

CREATE TABLE Title (
WORKER_REF_ID INT,
WORKER_TITLE CHAR(25),
AFFECTED_FROM DATETIME,
FOREIGN KEY (WORKER_REF_ID)
REFERENCES Worker(WORKER_ID)
ON DELETE CASCADE
);
INSERT INTO Title
(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
(001, 'Manager', '2016-02-20 00:00:00'),
(002, 'Executive', '2016-06-11 00:00:00'),
(008, 'Executive', '2016-06-11 00:00:00'),
(005, 'Manager', '2016-06-11 00:00:00'),
(004, 'Asst. Manager', '2016-06-11 00:00:00'),
(007, 'Executive', '2016-06-11 00:00:00'),
(006, 'Lead', '2016-06-11 00:00:00'),
(003, 'Lead', '2016-06-11 00:00:00');


select * from title;
-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as
-- <WORKER_NAME>.
select first_name as worker_name from worker;
-- Q2 Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
select upper(first_name) from worker;
-- Q3 Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
select distinct(department) from worker;
select distinct department from worker group by department;
-- Q-4. Write an SQL query to print the first three characters of FIRST_NAME from Worker table.
select substring(first_name,1,3) from worker;
-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column
-- ‘Amitabh’ from Worker table.
 select INSTR(first_name,'B') from worker where first_name='Amitabh';
 -- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces
-- from the right side.
select rtrim(first_name) from worker;
-- rtrim for right space and ltrim for left spaceing 
-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
select replace(first_name,'a','A') from worker ;
-- -- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME
-- Ascending.
select * from worker order by first_name;
-- Q-12. Write an SQL query to print all Worker details from the Worker table order by
-- FIRST_NAME Ascending and DEPARTMENT Descending.
select * from worker order by first_name asc , last_name desc;
-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
select * from worker where joining_date>'2014-02-01' order by joining_date desc ;
select * from worker where YEAR(joining_date) = 2014 AND MONTH(joining_date) = 02;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
select department,count(* )as total_count from worker where department ='Admin';
-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending
-- order.
select  count(worker_id) ,department from worker group by department;
SELECT COUNT(worker_id), department FROM worker GROUP BY department ;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
select w.* from worker as w inner join title as t on w.worker_id=t.worker_ref_id where t.worker_title='manager';

-- Q-25. Write an SQL query to fetch number (more than 1)
--  of same titles in the ORG of different
-- types.
select worker_title,count(worker_title) as cow from title group by worker_title having cow>1;
select worker_title, count(*) as count from title group by worker_title having count > 1;

-- Q-28. Write an SQL query to clone a new table from another table.
create table demo select * from worker;
select * from demo;

 -- q30  Write an SQL query to determine the nth (say n=5) highest salary from a table
 select * from worker order by salary desc limit 4,1;
 -- to this without using limit and offset	

-- using co related subquery 
  select * from worker w1 where 
  4>=(select count(distinct(salary)) from worker w2 where w2.salary >=w1.salary);
-- 3 highest salary
select max(salary) from worker
where salary not in (select max(salary) from worker
UNION
select max(salary) from worker
where salary not in (select max(salary) from worker));
  
  
  -- Q-35. Write an SQL query to fetch the list of employees with the same salary
  select * from worker w1 (select * from worker ) w2 where w1.salary= w2.salary;
  select * from worker w1 inner join worker w2 on w1.worker_id=w2.worker_id where w1.salary=w2.salary ;
  select w1.first_name ,w1.last_name from worker w1 join worker w2 ON w1.salary=w2.salary and w1.worker_id!=w2.worker_id  ;

-- q34 second hishets salary 
select * from worker as w1 where 1=(
select count(distinct(w2.salary)) from worker as w2 where w2.salary>=w1.salary);

select max(salary) from worker where salary not in (select max(salary) from worker);

-- Q-38. Write an SQL query to list worker_id who does not get bonus.
select * from worker where worker_id not in(select worker_ref_id from bonus);
-- joins
select w.* from worker w left join bonus b on w.worker_id=b.worker_ref_id where b.worker_ref_id is null;

-- Write an SQL query to fetch the first 50% records from a table.
select * from worker where worker_id<=(select count(worker_id)/2 as half from worker);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
select department,count(worker_id) from worker group by department having count(worker_id)<4;

-- Q-44. Write an SQL query to fetch the last five records from a table.
   select * from worker where worker_id > (select count(*) from worker)-5 order by salary desc; 
(select * from worker order by worker_id desc limit 5) order by worker_id ;

-- Q-42. Write an SQL query to show the last record from a table.

   select * from worker order by worker_id desc limit 1;
   select * from worker where worker_id=(select max(worker_id) from worker);
   
-- Q-45. Write an SQL query to print the name of employees having the highest salary in each
-- department

  select w.* from worker w inner join (select distinct(department),max(salary) as maks from worker group by department) demo on demo.maks=w.salary;
-- corelated subquery
select w.* from worker w 
		 where w.salary=(select max(salary) from worker w2 where w.department=w2.department );

-- -- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
select * from worker order by salary desc limit 3;

SELECT DISTINCT salary
FROM worker w1
WHERE 3 > (SELECT COUNT(DISTINCT salary)
           FROM worker w2
           WHERE w2.salary > w1.salary)
ORDER BY salary DESC;

select w.* from worker w 
where 
3>(select count(w2.salary) from worker w2 where w2.salary>w.salary) order by w.salary desc;


-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
select w.* from worker w 
where 
3>(select count(w2.salary) from worker w2 where w2.salary<w.salary) order by w.salary desc;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
select w.* from worker w 
where 
n>(select count(w2.salary) from worker w2 where w2.salary>w.salary) order by w.salary desc;

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
select department,sum(salary) from worker group by department; 

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
select first_name from worker where salary =(select max(salary) from worker);

-- q 51 remove all reversed pair from table 
create table pairs (
a int,
b int );

insert into pairs values
(1,2),
(3,4),
(2,1),
(4,3),
(2,4),
(7,8),
(4,2);

select lt.* from pairs lt left join pairs rt on lt.a=rt.b AND lt.b=rt.a where lt.a<=rt.a or rt.a is null;
select * from pairs;

select * from worker;
select * from title;
