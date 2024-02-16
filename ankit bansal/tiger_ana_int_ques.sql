-- Using databse
use [ankit_bansal];

--Creating table
drop table flights 

CREATE TABLE flights 
(
    cid VARCHAR(512),
    fid VARCHAR(512),
    origin VARCHAR(512),
    Destination VARCHAR(512)
);


--Inserting data
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f1', 'Del', 'Hyd');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f3', 'Mum', 'Agra');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('1', 'f2', 'Hyd', 'Blr');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f4', 'Agra', 'Kol');
INSERT INTO flights (cid, fid, origin, Destination) VALUES ('2', 'f5', 'kol', 'Pat');



--1____________ Find the origin and destination for all cid

select * from (
select f1.cid, f1.origin, f2.Destination from flights as f1
inner join flights as f2
on f1.Destination = f2.origin) as tab1
where Destination is not null


select tab4.cid, tab6.origin, tab4.Destination from 
(select * from
(select *, max(rk) over(partition by cid order by cid) as mx_rk from 
(select *, 
ROW_NUMBER() over(partition by cid order by fid) as rk
from flights)
as tab1)
as tab_2
where rk = mx_rk)
as tab4
inner join 
(select tab5.cid, tab5.origin from
(select * from 
(select *, 
ROW_NUMBER() over(partition by cid order by fid) as rk
from flights)
as tab3
where rk = 1)
as tab5) as tab6
on tab4.cid = tab6.cid


select * from flights


----------------------------------------------------------------------------------------------------


CREATE TABLE sales 
(
    order_date date,
    customer VARCHAR(512),
    qty INT
);

INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C1', '20');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-01-01', 'C2', '30');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C1', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-02-01', 'C3', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C5', '19');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-03-01', 'C4', '10');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C3', '13');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C5', '15');
INSERT INTO sales (order_date, customer, qty) VALUES ('2021-04-01', 'C6', '10');


--2____________ Find the count of new customers added in each month

select month_, count(month_) as num_of_cust from
(
select u_cust, min(month_) as month_ from
(
select month(order_date) as month_, customer, qty, rank() over(order by customer) as u_cust
from sales
)
as tab1
group by u_cust
)
as tab2
group by month_



select month(order_date) as month, count(ranking) as count_of_customers from
(
select *, rank() over(partition by customer order by order_date) as ranking from sales
)
as tab1
where ranking = 1
group by month(order_date)



--------------------------------------------------------------------------------------


create table family 
(
person varchar(5),
type varchar(10),
age int
);
delete from family ;
insert into family values ('A1','Adult',54)
,('A2','Adult',53),('A3','Adult',52),('A4','Adult',58),('A5','Adult',54),('C1','Child',20),('C2','Child',19),('C3','Child',22),('C4','Child',15);



--3____________________Make a pair of adult and child where oldest adult get paired with youngest child. If any elder or child did not get any pair, put him alone in the table.

select tab1.person, tab2.person from
(
select *, row_number() over(order by age desc) as rk from family
where person like 'A%'
)
as tab1
left join 
(
select *, row_number() over(order by age) as rk  from family
where person like 'C%'
) 
as tab2
on tab2.rk = tab1.rk



--------------------------------------------------------------------------------------------------------


CREATE TABLE cricket_runs
(ball_no integer,runs integer,delivery_type varchar(20));



