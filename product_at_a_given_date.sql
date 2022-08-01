# Write your MySQL query statement below

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
-- (product_id, change_date) is the primary key of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.

-- Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+



with get_rank as (
select product_id,
change_date,
dense_rank() over(partition by product_id order by change_date desc) as rnk,
new_price
from Products where change_date<='2019-08-16'
)

select distinct product.product_id, coalesce(temp1.new_price, 10) as price from products  product
left join (select * from get_rank where rnk=1) temp1 
on product.product_id  = temp1.product_id
