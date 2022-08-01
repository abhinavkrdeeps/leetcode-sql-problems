Input: 
Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        | 0 0
| 2    | 2017-01-02 | 109       | 1  1
| 3    | 2017-01-03 | 150       | 1  2
| 4    | 2017-01-04 | 99        | 0  0
| 5    | 2017-01-05 | 145       | 1  1
| 6    | 2017-01-06 | 1455      | 1  2
| 7    | 2017-01-07 | 199       | 1  3
| 8    | 2017-01-09 | 188       | 1  4  
+------+------------+-----------+
Output: 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+



select id, visit_date, people from stadium where people >= 100 and 

(((id+1 in (select id from stadium where people>=100)) and
  (id+2 in (select id from stadium where people>=100))
 
)
or
 ((id-1 in (select id from stadium where people>=100)) and
  (id+1 in (select id from stadium where people>=100)) 
 
)
 
or
 ((id-2 in (select id from stadium where people>=100)) and
  (id-1 in (select id from stadium where people>=100)) 
 
)
 
 or
 ((id-1 in (select id from stadium where people>=100)) and
  (id-2 in (select id from stadium where people>=100)) 
 
)
 
)