Customer
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.


select customer_id from (
select customer_id, sum( distinct product_key) as prd_sum  from customer group by customer_id) tmp where prd_sum = (
 select sum(product_key) from Product
)



select customer_id from (
select customer_id, count( distinct product_key) as prd_cnt  from customer group by customer_id) tmp where prd_cnt = (
 select count(distinct product_key) from Product
)