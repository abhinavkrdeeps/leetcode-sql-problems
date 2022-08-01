-- https://leetcode.com/problems/number-of-calls-between-two-persons/

create table calls(
from_id int,
to_id int,
duration int
);

insert into calls values
(1,2,59),
(2,1,11),
(1,3,20),
(3,4,100),
(3,4,100),
(3,4,200),
(3,4,200),
(4,3,400);

select * from calls;

with combine_pairs as (
select to_id, from_id, duration from calls where from_id > to_id
union all
select from_id, to_id , duration from calls where to_id > from_id
)
select from_id as person1 , to_id as person2, count(from_id) as call_count ,
sum(duration) as total_duration from combine_pairs group by from_id,to_id order by from_id,to_id