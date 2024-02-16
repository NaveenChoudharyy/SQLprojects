USE test2;


create table users
(
user_id integer,
name varchar(20),
join_date date
);
insert into users
values (1, 'Jon', CAST('2-14-20' AS date)), 
(2, 'Jane', CAST('2-14-20' AS date)), 
(3, 'Jill', CAST('2-15-20' AS date)), 
(4, 'Josh', CAST('2-15-20' AS date)), 
(5, 'Jean', CAST('2-16-20' AS date)), 
(6, 'Justin', CAST('2-17-20' AS date)),
(7, 'Jeremy', CAST('2-18-20' AS date));

create table events
(
user_id integer,
type varchar(10),
access_date date
);

insert into events values
(1, 'Pay', CAST('3-1-20' AS date)), 
(2, 'Music', CAST('3-2-20' AS date)), 
(2, 'P', CAST('3-12-20' AS date)),
(3, 'Music', CAST('3-15-20' AS date)), 
(4, 'Music', CAST('3-15-20' AS date)), 
(1, 'P', CAST('3-16-20' AS date)), 
(3, 'P', CAST('3-22-20' AS date));





/*
PRIME SUBSCRIPTION RATE BY PRODUCT ACTION
GIVEN THE FOLLOWING TWO TABLES,RETURN THE FRACTION OF USERS, ROUNDED TO TWO DECIMAL PLACES,
WHO ACCESSED AMAZON MUSIC AND UPGRADED TO PRIME MEMBERSHIP WITHIN THE 30 DAYS OF SIGNING UP
*/

SELECT * FROM users
SELECT * FROM events





SELECT * FROM users AS U
LEFT JOIN events AS E
ON E.user_id = U.user_id
WHERE E.type = 'MUSIC'


UNION

WITH CTE(U_ID,U_NAME,J_DATE,U_ID2,U_TYPE,ACC_DATE) AS
(
SELECT * FROM users AS U
LEFT JOIN events AS E
ON E.user_id = U.user_id
WHERE E.type = 'MUSIC'
UNION ALL
SELECT * FROM USERS AS U
LEFT JOIN events AS E
ON E.user_id = U.user_id
WHERE E.type = 'P' AND  U.user_id IN 
						(
						SELECT U.user_id FROM users AS U
						LEFT JOIN events AS E
						ON E.user_id = U.user_id
						WHERE E.type = 'MUSIC'
						) AND DATEDIFF(DAY,U.JOIN_DATE,E.ACCESS_DATE)<=30
)
SELECT round((COUNT(U_ID) - COUNT(DISTINCT U_ID))*1.0/(COUNT(DISTINCT U_ID)),2) AS FRACTION FROM CTE 




WITH CTE(U_ID,U_NAME,J_DATE,U_ID2,U_TYPE,ACC_DATE) AS
(
SELECT * FROM users AS U
LEFT JOIN events AS E
ON E.user_id = U.user_id
WHERE E.type = 'MUSIC'
UNION ALL
SELECT * FROM USERS AS U
LEFT JOIN events AS E
ON E.user_id = U.user_id
WHERE E.type = 'P' AND  U.user_id IN 
						(
						SELECT U.user_id FROM users AS U
						LEFT JOIN events AS E
						ON E.user_id = U.user_id
						WHERE E.type = 'MUSIC'
						) AND DATEDIFF(DAY,U.JOIN_DATE,E.ACCESS_DATE)<=30
)
SELECT COUNT(DISTINCT U_ID)*1.0/(COUNT(U_ID)) FROM CTE 



































