create table department(id int primary key,name varchar not null);

insert into department values(1,'HR'),(2,'IT');

SELECT * FROM department;


create table employee2(id serial primary key,name varchar,
					   salary real ,departmentId int,
					   foreign key(departmentId) references department(id));

insert into employee2(name,salary,departmentId) values ('Krishna',78000,1),
                                                        ('Krishika',96700,2),
														('Kishore',58000,1),
														('Kumar',67000,1);
						
select * from employee2;

/* Updating the table */
update employee2 set salary = 79000 where salary = 78000;

/* Getting the maximum salary */
select max(salary) as max_salary from employee2;
/* Getting Average salary */
select avg(salary) as avg_salary from employee2;
/* Getting minimum salary */
select min(salary) as min_salary from employee2;
/* Difference between maximum and minimum */
select max(salary) - min(salary) from employee2;
/* Sum of maximum and minimum */
select max(salary) + min(salary) from employee2;
/* Sub-Queiry */
select name,salary from employee2 where salary > (select avg(salary) as avg_salary from employee2);

/* To store the data of a query data into a table */
create view query_view as
select employee2.name as emp_name,salary,department.name from employee2 inner join department on employee2.departmentId = department.id
where salary > (select avg(salary) as avg_salary from employee2);

select * from query_view;

drop table department;
drop table employee2;
drop table query_data;
drop view query_view;