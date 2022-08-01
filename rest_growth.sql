-- https://leetcode.com/problems/restaurant-growth/

create table customers 
(
customer_id int,
name varchar(12),
visited_on date,
amount int
);

insert into customers values
(1, 'john', '2019-01-01', 100),
(2, 'daniel', '2019-01-02', 110),
(3, 'jade', '2019-01-03', 120),
(4, 'khaled', '2019-01-04', 130),
(5, 'winston', '2019-01-05', 110),
(6, 'elvis', '2019-01-06', 140),
(7, 'anna', '2019-01-07', 150),
(8, 'maria', '2019-01-08', 80),
(9, 'jaze', '2019-01-09', 110),
(1, 'john', '2019-01-10', 130),
(3, 'jade', '2019-01-01', 150);

select 
visited_on,
sum_amt as amount,
avg_amt as average_amount from(

select visited_on,
amount,
sum(amount) over(order by visited_on rows between 6 preceding and current row) as sum_amt,
round((sum(amount) over(order by visited_on rows between 6 preceding and current row))/7, 2) as avg_amt,
rn
from 
(
select visited_on,
row_number() over(order by visited_on ) as rn,
sum(amount) as amount from customer group by visited_on order by visited_on
) t1

) temp where rn > 6;