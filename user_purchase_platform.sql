/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

-- spend_date, paltform, total_amount, total_users

select 
user_id,
spend_date,
platform,
count(both+mobile+desktop) as total_users,
sum(amount) as total_amount
from (
select 
user_id,
both,
mobile,
desktop,
spend_date,
amount,
case when both = 1 then 'both' else platform end as platform,
from (

select
spend_date, amount,user_id,platform,
case when user_patform>=2 then 1 else 0 end as both,
case when user_patform=1 and platform='mobile' then 1 else 0 end as mobile,
case when user_patform=1 and platform='desktop' then 1 else 0 end as desktop,
from (
select *,
sum(plat_flag+mobile_flag)over(partition by user_id, spend_date) as user_patform
from(
select *,
case when platform='desktop' then 1 else 0 end as plat_flag,
case when platform='mobile' then 1 else 0 end as mobile_flag,
from `db_sse.spending` order by spend_date
) order by user_id

)
)) group by user_id,platform,spend_date order by spend_date;
