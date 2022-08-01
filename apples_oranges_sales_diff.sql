-- https://leetcode.com/problems/apples-oranges/
with differantiate_fruits as (
select
sale_date,
case when fruit = 'apples' then sold_num else 0 end as apples_sold,
case when fruit = 'oranges' then sold_num else 0 end as oranges_sold
from sales
) select sale_date,
sum(apples_sold-oranges_sold) as diff
from differantiate_fruits group by sale_date order by sale_date
;