insert into cricket_runs values 
(1,1,'legal'),(2,2,'legal'),(5,4,'legal'),(6,3,'legal'),(8,3,'legal'),(10,2,'legal'),(11,2,'legal'),(12,0,'legal'),(13,4,'legal'),
(14,2,'legal'),(17,3,'legal'),(18,4,'legal'),(19,4,'legal'),(22,1,'legal'),(23,2,'legal'),(24,0,'legal'),(26,0,'legal'),(27,4,'legal'),
(28,2,'legal'),(29,4,'legal'),(31,2,'legal'),(32,3,'legal'),(33,1,'legal'),(34,3,'legal'),(35,3,'legal'),(36,2,'legal'),(37,3,'legal'),
(38,1,'legal'),(39,0,'legal'),(41,4,'legal'),(42,0,'legal'),(43,1,'legal'),(44,3,'legal'),(45,2,'legal'),(46,0,'legal'),(47,1,'legal'),
(48,4,'legal'),(49,1,'legal'),(50,4,'legal'),(51,1,'legal'),(52,1,'legal'),(53,2,'legal'),(54,2,'legal'),(55,3,'legal'),(56,0,'legal'),
(57,0,'legal'),(58,1,'legal'),(59,1,'legal'),(60,3,'legal'),(61,4,'legal'),(62,2,'legal'),(63,3,'legal'),(64,2,'legal'),(65,1,'legal'),
(66,1,'legal'),(67,2,'legal'),(68,0,'legal'),(69,1,'legal'),(70,1,'legal'),(71,0,'legal'),(72,0,'legal'),(73,1,'legal'),(74,1,'legal'),
(75,0,'legal'),(76,4,'legal'),(77,4,'legal'),(78,3,'legal'),(79,3,'legal'),(80,2,'legal'),(81,4,'legal'),(82,4,'legal'),(83,2,'legal'),
(84,1,'legal'),(85,3,'legal'),(86,3,'legal'),(87,1,'legal'),(88,3,'legal'),(89,3,'legal'),(90,4,'legal'),(91,3,'legal'),(92,4,'legal'),
(93,0,'legal'),(94,3,'legal'),(95,3,'legal'),(96,2,'legal'),(97,2,'legal'),(98,1,'legal'),(99,4,'legal'),(100,4,'legal'),(101,0,'legal'),
(102,4,'legal'),(103,2,'legal'),(104,4,'legal'),(105,0,'legal'),(106,3,'legal'),(107,4,'legal'),(108,0,'legal'),(109,0,'legal'),
(110,2,'legal'),(111,4,'legal'),(112,3,'legal'),(113,3,'legal'),(114,4,'legal'),(115,1,'legal'),(116,2,'legal'),(117,2,'legal'),
(118,3,'legal'),(119,1,'legal'),(120,3,'legal'),(121,4,'legal'),(122,3,'legal'),(123,2,'legal'),(124,4,'legal'),(125,4,'legal'),
(126,3,'legal'),(127,2,'legal'),(128,1,'legal'),(129,2,'legal'),(130,3,'legal'),(131,0,'legal'),(132,3,'legal'),(133,3,'legal'),
(134,1,'legal'),(135,3,'legal'),(136,3,'legal'),(137,2,'legal'),(138,3,'legal'),(139,4,'legal'),(140,3,'legal'),(141,2,'legal'),
(142,2,'legal'),(143,2,'legal'),(144,0,'legal'),(145,4,'legal'),(146,2,'legal'),(147,1,'legal'),(148,2,'legal'),(149,3,'legal'),
(150,3,'legal'),(151,0,'legal'),(152,1,'legal'),(153,4,'legal'),(154,2,'legal'),(155,3,'legal'),(156,0,'legal'),(157,1,'legal'),
(158,3,'legal'),(159,0,'legal'),(160,1,'legal'),(161,3,'legal'),(162,1,'legal'),(163,3,'legal'),(164,2,'legal'),(165,0,'legal'),
(166,1,'legal'),(167,0,'legal'),(168,3,'legal'),(169,3,'legal'),(170,1,'legal'),(171,4,'legal'),(172,0,'legal'),(173,4,'legal'),
(174,0,'legal'),(175,3,'legal'),(176,4,'legal'),(177,0,'legal'),(178,2,'legal'),(179,2,'legal'),(180,2,'legal'),(181,2,'legal'),
(182,1,'legal'),(183,4,'legal'),(184,2,'legal'),(185,0,'legal'),(186,0,'legal'),(187,3,'legal'),(188,0,'legal'),(189,1,'legal'),
(190,0,'legal'),(21,0,'wd'),(191,3,'legal'),(192,2,'legal'),(193,2,'legal'),(194,0,'legal'),(195,2,'legal'),(196,1,'legal'),
(197,1,'legal'),(198,4,'legal'),(199,0,'legal'),(200,0,'legal'),(201,0,'legal'),(202,2,'legal'),(203,3,'legal'),(204,2,'legal'),
(205,3,'legal'),(206,2,'legal'),(207,0,'legal'),(208,0,'legal'),(209,1,'legal'),(210,0,'legal'),(211,1,'legal'),(212,2,'legal'),
(213,4,'legal'),(214,1,'legal'),(215,0,'legal'),(216,1,'legal'),(217,2,'legal'),(218,1,'legal'),(219,2,'legal'),(220,1,'legal'),
(221,1,'legal'),(222,1,'legal'),(223,4,'legal'),(224,2,'legal'),(225,1,'legal'),(226,2,'legal'),(227,4,'legal'),(228,0,'legal'),
(229,4,'legal'),(230,2,'legal'),(231,4,'legal'),(232,2,'legal'),(233,3,'legal'),(234,0,'legal'),(235,3,'legal'),(236,1,'legal'),
(237,3,'legal'),(238,1,'legal'),(239,4,'legal'),(240,4,'legal'),(241,2,'legal'),(242,3,'legal'),(243,0,'legal'),(244,3,'legal'),
(245,2,'legal'),(246,3,'legal'),(247,3,'legal'),(248,2,'legal'),(249,1,'legal'),(250,3,'legal'),(251,3,'legal'),(252,4,'legal'),
(253,3,'legal'),(254,3,'legal'),(255,4,'legal'),(256,0,'legal'),(257,3,'legal'),(258,3,'legal'),(259,0,'legal'),(260,1,'legal'),
(261,3,'legal'),(262,3,'legal'),(263,3,'legal'),(264,3,'legal'),(265,3,'legal'),(266,1,'legal'),(267,1,'legal'),(268,0,'legal'),
(269,3,'legal'),(270,3,'legal'),(271,4,'legal'),(272,2,'legal'),(273,2,'legal'),(274,1,'legal'),(275,1,'legal'),(276,0,'legal'),
(277,4,'legal'),(278,3,'legal'),(279,1,'legal'),(280,3,'legal'),(281,3,'legal'),(282,1,'legal'),(283,3,'legal'),(284,0,'legal'),
(285,2,'legal'),(286,0,'legal'),(287,2,'legal'),(288,4,'legal'),(289,4,'legal'),(290,0,'legal'),(291,0,'legal'),(292,4,'legal'),
(293,0,'legal'),(294,2,'legal'),(295,4,'legal'),(296,4,'legal'),(297,2,'legal'),(298,4,'legal'),(299,2,'legal'),(300,1,'legal'),
(301,4,'legal'),(302,4,'legal'),(303,0,'legal'),(304,1,'legal'),(305,1,'legal'),(306,2,'legal'),(307,1,'legal'),(308,1,'legal'),
(309,4,'legal'),(310,0,'legal'),(3,1,'nb'),(15,0,'nb'),(16,1,'nb'),(25,4,'nb'),(4,4,'wd'),(9,0,'wd'),(20,3,'wd'),(30,3,'wd'),
(40,3,'wd'),(7,0,'legal')




