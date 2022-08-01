Input: 
Project table:
+-------------+-------------+
| project_id  | employee_id |
+-------------+-------------+
| 1           | 1           |
| 1           | 2           |
| 1           | 3           |
| 2           | 1           |
| 2           | 4           |
+-------------+-------------+
Employee table:
+-------------+--------+------------------+
| employee_id | name   | experience_years |
+-------------+--------+------------------+
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 3                |
| 4           | Doe    | 2                |
+-------------+--------+------------------+

with get_emp_name_and_exp as (
select prj.project_id, prj.employee_id, emp.name, emp.experience_years 
from Project prj inner join Employee emp on prj.employee_id = emp.employee_id
),
get_exp_per_project_per_emp as (

    select project_id, employee_id,
    dense_rank() over(partition by project_id order by experience_years desc)  as rnk
    from get_emp_name_and_exp
)select project_id, employee_id from get_exp_per_project_per_emp where rnk=1


Output: 
+-------------+---------------+
| project_id  | employee_id   |
+-------------+---------------+
| 1           | 1             |
| 1           | 3             |
| 2           | 1             |
+-------------+---------------+
Explanation: Both employees with id 1 and 3 have the most experience among the employees of the first project.
 For the second project, the employee with id 1 has the most experience.