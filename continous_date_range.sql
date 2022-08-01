select min(date_value) as start_date,
max(date_value) as end_date, state 
from (
select * ,
row_number() over(partition by state order by date_value) as rn,
date_add(date_value, Interval -1*row_number() over(partition by state order by date_value) day ) as grouped_date
from `db_sse.tasks` order by date_value) group by grouped_date,state  order by start_date;