
use test2;



create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);


delete from transactions;


insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150)
;


/*

--CUSTOMER RETENTION AND CUSTOMER CHURN MATRICS

--CUSTOMER RETENTION 
CUSTOMER RETENTION REFERS TO A COMPANY'S ABAILITY TO TURN CUSTOMERS INTO REPEAT BUYERS
AND PREVENT THEM FROM SWITCHING TO A COMPETITOR.
IT INDECATES WHEATHER YOUR PRODUCT AND THE QUALITY OF YOUR SERVICE PLEASE YOUR CUSTOMERS OR NOT.

	REWARD PROGRAMS (CC COMPANIES)
	WALLET CASHBACK (PAYTM/FPAY)c
	ZOMATO PRO/SWIGGY SUPER

*/



----	>>>>>>							find retention

select * from transactions as T





select month(t1.order_date), count(distinct t2.cust_id) from transactions as T1
left join transactions as t2
on t1.cust_id = t2.cust_id and DATEDIFF(month, t1.order_date, t2.order_date) = -1
group by month(t1.order_date);





with cte(cid, pmonth,nmonth) as (
select t.cust_id, month(t.order_date), lag(month(t.order_date)) over(partition by t.cust_id order by t.order_date) from transactions as t
)
select pmonth, 
sum(case
when nmonth-pmonth=-1 then 1 else 0
end)
from cte
group by pmonth






----	>>>>>>							find churn







with cte as (
select cust_id , month(order_date) current_month, lead(month(order_date)) OVER ( Partition by cust_id order by month(order_date) ) next_month from transactions
)
select current_month , sum(case when next_month - current_month = 1 then 0 else 1 end ) diff from cte group  by  current_month;






















