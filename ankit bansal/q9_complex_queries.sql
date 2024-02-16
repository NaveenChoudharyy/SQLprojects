create database test2;

use test2;

create table users (
user_id         int     ,
 join_date       date    ,
 favorite_brand  varchar(50));

 create table orders (
 order_id       int     ,
 order_date     date    ,
 item_id        int     ,
 buyer_id       int     ,
 seller_id      int 
 );

 create table items
 (
 item_id        int     ,
 item_brand     varchar(50)
 );


 insert into users values (1,'2019-01-01','Lenovo'),(2,'2019-02-09','Samsung'),(3,'2019-01-19','LG'),(4,'2019-05-21','HP');

 insert into items values (1,'Samsung'),(2,'Lenovo'),(3,'LG'),(4,'HP');

 insert into orders values (1,'2019-08-01',4,1,2),(2,'2019-08-02',2,1,3),(3,'2019-08-03',3,2,3),(4,'2019-08-04',1,4,2)
 ,(5,'2019-08-04',1,3,4),(6,'2019-08-05',2,2,4);



 /*

 Market analysis : write a query to find for each seller, wheater the brand of the second item (by date) they sold is their favourite.  
 If a seller sold less then two items , report the anwer for the seller as no. o/p 

 seller id	second_item_fav_brand 
 1				yes/no
 2				yes/no

 */

 select * from items
 select * from orders
 select * from users 
 



 WITH CTE1(USERID, FITEMID) AS 
 (
 --FAV ITEM_ID FOR EACH USER_ID
 SELECT U.user_id, I.item_id FROM items AS I
 INNER JOIN users AS U
 ON I.item_brand = U.favorite_brand
 ),
 CTE2(SELLERID, ITEMID, ORD_DTE) AS
(
 SELECT U.USER_ID, O.item_id, O.order_date FROM USERS AS U
 LEFT JOIN orders AS O
ON O.SELLER_ID = U.USER_ID
 )
 SELECT  USERID, FITEMID, ITEMID, ORD_DTE,
 CASE
 WHEN FITEMID = ITEMID THEN 'YES' ELSE 'NO'
 END AS YESORNO, RANK() OVER(PARTITION BY USERID ORDER BY ORD_DTE) AS RN
 FROM CTE1 
 INNER JOIN CTE2
 ON USERID = SELLERID






 select * from items
 select * from orders
 select * from users 

 --o.item_id is sold product
 --u.item_id joined with items is fav_item_id 



with cte as 
(
select u.user_id as user_, i.item_id as fav_item, o.order_date, o.item_id as item , rank() over(partition by u.user_id order by o.order_date) as rn from users as u
left join items as I
on u.favorite_brand = i.item_brand
left join orders as o
on o.seller_id = u.user_id
)
select u1.user_id as seller ,
case 
when fav_item = item then 'yes' else 'no'
end as yes_or_no
from cte 
right join users as u1
on u1.user_id = user_ and rn = 2;


-- rn = 2  in in join statement as this is right join statement
--it will pick all fields from right wheather is is in the left or not
-- user 1 is not in left so it will pick user 1 as well
-- if it is used in where it will pick all with rn = 2  but user 1 has rn =1 so it will not pick rn = 1 ie not pick user 1.
-- but as we have used rn = 2 in join statement so it will pick this as well













