
-- Create a new database and switch to it

create database "AS"; -- use your initials
\c "AS"

-----------------------------------------------------------------------------
-- Inspired by
-- https://www.matchilling.com/introduction-to-logic-programming-with-prolog/

create table color (
  cname varchar(20),
  primary key (cname)
  );

create table country (
  id int,
  cname varchar(30) not null,
  mapcolor varchar(20),
  primary key (id),
  foreign key (mapcolor) references color(cname) on delete set null
  );

create table neighbors (
  id int not null,
  neighborid int,
  unique (id,neighborid),
  foreign key (id) references country(id) on delete cascade
  );

-----------------------------------------------------------------------------
-- Question I

-- Can the tables be created in another order? Explain.
-- The tables cannot be created in another order, because inside of the country table has foregin key (mapcolor) references color(cname) on delete set null. This already supposed to bring the foregin key from another table, so that without the color table, it cannot be created one.
-----------------------------------------------------------------------------
-- Question II
-- 
-- The following sequence of queries is submitted. Explain how the
-- database management system would reply after each query. If there
-- is an error explain the error; if the query has an effect on several
-- tables, then show the tables before and after the query.
-- 

/*
  insert into color (values (NULL));
  insert into color (values ('green'));
  insert into color (values ('green'));
  insert into country values (NULL,'xx',NULL);
  insert into country values (0,'xx',NULL);
  insert into country values (1,NULL,NULL);
  insert into country values (1,'yy',NULL);
  insert into country values (2,'aa','green');
  insert into country values (2,'aa','blue');
  insert into country values (3,'aa','blue');
  delete from color where cname='green';
  insert into neighbors values (1,null);
  insert into neighbors values (1,2);
  insert into neighbors values (1,3);
  insert into neighbors values (1,2);
  insert into neighbors values (1,null);
  insert into neighbors values (1,null);
  insert into neighbors values (1,null);
  delete from country where id=1;
*/
/* 
*note* I did third questions first so I create new table color1, country1,neighbor1 instead of using the original one
	
	insert into color1 (values (NULL));
	--Cannot insert NULL to primary key column
	insert into color1 (values ('green'));
	--Data inserted sucessfully
	insert into color1 (values ('green'));
	--Cannot insert data as it already exist. And the column is defined as a primary key column
	insert into country1 values (NULL,'xx',NULL);
	--cannot insert null in parimary key column
	insert into country1 values (0,'xx',NULL);
	--Data insert successfully
	insert into country1 values (1,NULL,NULL);
	--cname is defined as not null column
	insert into country1 values (1,'yy',NULL);
	--data inserted sucessfully
	insert into country1 values (2,'aa','green');
	--data insert successfully
	insert into country1 values (2,'aa','blue');
	--duplicate primary key, 2 already exist.
	insert into country1 values (3,'aa','blue');
	--foreign key violation, blue does not exist in color table
	 * Note * : before deleting from color1 where cname = 'green';
	
	select * from color1;
	--green
	select * from country1;
	--0,xx,null
	--1,yy,null
	--2,aa,green
	
	delete from color1 where cname='green'; 
	--data deleted sucessfully
	
	*Note *: After deleting from color1 where cname = 'green';
	select * from color1;
	--no data
	select * from country1;
	--0,xx,null
	--1,yy,null
	--2,aa,null
	
	insert into neighbors1 values (1,null);
	--data inserted sucessfully
	insert into neighbors1 values (1,2);
	--data inserted sucessfully
	insert into neighbors1 values (1,3);
	--data inserted sucessfully
	insert into neighbors1 values (1,2);
	--duplicate entry for id and neighnorid not allowed
	insert into neighbors1 values (1,null);
	--data inserted sucessfully, null not considered as duplicate
	insert into neighbors1 values (1,null);
   --data inserted sucessfully, null not considered as duplicate
	insert into neighbors1 values (1,null);
   --data inserted sucessfully, null not considered as duplicate
   
   *Note*: before deleting from country1 where id =1;
	select * from country1;
   --0,xx,null
	--1,yy,null
	--2,aa,null
	select * from neighbors1;
	-- 1, null
	-- 1, 2
	-- 1, 3
	-- 1, null
	-- 1, null
	-- 1, null
  
	delete from country1 where id=1;
	--data deleted sucessfully
	*Note*: After deleting from country1 where id=1;
	select * from country1;
	--0,xx,null
	--2,aa,null
	select * from neighbors1;
	--all data deleted because of cascade delete operation
 */



