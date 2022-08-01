create table db_sse.customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from db_sse.customer_orders;

insert into db_sse.customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)



select order_date, sum(new_customer) as new_cust_count, sum(repeat_customer) as repeat_cust_count,
sum(new_cust_order_amount) as new_cust_order_amount
, sum(repeat_cust_order_amount) as repeat_cust_order_amount
from (
select order_date, case when order_date=first_order_date then 1 else 0 end as new_customer, 
case when order_date=first_order_date then order_amount else 0 end as new_cust_order_amount,
case when order_date!=first_order_date then order_amount else 0 end as repeat_cust_order_amount,
case when order_date!=first_order_date then 1 else 0 end as repeat_customer from (
select t1.customer_id, t2.order_date, t1.first_order_date, t2.order_amount from (
(select customer_id, min(order_date) as first_order_date from `db_sse.customer_orders`  group by customer_id ) t1
inner join 
(select * from db_sse.customer_orders) t2
on t1.customer_id = t2.customer_id
))) group by order_date ;