with cte as 
(
select ball_no, runs, delivery_type
, case when ov_chn_ball_flag =  0 or ov_chn_ball_flag = 1 then 0 else 1 end as ov_chn_ball_flag
from
(
select ball_no, runs, delivery_type
, case when ball_no % 6 = 0 then ROW_NUMBER() over(partition by ball_no order by ball_no) else 0 end as ov_chn_ball_flag
from 
(
select
ball_no - sum(delivery_type) over(order by ball_no) as ball_no
, runs, delivery_type
, case when (ball_no - sum(delivery_type) over(order by ball_no)) % 6 = 0 then 1 else 0 end as ov_chn_ball_flag
from
(
select 
ROW_NUMBER() over(order by ball_no) as ball_no
, case when delivery_type = 'legal' then runs else runs+1 end as runs
, case when delivery_type = 'legal' then 0 else 1 end as delivery_type
from cricket_runs
) as t1
) as t2
) as t3
) select ceiling((ball_no + ov_chn_ball_flag)*1.0/6) as overs, sum(runs) as runs from cte
group by ceiling((ball_no + ov_chn_ball_flag)*1.0/6)











select overs, sum(runs) as tot_runs from
(select 
case 
when balls % 6 = 0 then balls/6
when balls % 6 = 1 then (balls + 5)/6
when balls % 6 = 2 then (balls + 4)/6
when balls % 6 = 3 then (balls + 3)/6
when balls % 6 = 4 then (balls + 2)/6
when balls % 6 = 5 then (balls + 1)/6 end as overs,
runs
from
(
select 
case when rn_ov_chng = 0 or rn_ov_chng = 1 then no_of_balls else no_of_balls + 1 end as balls
, runs
from
(
select *
, case when over_change_ball = 1 then ROW_NUMBER() over(partition by no_of_balls order by over_change_ball) else 0 end as rn_ov_chng
from 
(
select *
, case when no_of_balls % 6 = 0 then 1 else 0 end as over_change_ball
from 
(
select 
case when delivery_type = 'legal' then rn else (ball_no - rn) end as no_of_balls
, new_runs as runs
from
(
select *
, ROW_NUMBER() over(partition by delivery_type order by ball_no) as rn
, case when delivery_type = 'legal' then runs else runs + 1 end new_runs
from 
(
select ball_no, runs
, case when delivery_type = 'legal' then 'legal' else 'wd_or_nb' end as delivery_type
from cricket_runs
) as t1
) as t2
) as t3
) as t4
) as t5
) as t6
) as t7
group by overs


