create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);
delete from billings;
insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);
insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4)

-- get date range using lead 

select temp1.emp_name,
sum(case when hw.work_date between bill_date and end_date then (bill_rate*hw.bill_hrs) else 0 end) as amount
 from (
(select
*,
lead(date_sub(bill_date, interval 1 day),1,'9999-01-31') over(partition by emp_name order by bill_date) as end_date
from billings) temp1
inner join 
(select * from HoursWorked ) hw
on (temp1.emp_name = hw.emp_name)
) group by temp1.emp_name
;