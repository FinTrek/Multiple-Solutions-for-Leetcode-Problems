# 1596. The Most Frequently Ordered Products for Each Customer

# No customer will order the same product more than once in a single day
# Find the most frequently ordered product(s) for each customer

SELECT customer_id, product_id, product_name
FROM (
    SELECT o.customer_id, o.product_id, p.product_name, 

    	# Using window function to avoid MAX & COUNT function need to be used in the same time 
    	# Looking for 'most frequently', then DESC, then = 1 
        RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(o.product_id) DESC) AS rnk
    FROM Orders o
    JOIN Products p ON o.product_id = p.product_id 

    # Don't forgot to GROUP BY product_id as well
    GROUP BY customer_id, product_id
)temp
WHERE rnk = 1 




SELECT customer_id,products.product_id,product_name
from Orders
JOIN Products on Products.product_id=Orders.product_id
group by customer_id,product_id
HAVING (customer_id,COUNT(order_date)) IN(
#Get Maxiumum Count for each customer 
SELECT customer_id,MAX(cnt)FROM
(
SELECT customer_id,product_id,COUNT(order_date) as cnt
from Orders
group by customer_id,product_id
) as a
group by customer_id)



WITH M AS (SELECT customer_id, product_id, RANK() OVER (PARTITION BY customer_id ORDER BY frequency DESC) AS 'rnk'
FROM(SELECT customer_id, product_id, COUNT(order_id) AS 'frequency' FROM Orders GROUP BY customer_id, product_id) Sub)

SELECT M.customer_id, M.product_id, P.product_name
FROM M
LEFT JOIN Products P
ON M.product_id = P.product_id
WHERE rnk = 1










