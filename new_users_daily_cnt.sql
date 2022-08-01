Input: 
Traffic table:
+---------+----------+---------------+
| user_id | activity | activity_date |   diff_d 
+---------+----------+---------------+
| 1       | login    | 2019-05-01    |   activity_date-'2019-06-30'  <=90
| 1       | homepage | 2019-05-01    |
| 1       | logout   | 2019-05-01    |
| 2       | login    | 2019-06-21    |
| 2       | logout   | 2019-06-21    |
| 3       | login    | 2019-01-01    |
| 3       | jobs     | 2019-01-01    |
| 3       | logout   | 2019-01-01    |
| 4       | login    | 2019-06-21    |
| 4       | groups   | 2019-06-21    |
| 4       | logout   | 2019-06-21    |
| 5       | login    | 2019-03-01    |
| 5       | logout   | 2019-03-01    |
| 5       | login    | 2019-06-21    |
| 5       | logout   | 2019-06-21    |
+---------+----------+---------------+
Output: 
+------------+-------------+
| login_date | user_count  |
+------------+-------------+
| 2019-05-01 | 1           |
| 2019-06-21 | 2           |
+------------+-------------+
-- Explanation: 
-- Note that we only care about dates with non zero user count.
-- The user with id 5 first logged in on 2019-03-01 so he's not counted on 2019-06-21.

with get_at_most_90_days as (
select *, datediff('2019-06-30',activity_date) as diff_d from traffic
),
create_ranks_per_date_per_activity as 
(
  select  *,
   dense_rank() over(partition by user_id, activity order by activity_date ) as rnk
  from get_at_most_90_days
)
select
distinct
activity_date as login_date,
count(user_id) over(partition by activity_date order by activity_date) as user_count
    
from create_ranks_per_date_per_activity where activity='login' and rnk=1 and diff_d<=90
-------------------------------

with first_login_date as 
(
    select user_id,
    min(case when activity='login' then activity_date else null end) as first_login
    from Traffic
    group by user_id
)
select
first_login as login_date,
count(user_id) as user_count
from first_login_date
where datediff('2019-06-30',first_login) <=90
group by first_login