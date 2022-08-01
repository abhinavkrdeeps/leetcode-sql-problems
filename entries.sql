
create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),('A','Bangalore','A1@gmail.com',1,'CPU'),('A','Bangalore','A2@gmail.com',2,'DESKTOP')
,('B','Bangalore','B@gmail.com',2,'DESKTOP'),('B','Bangalore','B1@gmail.com',2,'DESKTOP'),('B','Bangalore','B2@gmail.com',1,'MONITOR')


with get_floor as (
select name, floor, vis_floor as max_vis_floor from(
select name, floor, count(1) as vis_floor ,
rank() over(partition by name order by count(1) desc) as rank,
from db_sse.entries group by name, floor) where rank=1)
,
get_resources_and_count as (
select name, count(1) as total_count , string_agg(distinct(resources), '_') from db_sse.entries group by name
)
select * from get_floor floor_info
inner join
(select * from get_resources_and_count) res_count
on (floor_info.name = res_count.name);