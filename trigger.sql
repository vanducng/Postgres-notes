-- No null value of employee name
-- No null value for salary and its value must be positive
create table employee
(
    empname text,
    salary integer
);

select *
from employee;

create or replace function emp_stamp
() returns trigger as $emp_stamp$
begin
    if new.empname is null then
		raise exception 'Employee name cannot be null';
end
if;
	if new.salary is null then
		raise exception '% cannot have null salary', new.empname;
end
if;

	-- salary must be bigger than zero
	if new.salary < 0 then 
		raise exception '% cannot have nagative salary', new.empname;
end
if;

	return new;
end;

$emp_stamp$ language plpgsql;

create trigger emp_stamp before
insert or
update on employee
	for each row
execute procedure emp_stamp
();


insert into employee
values('Duc', 1000);

select *
from employee;

insert into employee
    (empname, salary)
values('Duc', -220);


-- Audit table
drop table employee;

create table employee
(
    empname varchar(40) not null,
    salary int not null
);

create table employee_audit
(
    operation char(1) not null,
    stamp timestamp not null,
    "user" varchar(40) not null,
    empname varchar(40) not null,
    salary int
);

create or replace function process_emp_audit
() returns trigger as
$emp_audit$
begin
    if (TG_OP = 'DELETE') then
    insert into employee_audit
    values('D', now(), user, old.*);
    return old;
    elseif
    (TG_OP = 'UPDATE') then
    insert into employee_audit
    values('U', now(), user, new.*);
    return new;
end
if;

	if (TG_OP = 'INSERT') then
insert into employee_audit
values('I', now(), user, new.*);
return new;
end
if;
	return null;
end
$emp_audit$ language plpgsql;


create trigger employee_audit
after
insert or
update or delete on employee
	for each row
execute procedure process_emp_audit
();

insert into employee
values('Duc', 299),
    ('Nam', 499)


select *
from employee;
select *
from employee_audit;

update employee
set salary = 899
where empname = 'Nam'

select *
from employee_audit;

