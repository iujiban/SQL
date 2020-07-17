create database "JK"; -- use your initials
\c "JK"
\set ECHO all
 
CREATE TABLE Student( 
    student_id serial not null,
    name varchar(30) not null,
    sex varchar(1),
    phone varchar(10),
    address varchar(10),
    balance decimal not null default 0,
   
   primary key(student_id)
);

-- student_id -> name, sex, phone, address, balance

CREATE TABLE Category( 
    category_id serial not null,
    category_name varchar(30) not null,
    shelf int,
   
   primary key(category_id)
);

-- category_id -> category_name, shelf

CREATE TABLE BookInfo(
    ISBN int primary key,
    title varchar(50) not null,
    category_id int,
    author varchar(30),
    publication int,
    number_of_copy int,
   
   foreign key (category_id) references category(category_id)
);

-- ISBN -> title, category_id, author, publication, number_of_copy


CREATE TABLE BookID( 
    book_id serial not null,
    ISBN int,
   
   primary key (book_id),
    foreign key (ISBN) references BookInfo(ISBN)
);

-- book_id -> ISBN


CREATE TABLE BookIssue(
    book_id int not null,
    student_id int not null,
    issued_date date NOT NULL DEFAULT CURRENT_DATE,
    return_date date NOT NULL DEFAULT CURRENT_DATE+14, --checking
    return_status boolean not null DEFAULT False,

   
       
    foreign key (book_id) references BookID(book_id),
    foreign key (student_id) references Student(student_id)
);

-- Book_id, student_id -> issued_date, return_date, return_status





-- When inserting book data into  bookinfo table, 
-- new book id is inserted in bookid table with newly inserted ISBN in bookinfo table.
-- Also, book_ids are newly created based on number_of_copy in bookinfo table data.
-- EX)  insert into bookinfo values(13524, 'Database Concept',1,'Sabry',1,5);
--      Above code will make this trigger to insert 5 book_ids with isbn=13524 in bookid table. 
create or replace function insertbook() returns trigger as
$$
begin
for r in 1..new.number_of_copy loop
insert into bookid(ISBN) values(new.ISBN);
end loop;
return new;
end;
$$ language plpgsql;


CREATE TRIGGER insertbookid
  After insert
  ON bookinfo
  FOR Each ROW
  EXECUTE PROCEDURE insertbook();
  
  




--------------------------

insert into student (name,sex,phone,address)values('Kim','M','0000000000','Blooming');
insert into student (name,sex,phone,address)values( 's','M','1111111111','Blooming');
insert into student (name,sex,phone,address)values('s','M','222222222','Blooming');

insert into category (category_name,shelf)values('Database',14);
insert into category (category_name,shelf)values('course',4);

insert into bookinfo values(13524, 'Database Concept',1,'Sabry',1,5);
insert into bookinfo values(12345, '461',2,'Sabry',1,3);
insert into bookinfo values(23456, '351',2,'Saul',2,5);


----------------------
select * from student;
--
select * from category;

select * from bookinfo;

select * from bookid;
-- automatically inserted
select * from bookissue;
-- 


-- put book title and return category_name and shelf num
-- EX) select * from checkshelf(BOOK_TITLE);
--     Above code returns table of name of category and shelf number.
create or replace function checkshelf (booktitle char) returns table (category char, shelf_Num integer) as
$$
  select category_name,shelf 
  from category 
  where category_id = (select category_id 
                   from bookinfo 
                  where title=booktitle);
$$ language sql;


-- put ISBN and return how many books are left in the library
-- EX) select availiable(ISBN);
--     Above code returns how many number of book with given ISBN is in the library. 
create or replace function availiable (num integer) returns bigint as
$$
  select count(book_id)
  from bookid 
  where ISBN = num and book_id not in (select book_id 
                                          from bookissue 
                                where return_status=False);
$$ language sql;


-- put isbn and return who burrowed this book.
-- EX) select * from burrowedby(ISBN)
--     Above code returns student_id,name, issued_date and reteurn_date of people who burrowed book with given ISBN.
create or replace function burrowedby (book integer) returns table(id int, name char, issued_date date,return_date date) as
$$
  select s.student_id,s.name,i.issued_date ,i.return_date 
  from student s, bookissue i, bookid b where 
  s.student_id=i.student_id and i.return_status=False and i.book_id = b.book_id and b.ISBN = book order by i.return_date;
