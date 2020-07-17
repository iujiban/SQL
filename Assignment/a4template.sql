-- Redo a3 but in a different style as detailed in each query

create database "AS"; -- use your initials
\c "AS"
\set ECHO all

-----------------------------------------------------------------------------
-- Source to be identified...

create table supplier (
  id int primary key,
  name varchar(40) not null
);

create table item (
  name varchar(40) primary key,
  type char(1) not null,
  color	varchar(20)
);

create table dept (
  name varchar(15) primary key,
  floor	int not null,
  phone	int not null,
  managerid int not null
);

create table employee (
  id int primary key,
  name varchar(20) not null,
  salary int not null,
  dept varchar(15) not null,
  superviserid int,
  foreign key (superviserid) references employee(id),
  foreign key (dept) references dept(name)
);

create table sale (
  id int primary key,
  quantity int not null,
  item varchar(40) not null,
  dept varchar(15) not null,
  foreign key (item) references item(name),
  foreign key (dept) references dept(name)
);
 
create table delivery (
  id int primary key,
  quantity int not null,
  item varchar(40) not null,
  dept varchar(15) not null,
  supplier int not null,
  foreign key (item) references item(name),
  foreign key (dept) references dept(name),
  foreign key (supplier) references supplier(id)
);

-----------------------------------------------------------------------------
-- Populate...

insert into supplier values(101, 'Global Books & Maps');
insert into supplier values(102,  'Nepalese Corp.');
insert into supplier values(103 , 'All Sports Manufacturing');
insert into supplier values(104, 'Sweatshops Unlimited');
insert into supplier values(105, 'All Points, Inc.');
insert into supplier values(106, 'Sao Paulo Manufacturing');

insert into item values('Boots-snakeproof' , 'C', 'Green');
insert into item values('Camel saddle', 'R', 'Brown');
insert into item values('Compass', 'N', NULL);
insert into item values('Elephant polo stick', 'R', 'Bamboo');
insert into item values('Exploring in 10 Easy Lessons', 'B', NULL);
insert into item values('Geo positioning system', 'N', NULL);
insert into item values('Hammock', 'F', 'Khaki');
insert into item values('Hat-polar explorer', 'C', 'White');
insert into item values('How to Win Foreign Friends', 'B', NULL);
insert into item values('Map case', 'E', 'Brown');
insert into item values('Map measure', 'N',  NULL);
insert into item values('Pith helmet', 'C', 'Khaki');
insert into item values('Pocket knife-Avon',  'E', 'Brown');
insert into item values('Pocket knife-Nile',  'E',  'Brown');
insert into item values('Safari chair',  'F', 'Khaki');
insert into item values('Safari cooking kit', 'F', NULL);
insert into item values('Sextant', 'N', NULL);
insert into item values('Stetson',  'C', 'Black');
insert into item values('Tent-2 person', 'F', 'Khaki');
insert into item values('Tent-8 person', 'F', 'Khaki');

insert into dept values('Management',5,34,1);
insert into dept values('Books',1,81,4);
insert into dept values('Clothes',2,24,4);
insert into dept values('Equipment',3,57,3);
insert into dept values('Furniture',4,14,3);
insert into dept values('Navigation',1,41,3);
insert into dept values('Recreation',2,29,4);
insert into dept values('Accounting',5,35,5);
insert into dept values('Purchasing',5,36,7);
insert into dept values('Personnel',5,37,9);
insert into dept values('Marketing',5,38,2);

insert into employee values(1,'Alice',75000,'Management', NULL);
insert into employee values(2,'Ned',45000,'Marketing',1);
insert into employee values(3,'Andrew',25000,'Marketing',2);
insert into employee values(4,'Clare',22000,'Marketing',2);
insert into employee values(5,'Todd',38000,'Accounting',1);
insert into employee values(6,'Nancy',22000,'Accounting',5);
insert into employee values(7,'Brier',43000,'Purchasing',1);
insert into employee values(8,'Sarah',56000,'Purchasing',7);
insert into employee values(9,'Sophie',35000,'Personnel',1);
insert into employee values(10,'Sanjay',15000,'Navigation',3);
insert into employee values(11,'Rita',15000,'Books',4);
insert into employee values(12,'Gigi',16000,'Clothes',4);
insert into employee values(13,'Maggie',16000,'Clothes',4);
insert into employee values(14,'Paul',11000,'Equipment',3);
insert into employee values(15,'James',15000,'Equipment',3);
insert into employee values(16,'Pat',15000,'Furniture',3);
insert into employee values(17,'Mark',15000,'Recreation',3);

