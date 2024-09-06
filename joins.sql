create table courses(name varchar,course varchar);

insert into courses values('AAA','DATABASE'),
                           ('BBB','DATA ANALYTICS'),
						   ('CCC','DATA SCIENCE'),
						   ('DDD','SQL');
						   
select * from courses;						   
						   
create table students(name varchar , age int);

drop table students;
insert into students values('BBB',21),
                           ('CCC',23),
						   ('DDD',24),
						   ('EEE',56);
						   
select * from students;						   

/* Cross Join - performs cartesian product which is not much useful*/
select students.name , age, courses.name , course from students,courses;

/* Inner Join - gives matches from both tables */
/* join clause is based on name field */
select students.name,age,courses.name,course from students inner join courses on students.name = courses.name;

/* Left join - get all data from left side table and matching data from right side table*/
select * from courses left join students on students.name = courses.name;

/* Right join - get all data from right side table and matching data from left side table*/
select * from students right join courses on students.name = courses.name;

/* Full join - get all data from both the tables*/
select * from students full join courses on students.name = courses.name;

/* Left only(left outer join) - data exclusively present in left side table*/
select students.name,age,courses.name,course from students left join courses on students.name = courses.name where courses.name is null;

/* Right only(Right outer join) - data exclusively present in right side table*/
select students.name,age,courses.name,course from students right join courses on students.name = courses.name where students.name is null;

/* 	not inner scenario(Full outer join) - data which is distinct in both the data(Unique data)*/
select students.name,age,courses.name,course from students full outer join courses on students.name = courses.name where students.name is null or courses.name is null;






create table t1(number int,id1 int);
insert into t1 values(1,1),(2,1),(3,2),(4,2),(5,4),(6,null);
select * from t1;
-- drop table t1;
create table t2(number int,id2 int);
insert into t2 values(1,1),(2,1),(3,1),(4,3),(5,2),(6,null);
select * from t2;
-- drop table t2;

-- left join
select * from t1 left join t2 on t1.number = t2.number;
-- right join
select * from t1 right join t2 on t1.number = t2.number;
-- inner join
select * from t1 inner join t2 on t1.number = t2.number;




create table table1(num int,name varchar(45));
insert into table1 values(1,'a'),(2,'b'),(3,'c'),(4,'d');
select * from table1;

create table table2(num int,marks int);
insert into table2 values(1,80),(3,90),(4,30),(5,50);
select * from table2;

-- inner join
select * from table1 inner join table2 on table1.num = table2.num;
-- left join
select * from table1 left join table2 on table1.num = table2.num;
-- right join
select * from table1 right join table2 on table1.num = table2.num;
-- outer join
select * from table1 full join table2 on table1.num = table2.num;


