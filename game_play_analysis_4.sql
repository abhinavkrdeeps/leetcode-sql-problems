Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
-- Explanation: 
-- Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

with get_prev_logged_in as (
select 
distinct player_id,
device_id,
event_date,
lag(event_date, 1, '9999-12-31') over(partition by player_id order by event_date asc) as prev_logged_in,
count(distinct player_id ) over() as total_player_cnt
from activity
),
get_players_with_consec_logged_in as (
    select distinct get_prev_logged_in.player_id  as player_id,total_player_cnt
    from get_prev_logged_in where abs(date_diff(prev_logged_in,event_date, day)) =1 
)select count(get_players_with_consec_logged_in.player_id )/total_player_cnt  as fraction from get_players_with_consec_logged_in group by total_player_cnt