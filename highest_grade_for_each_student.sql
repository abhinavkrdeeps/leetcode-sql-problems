Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    | 2
| 1          | 2         | 99    | 1 
| 3          | 1         | 80    |  2
| 3          | 2         | 75    |  3
| 3          | 3         | 82    |  1
+------------+-----------+-------+
Output: 
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+

with give_ranks as (
select student_id, 
course_id, 
grade,
dense_rank() over(partition by student_id order by grade desc, course_id) as rnk
from Enrollments
) select student_id, course_id,  grade from  give_ranks where rnk=1