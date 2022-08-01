Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
| 8  | 2   |
| 9  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
| 2               |
+-----------------+
-- Explanation: 1 is the only number that appears consecutively for at least three times.

-- with analytical functions
select num as ConsecutiveNums  from(
select id,
num,
lag(num, 1) over(order by id) as prev,
lead(num, 1) over(order by id) as next
 from logs_table order by id) temp where prev=num and num=next;