

/* DCL - Data Control Language */
/* grant,revoke */
/* Note : create new user and grant permissions to access the database */

create user PS1 password 'vishnu';

/* At this time the new_user PS1 cannot able to access the database */
select * from employee; /* ERROR:  permission denied for table employee  */

/* To access the database - superuser should grant the permissions */
/* GRANT - ON - TO */
grant select on employee to PS1;  /* super-user 'postgres' should grant permissions - */
/*so login with superuser credentials and then grant permissions*/

select * from employee;
/* to update table superuser should give all permissions */
update employee set status = 'Active' where name = 'balaji'; /* ERROR:  permission denied for table employee */

grant update on employee to PS1;  /* super-user 'postgres' should grant permissions - */
/*so login with superuser credentials and then grant permissions*/

update employee set status = 'Active' where name = 'balaji';

select * from employee;

/* If you want to grant all permissions to superuser then use 'all' attribute  as superuser*/

grant all on employee to PS1; 

/*NOTE : The command GRANT ALL ON employee TO PS1;
grants permissions on the "employee" table to the user "PS1," 
but it does not grant Data Definition Language (DDL) commands explicitly. */

/* The permissions granted by this command typically include permissions
for Data Manipulation Language (DML) operations such as SELECT, INSERT, UPDATE, DELETE, 
and other table-related actions like REFERENCES. 
However, it does not grant the ability to perform DDL commands,
which are used for creating, altering, and dropping database objects like tables, indexes, and schemas.*/

/* To grant DDL commands to a user, you would need to use GRANT statements
specifically for those privileges, such as CREATE, ALTER, and DROP.*/

/* GRANT CREATE, ALTER, DROP ON DATABASE dbname TO PS1; */

/* Revoke - The super-user can remove privileages which are granted to other query */
revoke UPDATE on employee from PS1;
/* If we perform UPDATE command then it throws an error */
update employee set status = 'InActive' where name = 'balaji'; -> /* ERROR:  permission denied for table employee */ 

/* If you want to remove all permissions granted to other user */
revoke all on employee from PS1;

select * from employee; /* ERROR:  permission denied for table employee */

