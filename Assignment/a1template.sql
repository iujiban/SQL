
/*

If this file is saved as "a1.sql", you can run it through psql as follows:

$ psql
psql (11.5)
Type "help" for help.

sabry=# \i a1.sql

*/

-- Create a new database and switch to it

create database "AS"; -- use your initials
\c "AS";

-- Create the tables and populate them
-- Inspired by:
-- https://www.matchilling.com/introduction-to-logic-programming-with-prolog/

create table countries (
  countryid int, --- this one here is the primary key
  countryname varchar(30),
  mapcolor varchar(20)
  );

create table color (
  colorname varchar(20)
  );

create table neighbors (
  countryid int, -- this one here is the foreign key. it should map to the key above
  neighboringids int[]
  );

insert into countries values ( 0, 'austria',       'yellow');
insert into countries values ( 1, 'belgium',       NULL);
insert into countries values ( 2, 'bulgaria', 	   NULL);
insert into countries values ( 3, 'croatia', 	   'yellow');
insert into countries values ( 4, 'cyprus', 	   'yellow');
insert into countries values ( 5, 'czekrepublic',  'purple');
insert into countries values ( 6, 'denmark', 	   'yellow');
insert into countries values ( 7, 'estonia', 	   NULL);
insert into countries values ( 8, 'finland', 	   'yellow');
insert into countries values ( 9, 'france', 	   'yellow');
insert into countries values (10, 'germany', 	   'red');
insert into countries values (11, 'greece', 	   'green');
insert into countries values (12, 'hungary', 	   'red');
insert into countries values (13, 'ireland', 	   'yellow');
insert into countries values (14, 'italy', 	   NULL);
insert into countries values (15, 'latvia', 	   'green');
insert into countries values (16, 'lithunia',      NULL);
insert into countries values (17, 'luxemburg', 	   'green');
insert into countries values (18, 'malta', 	   'green');
insert into countries values (19, 'netherlands',   'yellow');
insert into countries values (20, 'poland', 	   'yellow');
insert into countries values (21, 'portugal', 	   'yellow');
insert into countries values (22, 'romania', 	   'green');
insert into countries values (23, 'slovakia', 	   NULL);
insert into countries values (24, 'slovenia', 	   'green');
insert into countries values (25, 'spain', 	   NULL);
insert into countries values (26, 'sweden', 	   'green');
insert into countries values (27, 'unitedkingdom', 'green');

insert into color values ('green');
insert into color values ('yellow');
insert into color values ('red');
insert into color values ('purple');

insert into neighbors values ( 0, '{5,10,12,14,23,24}');
insert into neighbors values ( 1, '{9,10,17,19,27}');
insert into neighbors values ( 2, '{11,22}');
insert into neighbors values ( 3, '{12,24}');
insert into neighbors values ( 4, '{11}');
insert into neighbors values ( 5, '{0,10,20,23}');
insert into neighbors values ( 6, '{10,26}');
insert into neighbors values ( 7, '{8,15,16}');
insert into neighbors values ( 8, '{7,26}');
insert into neighbors values ( 9, '{1,10,14,17,25,27}');
insert into neighbors values (10, '{0,1,6,9,17,19,20}');
insert into neighbors values (11, '{2,4}');
insert into neighbors values (12, '{0,3,22,23,24}');
insert into neighbors values (13, '{27}');
insert into neighbors values (14, '{0,9,24}');
insert into neighbors values (15, '{7,16}');
insert into neighbors values (16, NULL);
insert into neighbors values (17, '{1,9,10}');
insert into neighbors values (18, '{}');
insert into neighbors values (19, '{1,10,27}');
insert into neighbors values (20, '{5,10,16,23}');
insert into neighbors values (21, '{25}');
insert into neighbors values (22, '{2,12}');
insert into neighbors values (23, '{0,5,12,20}');
insert into neighbors values (24, '{0,3,12,14}');
insert into neighbors values (25, '{9,21}');
insert into neighbors values (26, '{6,8}');
insert into neighbors values (27, '{1,9,13,19}');

-- Write the queries. The first one is given as an example.

-- P1
-- Find all country names

select countryname from countries;

-- P2
-- Find all country names whose map color is green
select countryname from countries where mapcolor ='green';
-- P3
-- Find all country names whose map color is yellow
select countryname from countries where mapcolor = 'yellow';
-- P4
-- Find all country names whose map color is red
select countryname from countries where mapcolor ='red';
-- P5
-- Find all country names whose map color is purple
select countryname from countries where mapcolor ='purple';
-- P6
-- Find all country names whose map color is null
select countryname from countries where mapcolor is NULL;
-- P7
-- Find all country names that have NOT NULL neighbors
select countryname
from countries , neighbors
where neighbors.neighboringids is not NULL;
-- P8
-- Find all country names that have more than 2 neighbors
select countryname
from countries , neighbors
where neighbors.countryid = countries.countryid 
and array_length(neighboringids,1)>2;
-- P9
-- Produce a table with all country names and the number of their neighbors
create table as1 as select countryname, array_length(neighboringids,1)
from countries, neighbors where countries.countryid = neighbors.countryid;
-- P10
-- Same table as P9 but sorted by the number of neighbors from smallest to largest
create table as2 as select countryname, array_length(neighboringids,1) 
as neighbour_count
from countries, neighbors 
where countries.countryid = neighbors.countryid 
order by neighbour_count  asc;
--neighbour_count is an alias name to the column name, this is used to easy refer the column order by is the command we give in SQL to order the data either in ascending or descending order

-- other one 
create table as2 as select countryname, array_length(neighboringids,1) 
as neighbour_count
from countries, neighbors 
where countries.countryid = neighbors.countryid 
order by neighbour_count  asc;

-- just note 
-- as you are creating a table out of it, it is always advisable to use a alias name so that your new table has the column name you have given and does not uses the keywords as a column name for example in this case you new table will have a column name as array_length which is a keyword that is used to calcualtethe length of an array_length

-- Switch to default db postgres and drop your database in the end

\c postgres;

drop database "AS";





