-- https://leetcode.com/problems/customers-who-bought-products-a-and-b-but-not-c/

select customer_id, customer_name from customers where customer_id in (
select customer_id from (
select 
customer_id,
sum(case when  product_name = 'A' or product_name = 'B' then 1 else 0 end  ) as a_b_cnt,
sum(case when product_name = 'C'  then 1 else 0 end  ) as c_cnt
from ( select distinct customer_id, product_name from orders) temp1 group by customer_id
) temp where a_b_cnt=2 and c_cnt=0
);