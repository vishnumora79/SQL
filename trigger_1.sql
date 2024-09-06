/* Creating table sales_data */
create table sales_data(id serial,customer_name varchar,
						location varchar,item_price int,
						no_of_items int,total_price int);
						
/* Insert the data into table */						
insert into sales_data(customer_name,location,item_price,no_of_items) values('sandeep','Hyd',45,3),
                                                                             ('sagar','chennai',67,2),
																			 ('sumanth','mumbai',45,6);
																			 
/* Create function */
create function calculate_total_price()
returns trigger 
as $$
declare
     total numeric;
begin
   total = new.item_price * new.no_of_items;
   new.total_price = total;
   return new;
end;
$$ language plpgsql;

-- create function calc_tot_price()    
-- returns trigger          
-- as $$
-- declare
-- 	total numeric;
-- begin
-- 	total = new.sales * new.quantity;
-- 	new.total_price = total;
-- 	return new;
-- end;
-- $$ language plpgsql;

-- create trigger calc_tot_insert
-- before insert
-- on sales_data
-- for each row
-- execute procedure calc_tot_price();

/* Create trigger */
create trigger sales_trigger
       before insert
on sales_data
for each row
execute procedure calculate_total_price();
	   
	   
select * from sales_data;	   
   
delete from sales_data where customer_name = 'sandeep';
drop table sales_data;  
drop trigger if exists sales_trigger on sales_data;
drop function if exists calculate_total_price();