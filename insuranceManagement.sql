create table Customers(
	customer_id int primary key,
	first_name varchar(25),
	last_name varchar(25),
	date_of_birth date,
	gender varchar(12),
	contact_number varchar(10),
	email varchar(30),
	address varchar(30)
);

create table Policies(
	policy_id int primary key,
	policy_name varchar(30),
	policy_type varchar(20),
	coverage_details varchar(20),
	premium real,
	start_date date,
	end_date date
);

create table Claims(
	claim_id int primary key,
	claim_date date,
	claim_amount real,
	approved_amount real,
	claim_status varchar(20),
	policy_id int,
	customer_id int,
	foreign key(policy_id) references Policies(policy_id),
	foreign key(customer_id) references Customers(customer_id)
);

create table Agents(
	agent_id int primary key,
	first_name varchar(25),
	last_name varchar(25),
	conatct_number varchar(10),
	email varchar(30),
	hire_date date
);

create table Policy_Assignment(
	assignment_id int primary key,
	customer_id int,
	policy_id int,
	start_date date,
	end_date date,
	foreign key(policy_id) references Policies(policy_id),
	foreign key(customer_id) references Customers(customer_id)
);

create table Claim_Processing(
	processing_id int primary key,
	claim_id int,
	processing_date date,
	payment_amount real,
	payment_date date,
	foreign key(claim_id) references Claims(claim_id)
);

--DDL Queries
--1. Add a new column to the agents table
alter table agents add column address varchar(25);

--2.Rename the policy_name column in the policies table to policy_title
alter table policies rename column policy_name to policy_title;

--3.Drop the address column from th ecustomers table
alter table customers drop column address;

select * from customers;

--DML Queries
insert into customers values(1, 'John', 'Doe', '1980-05-15', 'Male', '1234567890', 'john.doe@example.com');
insert into customers values(2, 'Jane', 'Smith', '1990-08-22', 'Female', '2345678901', 'jane.smith@example.com');
insert into customers values(3, 'Emily', 'Brown', '1975-11-30', 'Female', '3456789012', 'emily.brown@example.com');
 
insert into policies values(1, 'Health Plus', 'Health', 'Covers ', 500.00, '2024-01-01', '2024-12-31');
insert into policies values(2, 'Auto Secure', 'Auto', 'Covers theft', 300.00, '2024-01-01', '2024-12-31');
insert into policies values(4, 'Life Shield', 'Life', 'death benefit', 1000.00, '2024-01-01', '2044-12-31');
-- 
insert into claims values(12, '2024-07-15', 1500.00, 1200.00, 'Approved', 1, 1);
insert into claims values(24, '2024-07-20', 2000.00, 0.00, 'Denied', 2, 2);
insert into claims values (36, '2024-07-25', 500.00, 500.00, 'Approved', 3, 3);

insert into agents values(101, 'Michael', 'Scott', '1234567890', 'michael.scott@example.com', '2015-04-01');
insert into agents values(201, 'Dwight', 'Schrute', '2345678901', 'dwight.sch@example.com', '2016-05-15');
insert into agents values(301, 'Jim', 'Halpert', '3456789012', 'jim.halpert@example.com', '2017-06-20');
 

insert into claim_processing  values(125, 12, '2024-07-16', 1200.00, '2024-07-17');
insert into claim_processing  values(208, 24, '2024-07-21', 0.00, '2024-07-17');
insert into claim_processing  values(303, 24, '2024-07-26', 500.00, '2024-07-27');
 
insert into policy_assignment values(11, 1, 1, '2024-01-01', '2024-12-31');
insert into policy_assignment values(21, 2, 2, '2024-01-01', '2024-12-31');
insert into policy_assignment values(31, 3, 3, '2024-01-01', '2044-12-31');

--1.Update a policy's premium amount
update policies set premium=600 where policy_id=2;

--2.Delete a specific claim
delete from claims where claim_id=36;

--3.Insert a new policy assignment
insert into policy_assignment values(33, 1, 2, '2024-02-01', '2044-12-11');

--join queries
--1 Retrieve all customers with their assigned policies and agents
 select * from customers c join policy_assignment pa on c.customer_id =pa.customer_id ;

--2 Find all claims and the associated policy details
select * from policies p join claims c on p.policy_id =c.policy_id ;

--3.List all claims along with the customer details
select * from claims natural join customers ;

--4 Get the total claim amount and number of claims per policy type
select p.policy_type ,sum(claim_amount) as sum_of_claim_amounts,count(*)as number_of_policies from claims c join policies p on c.policy_id =p.policy_id
group by p.policy_type ;

--5 Find the most recent claim for each customer
select cl.claim_id, c.first_name, c.last_name from claims cl join customers c on (c.customer_id=cl.customer_id) where cl.claim_date=(select max(claims.claim_date) from claims);







