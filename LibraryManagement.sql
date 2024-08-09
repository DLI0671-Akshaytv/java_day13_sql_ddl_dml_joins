--create Auhtor table
create table Authors(
	author_id int primary key,
	first_name varchar(25),
	last_name varchar(25),
	date_of_birth date,
	nationality varchar(25)
);

--create Books table
create table Books(
	book_id int primary key,
	title varchar(30),
	author_id int,
	publication_year int,
	genre varchar(25),
	isbn varchar(30),
	available_copies  int,
	foreign key(author_id) references Authors(author_id)
);

--create Members table
create table Members(
	member_id int primary key,
	first_name varchar(25),
	last_name varchar(25),
	date_of_birth date,
	contact_number varchar(10),
	email varchar(30),
	membership_date date
);

--create Loans table
create table Loans(
	loan_id int primary key,
	book_id int,
	member_id int,
	loan_date date,
	return_date date,
	actual_return_date date,
	foreign key(book_id) references Books(book_id),
	foreign key(member_id) references Members(member_id)
);

--create Staff table
create table Staff(
	staff_id int primary key,
	first_name varchar(25),
	last_name varchar(25),
	position varchar(25),
	contact_number varchar(10),
	email varchar(30),
	hire_date date
);

--DDL Queries
--Add a new column to the books table
alter table Books add rating float;

--Rename the position column in the staff table to job_title
alter table Staff rename column position to job_title;

--drop the email column from the members table
alter table Members drop column email;

--DML Queries
--insert new data into the books table
insert into Authors (author_id, first_name, last_name, date_of_birth, nationality) values (1, 'F. Scott', 'Fitzgerald', '1896-09-24', 'American'),(2, 'Harper', 'Lee', '1926-04-28', 'American'),(3, 'George', 'Orwell', '1903-06-25', 'British');

insert into Books (book_id, title, author_id, publication_year, genre, isbn, available_copies)
values(103, '1984', 3, 1949, 'Science Fiction', '978-0-452-28423-4', 2),(102, 'To Kill a Mockingbird', 2, 1960, 'Fiction', '978-0-06-112008-4', 3),(104, 'Pride and Prejudice', 1, 1813, 'Romance', '978-0-14-143951-8', 4);

insert into Members values (101, 'John', 'Doe', '1990-05-15', '1234567890', '2023-01-01'),(102, 'Jane', 'Smith', '1985-08-20', '9876543210', '2023-01-05'),(103, 'Alice', 'Johnson', '2000-03-10', '5551234567', '2023-01-10');

insert into Loans values (201, 102, 101, '2023-02-01', '2023-02-15', '2023-04-23'),(202, 103, 102, '2023-02-03', '2023-02-18', '2023-04-23'),(203, 104, 103, '2023-02-05', '2023-02-20', NULL);

insert into Staff values (301, 'John', 'Smith', 'Manager', '9876543210', 'john.smith@example.com', '2023-02-10');


--Update a member's contact number
update Members set contact_number =9894725564 where member_id=102;

--Delete a specific loan record
delete from loans where loan_id=201;

--insert a new loan record
insert into loans values(201, 102, 101, '2023-02-01', '2023-02-15', '2023-04-23');


--Join Queries
--retrieve all books along with their authors:
select b.title as Book_Title, a.first_name ||' '|| a.last_name as name from Books b join Authors a on a.author_id=b.author_id;

--Find all books currently on loan along with member details:
select b.title as Book_Title, m.member_id as member_id ,m.first_name||' '||m.last_name as Member_details from Books b join loans l  on (l.book_id =b.book_id)  join members m on (l.member_id =m.member_id);

--List all books borrowed by a specific member
select b.title as Book_Title, m.member_id as member_id ,m.first_name||' '||m.last_name as Member_details from Books b join loans l  on (l.book_id =b.book_id)  join members m on (l.member_id =m.member_id) where m.first_name='Jane' and m.last_name='Smith';

--Get the total number of books and the total available copies for each genre:
select sum(available_copies) as total_copies from Books;
select genre , sum(available_copies) from Books group by genre ;

--Find all staff members who are librarians and their hire dates
select s.first_name||' '||s.last_name ,hire_date from Staff s where job_title='Librarian';

