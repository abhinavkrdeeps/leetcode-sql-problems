
Student table:
+--------+-----------+
| name   | continent |
+--------+-----------+
| Jane   | America   |
| Pascal | Europe    |
| Xi     | Asia      |
| Jack   | America   |
+--------+-----------+
Output: 
+---------+------+--------+
| America | Asia | Europe |
+---------+------+--------+
| Jack    | Xi   | Pascal |
| Jane    | null | null   |
+---------+------+--------+

select min(America) as America , min(Asia) as Asia, min(Europe) as Europe from(
select 
name,
continent,
case when continent='America' then name end as America,
case when continent='Europe' then name end as Europe,
case when continent='Asia' then name end as Asia,
row_number() over(partition by continent order by name ) as rn
from student  ) derived group by rn order by name ;