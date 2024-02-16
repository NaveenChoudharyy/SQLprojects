


use test2;

create table spending 
(
user_id int,
spend_date date,
platform varchar(10),
amount int
);

insert into spending values(1,'2019-07-01','mobile',100),(1,'2019-07-01','desktop',100),(2,'2019-07-01','mobile',100)
,(2,'2019-07-02','mobile',100),(3,'2019-07-01','desktop',100),(3,'2019-07-02','desktop',100);


/* User purchase platform.
-- The table logs the spendings history of users that make purchases from an online shopping website which has a desktop 
and a mobile application.
-- Write an SQL query to find the total number of users and the total amount spent using mobile only, desktop only 
and both mobile and desktop together for each date.
*/

select * from spending



select s.spend_date, count(distinct s.user_id),
case
WHEN COUNT(distinct user_id)>1 THEN 'Both' ELSE MAX(platform)
end ,sum(s.amount) from spending as s
group by s.spend_date, s.user_id



---inserting dummy record as we want all dates for all the platforms i.e. mobile, desktop and	BOTH	. And in this case both is not there for date 1 july.
---also remember use distinct in if required distinct count or sum

union all
select distinct s.spend_date, 0, 'both', 0  from spending as s
group by s.spend_date, s.user_id

having COUNT(distinct user_id)<>1
