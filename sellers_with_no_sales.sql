-- https://leetcode.com/problems/sellers-with-no-sales/


select  seller.seller_name from (
( select * from seller ) seller
left join
(select * from orders where extract(Year from sale_date)= 2020) orders
on seller.seller_id = orders.seller_id
) where orders.order_id is null order by seller.seller_name;