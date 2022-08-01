--Recommendation system
-- Find the pairs that are bought together and their frequency.

select distinct concat(temp1.name,',', temp2.name) as pairs ,
 count(concat(temp1.name,',', temp2.name)) over(partition by concat(temp1.name,',', temp2.name))  as freq 
 from (
(select ord.order_id ,ord.customer_id, prod.name from orders ord
inner join 
(select * from products ) prod
on ord.product_id = prod.id) temp1

inner join 

(select ord.order_id ,ord.customer_id, prod.name from orders ord
inner join 
(select * from products ) prod
on ord.product_id = prod.id) temp2
on temp1.order_id = temp2.order_id ) where temp1.name!=temp2.name and temp1.name<temp2.name order by pairs
;