insert into sale values (1001,2,'Boots-snakeproof', 'Clothes');
insert into sale values (1002,1,'Pith helmet','Clothes');
insert into sale values (1003,1,'Sextant','Navigation');
insert into sale values (1004,3,'Hat-polar explorer','Clothes');
insert into sale values (1005,5,'Pith helmet','Equipment');
insert into sale values (1006,1,'Pocket knife-Nile','Clothes');
insert into sale values (1007,1,'Pocket knife-Nile','Recreation');
insert into sale values (1008,1,'Compass','Navigation');
insert into sale values (1009,1,'Geo positioning system','Navigation');
insert into sale values (1010,5,'Map measure','Navigation');
insert into sale values (1011,1,'Geo positioning system','Books');
insert into sale values (1012,1,'Sextant','Books');
insert into sale values (1013,3,'Pocket knife-Nile','Books');
insert into sale values (1014,1,'Pocket knife-Nile','Navigation');
insert into sale values (1015,1,'Pocket knife-Nile','Equipment');
insert into sale values (1016,1,'Sextant','Clothes');
insert into sale values (1017,1,'Sextant','Equipment');
insert into sale values (1018,1,'Sextant','Recreation');
insert into sale values (1019,1,'Sextant','Furniture');
insert into sale values (1020,1,'Pocket knife-Nile','Furniture');
insert into sale values (1021,1,'Exploring in 10 Easy Lessons','Books');
insert into sale values (1022,1,'How to Win Foreign Friends','Books');
insert into sale values (1023,1,'Compass','Books');
insert into sale values (1024,1,'Pith helmet','Books');
insert into sale values (1025,1,'Elephant polo stick','Recreation');
insert into sale values (1026,1,'Camel saddle','Recreation');

insert into delivery values (51,50,'Pocket knife-Nile','Navigation',105);
insert into delivery values (52,10,'Pocket knife-Nile','Books',105);
insert into delivery values (53,10,'Pocket knife-Nile','Clothes',105);
insert into delivery values (54,10,'Pocket knife-Nile','Equipment',105);
insert into delivery values (55,10,'Pocket knife-Nile','Furniture',105);
insert into delivery values (56,10,'Pocket knife-Nile','Recreation',105);
insert into delivery values (57,50,'Compass','Navigation',101);
insert into delivery values (58,10,'Geo positioning system','Navigation',101);
insert into delivery values (59,10,'Map measure','Navigation',101);
insert into delivery values (60,25,'Map case','Navigation',101);
insert into delivery values (61,2,'Sextant','Navigation',101);
insert into delivery values (62,1,'Sextant','Equipment',105);
insert into delivery values (63,20,'Compass','Equipment',103);
insert into delivery values (64,1,'Geo positioning system','Books',103);
insert into delivery values (65,15,'Map measure','Navigation',103);
insert into delivery values (66,1,'Sextant','Books',103);
insert into delivery values (67,5,'Sextant','Recreation',102);
insert into delivery values (68,3,'Sextant','Navigation',104);
insert into delivery values (69,5,'Boots-snakeproof','Clothes',105);
insert into delivery values (70,15,'Pith helmet','Clothes',105);
insert into delivery values (71,1,'Pith helmet','Clothes',101);
insert into delivery values (72,1,'Pith helmet','Clothes',102);
insert into delivery values (73,1,'Pith helmet','Clothes',103);
insert into delivery values (74,1,'Pith helmet','Clothes',104);
insert into delivery values (75,5,'Pith helmet','Navigation',105);
insert into delivery values (76,5,'Pith helmet','Books',105);
insert into delivery values (77,5,'Pith helmet','Equipment',105);
insert into delivery values (78,5,'Pith helmet','Furniture',105);
insert into delivery values (79,5,'Pith helmet','Recreation',105);
insert into delivery values (80,10,'Pocket knife-Nile','Navigation',102);
insert into delivery values (81,1,'Compass','Navigation',102);
insert into delivery values (82,1,'Geo positioning system','Navigation',102);
insert into delivery values (83,10,'Map measure','Navigation',102);
insert into delivery values (84,5,'Map case','Navigation',102);
insert into delivery values (85,5,'Compass','Books',102);
insert into delivery values (86,5,'Pocket knife-Avon','Recreation',102);
insert into delivery values (87,5,'Tent-2 person','Recreation',102);
insert into delivery values (88,2,'Tent-2 person','Recreation',102);
insert into delivery values (89,5,'Exploring in 10 Easy Lessons','Navigation',102);
insert into delivery values (90,5,'How to Win Foreign Friends','Navigation',102);
insert into delivery values (91,10,'Exploring in 10 Easy Lessons','Books',102);
insert into delivery values (92,10,'How to Win Foreign Friends','Books',102);
insert into delivery values (93,2,'Exploring in 10 Easy Lessons','Recreation',102);
insert into delivery values (94,2,'How to Win Foreign Friends','Recreation',102);
insert into delivery values (95,5,'Compass','Equipment',105);
insert into delivery values (96,2,'Boots-snakeproof','Equipment',105);
insert into delivery values (97,20,'Pith helmet','Equipment',106);
insert into delivery values (98,20,'Pocket knife-Nile','Equipment',106);
insert into delivery values (99,1,'Sextant','Equipment',106);
insert into delivery values (100,3,'Hat-polar explorer','Clothes',105);
insert into delivery values (101,3,'Stetson','Clothes',105);

