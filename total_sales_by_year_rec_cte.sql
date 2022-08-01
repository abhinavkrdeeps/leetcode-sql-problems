-- total sales by year

with recursive rec_cte as 
(
 select min(period_start) as dates, max(period_end) as max_date from sales
 
 union all
 
 select date_add(dates, interval 1 day) as dates, max_date from rec_cte where dates < max_date
 
)
select year(dates) as yr, product_id , sum(average_daily_sales) as total_sales from rec_cte
inner join sales on dates between period_start and period_end
group by yr,product_id
order by yr, product_id