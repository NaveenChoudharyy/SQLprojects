USE TEST2;








create table orders
(
order_id int,
customer_id int,
product_id int,
);

insert into orders VALUES 
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 4),
(3, 1, 5);

create table products (
id int,
name varchar(10)
);
insert into products VALUES 
(1, 'A'),
(2, 'B'),
(3, 'C'),
(4, 'D'),
(5, 'E');





---	>>>> RECOMMENDATION SYSTEM IS BASED ON  - PRODUCT PAIRS MOST COMMONLY PURCHASED TOGATHER


SELECT * FROM orders

SELECT * FROM products



SELECT  COUNT(O1.customer_id) AS FREQ, CONCAT(P1.name, ' ', P2.name) FROM orders AS O1
INNER JOIN products AS P1
ON P1.id = O1.product_id
INNER JOIN orders O2
ON O1.customer_id =O2.customer_id AND O1.product_id <> O2.product_id AND O1.order_id =O2.order_id AND O1.product_id > O2.product_id 
INNER JOIN products AS P2
ON P2.id = O2.product_id
GROUP BY CONCAT(P1.name, ' ', P2.name) 





















































