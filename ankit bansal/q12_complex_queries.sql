use test2;





create table sales (
product_id int,
period_start date,
period_end date,
average_daily_sales int
);

insert into sales values(1,'2019-01-25','2019-02-28',100),(2,'2018-12-01','2020-01-01',10),(3,'2019-12-01','2020-01-31',1);


select * from sales 









--recursive cte code





with cte as(
select 6 as N
union all
select n+7
from cte
where n+7<500)
select * from cte



----

--	>>> total sales by year

select * from sales

with cte as (
select min(s.period_start) as S_DATE, max(s.period_end) as E_DATE from sales as s
union all
select dateadd(day, 1, S_DATE) as S_DATE, E_DATE from cte
where S_DATE < E_DATE
)
select S.product_id,YEAR(S_DATE) AS DATE_, SUM(S.average_daily_sales) from cte
INNER JOIN sales AS S
ON S_DATE BETWEEN s.period_start AND s.period_end

GROUP BY S.product_id,YEAR(S_DATE), S.average_daily_sales 
OPTION (MAXRECURSION 1000) 

 


























