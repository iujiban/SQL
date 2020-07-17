-- Redo a3 but in a different style as detailed in each query

create database "JH"; -- use your initials
\c "JH"
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
-- Using the Join method
select distinct e.name from employee e
join employee on e.superviserid 
in (select id from employee where name = 'Clare');

-- Using the appropriate join method
select e1.name from employee e1
inner join employee e2 on e1.superviserid = e2.id 
and e2.name = 'Clare';

-----------------------------------------------------------------------------
-- 2. Find the items sold by no department on the second floor.
-- *** Use appropriate inner and outer joins
--inner
create table notSecondfloor as (select distinct s.item, s.dept from sale s, dept d where s.dept = d.name and d.floor =2);
select distinct s.item from sale s  
inner join notSecondfloor on s.item 
not in (select notSecondfloor.item from notSecondfloor);
--outer
create table nothSecondfloor as (select distinct s.item, s.dept from dept d,sale s where d.name = s.dept and d.floor != 2);
select distinct n.item from nothSecondfloor n 
right outer join notSecondfloor on n.item 
not in (select notSecondfloor.item from notSecondfloor);

-- not using the not in 
-- create the table
create table T1 as (select distinct s.item, s.dept from sale s, dept d where s.dept = d.name and d.floor =2);
create table T2 as (select distinct s.item, s.dept from sale s,dept d where d.name = s.dept and d.floor != 2);
-- select
select distinct T2.item from T2 left outer join T1 on T1.item = T2.item where T1.item is null;

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
-- not using the array_agg and order by one
select array(select distinct d.name from dept d where d.floor=2) 
as names;
--using the array_agg and order by one
select array_agg(name order by name) as names
from dept
where floor = 2;
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

select item, dept
from sale join dept on sale.dept = dept.name
where dept.floor = 2;

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

-- not using the array_agg, partition by and order by
select s2.item, (array(select s1.dept from sale s1 where s1.item=s2.item 
and s1.dept in (select dept.name from dept where dept.floor=2))) as depts 
from sale s2 inner join dept d on d.floor=2 and s2.dept=d.name;

-- using the array_agg, partition by and order by
select item, array_agg(dept) over(partition by item order by dept) 
as depts
from sale join dept on sale.dept = dept.name
where dept.floor = 2;

-- d. Use a join to produce the desired result

--Not using the array_agg and order by and partition by

WITH names_on_second_floor AS
(select array(select distinct d.name from dept d where d.floor=2) 
as names
),
items_on_second_floor AS
(
select s2.item, (array(select s1.dept from sale s1 where s1.item=s2.item 
and s1.dept in (select dept.name from dept where dept.floor=2))) as depts 
from sale s2 inner join dept d on d.floor=2 and s2.dept=d.name

)
select distinct i.*, depts 
from item i
join items_on_second_floor isf on i.name = isf.item
where isf.depts in (select names from names_on_second_floor);

--Using the array_agg and order by and partition by
WITH depts_on_second_floor AS
(
  select array_agg(name order by name) as depts
  from dept
  where floor = 2
),
items_on_second_floor AS
(
  select item, array_agg(dept) over(partition by item order by dept) as item_depts
  from sale join dept on sale.dept = dept.name
  where dept.floor = 2
)
select i.*, item_depts 
from item i
join items_on_second_floor isf on i.name = isf.item
where isf.item_depts in (select depts from depts_on_second_floor);

-----------------------------------------------------------------------------
-- 4. Find all departments (excluding the 'Management' department)
-- where all the employees earn less than their manager
-- *** Use the following strategy:
-- 
-- a. Define a table containing for each department, an array of the
-- employee salaries (excluding the manager), and the manager's
-- salary.
select d.name,(array (select e1.salary from employee e1 
where e1.id<> d.managerid and e1.dept = d.name)) as empSalaries, e2.salary
from dept d inner join employee e2 on e2.id = d.managerid;


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

select manager_salary.name from
(select d.name,(array (select e1.salary from employee e1 
where e1.id<> d.managerid and e1.dept = d.name)) as empSalaries, e2.salary
from dept d inner join employee e2 on e2.id = d.managerid) as manager_salary
where manager_salary.salary>all(manager_salary.EMPsalary) and manager_salary.name<>'Management';

/*
WITH employee_salaries AS
(
  select
    emp.dept,
      array_remove(array_agg(case when dept.managerid != emp.id then emp.salary else null end) over(partition by emp.dept), null) as employee_salaries,
      mgr.salary as manager_salary
  from dept
  join employee as emp on emp.dept = dept.name
  join employee as mgr on dept.managerid = mgr.id
)

select distinct dept, employee_salaries, manager_salary
from employee_salaries
where manager_salary > ALL (employee_salaries);
*/
-----------------------------------------------------------------------------
-- 5. Find the suppliers that deliver all items of type 'N'
-- *** Use the following strategy:

-- a. Define a table containing one row whose value is the collection
-- of items of type 'N'
-- 
--                           items                           
-- ----------------------------------------------------------
--  {Compass,"Geo positioning system","Map measure",Sextant}
-- not Using the array_agg
select array(select i.name from item i where i.type ='N') as items;

--Using the array_agg 
select array_agg(name) as item_array
from item
where type = 'N';

