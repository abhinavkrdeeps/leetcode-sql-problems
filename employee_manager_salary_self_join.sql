select * from employee;


Insert into employee values 
(1, 'Ankit', 10000, 4),
(2, 'Mohit', 15000, 5),
(3, 'VIkash', 10000, 4),
(4, 'Rohit', 5000, 2),
(5, 'Mudit', 12000,6),
(6, 'Agam', 12000, 2),
(7, 'Sanjay', 9000, 2),
(8, 'Ashish', 5000, 2)

1	Ankit	10000	4
2	Mohit	15000	5
3	VIkash	10000	4
4	Rohit	5000	2
5	Mudit	12000	6
6	Agam	12000	2
7	Sanjay	9000	2
8	Ashish	5000	2


with self_join_tbls as (
select e2.emp_id as emp_id, e2.emp_name, e2.salary as emp_sal, e1.salary as man_sal
from employee e1, employee e2 where e1.emp_id = e2.manager_id order by e2.emp_id
) select emp_id,
emp_name,emp_sal,man_sal
from self_join_tbls where emp_sal > man_sal


-- employees who are not managers of others
select e1.emp_id, e1.emp_name from employee e1 left join employee e2 on e1.emp_id=e2.manager_id where e2.emp_id is null;




