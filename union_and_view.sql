create table may(day int,customer varchar,purchases int,paymnent_mode varchar);
create table june(day int,customer varchar,purchases int,paymnent_mode varchar);
create table july(day int,customer varchar,purchases int,paymnent_mode varchar);

insert into july values(3,'lilly',4,'cash'),
                       (23,'nani',56,'online'),
					   (12,'baby',67,'online');
					   
select * from may;
select * from june;
select * from july;

/* Note : The main difference between table and view is
  #table occupy physical storage space in the database
  whereas
  #view just project on the data and present it. */

/* UNION - combines the records (append data from multiple tables)*/
create view union_output_view as 
select * from may union select * from june union select * from july;

select * from union_output_view;