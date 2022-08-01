+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |


with combine as (
select requester_id as id, count(requester_id) as cnt from RequestAccepted group by requester_id
union all
select accepter_id as id, count(accepter_id) as cnt from RequestAccepted group by accepter_id
)
, get_grouped_sum as 
(
select id, sum(cnt) as total_friends from combine group by id
)select id, total_friends as num  from get_grouped_sum where  total_friends = (select max(total_friends) from  get_grouped_sum)
;