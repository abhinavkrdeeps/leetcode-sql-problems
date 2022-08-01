-- https://leetcode.com/problems/monthly-transactions-i/
-- Write your MySQL query statement below
select
substr(trans_date,1 ,7) as month,
country,
count(1) as trans_count,
sum(case when state = 'approved' then 1 else 0 end )  as approved_count,
sum(amount) as trans_total_amount,
sum(case when state='approved' then amount else 0 end)  as approved_total_amount
from transactions group by substr(trans_date,1 ,7), country
order by substr(trans_date,1 ,7), country
;