-- b. Define a table with attributes for supplier id, supplier name,
-- and an array containing all the items delivered by this supplier.
-- 
--  101 | Global Books & Maps      | {Compass,...}
--  102 | Nepalese Corp.           | {Sextant,...}
--  103 | All Sports Manufacturing | {Compass,...}
--  104 | Sweatshops Unlimited     | {Sextant,"Pith helmet"}
--  105 | All Points, Inc.         | {"Pocket knife-Nile",...}
--- 106 | Sao Paulo Manufacturing  | {"Pith helmet","Pocket knife-Nile",Sextant}

-- not using the array_agg and partition by
select distinct sup.id, sup.name, array(select de.item from delivery de
where de.supplier = sup.id) 
from supplier sup, delivery d 
where sup.id = d.supplier;
-- Using the array_agg and partition by
select
distinct s.id, s.name,
array_agg(d.item) over(partition by d.supplier) as s_items
from supplier s
join delivery d on s.id = d.supplier;

-- c. Finish the query using the containment operation on arrays

-- not using the array_agg
WITH items AS(
select array(select i.name from item i where i.type ='N') as items_array
),
supplier_items AS (
select distinct sup.id, sup.name, array(select de.item from delivery de
where de.supplier = sup.id) as sup_items
from supplier sup, delivery d 
where sup.id = d.supplier
)
select * from supplier_items
where sup_items @> (select items_array from items limit 1);

-- Using the array_agg 
WITH items AS
(
  select array_agg(name) as item_array
  from item
  where type = 'N'
),
supplier_items AS
(
  select
    distinct s.id, s.name,
    array_agg(d.item) over(partition by d.supplier) as s_items
  from supplier s
  join delivery d on s.id = d.supplier
)

select * from supplier_items
where s_items @> (select item_array from items limit 1);

-----------------------------------------------------------------------------
-- 6. Find the suppliers that deliver both compasses and an item other
-- than compasses
-- *** Use appropriate joins

-- without using the intersect
select distinct s.name 
from delivery d1 inner join delivery d2 
on d1.item<> d2.item and d1.item='Compass' inner join supplier sup on d1.supplier = sup.id;

-- Using the intersect one
select distinct name from supplier inner join (select supplier from delivery d inner join item i on d.item = i.name and i.name = 'Compass' 
intersect select supplier from delivery d inner join item i on d.item = i.name and i.name <> 
'Compass') as CP on CP.supplier = supplier.id;

-----------------------------------------------------------------------------
-- 7. Find the departments that have not recorded a sale for items of type 'N'
-- *** Take the set difference of two appropriate sets
-- Using the except all 
(select name as dept from dept)
except all
(select dept
from sale
join item on sale.item = item.name
where type = 'N');

-- not using the except all (using the not in )
select d.name from dept d where d.name
not in (select distinct s.dept from sale s
inner join item on s.item = item.name and item.type = 'N');

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
select array(select i.name from item i
where i.type = 'C') as items

--Using the array_agg
select array_agg(name) as item_array
from item
where type = 'C';

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
-- not Using the array_agg and partition by
select distinct sup.id, de2.dept, 
array(select de1.item from delivery de1 where sup.id = de1.supplier
and de1.dept = d.name) 
from supplier sup, dept d, delivery de2
where de2.dept=d.name and d.floor =2;

--Using the array_agg and partition by
select distinct supplier, dept.name as dept,
(array_agg(item) over(partition by supplier, dept.name)) as items
from delivery
join dept on dept.name = delivery.dept
where dept.floor = 2;

-- c. Finish the query to get the desired result

select s.name from(select distinct sup.id,de2.dept ,
(array(select de1.item from delivery de1 where sup.id=de1.supplier 
and de1.dept=d.name))as dep 
from supplier sup, dept d, delivery de2 where de2.dept=d.name and d.floor=2) 
as supplier_items inner join supplier s on s.id=supplier_items.id
and supplier_items.dep @> (select array(select i.name from item i where i.type='C'));

/*
-- not using the array_agg and partition by
WITH c_items AS
(
select array(select i.name from item i
where i.type = 'C') as items
),
supplier_items AS
(
select distinct sup.id, de2.dept, 
array(select de1.item from delivery de1 where sup.id = de1.supplier
and de1.dept = d.name) as items
from supplier sup, dept d, delivery de2
where de2.dept=d.name and d.floor =2
)
select * 
from supplier_items
where items @> (select array(select i.name from item i where i.type='C');
*/

-----------------------------------------------------------------------------
-- 9. Find the pair of suppliers and items where the supplier is the only
-- deliverer of the item.
-- *** Use appropriate joins
select distinct s.name, de.item
from supplier s inner join delivery de on s.id = de.supplier
where de.item not in 
(select distinct de1.item from delivery de1
inner join delivery de2 on de1.item = de2.item
and de1.supplier<> de2.supplier);

/*
WITH item_suppliers AS
(
select distinct item, supplier
from delivery
),
item_suppliers_count AS
(
select distinct item, 
count(supplier) over(partition by item) as supplier_count
from item_suppliers
) 

select distinct d.item, d.supplier
from delivery d
join item_suppliers_count isc on d.item = isc.item
where supplier_count = 1;
*/

-----------------------------------------------------------------------------

-- Switch to default db postgres and drop your database in the end
\c postgres
drop database "JH";

-----------------------------------------------------------------------------
