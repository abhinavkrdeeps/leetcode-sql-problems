Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+

with get_dept_name as
(
    select
    emp.name as Employee,
    emp.salary as Salary,
    dept.name as Department,
    emp.departmentId as departmentId
    from Employee  emp
    inner join Department  dept
     on emp.departmentId=dept.id
)
, create_ranks as 
(
    select 
    Department,
    Employee,
    Salary,
    dense_rank() over(partition by departmentId order by salary desc) as dept_wise_rank
    from get_dept_name
)select Department, Employee, Salary from create_ranks where dept_wise_rank=1
