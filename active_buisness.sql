Input: 
Events table:
+-------------+------------+------------+
| business_id | event_type | occurences |   avg         is_greater
+-------------+------------+------------+
| 1           | reviews    | 7          |    5           1
| 3           | reviews    | 3          |    5           1
| 1           | ads        | 11         |    8           1
| 2           | ads        | 7          |    8           0
| 3           | ads        | 6          |    8           0
| 1           | page views | 3          |    7.5         0
| 2           | page views | 12         |    7.5         1
+-------------+------------+------------+
Output: 
+-------------+
| business_id |
+-------------+
| 1           |
+-------------+
Explanation:  
-- The average activity for each event can be calculated as follows:
-- - 'reviews': (7+3)/2 = 5
-- - 'ads': (11+7+6)/3 = 8
-- - 'page views': (3+12)/2 = 7.5
-- The business with id=1 has 7 'reviews' events (more than 5) and 11 'ads' events (more than 8), 
-- so it is an active business.


with get_avg_for_each_event as 
(

    select business_id , event_type, occurences,
    avg(occurences) over (partition by event_type) as avg_act_per_event
    from Events
),
create_is_greater_flag as 
(
   select business_id, event_type, occurences, 
   case when occurences > avg_act_per_event then 1 else 0 end as is_greater
   from Events
)select business_id from create_is_greater_flag group by business_id having sum(is_greater) > 1
