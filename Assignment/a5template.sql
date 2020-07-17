-- Transactions

create database "JH"; -- use your initials
\c "JH"
\set ECHO all

-----------------------------------------------------------------------------
/* 

Small database of bank customers and their accounts. A customer may
have more than one account.

*/

create table Customer (
  custid int primary key,
  name varchar(30) not null
);

create table Account (
  acctnum int unique,
  type char, -- C checking, S savings
  custid int,
  balance int,
  primary key (acctnum,type),
  foreign key (custid) references Customer(custid)
);

create table Actions (
  actionid int primary key,
  acctnum int,
  type char, -- D deposit, W withdraw
  amount int,
  foreign key (acctnum) references Account(acctnum)
);

insert into Customer values(1,'Ace');
insert into Customer values(2,'Bob');
insert into Customer values(3,'Cai');
insert into Customer values(4,'Dag');
insert into Customer values(5,'Ebi');
insert into Customer values(6,'Fab');
insert into Customer values(7,'Gan');

insert into Account values(1,'C',1,150);
insert into Account values(2,'S',1,200);
insert into Account values(3,'C',2,100);
insert into Account values(4,'C',3,1000);
insert into Account values(5,'C',4,200);
insert into Account values(6,'S',4,10000);
insert into Account values(7,'C',6,50);
insert into Account values(8,'S',7,0);

insert into Actions values(1,1,'D',300);
insert into Actions values(2,2,'W',150);
insert into Actions values(3,1,'W',10);
insert into Actions values(4,7,'D',1000);
insert into Actions values(5,7,'W',30);
insert into Actions values(6,7,'D',20);
insert into Actions values(7,4,'D',50);
insert into Actions values(8,5,'D',10);
insert into Actions values(9,6,'W',350);

-----------------------------------------------------------------------------
-- Simple queries and/or modifications

-- 1. Write a query that produces a table consisting of each customer
-- id, their name, and for each account they have, the account number
-- and balance. If the customer has no accounts, their id and name
-- should still appear in the table.


-- 2. Withdraw 100 from account 6


-- 3. Withdraw 100 from Bob's account. Use a subquery to compute Bob's
-- account number.


-- 3. Transfer 50 from account 1 to account 2


-- 4. Delete all accounts with 0 balance.


-- 5. Below is a transaction that process the first three rows in the
-- actions table.
-- 
-- Answer the following questions in a context where the transaction
-- runs concurrently with other (arbitrary) transactions,
-- 
-- a. Is it possible that interference from other transactions would
-- cause the deposit action to never execute?
-- 
-- b. Is it possible that interference from other transactions would
-- cause either withdraw action to happen twice? 
--
-- In each case, if you answer yes, provide a scenario that exhibits
-- the anomalous behavior. If you answer no, briefly justify your
-- answer.

begin transaction;
set transaction isolation level read committed;

  -- Process action 1
  
  update Account as A
    set balance = balance + (select T.amount
    		  	     from Actions T
			     where T.acctnum = 1
			     and T.type = 'D')
    where A.acctnum = 1;

  delete from Actions T
  where T.actionid = 1;

  -- Process action 2

  update Account as A
    set balance = balance - (select T.amount
    		  	     from Actions T
			     where T.acctnum = 2
			     and T.type = 'W')
    where A.acctnum = 2;

  delete from Actions T
  where T.actionid = 2;

  -- Process action 3

  update Account as A
    set balance = balance - (select T.amount
    		  	     from Actions T
			     where T.acctnum = 1
			     and T.type = 'W')
    where A.acctnum = 1;

  delete from Actions T
  where T.actionid = 3;

commit;

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- Switch to default db postgres and drop your database in the end

\c postgres
drop database "JH";

-----------------------------------------------------------------------------


