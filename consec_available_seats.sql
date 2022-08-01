Input: 
Cinema table:
+---------+------+
| seat_id | free |
+---------+------+
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+
Output: 
+---------+
| seat_id |
+---------+
| 3       |
| 4       |
| 5       |
+---------+

select seat_id from cinema where free=1 and ((seat_id+1 in (
select seat_id from cinema where free=1
)                                           
) 
or      
(seat_id-1 in (
select seat_id from cinema where free=1
)                                           
)
)
