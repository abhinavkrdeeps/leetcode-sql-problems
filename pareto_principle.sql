create or replace table db_sse.orders
(
order_id int64,
product_id string,
product_sales float64
);

Insert into db_sse.orders values
(1,"P1", 100),
(1,"P2", 200),
(1,"P3", 300),
(1,"P4", 400),
(1,"P5", 50),
(1,"P6", 60),
(1,"P7", 10),
(1,"P8", 80),
(1,"P9", 40),
(1,"P10", 30),
(1,"P11", 10),
(1,"P12", 0),
(1,"P13", 100)



select product_id from (
select product_id, product_sales , 
sum(product_sales) over(order by product_sales desc rows between unbounded preceding and current row) as running_sales,
0.8 * sum(product_sales) over() as total_sales
from db_sse.orders order by running_sales ) where running_sales<=total_sales ;