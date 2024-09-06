-- Hackerrank Practice Questions

create database HackerRank_Questions;

-- 1.Creating a table with name and occupation columns
create table occupations(Name varchar,occupation varchar not null);

insert into occupations values('sam','Doctor'),
                              ('Julia','Actor'),
							  ('Maria','Actor'),
							  ('Meera','Singer'),
							  ('Ashely','Professor'),
							  ('Ketty','Professor'),
							  ('LEO','Professor'),
							  ('Jenny','Doctor');
-- Creating a view on header data							  
create view occupation_header as 					
select 
  max(case when occupation = 'Doctor' then name end) as Doctor,
  max(case when occupation = 'Professor' then name end) as Professor,
  max(case when occupation = 'Actor' then name end) as Actor,
  max(case when occupation = 'Singer' then name end) as Singer
  from (
     select occupation,name,row_number() over(partition by occupation order by name) as rn
     from occupations) as pivot
	 group by rn
	 order by rn;

select * from occupation_header;
							  