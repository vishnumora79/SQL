create table Student_score(id int, score int);

insert into Student_score values(1,2),
(2,5),
(3,5),
(4,6),
(5,9);

select * from Student_score;

select id,
  case 
    when score <= 2 then 'Fail'
	when score < 6 then 'Supplimentary'
	else 'Distinction'
end as result
from Student_score;
 
select customer_id from (select customer_id,count(*) as f from orders group by customer_id order by f desc limit 1) as r;

select score from (select score,count(*) as frequency from Student_score group by score order by frequency desc limit 1) as result;