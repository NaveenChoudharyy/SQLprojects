



CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);




insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');



--THE ACTIVITY TABLE SHOWS THE APP INSTALLED AND APP PURCHASE ACTIVITIES FOR SPOTIFY APP ALONG WITH COUNTRY DETAILS


SELECT * FROM activity AS A

/*
QUESTION 1: FIND TOTAL ACTIVE USERS EACH DAY
EVENT_DATE	TOTAL_ACTIVE_USERS
2022-01-01		3
2022-01-02		1
2022-01-03		3
2022-01-04		1
*/

SELECT A.event_date AS EVENT_DATE, COUNT(DISTINCT A.user_id) AS TOTAL_ACTIVE_USERS FROM activity AS A
GROUP BY A.event_date;

/*
QUESTION 2: FIND TOTAL ACTIVE USERS EACH WEEK
WEEK_NUM	TOTAL_ACTIVE_USERS
1			3
2			5
*/


SELECT DATEPART(WEEK,A.EVENT_DATE) AS WEEK_NUM, COUNT(DISTINCT A.user_id) AS TOTAL_ACTIVE_USERS FROM activity AS A
GROUP BY DATEPART(WEEK,A.EVENT_DATE);



/*
QUESTION 3: DATWISE TOTAL NUMBER OF USERS WHO MADE THE PURCHASE SAME DAY THEY INSTALLED THE APP

EVENT_DATE	 NO. OF USERS SAME DAY PURCHASE


*/


WITH CTE AS
(
SELECT A.user_id UID, A.event_date DATE_ FROM activity AS A
WHERE A.event_name = 'app-installed'
INTERSECT
SELECT A.user_id, A.event_date FROM activity AS A
WHERE A.event_name = 'app-purchase'
)
SELECT A.event_date,COUNT(DISTINCT UID) FROM CTE
RIGHT JOIN activity AS A
ON UID = A.user_id
GROUP BY A.event_date;



/*
QUESTION 4: PERCENTAGE OF PAID USERS IN INDIA, USA AND ANY OTHER COUNTRY SHOULD BE TAGGED AS OTHERS 
COUNTRY PERCANTAGE_OF_USERS
INDIA		40
USA			20
OTHERS		40
*/


SELECT 
A.country, CONVERT(INT,COUNT(A.event_name)*100.0/(SELECT COUNT(A.user_id) FROM ACTIVITY AS A WHERE A.event_name = 'app-purchase')) AS PERCANTAGE_OF_USERS 
FROM activity AS A
WHERE A.event_name = 'app-purchase' AND A.country IN ('USA','INDIA') 
GROUP BY A.country
UNION
SELECT 
'OTHERS', CONVERT(INT,COUNT(A.event_name)*100.0/(SELECT COUNT(A.user_id) FROM ACTIVITY AS A WHERE A.event_name = 'app-purchase')) AS PERCANTAGE_OF_USERS 
FROM activity AS A
WHERE A.event_name = 'app-purchase' AND A.country NOT IN ('USA','INDIA');





/*
AMONG ALL THE USERS WHO INSTALLED THE APP ON A GIVEN DAY, HOW MANY DID IN APP PURCHASED ON THE VERY NEXT DAY --DAY WISE RESULT 

EVENT_DATE	CNT_USERS
2022-01-01		0
2022-01-02		1
2022-01-03		0
2022-01-04		0

*/

WITH CTE AS 
(
SELECT 
user_id AS UID, 
event_name, event_date AS E_DAY, country, LAG(DATEADD(DAY,1,A.EVENT_DATE)) OVER(PARTITION BY A.USER_ID ORDER BY A.EVENT_DATE) AS NXT_DAY 
FROM activity AS A
)
SELECT A.event_date, COUNT(DISTINCT UID) AS CNT_USERS FROM CTE
RIGHT JOIN activity AS A
ON A.user_id = UID AND NXT_DAY IS NOT NULL AND E_DAY = NXT_DAY AND  A.event_name = 'app-purchase'
GROUP BY A.event_date;


