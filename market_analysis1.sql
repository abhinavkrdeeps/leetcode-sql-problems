Users table:
+---------+------------+----------------+
| user_id | join_date  | favorite_brand |
+---------+------------+----------------+
| 1       | 2018-01-01 | Lenovo         |
| 2       | 2018-02-09 | Samsung        |
| 3       | 2018-01-19 | LG             |
| 4       | 2018-05-21 | HP             |
+---------+------------+----------------+
Orders table:
+----------+------------+---------+----------+-----------+
| order_id | order_date | item_id | buyer_id | seller_id |
+----------+------------+---------+----------+-----------+
| 1        | 2019-08-01 | 4       | 1        | 2         |
| 2        | 2018-08-02 | 2       | 1        | 3         |
| 3        | 2019-08-03 | 3       | 2        | 3         |
| 4        | 2018-08-04 | 1       | 4        | 2         |
| 5        | 2018-08-04 | 1       | 3        | 4         |
| 6        | 2019-08-05 | 2       | 2        | 4         |
+----------+------------+---------+----------+-----------+
Items table:
+---------+------------+
| item_id | item_brand |
+---------+------------+
| 1       | Samsung    |
| 2       | Lenovo     |
| 3       | LG         |
| 4       | HP         |
+---------+------------+
Output: 
+-----------+------------+----------------+
| buyer_id  | join_date  | orders_in_2019 |
+-----------+------------+----------------+
| 1         | 2018-01-01 | 1              |
| 2         | 2018-02-09 | 2              |
| 3         | 2018-01-19 | 0              |
| 4         | 2018-05-21 | 0              |
+-----------+------------+----------------+

-- Write an SQL query to find for each user, the join date and the number of orders they 
-- made as a buyer in 2019.

with joined_tbl as (
select ords.*, users.join_date from Orders ords
inner join  Users users on ords.buyer_id= users.user_id
),
result as (
select order_id, buyer_id,join_date,
case when year(order_date)=2019 then 1 else 0 end as is_2019
 from joined_tbl 
)select 
buyer_id,
join_date,
sum(is_2019) as orders_in_2019
 from result group by buyer_id,join_date ; 


 select
buyer_id,
join_date,
sum(
    case when year(order_date)=2019 then 1 else 0 end
) as orders_in_2019

from users  
left join orders on users.user_id=Orders.buyer_id      
group by buyer_id,join_date