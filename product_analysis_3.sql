-- https://leetcode.com/problems/product-sales-analysis-iii/
select product_id,year as first_year,quantity,price from(
select 
product_id ,
year,
quantity,
price,
dense_rank() over(partition by product_id order by year asc)  rnk
from Sales ) temp where rnk=1;