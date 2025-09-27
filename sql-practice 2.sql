CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50),
    loyalty_points INT,
    created_at DATE
);

INSERT INTO Customers (customer_id, name, email, country, loyalty_points, created_at) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'USA', 1200, '2023-05-12'),
(2, 'Bob Smith', 'bob@example.com', 'Canada', 850, '2023-06-25'),
(3, 'Charlie Brown', 'charlie@example.com', 'UK', 430, '2023-07-10'),
(4, 'Diana Prince', 'diana@example.com', 'USA', 2000, '2023-08-15'),
(5, 'Ethan Hunt', 'ethan@example.com', 'Australia', 0, '2023-09-01'),
(6, 'Fiona Glen', 'fiona@example.com', 'USA', 1500, '2023-09-10');

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    order_status VARCHAR(20),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders (order_id, customer_id, product_name, quantity, price, order_status, order_date) VALUES
(101, 1, 'Laptop', 1, 1200.00, 'Shipped', '2023-06-01'),
(102, 1, 'Mouse', 2, 25.00, 'Delivered', '2023-06-03'),
(103, 2, 'Keyboard', 1, 50.00, 'Cancelled', '2023-07-05'),
(104, 3, 'Monitor', 2, 300.00, 'Delivered', '2023-07-15'),
(105, 4, 'Tablet', 1, 500.00, 'Shipped', '2023-08-20'),
(106, 6, 'Headphones', 3, 150.00, 'Processing', '2023-09-15'),
(107, 1, 'USB Cable', 5, 10.00, 'Delivered', '2023-09-18');


CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(50),
    payment_status VARCHAR(20),
    paid_amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Payments (payment_id, order_id, payment_method, payment_status, paid_amount, payment_date) VALUES
(201, 101, 'Credit Card', 'Completed', 1200.00, '2023-06-01'),
(202, 102, 'PayPal', 'Completed', 50.00, '2023-06-03'),
(203, 103, 'Credit Card', 'Refunded', 50.00, '2023-07-06'),
(204, 104, 'Bank Transfer', 'Completed', 600.00, '2023-07-16'),
(205, 105, 'Credit Card', 'Pending', 500.00, '2023-08-22'),
(206, 107, 'Credit Card', 'Completed', 50.00, '2023-09-18');

------------------------------------------------------------------
List all orders with the customer name and product ordered.

SELECT *
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

------------------------------------------------------------------
Find customers who didn’t place any orders
SELECT c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
------------------------------------
Show all orders, even if customer info is missing

SELECT o.order_id, o.product_name, c.name
FROM Orders o
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;
------------------------------------------
Total amount spent by each customer

SELECT c.name, SUM(o.quantity * o.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;
------------------------------------
Customers who spent more than $500

SELECT c.name, t.total_spent
FROM Customers c
JOIN (
    SELECT customer_id, SUM(quantity * price) AS total_spent
    FROM Orders
    GROUP BY customer_id
    HAVING SUM(quantity * price) > 500
) t ON c.customer_id = t.customer_id;
-----------------------------------------------------
Only show customers with completed payments

SELECT c.name, o.product_name, p.payment_status
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Completed';
--------------------------------------------
Customers who have orders but no successful payment yet

SELECT DISTINCT c.name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Payments p ON o.order_id = p.order_id
WHERE p.payment_id IS NULL OR p.payment_status != 'Completed';
------------------------------------------------
Orders that have NO successful payment

SELECT o.order_id, o.product_name
FROM Orders o
LEFT JOIN Payments p ON o.order_id = p.order_id AND p.payment_status = 'Completed'
WHERE p.payment_id IS NULL;
----------------------------------------------
countries where NO customers have placed any orders

SELECT DISTINCT c.country
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.customer_id = c.customer_id
);
-----------------------------------------------------
SELECT *
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id AND c.customer_id = '1';

------------------------------------------------------------------

SELECT *
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
RIGHT JOIN payments p ON p.order_id = o.order_id;

----------------------------------------------------------------

SELECT c.country 
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL


SELECT  country
FROM Customers
WHERE customer_id NOT IN (SELECT customer_id FROM Orders);

SELECT DISTINCT c.country
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
------------------------------------------------ 
Find the running total 

SELECT 
    c.name,
    o.order_date,
    o.price,
    t.running_total
FROM Customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
JOIN (
    SELECT 
        order_date,
        SUM(price) OVER (ORDER BY order_date) AS running_total
    FROM Orders
) t 
    ON o.order_date = t.order_date
ORDER BY o.order_date;



SELECT c.name, o.order_date, o.price, t.r_T
FROM Customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN
(SELECT order_date, SUM(price) OVER ( ORDER BY order_date) AS r_T
FROM orders )  t 
ON o.order_date = t.order_date
ORDER BY o.order_date

SELECT 
    c.name,
    o.order_date,
    o.price,
    SUM(o.price) OVER (ORDER BY o.order_date) AS running_total
FROM Customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
ORDER BY o.order_date;

SELECT c.name, o.price, o.order_date,
SUM( o.price ) OVER ( ORDER BY o.order_date ) AS T
FROM customers c
JOIN orders o 
ON o.customer_id = c.customer_id
ORDER BY o.order_date