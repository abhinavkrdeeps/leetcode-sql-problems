-- Given a table macthes that contains team1, team2, winner. Find the number of matches played and won by
-- each Team.
-- Input 
-- team1,team2,winner
-- ENG,NZ,NZ
-- Sl,Aus,Aus
-- SA,ENG,ENG
-- India,Sl,India
-- Aus,India,India

-- Output
-- team1,matches_played,matches_won
-- ENG,2,1
-- Sl,2,0
-- SA,1,0
-- India,2,2
-- Aus,2,1
-- NZ,1,1






















select team1, count(team1) as matches_played , sum(win_flag) as matches_won from (
select team1, case when team1=winner then 1 else 0 end as win_flag from db_sse.matches
union all
select team2, case when team2=winner then 1 else 0 end as win_flag from db_sse.matches
) group by team1
;