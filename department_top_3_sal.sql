-- https://leetcode.com/problems/department-top-three-salaries/

select Department, Employee,Salary from(
select  dept.name as Department, emp.name as Employee,emp.salary as Salary,
dense_rank() over(partition by emp.departmentId order by  emp.salary desc) as ord
from (
(select * from employee ) emp
inner join
(select * from department) dept
on (emp.departmentId=dept.id)
) 
) temp1 where ord in (1,2,3) 