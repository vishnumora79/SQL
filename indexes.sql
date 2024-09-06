-- Creating a table
create table employee_data(id serial not null,name varchar not null,salary int not null);
-- Inserting data into table
insert into employee_data(name,salary) values('radhika',34000),
                                             ('radha',67000),
											 ('ram',450000),
											 ('ramya',87999),
											 ('rohan',34056),
											 ('roja',895666),
											 ('raja',58000);
											 
-- Normal select query
select * from employee_data where name = 'rohan';

-- Creating the index on salary
create index salary_index on employee_data(salary);

-- Select query on salary with index
select * from employee_data where name = 'rohan';

			
drop index salary_index;			