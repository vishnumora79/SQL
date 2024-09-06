/* CASE STATEMENT */

/* create table */
create table product(product_name varchar,quantity int);

/* insert data into table */
insert into product values('Charis',20),
                          ('BookCases',10),
						  ('Storage',25),
						  ('Phone',18),
					      ('Copiers',null);
						  
/* Segregate records based on qunatity using CASE by creating a view */
create view product_view as (
select product_name,quantity,
CASE
   WHEN quantity < 10 then 'Less than 10 products'
   when quantity > 10 then 'More than 10 products'
   when quantity = 10 then 'Equal to 10 products'
  Else 'No Stock'
end
as stock_details from product);

select * from product_view;
