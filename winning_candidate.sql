Input: 
Candidate table:
+----+------+
| id | name |
+----+------+
| 1  | A    |
| 2  | B    |
| 3  | C    |
| 4  | D    |
| 5  | E    |
+----+------+
Vote table:
+----+-------------+
| id | candidateId |
+----+-------------+
| 1  | 2           |
| 2  | 4           |
| 3  | 3           |
| 4  | 2           |
| 5  | 5           |
+----+-------------+
Output: 
+------+
| name |
+------+
| B    |
+------+
-- Explanation: 
-- Candidate B has 2 votes. Candidates C, D, and E have 1 vote each.
-- The winner is candidate B.

create table candidate(
id int, name varchar(20)
);

insert into candidate values (1,'A'),(2,'B'),(3,'C'),(4,'D'),(5,'E');

select * from candidate;
select * from vote;

with join_tbl as (
select c.id,c.name from candidate c
inner join vote v on c.id=v.candidateId
) ,
get_grouped_res as 
(
select id, name, count(name) as cnt from join_tbl group by id
) select name  from get_grouped_res where cnt = (select max(cnt) from get_grouped_res)

