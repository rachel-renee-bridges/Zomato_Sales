-- What is the total amount each customer spent on Zomato?
SELECT 	s.userid,
	SUM(p.price) AS total_amt_spent
FROM sales s
JOIN product p 
ON s.product_id=p.product_id
GROUP BY s.userid;


-- How many days has each customer visited Zomato?
SELECT 	userid,
	count(distinct created_date) AS distinct_days
FROM sales
GROUP BY userid;   


-- What was the first project purchased by each customer?
SELECT * FROM
(SELECT *, RANK() OVER(PARTITION BY userid ORDER BY created_date) 
AS rnk FROM sales)
a WHERE rnk=1; 


-- What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT 	userid,
	COUNT(product_id) AS cnt
FROM sales 
WHERE product_id = 
(SELECT product_id FROM sales 
GROUP BY product_id
ORDER BY COUNT(product_id) DESC
LIMIT 1)
GROUP BY userid
ORDER BY userid;


-- Which item was the most popular for each customer?
SELECT * FROM
(SELECT *, RANK() OVER(PARTITION BY userid ORDER BY cnt DESC) AS rnk
FROM
(SELECT userid, product_id, COUNT(product_id) AS cnt FROM sales
GROUP BY userid, product_id)a)b
WHERE rnk=1;

