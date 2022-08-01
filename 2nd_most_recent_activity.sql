
create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


select * from userActivity;

with get_rank_and_user_cnt as (
select
 *,
 rank() over(partition by username order by startDate) as rnk,
 count(username) over(partition by username) as user_cnt

 from userActivity 
 ),
 get_recent_activity as (
  select 
  username,activity,startDate,endDate
  from get_rank_and_user_cnt where (user_cnt>1 and rnk=2) or (user_cnt=1 and rnk=1)
 ) select * from get_recent_activity
 ;