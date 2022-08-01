Input: 
Point2D table:
+----+----+
| x  | y  |
+----+----+
| -1 | -1 |
| 0  | 0  |
| -1 | -2 |
+----+----+
Output: 
+----------+
| shortest |
+----------+
| 1.00     |
+----------+
-- Explanation: The shortest distance is 1.00 from point (-1, -1) to (-1, 2).

select min(round((sqrt(((x-x1)*(x-x1))+ ((y-y1)*(y-y1)))),2)) as shortest  from Point2D, (
select x as x1 , y as y1 from Point2D 
) temp where ((x-x1)!=0 or (y-y1)!=0);