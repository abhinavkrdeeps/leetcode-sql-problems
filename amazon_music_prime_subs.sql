create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('2020-02-14' AS date)), 
(2, 'Jane', CAST('2020-02-14' AS date)), 
(3, 'Jill', CAST('2020-02-14' AS date)), 
(4, 'Josh', CAST('2020-02-15' AS date)), 
(5, 'Jean', CAST('2020-02-15' AS date)), 
(6, 'Justin', CAST('2020-02-17' AS date)),
(7, 'Jeremy', CAST('2020-02-18' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('2020-03-01' AS date)), 
(2, 'Music', CAST('2020-03-02' AS date)), 
(2, 'P', CAST('2020-03-12' AS date)),
(3, 'Music', CAST('2020-03-15' AS date)), 
(4, 'Music', CAST('2020-03-15' AS date)), 
(1, 'P', CAST('2020-03-16' AS date)), 
(3, 'P', CAST('2020-03-22' AS date));

-- Find the username that buy the prime subscription within 30 days

select name from users where user_id in (

select 
user_id

 from (

select 
user_id,
case when type = 'Music' then access_date else null end as music_date,
case when type = 'P' then access_date else null end as payment_date

from events where type = 'Music' or type = 'P'  order by user_id 
) x group by user_id having datediff(max(payment_date), max(music_date)) <=30
) ;