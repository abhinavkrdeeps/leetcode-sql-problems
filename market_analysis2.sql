

with get_rank_and_fav_items as (
select u.user_id ,u.favorite_brand , ord.*
from (
(select * from `db_sse.users_table` ) u 
left join

(select * from (
(select * ,
rank() over(partition by seller_id order by order_date asc) as rnk
from `db_sse.orders_table` ) ) orders  where rnk=2 ) ord

on (ord.seller_id = u.user_id )
)
),
get_selled_item_name as (
select r_fv.*, itms.item_brand from (
(select 
*
from get_rank_and_fav_items ) r_fv
left join
(select * from `db_sse.items_table` ) itms
on (r_fv.item_id = itms.item_id ))
)select 
user_id  ,
case when favorite_brand =  item_brand then 'Yes' else 'No' end as is_2nd_item_fav

from get_selled_item_name