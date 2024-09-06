create table product(PName varchar(25),Price decimal, Category varchar(25),Manufacturer varchar(25));

select * from product;

insert into product values('Gizmo', 19.99,'Gadgets', 'GizmoWorks'),
                           ('Powergizmo', 29.99,'Gadgets', 'GizmoWorks'),
						   ('SingleTouch', 149.99,'Photography', 'Canon'),
						   ('MultiTouch', 203.99,'HouseHold', 'Hitachi');
	
select * from product where Price between 100 and 200;

select PName from product where Manufacturer in ('Canon','Hitachi');

select * from product where PName like 'P%'; 
select * from product where PName like '%Touch';
select * from product where PName like '_u%';
select * from product where PName like '%u__';
select * from product where PName like '%h';

-- Like operator

select * from product where PName like '%e%';

select * from product where pname like '_o%';

select pname from product where pname like '%c_';    -- pname with 2nd last character is c.


select round(sum(price),1) as total, count(price) as count, max(price) as maximum, min(price) as minimum , round(avg(price),2) as average from product; 
	
select manufacturer,round(avg(price),2) as average from product group by manufacturer;	

select round(sum(price),2) as total from product group by manufacturer;

select manufacturer, count(price) as count from product group by manufacturer;

select manufacturer,count(pname) from product where pname like '%o%';
	


-- alter table product add boolean1 int;

-- alter table product drop boolean1;

select pname,price,category,manufacturer, 
case 
  when pname like '%To%'
  then 1
  else 0
  end as checker from product;
  
select pname,price,category,manufacturer, if  as if_checker from product;  
  
  
-- creating table for case operations
create table emp_salary_details (emp_id int, emp_salary decimal);

insert into emp_salary_details values(1,50000),
(2,35000),(3,70000),(4,10000),(5,120000);

select * from emp_salary_details;

select * from emp_salary_details where emp_salary > (select avg(emp_salary) from emp_salary_details);

truncate table emp_salary_details;


create table machines (m_id int, p_id int, activity_type varchar(7),time_stamp decimal);

select * from machines;
drop table machine;
truncate table machine;
insert into machines values(0,0,'start',0.712),
						(0,0,'end',1.512),
						(0,1,'start',3.140),
                        (0,1,'end',4.120),
						(1,0,'start',0.550),
						(1,0,'end',1.550),
						(1,1,'start',0.430),
                        (1,1,'end',1.420),
                        (2,0,'start',4.100),
						(2,0,'end',4.512),
						(2,1,'start',2.500),
                        (2,1,'end',5.00);
						
explain select m_id,avg(e-s) as processing_time
from
(select 
m_id,
p_id,
max(case when activity_type = 'end' then time_stamp end) as E,
min(case when activity_type = 'start' then time_stamp end) as S 
from machines group by m_id,p_id) as new_machine group by m_id;

select m_id,p_id from machine group by m_id,p_id;



create table emp_data(id int primary key,name varchar(10),mgr_id int);

select * from emp_data;

insert into emp_data values (1,'a',3),
                     (2,'b',5),
					 (3,'c',null),
					 (4,'d',2),
					 (5,'e',3);
		
select emp.id,emp.name,mgr.name as mgr_name from emp_data as emp left join emp_data as mgr on emp.mgr_id = mgr.id;

	
alter table emp_data add column salary int;	

update emp_data set salary = 
case 
when id = 1 then 20000
when id = 2 then 30000
when id = 3 then 50000
when id = 4 then 55000
when id = 5 then 40000
end;
select * from emp_data;

select emp.name,emp.salary from emp_data as emp left join emp_data as mgr on emp.mgr_id = mgr.id where emp.salary > mgr.salary;

select * from emp_data order by salary desc limit 1 offset 1;  


-- Another data table

create table company(id int,name varchar(45),dept varchar(45),salary int);

insert into company values(1,'a','IT',30000),
                    (2,'b','IT',70000),
					(3,'c','HR',50000),
					(4,'d','HR',20000),
					(5,'e','FINANCE',10000),
					(6,'f','FINANCE',10000),
					(7,'g','BPO',20000);
					
SELECT name,salary FROM COMPANY where SALARY > (select avg(salary) from company);

select c.name,c.salary,dept_avg.avg_salary from company as c join (select dept,avg(salary) as avg_salary from company group by dept) as dept_avg on c.dept = dept_avg.dept where c.salary > dept_avg.avg_salary;

-- SELECT *
-- FROM company as e
-- JOIN (
--     SELECT dept, AVG(salary) AS avg_salary
--     FROM company
--     GROUP BY dept
-- ) dept_avg ON e.dept = dept_avg.dept
-- WHERE e.salary > dept_avg.avg_salary;


-- finding the unique values without using distinct keyword
create table unique_example(id int primary key,name varchar(45));

insert into unique_example values(1,'vishnu'),
(2,'vardhan'),
(3,'wanda'),
(4,'Iron Man'),
(5,'Thor'),
(6,'Hulk'),
(7,'vardhan'),
(8,'wanda');

-- select distinct name from unique_example;

select name from unique_example group by name;
					




	
			
						   