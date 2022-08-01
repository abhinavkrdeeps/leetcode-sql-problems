-- https://leetcode.com/problems/countries-you-can-safely-invest-in/
with get_person_name as (
select p.id, c.name as country_name from Person p
inner join Country c
on cast(substr(p.phone_number,1, 3) as SIGNED) = c.country_code
),
get_caller_country as 
(
 select caller_id, duration, country_name from get_person_name nm inner join Calls calls on nm.id = calls.caller_id
),
get_calle_country as (
 select caller_id, duration, country_name from get_person_name nm inner join Calls calls on nm.id = calls.callee_id 
),
union_result as (
select * from get_caller_country union all select * from get_calle_country
),
per_country as (
select caller_id, duration, country_name,
avg(duration) over() as global_avg,
avg(duration) over(partition by country_name) as per_country_avg
from union_result
)select distinct country_name as country from per_country where per_country_avg> global_avg