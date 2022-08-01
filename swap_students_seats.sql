Input: 
Seat table:
+----+---------+
| id | student |    
+----+---------+  
| 1  | Abbot   | 
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+

Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
-- Explanation: 
-- Note that if the number of students is odd, there is no need to change the last one's seat.


select 
case 
when cnt%2=0 and id%2!=0 then id+1
when cnt%2=0 and id%2=0 then id-1
when cnt%2!=0 and id%2=0 then id-1
when cnt%2!=0 and id%2!=0 and id=cnt then id else id+1 end as id,
student
from Seat,
(select count(1) as cnt from Seat) seat_cnts order by id