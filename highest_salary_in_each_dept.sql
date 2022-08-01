select dept_name as Department , emp_name as Employee ,salary as Salary from(
select emp.name as emp_name, 
salary,
departmentId ,
dept.name as dept_name,
rank() over(partition by departmentId order by salary desc ) as rnk

from 
(
  (select name,salary,departmentId from employee) emp
   inner join
   (select id, name from department) dept
    on (emp.departmentId=dept.id)
)
) query_res where rnk=1;