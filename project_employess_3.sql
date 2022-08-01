Input: 
Project table:
+-------------+-------------+
| project_id  | employee_id | per_project  each_emp
+-------------+-------------+
| 1           | 1           | 3               sum(exp_yers) over(partition by emp_id)
| 1           | 2           | 2
| 1           | 3           | 3
| 2           | 1           | 3
| 2           | 4           | 2
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
Output: 
+-------------+---------------+
| project_id  | employee_id   |
+-------------+---------------+
| 1           | 1             |
| 1           | 3             |
| 2           | 1             |
+-------------+---------------+

-- Explanation: Both employees with id 1 and 3 have the most experience among the employees of the first project. 
-- For the second project, the employee with id 1 has the most experience.


with join_tbl as (
Select p.project_id,p.employee_id, emp.experience_years from Project p
inner join Employee emp on p.employee_id = emp.employee_id
),
get_exp_years as 
(
 select 
    *,
   max(experience_years) over(partition by project_id order by project_id) as max_exp
    
from join_tbl
) select project_id,employee_id from get_exp_years where experience_years = max_exp