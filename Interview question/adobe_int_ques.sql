create database temp;


use temp;


create table trans
(
cust_id int,
product varchar(20),
revnue int);


insert into trans values
(123, 'photoshop', 50),
(123, 'premier pro', 100),
(123, 'after effacts', 50),
(234, 'illustrator', 200),
(234, 'premier pro', 100);




select 
t.cust_id, sum(t.revnue)-(select sum(t.revnue) from trans as t where t.product = 'photoshop' ) as tot_rev 
from trans as t
where t.cust_id in (select t.cust_id from trans as t where t.product = 'photoshop')
group by t.cust_id;

--_____________________________________________________________________________________________________________________________




create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));

insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');



with cte as 
(
select id as d_id, start_loc as s_loc, end_loc as e_loc, 
lag(d.end_loc) over(order by d.end_loc) as end_loction  from drivers as d
)
select d_id, count(*) as total_rides,
sum(case
when end_loction = S_loc then 1 else 0
end) as total_profitable_rides from cte 
group by d_id;



--_________________________________________________________________________________________________________________________________________


create table purchase_history
(userid int
,productid int
,purchasedate date
);

SET DATEFORMAT dmy;
insert into purchase_history values
(1,1,'23-01-2012')
,(1,2,'23-01-2012')
,(1,3,'25-01-2012')
,(2,1,'23-01-2012')
,(2,2,'23-01-2012')
,(2,2,'25-01-2012')
,(2,4,'25-01-2012')
,(3,4,'23-01-2012')
,(3,1,'23-01-2012')
,(4,1,'23-01-2012')
,(4,2,'25-01-2012');


select * from purchase_history as p;


--Given the users purchase history write a query to print users who have done purchase on more than 1 day 
--and products purchased on a given day are never repeated on any other day.


select * from purchase_history as p



---customers spend money more then 1 day
select p.userid
from purchase_history as p
group by p.userid
having count(distinct day(p.purchasedate)) > 1


select p.purchasedate,p.productid, p.userid from purchase_history as p



--purchase day is different but userid and productid is same--using inner join as i need only those who purchased same product on different days

select p.userid from purchase_history as p
inner join  purchase_history  as h
on h.userid = p.userid and h.purchasedate <>p.purchasedate and p.productid = h.productid
group by p.userid


--Final answer

select p.userid
from purchase_history as p
where p.userid not in
						(select p.userid from purchase_history as p
						inner join  purchase_history  as h
						on h.userid = p.userid and h.purchasedate <>p.purchasedate and p.productid = h.productid
						group by p.userid)
group by p.userid
having count(distinct day(p.purchasedate)) > 1


















