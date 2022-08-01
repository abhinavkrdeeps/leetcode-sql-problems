Users 
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| join_date      | date    |
| favorite_brand | varchar |
+----------------+---------+

Orders
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| order_id      | int     |
| order_date    | date    |
| item_id       | int     |
| buyer_id      | int     |
| seller_id     | int     |
+---------------+---------+

Items
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| item_id       | int     |
| item_brand    | varchar |
+---------------+---------+

-- Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.

select buyer_id, join_date,
sum(case when year=2019 then 1 else 0 end) as order_in_2019 from(
select order_date, buyer_id,join_date , extract(Year from order_date) as year,

from(
select * from `db_sse.orders_table` ord
inner join
(select * from `db_sse.users_table` ) users
on (ord.buyer_id = users.user_id )
)  ) group by buyer_id,join_date;