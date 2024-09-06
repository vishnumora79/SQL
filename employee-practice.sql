//DDL - (Data Query Language) command - Defining a table with structure
create table employee(first_name varchar(20) not null,
					  middle_name varchar(20),
					  last_name varchar(20) not null,
					  age int not null,
                      salary int not null,
					  location varchar(20) default 'Hyderabad' not null);
					  
//DML - (Data Manupulation Language) - To modify data in a table					  
insert into employee values('Raj','Ram','Roy',35,45000,'Hyderabad');
insert into employee values('Mohan',null,'Kumar',32,67000,'Chennai');
insert into employee(first_name,last_name,age,salary,location) values('Priya','Sharma',45,89999,'Mumbai');
insert into employee(first_name,last_name,age,salary,location) values('Bhuvi','Kumar',45,56000,'Panjab');
insert into employee(first_name,last_name,age,salary) values('Gita','Gopinath',34,78000);
insert into employee(first_name,last_name,age,salary,location) values('Narendra','Modi',87,200000000,'Delhi');
insert into employee values('Akash',null,'Singh',56,7899,null);
insert into employee(first_name,middle_name,last_name,age,salary) values('Anu','Ram','Reddy',45,23495);
insert into employee(first_name,middle_name,last_name,age,salary) values('Krish','Green','Reddy',12,340);
insert into employee(first_name,middle_name,last_name,age,salary) values('Shushanth','Singh','Rajput',34,5600000);



//DQL-(Data Query Language) - To query data in a table					  
select * from employee;		

//DDL Command - Drops the entire table and its structure
drop table employee;