-----------------------------------------------------------------------------
-- Queries

-- 1. Find all the employees supervised by Clare.
-- *** Use an appropriate join
select distinct e.name from employee e
join employee on e.superviserid 
in (select id from employee where name = 'Clare');

-----------------------------------------------------------------------------
-- 2. Find the items sold by no department on the second floor.
-- *** Use appropriate inner and outer joins
create table nosecondfloor as (select distinct sale.item, sale.dept from sale, dept where sale.dept = dept.name and dept.floor =2);
select distinct sale.item from sale inner join nosecondfloor on sale.item not in (select nosecondfloor.item from nosecondfloor);

create table notsecondfloor as (select distinct sale.item, sale.dept from dept,sale where dept.name = sale.dept and dept.floor != 2);
select distinct notsecondfloor.item from notsecondfloor right outer join nosecondfloor on notsecondfloor.item not in (select nosecondfloor.item from nosecondfloor);
     
-----------------------------------------------------------------------------
-- 3. Find the items sold by all departments on the second floor.
-- *** Use the following strategy:
-- 
-- a. Define a table with one row whose value is an array of the
-- departments on the second floor
-- 
--         names         
-- ----------------------
--  {Clothes,Recreation}
-- 
-- b. Define a table that gives for each item all the departments on
-- the second floor that sell it.
-- 
--         item         |    dept    
-- ---------------------+------------
--  Boots-snakeproof    | Clothes
--  Pith helmet         | Clothes
--  Hat-polar explorer  | Clothes
--  Pocket knife-Nile   | Clothes
--  Pocket knife-Nile   | Recreation
--  Sextant             | Clothes
--  Sextant             | Recreation
--  Elephant polo stick | Recreation
--  Camel saddle        | Recreation
-- 
-- c. Define a table that collects for each item an array of the
-- departments on the second floor that sell it.
--
-- item         |        depts         
-- ---------------------+----------------------
--  Boots-snakeproof    | {Clothes}
--  Pith helmet         | {Clothes}
--  Hat-polar explorer  | {Clothes}
--  Pocket knife-Nile   | {Clothes,Recreation}
--  Pocket knife-Nile   | {Clothes,Recreation}
--  Sextant             | {Clothes,Recreation}
--  Sextant             | {Clothes,Recreation}
--  Elephant polo stick | {Recreation}
--  Camel saddle        | {Recreation}
-- 
-- d. Use a join to produce the desired result


