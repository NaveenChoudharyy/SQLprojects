USE TEST2;



create table billings 
(
emp_name varchar(10),
bill_date date,
bill_rate int
);

insert into billings values
('Sachin','01-JAN-1990',25)
,('Sehwag' ,'01-JAN-1989', 15)
,('Dhoni' ,'01-JAN-1989', 20)
,('Sachin' ,'05-Feb-1991', 30)
;

create table HoursWorked 
(
emp_name varchar(20),
work_date date,
bill_hrs int
);

insert into HoursWorked values
('Sachin', '01-JUL-1990' ,3)
,('Sachin', '01-AUG-1990', 5)
,('Sehwag','01-JUL-1990', 2)
,('Sachin','01-JUL-1991', 4);


SELECT * FROM billings AS B
SELECT * FROM HoursWorked AS H




WITH CTE AS 
(
		SELECT 
		B.emp_name AS E_NAME, B.bill_rate AS B_RATE, B.bill_date AS B_DATE,
		LEAD(DATEADD(DAY,-1,B.bill_date),1,'9999-12-30') OVER(PARTITION BY B.emp_name ORDER BY B.bill_date ASC) AS B_DATE_END
		FROM billings AS B
)
SELECT E_NAME, SUM(B_RATE*1.0*H.bill_hrs) AS TOT_AMT FROM CTE
INNER JOIN HoursWorked AS H
ON H.emp_name = E_NAME AND H.work_date BETWEEN B_DATE AND B_DATE_END
GROUP BY E_NAME

































