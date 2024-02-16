use ankit_bansal



create database ankit_bansal
create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');


select * from drivers

--write a sql query to print total rides and profit rides for each driver
--profit rides is when the end location of current ride is same as start location on next ride 
-- 22:07



select t1.id, sum(t1.cnt), sum(case when s_loc= end_loc then 1 else 0 end) from 
(
select id, count(id) as cnt,end_loc,
lead(start_loc,1) over(partition by id order by start_time)  as s_loc
from drivers 
group by  id,start_time,start_loc,end_loc
) as t1
group by t1.id

--------------------------------------------------------------------------------------------------------


create table brands 
(
category varchar(20),
brand_name varchar(20)
);
insert into brands values
('chocolates','5-star')
,(null,'dairy milk')
,(null,'perk')
,(null,'eclair')
,('Biscuits','britannia')
,(null,'good day')
,(null,'boost');

--write a sql quary to populate category values to the last not null value

select * from brands as b;


select row_number() over(order by (select null)),* from brands as b



--____________________________________________________________________________________________________________________________________

create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');
INSERT INTO icc_world_cup values(12,'SA','IND','DRAW');




select * from icc_world_cup



select team_1, count(team_1) from icc_world_cup group by team_1;
select team_2, count(team_2) from icc_world_cup group by team_2;
select winner, count(winner) from icc_world_cup group by winner;



select team_1 as Team, P
, case when cnt_2 is Null then (P-0) else (P - cnt_2) end  as L
, case when cnt_2 is Null then 0 else cnt_2 end as Pts
from (
select team_1, P, cnt_2 from (
select team_1, sum(cnt) as P from
(select team_1, count(team_1) as cnt from icc_world_cup group by team_1
union all
select team_2, count(team_2) from icc_world_cup group by team_2) as t1
group by team_1 ) as t4
full join (select * from (select winner, count(winner) as cnt_2 from icc_world_cup group by winner) as t2) as t3
on t3.winner = t4.team_1 ) as t5


select * from icc_world_cup


select * from icc_world_cup


select team_1, team_2, winner from icc_world_cup
group by team_1, team_2, winner


with match as 
(
SELECT team_1 as team,winner from icc_world_cup iwc 
union all
SELECT team_2 as team,winner from icc_world_cup iwc 
)
select team,count(team) Matchs_played,
sum(case when team = winner then 1 else 0 end ) Win,
sum(case when winner is null then 1 else 0 end ) Draw,
sum(case when team != winner then 1 else 0 end ) lost,
sum(case when team = winner then 1 else 0 end) * 2 Points
from match
group by team











select t1.team_1, t2.team_2, t2.winner as team from 
(
select distinct team_1 from icc_world_cup
union
select distinct team_2 from icc_world_cup
) as t1
left join icc_world_cup as t2 on t1.team_1 = t2.team_1



select t2.team_2 as team from 
(
select distinct team_1 from icc_world_cup
union
select distinct team_2 from icc_world_cup
) as t1
left join icc_world_cup as t2 on t1.team_1 = t2.team_1



select distinct team_1 from icc_world_cup



select * from icc_world_cup









select t1.team_1 as team from 
(
select distinct team_1 from icc_world_cup
union
select distinct team_2 from icc_world_cup
) as t1
left join icc_world_cup as t2 on t2.team_1 = t1.team_1




































