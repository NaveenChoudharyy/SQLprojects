

use [test2];


create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values ('2019-01-01','success'),('2019-01-02','success'),('2019-01-03','success'),('2019-01-04','fail')
,('2019-01-05','fail'),('2019-01-06','success')


select * from tasks


with cte as (
select
row_number() over(partition by state order by date_value) as rn, dateadd(day, -1*(row_number() over(partition by state order by date_value)), date_value) as newdate, date_value as date_, state as state_
from tasks
)
select min(DATE_) as start_date, max(date_) as end_date,state_ from cte
group by newdate, state_
order by min(DATE_) 





