__________________________________________________________________________________________________________________________________

create table company_revenue 
(
company varchar(100),
year int,
revenue int
)

insert into company_revenue values 
('ABC1',2000,100),('ABC1',2001,110),('ABC1',2002,120),('ABC2',2000,100),('ABC2',2001,90),('ABC2',2002,120)
,('ABC3',2000,500),('ABC3',2001,400),('ABC3',2002,600),('ABC3',2003,800);


--- Find the company having revanue increasing every year

with cte as(
select company, count(company) as cnt_com, sum(rev_inc_flag) as tot_pos from
(
select *
, case when revenue - lag(revenue) over(partition by company order by year) > 0 then 1 else 0 end as rev_inc_flag
, ROW_NUMBER() over(partition by company order by year) as rn
from company_revenue
) as t1
where rn != 1
group by company)
select company as compeany_having_revanue_increasing_every_year from cte
where cnt_com = tot_pos







--____________________________________________________________________________________________________

create table source(id int, name varchar(5))

create table target(id int, name varchar(5))

insert into source values(1,'A'),(2,'B'),(3,'C'),(4,'D')

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');





select * from source;
select * from target;




--_______________________________________________________________________________________________________________________________________________


create table namaste_orders
(
order_id int,
city varchar(10),
sales int
)

create table namaste_returns
(
order_id int,
return_reason varchar(20),
)

insert into namaste_orders
values(1, 'Mysore' , 100),(2, 'Mysore' , 200),(3, 'Bangalore' , 250),(4, 'Bangalore' , 150)
,(5, 'Mumbai' , 300),(6, 'Mumbai' , 500),(7, 'Mumbai' , 800)
;
insert into namaste_returns values
(3,'wrong item'),(6,'bad quality'),(7,'wrong item');




select * from namaste_orders;
select * from namaste_returns;


select distinct o.city from namaste_orders as o
where o.order_id not in (select r.order_id from namaste_returns as r) and
o.city not in (select distinct o.city from namaste_returns as r
left join namaste_orders as o
on o.order_id = r.order_id)


select * from namaste_orders as o
left join namaste_returns as r
on o.order_id = r.order_id
where r.order_id is null 


select o.city from namaste_orders as o
left join namaste_returns as r
on o.order_id = r.order_id
group by o.city
having count(r.order_id) =0


--------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE travel_data (
    customer VARCHAR(10),
    start_loc VARCHAR(50),
    end_loc VARCHAR(50)
);

INSERT INTO travel_data (customer, start_loc, end_loc) VALUES
    ('c1', 'New York', 'Lima'),
    ('c1', 'London', 'New York'),
    ('c1', 'Lima', 'Sao Paulo'),
    ('c1', 'Sao Paulo', 'New Delhi'),
    ('c2', 'Mumbai', 'Hyderabad'),
    ('c2', 'Surat', 'Pune'),
    ('c2', 'Hyderabad', 'Surat'),
    ('c3', 'Kochi', 'Kurnool'),
    ('c3', 'Lucknow', 'Agra'),
    ('c3', 'Agra', 'Jaipur'),
    ('c3', 'Jaipur', 'Kochi');






with cte as (
select *, lead(end_loc) over(partition by customer order by end_loc) as dest from
(
select *, 1 as tab_name from travel_data as t2
where 
t2.start_loc in (select t1.start_loc from travel_data as t1 except select t1.end_loc from travel_data as t1)
union
select *, 2 as tab_name from travel_data as t3
where 
t3.end_loc in (select t1.end_loc from travel_data as t1 except select t1.start_loc from travel_data as t1)
) as t4 )
select customer, start_loc, dest from cte
where dest is not null;
