$$ language sql;


-- put bookid, studentid to issue book.  if it is already issued, raises exception
-- EX) select issueabook(book_id,student_id)
--     Above code will insert new row into bookissue.
--     If given book_id is already issued by other person, it raises exception.
CREATE OR REPLACE FUNCTION issueabook (bookid int,studentid int) RETURNS void AS
$$
BEGIN
IF bookid not in (select book_id from bookissue where return_status = FALSE)
THEN INSERT INTO bookissue values(bookid,studentid);
else
raise exception '% is already issued by other!', bookid;
END IF;
 END;
$$ language plpgsql;


-- put bookid and studentid to change return_status to true returning book
-- EX) select returnabook(book_id,student_id)
--     Above code changes return status of row in bookissue with given book_id and student_id into true.
CREATE OR REPLACE FUNCTION returnabook(bookid int, studentid int) RETURNS void AS
$$
BEGIN
IF bookid in (select book_id from bookissue where return_status = FALSE)
THEN UPDATE bookissue AS b set return_status=TRUE where b.book_id = bookid and b.student_id = studentid;
END IF;
END;
$$ language plpgsql;

-- return people who need to return book.
-- EX) select returnrecord()
--     Above code returns all the people who did not return book yet.
CREATE OR REPLACE FUNCTION returnrecord() RETURNS table(student_id int, student_name char,book_id int, book_title char, issued_date date, return_date date) AS
$$
select s.student_id,s.name,b.book_id,f.title,i.issued_date ,i.return_date 
  from student s, bookissue i, bookid b, bookinfo f where 
  s.student_id=i.student_id and b.isbn = f.isbn and i.return_status=False and i.book_id = b.book_id order by i.return_date;
  
$$ language sql;


-- return people who did not return book in 14days 
-- EX) select longermoverdue()
--     Above code returns people who issued book more than 14 days with overdue in their balance.
CREATE OR REPLACE FUNCTION longtermoverdue() RETURNS table(student_id int, student_name char,book_id int, book_title char, issued_date date, return_date date, balance int) AS
$$
select s.student_id,s.name,b.book_id,f.title,i.issued_date ,i.return_date, s.balance 
  from student s, bookissue i, bookid b, bookinfo f where 
  s.student_id=i.student_id and b.isbn = f.isbn and i.return_status=False and i.book_id = b.book_id and s.balance>0 and i.return_date-current_date<0 order by i.return_date;
  
$$ language sql;

-- return people who has to pay overdue
-- EX) select overduerecord()
--     Above code returns people who have to pay overdue.
--     Made this code, because not all the people return book and pay overdue at the same time.
CREATE OR REPLACE FUNCTION overduerecord() RETURNS table(student_id int, student_name char, balance decimal) AS
$$
select s.student_id,s.name, s.balance 
  from student s where 
   s.balance>0;
  
$$ language sql;


-- pay overdue given student_id
-- EX) select payoverdue(student_id,money)
--     Above code decrease the balance of the student, who has given student_id, according to money given.
--     Student cannot pay more than their overdue.
--     If student does not have overdue or trying to pay more than overdue in the balance, it raises errors.
CREATE OR REPLACE FUNCTION payoverdue(studentid int, money int) RETURNS void AS
$$
BEGIN
IF studentid in (select s.student_id from student s where s.balance>0 and money <= s.balance)
THEN UPDATE student set balance=balance-money where student_id = studentid;
else
raise exception 'Either student_id or amount of money is wrong!';
END IF;
END;
$$ language plpgsql;


-- update all the people's balance if their return date had passed
-- EX) select updateoverdue()
--     This is a function, which should be called once in a day.
--     User should call this function before library close in order to update balance of the people who did not return the book.
CREATE OR REPLACE FUNCTION updateoverdue() returns void as
$$
update student set balance = balance+0.25 from bookissue where bookissue.student_id = student.student_id and current_date>bookissue.return_date;
$$ language sql;



--\c postgres

