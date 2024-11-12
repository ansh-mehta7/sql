-- joins 
USE org ;
-- INNER JOIN 
SELECT w.* ,b.* FROM worker AS w INNER JOIN bonus AS b ON w.worker_id=b.worker_ref_id;

DELETE from worker WHERE worker_id IN(5,4);
-- LEFT JOIN 
SELECT w.* ,b.* FROM worker AS w LEFT JOIN bonus AS b ON w.worker_id=b.worker_ref_id;
SELECT w.* ,b.* FROM worker AS w right JOIN bonus AS b ON w.worker_id=b.worker_ref_id;

-- self join 
SELECT w1.f_name ,w1.l_name,w2.salary FROM worker AS w1 INNER JOIN worker AS w2 ON w1.worker_id=w2.worker_id ORDER BY w2.salary;

-- new tables 
CREATE TABLE Employee (
    id INT PRIMARY KEY,
    fname VARCHAR(50),
    lname VARCHAR(50),
    Age INT,
    emailID VARCHAR(100),
    PhoneNo VARCHAR(20),
    City VARCHAR(50)
);
-- Creating the Client table
CREATE TABLE Client (
    id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    emailID VARCHAR(100),
    PhoneNo VARCHAR(20),
    City VARCHAR(50),
    empID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id)
);
CREATE TABLE Project (
    id INT PRIMARY KEY,
    empID INT,
    name VARCHAR(50),
    startdate DATE,
    clientID INT,
    FOREIGN KEY (empID) REFERENCES Employee(id),
    FOREIGN KEY (clientID) REFERENCES Client(id)
);
-- Inserting values into the Employee table
INSERT INTO Employee (id, fname, lname, Age, emailID, PhoneNo, City)
VALUES
(1, 'Aman', 'Proto', 32, 'aman@gmail.com', '898', 'Delhi'),
(2, 'Yagya', 'Narayan', 44, 'yagya@gmail.com', '222', 'Palam'),
(3, 'Rahul', 'BD', 22, 'rahul@gmail.com', '444', 'Kolkata'),
(4, 'Jatin', 'Hermit', 31, 'jatin@gmail.com', '666', 'Raipur'),
(5, 'PK', 'Pandey', 21, 'pk@gmail.com', '555', 'Jaipur');

-- Inserting values into the Client table
INSERT INTO Client (id, first_name, last_name, age, emailID, PhoneNo, City, empID)
VALUES
(1, 'Mac', 'Rogers', 47, 'mac@hotmail.com', '333', 'Kolkata', 3),
(2, 'Max', 'Poirier', 27, 'max@gmail.com', '222', 'Kolkata', 3),
(3, 'Peter', 'Jain', 24, 'peter@abc.com', '111', 'Delhi', 1),
(4, 'Sushant', 'Aggarwal', 33, 'sushant@yahoo.com', '44554', 'Hyderabad', 5),
(5, 'Pratap', 'Singh', 36, 'p@xyz.com', '77767', 'Mumbai', 2);

-- Inserting values into the Project table
INSERT INTO Project (id, empID, name, startdate, clientID)
VALUES
(1, 1, 'A', '2021-04-21', 3),
(2, 2, 'B', '2021-03-12', 1),
(3, 3, 'C', '2021-01-16', 5),
(4, 3, 'D', '2021-04-27', 2),
(5, 5, 'E', '2021-05-01', 4);

SELECT * FROM client;
-- ques
 -- 1 all employee id's names aliong with project allocated to them
 SELECT e.id, e.fname,e.lname AS fullname ,p.name FROM employee AS e INNER JOIN project AS p ON e.id=p.empID;
 -- 2 feth all employee id and thir comatct detials who
 -- have been wprkng from jaipur and the client name worling in hyderabad 
SELECT e.id, e.PhoneNo, e.emailID, CONCAT(c.first_name, ' ', c.last_name) AS full_name
FROM Employee AS e
INNER JOIN Client AS c ON e.id = c.empID
WHERE e.City = 'Jaipur'
AND c.City = 'Hyderabad';

 --  fetch out each project allciated to each employee 
 SELECT p.name ,CONCAT(e.fname,' ',e.lname) as employee_name from project as p right JOIN employee as e on p.empId=e.id; 
 
 -- subqueries 
 
 -- where clause same table
 SELECT * from employee where age in(select age from employee where age>30);
 
 -- where clause diffrnent table 
 -- emp details working in more then 1 project 
 select * from employee where id in
(select empID from project group by empID having count(empID)>1);
-- joins 
SELECT e.fname, e.lname, c.first_name, c.last_name, e.City
FROM Employee AS e
INNER JOIN Client AS c ON e.City = c.City;

-- practice 
-- 1  List all projects along with the employee's first and last name working on those projects.
select p.name,e.fname,e.lname from employee e inner join project p on e.id=p.empID;
 
 -- 2. Retrieve the list of clients along with their respective employees who are managing them, 
 --    including clients who do not have an assigned employee.

 select c.id as client_id ,e.fname,e.lname from client as c left join employee as e on c.empID=e.id;
   
  -- 3. Find the employee and their corresponding client(s) from the same city.
  select c.first_name as client_name ,e.fname as employee_name from client as c inner join employee as e on e.id=c.empID where e.city=c.city;
 
 -- 4. Retrieve all projects and their clients, even if a project has no client assigned.
     select p.name ,CONCAT(c.first_name,' ',c.last_name) as client_name from project as p left join client as c on p.clientID=c.id;
     
 -- 5. Find the employees who are managing multiple clients.
 select e.* from employee e inner join
 (select distinct(empID),count(empID) from client group by empId having count(empID)>1) as temp 
 on e.id=temp.empID;
	
SELECT e.fname, e.lname, COUNT(c.empID) AS client_count
FROM Employee AS e
INNER JOIN Client AS c ON e.id = c.empID
GROUP BY e.fname, e.lname
HAVING COUNT(c.empID) > 1;

-- 6. List the employee, project name, and the client they are working with
select concat(e.fname,' ',e.lname) as employee_name,
p.name as project_name,
concat(c.first_name,' ',c.last_name) as client_name 
from project as p inner join 
employee as e on e.id=p.empID inner join
client as c on p.clientID=c.id; 

-- 9. Retrieve the list of projects that were started after January 2021, along with the employee names and client details.
     select concat(e.fname,' ',e.lname) as employee_name,
p.name as project_name,
concat(c.first_name,' ',c.last_name) as client_name 
from project as p inner join 
employee as e on e.id=p.empID inner join
client as c on p.clientID=c.id where p.startdate>'2021-01-01 00:00:00';

 -- emp detials age > avg age 
select * from employee where Age>(select avg(age) from employee);

-- select max age person whose name contains a 
select fname,lname,age from employee where fname like'%a%' order by age desc limit 1;

SELECT fname, lname, Age
FROM Employee e
WHERE Age = (SELECT MAX(Age) 
             FROM Employee 
             WHERE fname LIKE '%a%' OR lname LIKE '%a%');

SELECT COUNT(*) FROM Employee WHERE City = 'Kolkata';

-- corelated subqueries 
-- find 3 oldest employee all 3 ways 

select * from employee order by age desc limit 1 offset 2;

 select * from employee as e1 where 
 2= (select count(distinct(age))
   from employee as e2 where e2.age>e1.age
 );
 -- one more possible way
 select * from employee where age
 =(select max(age) from employee where age < 
 (select max(age) from employee where age<
 (select max(age) from employee)));

 
 SELECT * FROM employee;
 SELECT * FROM project;
 select * from client ;