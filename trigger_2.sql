-- create a table
create table employee(
id serial primary key,
name varchar not null,
dept varchar not null,
date_of_joining date not null default current_date,
status varchar default 'Active',
salary real not null,
last_updated timestamp default CURRENT_TIMESTAMP);

-- insert the data into table
insert into employee(name,dept,salary) values('balaji','IT',45000),
                                             ('bhargav','HR',340000);
											 
select * from employee;											 
	
-- Creating a function	
create function update_time()
returns trigger 
as $$
begin 
    new.last_updated = now();
	return new;
end;
$$ language plpgsql;

-- Creating a trigger
create trigger update_time
before update
on employee
for each row
execute procedure update_time()

update employee set status = 'InActive' where name = 'balaji';
	
