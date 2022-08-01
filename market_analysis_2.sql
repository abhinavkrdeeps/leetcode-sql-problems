Users table:
+---------+------------+----------------+
| user_id | join_date  | favorite_brand |
+---------+------------+----------------+
| 1       | 2019-01-01 | Lenovo         |
| 2       | 2019-02-09 | Samsung        |
| 3       | 2019-01-19 | LG             |
| 4       | 2019-05-21 | HP             |
+---------+------------+----------------+
Orders table:
+----------+------------+---------+----------+-----------+
| order_id | order_date | item_id | buyer_id | seller_id |  fav_brand          item_brand
+----------+------------+---------+----------+-----------+
| 1        | 2019-08-01 | 4       | 1        | 2         | Samsung             HP
| 2        | 2019-08-02 | 2       | 1        | 3         | LG                  Lenovo
| 3        | 2019-08-03 | 3       | 2        | 3         | LG                  LG
| 4        | 2019-08-04 | 1       | 4        | 2         | Samsung             Samsung
| 5        | 2019-08-04 | 1       | 3        | 4         | HP                  Samsung
| 6        | 2019-08-05 | 2       | 2        | 4         | HP                  Lenovo
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
+-----------+--------------------+
| seller_id | 2nd_item_fav_brand |
+-----------+--------------------+
| 1         | no                 |
| 2         | yes                |
| 3         | yes                |
| 4         | no                 |
+-----------+--------------------+
-- Explanation: 
-- The answer for the user with id 1 is no because they sold nothing.
-- The answer for the users with id 2 and 3 is yes because the brands of their second sold items are their favorite brands.
-- The answer for the user with id 4 is no because the brand of their second sold item is not their favorite brand.


with get_fav_brand as (
select ords.*, usrs.favorite_brand from Orders ords
inner join Users usrs on ords.seller_id=usrs.user_id
),
get_brand_item_sold as (

    select b.*, items.item_brand ,
    dense_rank() over(partition by seller_id order by order_date asc) rnk
    from get_fav_brand b
    inner join items items on items.item_id = b.item_id
),
result as 
(

select seller_id ,
case when favorite_brand=item_brand and rnk=2 then 'yes' else 'no' end as is_2nd_fav_branc
from 
get_brand_item_sold
)select * from result



with get_fav_brand as (
select ords.*,usrs.user_id, usrs.favorite_brand from Users usrs
left join Orders ords on ords.seller_id=usrs.user_id
),
get_brand_item_sold as (

    select b.*, items.item_brand ,
    dense_rank() over(partition by user_id order by order_date asc) rnk
    from get_fav_brand b
    inner join items items on items.item_id = b.item_id
) select * from get_brand_item_sold ,
result as 
(

select user_id ,
case when favorite_brand=item_brand and rnk=2 then 'yes' else 'no' end as is_2nd_fav_branc
from 
get_brand_item_sold
)select * from result