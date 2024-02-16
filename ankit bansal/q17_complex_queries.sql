
use [test2]

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


--Get the second most recent activity

select * from UserActivity as U

WITH CTE AS
(
select U.username AS USER_, U.activity AS ACTI_, U.startDate AS S_DATE, U.endDate AS E_DATE
, RANK() OVER(PARTITION BY U.username ORDER BY U.endDate DESC) AS RN from UserActivity as U
) 
SELECT 
USER_, ACTI_, S_DATE, E_DATE
FROM CTE 
WHERE RN= 2 OR USER_ IN
						(select U.username from UserActivity as U
						GROUP BY U.username
						HAVING COUNT(U.username) =1
						)





U.username, U.activity, U.startDate, U.endDate