-----------------------------------------------------------------------------
-- Question III:

-- Load the following data and write the requested queries. For each
-- query, please use meaningful identifiers to name the tuples and
-- optionally give a meaningful name to the resulting table.
-- Additionally, attempt to write "efficient nested queries" instead
-- of joining all the tables together. (See code from lecture for examples.) 

insert into color values ('green');
insert into color values ('yellow');
insert into color values ('red');
insert into color values ('purple');

insert into country values ( 0, 'austria',       'yellow');
insert into country values ( 1, 'belgium',       NULL);
insert into country values ( 2, 'bulgaria', 	   NULL);
insert into country values ( 3, 'croatia', 	   'yellow');
insert into country values ( 4, 'cyprus', 	   'yellow');
insert into country values ( 5, 'czekrepublic',  'purple');
insert into country values ( 6, 'denmark', 	   'yellow');
insert into country values ( 7, 'estonia', 	   NULL);
insert into country values ( 8, 'finland', 	   'yellow');
insert into country values ( 9, 'france', 	   'yellow');
insert into country values (10, 'germany', 	   'red');
insert into country values (11, 'greece', 	   'green');
insert into country values (12, 'hungary', 	   'red');
insert into country values (13, 'ireland', 	   'yellow');
insert into country values (14, 'italy', 	   NULL);
insert into country values (15, 'latvia', 	   'green');
insert into country values (16, 'lithunia',      NULL);
insert into country values (17, 'luxemburg', 	   'green');
insert into country values (18, 'malta', 	   'green');
insert into country values (19, 'netherlands',   'yellow');
insert into country values (20, 'poland', 	   'yellow');
insert into country values (21, 'portugal', 	   'yellow');
insert into country values (22, 'romania', 	   'green');
insert into country values (23, 'slovakia', 	   NULL);
insert into country values (24, 'slovenia', 	   'green');
insert into country values (25, 'spain', 	   NULL);
insert into country values (26, 'sweden', 	   'green');
insert into country values (27, 'unitedkingdom', 'green');

