/* TCL - TRANSACTION CONTRL LANGUAGE */
/* Every query we run is a transaction */
/* TCL COMMANDS - BEGIN,
                  ROLLBACK,
				  COMMIT */
/* BEGIN - used to track the transaction */
/* ROLLBACK - undo */
/* COMMIT - to stop the transaction tracking */

select * from employee2;
			
delete from employee2 where salary = 96700;/* in this case i didn't use TCL Commands , so changed can't be rollbacked */ 			
/* So if you want that deleted data into table , you need to insert into table */
insert into employee2 values(2,'Krishika',96700,2);

/* If we use TCL Commands */
begin;
delete from employee2 where salary = 96700;
rollback;
commit;

/* update */
begin;
update employee2 set salary = 98000 where name like 'Kr%';
rollback;
commit;