-----------------------------------------------------------------------------
-- 4. Find all departments (excluding the 'Management' department)
-- where all the employees earn less than their manager
-- *** Use the following strategy:
-- 
-- a. Define a table containing for each department, an array of the
-- employee salaries (excluding the manager), and the manager's
-- salary.
-- 
-- name    |  empSalaries  | salary 
-- ------------+---------------+--------
--  Management | {}            |  75000
--  Books      | {15000}       |  22000
--  Clothes    | {16000,16000} |  22000
--  Equipment  | {11000,15000} |  25000
--  Furniture  | {15000}       |  25000
--  Navigation | {15000}       |  25000
--  Recreation | {15000}       |  22000
--  Accounting | {22000}       |  38000
--  Purchasing | {56000}       |  43000
--  Personnel  | {}            |  35000
--  Marketing  | {25000,22000} |  45000
--
-- b. Finish the query using the keyword 'all'

-----------------------------------------------------------------------------
-- 5. Find the suppliers that deliver all items of type 'N'
-- *** Use the following strategy:

-- a. Define a table containing one row whose value is the collection
-- of items of type 'N'
-- 
--                           items                           
-- ----------------------------------------------------------
--  {Compass,"Geo positioning system","Map measure",Sextant}
-- 
-- b. Define a table with attributes for supplier id, supplier name,
-- and an array containing all the items delivered by this supplier.
-- 
--  101 | Global Books & Maps      | {Compass,...}
--  102 | Nepalese Corp.           | {Sextant,...}
--  103 | All Sports Manufacturing | {Compass,...}
--  104 | Sweatshops Unlimited     | {Sextant,"Pith helmet"}
--  105 | All Points, Inc.         | {"Pocket knife-Nile",...}
--- 106 | Sao Paulo Manufacturing  | {"Pith helmet","Pocket knife-Nile",Sextant}
--
-- c. Finish the query using the containment operation on arrays


-----------------------------------------------------------------------------
-- 6. Find the suppliers that deliver both compasses and an item other
-- than compasses
-- *** Use appropriate joins
select name from supplier inner join (select supplier from delivery d inner join item i on d.item = i.name and i.name = 'Compass' 
intersect select supplier from delivery d inner join item i on d.item = i.name and i.name <> 
'Compass') as CP on CP.supplier = supplier.id;

-----------------------------------------------------------------------------
-- 7. Find the departments that have not recorded a sale for items of type 'N'
-- *** Take the set difference of two appropriate sets

-- orignal one not using the joins
select S.name from supplier S where not exists(select * from item I where I.type = 'N' 
and I.name not in (select D.item  from delivery D  where D.supplier = S.id));

-- using the joins

-----------------------------------------------------------------------------
-- 8. Find the suppliers that deliver every item of type 'C' to the same
-- department on the second floor.
-- *** Use the following strategy:
--
-- a. Define a table with one row whose values is an array containing
-- all the values of type 'C'
--                              items                             
-- ---------------------------------------------------------------
--  {Boots-snakeproof,"Hat-polar explorer","Pith helmet",Stetson}
--
-- b. Build a table with attributes for supplier id, second-floor
-- department name, and for each supplier and department, an array of
-- all the items delivered by this supplier to that department:
--
--  101 | Clothes    | {"Pith helmet"}
--  101 | Recreation | {}
--  102 | Clothes    | {"Pith helmet"}
--  102 | Recreation | {"Exploring in 10 Easy Lessons",...}
--  103 | Clothes    | {"Pith helmet"}
--  103 | Recreation | {}
--  104 | Clothes    | {"Pith helmet"}
--  104 | Recreation | {}
--  105 | Clothes    | {Boots-snakeproof,"Hat-polar explorer",...}
--  105 | Recreation | {"Pith helmet","Pocket knife-Nile"}
--  106 | Clothes    | {}
--  106 | Recreation | {}
--
-- c. Finish the query to get the desired result


-----------------------------------------------------------------------------
-- 9. Find the pair of suppliers and items where the supplier is the only
-- deliverer of the item.
-- *** Use appropriate joins
-- original not using the joins
SELECT DISTINCT supplier.name, item 
FROM supplier, delivery D 
WHERE supplier.id = D.supplier 
AND item 
NOT IN (SELECT item     FROM delivery  WHERE supplier <> D.supplier);

-- using the joins
select distinct supplier.name, item from supplier inner join (select supplier.name, item from supplier inner join delivery D on supplier.id = D.supplier) as Something on Something.item not in (select delivery.item from delivery inner join delivery DE on delivery.supplier <> DE.supplier);

-----------------------------------------------------------------------------

-- Switch to default db postgres and drop your database in the end
\c postgres
drop database "AS";

-----------------------------------------------------------------------------
