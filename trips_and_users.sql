+----+-----------+-----------+---------+---------------------+------------+
| id | client_id | driver_id | city_id | status              | request_at |
+----+-----------+-----------+---------+---------------------+------------+
| 1  | 1         | 10        | 1       | completed           | 2013-10-01 |
| 2  | 2         | 11        | 1       | cancelled_by_driver | 2013-10-01 |
| 3  | 3         | 12        | 6       | completed           | 2013-10-01 |
| 4  | 4         | 13        | 6       | cancelled_by_client | 2013-10-01 |
| 5  | 1         | 10        | 1       | completed           | 2013-10-02 |
| 6  | 2         | 11        | 6       | completed           | 2013-10-02 |
| 7  | 3         | 12        | 6       | completed           | 2013-10-02 |
| 8  | 2         | 12        | 12      | completed           | 2013-10-03 |
| 9  | 3         | 10        | 12      | completed           | 2013-10-03 |
| 10 | 4         | 13        | 12      | cancelled_by_driver | 2013-10-03 |
+----+-----------+-----------+---------+---------------------+------------+

+----------+--------+--------+
| users_id | banned | role   |
+----------+--------+--------+
| 1        | No     | client |
| 2        | Yes    | client |
| 3        | No     | client |
| 4        | No     | client |
| 10       | No     | driver |
| 11       | No     | driver |
| 12       | No     | driver |
| 13       | No     | driver |
+----------+--------+--------+

with users_trips as (
select distinct * from (
select id, status, request_at  from `db_sse.trips`  t
inner join
(select * except(role__) from `db_sse.users` where trim(banned)='No' ) users
on (t.client_id =users.users_id ) or (t.driver_id = users.users_id ) )
), temp2 as (
select
request_at,
case when  status = 'cancelled_by_driver' or status = 'cancelled_by_client' then 1 else 0 end as is_cancelled,
count(id) over (partition by request_at ) as todays_total_ride
from users_trips order by request_at)
, final_result as (
select * from temp2
)

select 
request_at,
round(sum(is_cancelled)/todays_total_ride, 2) as rate_of_cancellation
from final_result group by request_at, todays_total_ride; 
