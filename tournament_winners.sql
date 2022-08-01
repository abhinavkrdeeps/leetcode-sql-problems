create table db_sse.players
(player_id int64,
group_id int64);

insert into db_sse.players values (15,1);
insert into db_sse.players values (25,1);
insert into db_sse.players values (30,1);
insert into db_sse.players values (45,1);
insert into db_sse.players values (10,2);
insert into db_sse.players values (35,2);
insert into db_sse.players values (50,2);
insert into db_sse.players values (20,3);
insert into db_sse.players values (40,3);

create table db_sse.matches
(
match_id int64,
first_player int64,
second_player int64,
first_score int64,
second_score int64);

insert into db_sse.matches values (1,15,45,3,0);
insert into db_sse.matches values (2,30,25,1,2);
insert into db_sse.matches values (3,30,15,2,0);
insert into db_sse.matches values (4,40,20,5,2);
insert into db_sse.matches values (5,35,50,1,1);




select * from (
with get_combined as (select * from  (
select * from `db_sse.tour_matches` m
inner join
(select * from `db_sse.players` ) p
on ( m.first_player = p.player_id ) or ( m.second_player=p.player_id )
) order by player_id
) ,

get_each_player_score as 
(
select 
player_id,
group_id,
sum(case when first_player=player_id then first_score else second_score end) as player_score
from get_combined group by player_id, group_id
)select
player_id,
group_id , 
player_score ,
dense_rank() over(partition by group_id order by player_score desc, player_id) as rank_in_group
from get_each_player_score order by group_id ) where rank_in_group=1;