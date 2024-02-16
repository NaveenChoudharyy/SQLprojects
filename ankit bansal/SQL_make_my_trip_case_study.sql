-- Createing database
Create database make_my_trip;

--Using database
use make_my_trip;


--Creating tables

CREATE TABLE booking_table(
   Booking_id       VARCHAR(3) NOT NULL 
  ,Booking_date     date NOT NULL
  ,User_id          VARCHAR(2) NOT NULL
  ,Line_of_business VARCHAR(6) NOT NULL
);













INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
;






CREATE TABLE user_table(
   User_id VARCHAR(3) NOT NULL
  ,Segment VARCHAR(2) NOT NULL
);



INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');


------------------------------------Queries------------------------------------

--1. Write an sql query that gives the below output.
/*
output summary at segment level
segment     Total_user_count     User_who_booked_flight_inapr2022
s1				3						2
s2				2						2
s3				5						1
*/

WITH cte_tab_1 AS (
  SELECT
    Segment,
    COUNT(User_id) AS Total_user_count
  FROM
    user_table
  GROUP BY
    Segment
), cte_tab_2 AS (
  SELECT
    U.Segment AS Seg,
    B.User_id AS ID,
    COUNT(DISTINCT B.User_id) AS cnt_user_id
  FROM
    booking_table AS B
    INNER JOIN user_table AS U ON U.User_id = B.User_id
  WHERE
    B.Line_of_business = 'Flight'
  GROUP BY
    U.Segment,
    B.User_id
)
SELECT
  tab_1.Segment,
  tab_1.Total_user_count,
  SUM(tab_2.cnt_user_id) AS User_who_booked_flight_inapr2022
FROM
  cte_tab_1 AS tab_1
  INNER JOIN cte_tab_2 AS tab_2 ON tab_1.Segment = tab_2.Seg
GROUP BY
  tab_1.Segment,
  tab_1.Total_user_count
ORDER BY
  tab_1.Segment;
















--2. Write a query to identify users whose first booking was a hotel booking

WITH cte AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY User_id ORDER BY Booking_date) AS RN
  FROM
    booking_table
)
SELECT
  User_id
FROM
  cte
WHERE
  RN = 1
  AND Line_of_business = 'Hotel';











--3. Write a query to calculate the days between first and last booking of each user

WITH cte_bookings AS (
  SELECT
    User_id,
    Booking_date,
    LEAD(Booking_date) OVER (PARTITION BY User_id ORDER BY Booking_date) AS next_Booking_date
  FROM
    booking_table
)
SELECT
  User_id,
  DATEDIFF(DAY, MIN(Booking_date), MAX(next_Booking_date)) AS days_dif_btw_first_and_last
FROM
  cte_bookings
GROUP BY
  User_id;











--4. Write a query to count the number of flight and hotel bookings in each of the user segments for the year 2022

SELECT
  U.Segment,
  B.Line_of_business,
  COUNT(B.Line_of_business) AS count_of_booking
FROM
  booking_table AS B
  INNER JOIN user_table AS U ON B.User_id = U.User_id
GROUP BY
  U.Segment,
  B.Line_of_business;






