insert into neighbors values ( 0, 5);
insert into neighbors values ( 0, 10);
insert into neighbors values ( 0, 12);
insert into neighbors values ( 0, 14);
insert into neighbors values ( 0, 23);
insert into neighbors values ( 0, 24);
insert into neighbors values ( 1, 9);
insert into neighbors values ( 1, 10);
insert into neighbors values ( 1, 17);
insert into neighbors values ( 1, 19);
insert into neighbors values ( 1, 27);
insert into neighbors values ( 2, 11);
insert into neighbors values ( 2, 22);
insert into neighbors values ( 3, 12);
insert into neighbors values ( 3, 24);
insert into neighbors values ( 4, 11);
insert into neighbors values ( 5, 0);
insert into neighbors values ( 5, 10);
insert into neighbors values ( 5, 20);
insert into neighbors values ( 5, 23);
insert into neighbors values ( 6, 10);
insert into neighbors values ( 6, 26);
insert into neighbors values ( 7, 8);
insert into neighbors values ( 7, 15);
insert into neighbors values ( 7, 16);
insert into neighbors values ( 8, 7);
insert into neighbors values ( 8, 26);
insert into neighbors values ( 9, 1);
insert into neighbors values ( 9, 10);
insert into neighbors values ( 9, 14);
insert into neighbors values ( 9, 17);
insert into neighbors values ( 9, 19);
insert into neighbors values ( 9, 20);
insert into neighbors values ( 10, 0);
insert into neighbors values ( 10, 1);
insert into neighbors values ( 10, 6);
insert into neighbors values ( 10, 9);
insert into neighbors values ( 10, 17);
insert into neighbors values ( 10, 19);
insert into neighbors values ( 10, 20);
insert into neighbors values ( 11, 2);
insert into neighbors values ( 11, 4);
insert into neighbors values ( 12, 0);
insert into neighbors values ( 12, 3);
insert into neighbors values ( 12, 22);
insert into neighbors values ( 12, 23);
insert into neighbors values ( 12, 24);
insert into neighbors values ( 13, 27);
insert into neighbors values ( 14, 0);
insert into neighbors values ( 14, 9);
insert into neighbors values ( 14, 24);
insert into neighbors values ( 15, 7);
insert into neighbors values ( 15, 16);
insert into neighbors values ( 16, NULL);
insert into neighbors values ( 17, 1);
insert into neighbors values ( 17, 9);
insert into neighbors values ( 17, 10);
insert into neighbors values ( 18, NULL);
insert into neighbors values ( 19, 1);
insert into neighbors values ( 19, 10);
insert into neighbors values ( 19, 27);
insert into neighbors values ( 20, 5);
insert into neighbors values ( 20, 10);
insert into neighbors values ( 20, 16);
insert into neighbors values ( 20, 23);
insert into neighbors values ( 21, 25);
insert into neighbors values ( 22, 2);
insert into neighbors values ( 22, 12);
insert into neighbors values ( 23, 0);
insert into neighbors values ( 23, 5);
insert into neighbors values ( 23, 12);
insert into neighbors values ( 23, 20);
insert into neighbors values ( 24, 0);
insert into neighbors values ( 24, 3);
insert into neighbors values ( 24, 12);
insert into neighbors values ( 24, 14);
insert into neighbors values ( 25, 9);
insert into neighbors values ( 25, 21);
insert into neighbors values ( 26, 6);
insert into neighbors values ( 26, 8);
insert into neighbors values ( 27, 1);
insert into neighbors values ( 27, 9);
insert into neighbors values ( 27, 13);
insert into neighbors values ( 27, 19);

-- Find all country names
   select C.cname from country C;

-- Find all country names whose map color is green
   select C.cname from country C
   where C.mapcolor = 'green';

-- Find all country names whose map color is yellow
   select C.cname from country C
   where C.mapcolor = 'yellow';	

-- Find all country names whose map color is red
   select C.cname from country C
   where C.mapcolor = 'red';

-- Find all country names whose map color is purple
  select C.cname from country C
  where C.mapcolor = 'purple';

-- Find all country names whose map color is null
  select C.cname from country C
  where C.mapcolor is NULL;

-- Find all distinct country names that have neighbors and at least
-- one of them has not been colored (i.e., has color NULL)
  select distinct C.cname
  from country C
  join neighbors N
  on C.id = N.id
  where mapcolor is NULL
  group by C.cname;
  
  --*Note * : other one using from lecture note
	select C.cname 
	from country C 
	where C.id in
	(select distinct N.id from country C, neighbors N
	where N.neighborid = C.id and C.mapcolor is NULL);


-- Find all country names that have at least 2 neighbors  
  select C.cname
  from country C
  join neighbors N
  on C.id = N.id
  group by C.cname
  having count(*) >= 2;
  
  -- *Note * : other one using from the lecture note
  select distinct C.cname
	from country C, neighbors n1, neighbors n2
	where n1.id = C.id and n2.id = C.id 
	and n1.neighborid <> n2.neighborid; 

-----------------------------------------------------------------------------

-- Switch to default db postgres and drop your database in the end
\c postgres
drop database "AS";

-----------------------------------------------------------------------------
