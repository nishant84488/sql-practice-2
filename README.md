# 💻 SQL Core Competencies & Practice Database

This repository contains a comprehensive SQL script (`sql-practice 2.sql`) designed to demonstrate mastery of essential and advanced SQL techniques. It sets up a fully functional, mock e-commerce database environment and provides solved, real-world data analysis challenges, making it an excellent resource for skills validation and practice.

---

## 🗄️ Database Schema & Structure

The project starts by creating and populating a small relational database modeled after a typical e-commerce system.

| Table Name | Primary Purpose | Key Columns | Relationships |
| :--- | :--- | :--- | :--- |
| **`Customers`** | Stores customer profiles and loyalty data. | `customer_id`, `name`, `email`, `loyalty_points` | Linked to `Orders` by `customer_id`. |
| **`Orders`** | Stores transaction details for products purchased. | `order_id`, `product_name`, `quantity`, `price` | Linked to `Customers` and `Payments`. |
| **`Payments`** | Records payment methods, status, and amounts. | `payment_id`, `payment_method`, `payment_status`, `paid_amount` | Linked to `Orders` by `order_id`. |

---

## ✅ Demonstrated SQL Competencies

The `sql-practice 2.sql` file includes a collection of solved, practical queries that showcase proficiency across the SQL spectrum:

### 1. Relational Joins

Mastery of combining data across multiple tables to answer business questions.

- **`INNER JOIN`**: Listing all orders with customer names.  
- **`LEFT/RIGHT JOIN`**: Showing all orders even if customer information is missing, and vice-versa.

### 2. Aggregation & Grouping (Reporting)

Calculating summary metrics crucial for reporting.

- **`SUM()`, `GROUP BY`**: Calculating the **Total amount spent by each customer**.  
- **`HAVING` Clause**: Filtering grouped results (e.g., selecting "Customers who spent more than $500").

### 3. Anti-Join Logic (Finding Missing Data)

Using `LEFT JOIN...WHERE IS NULL`, `NOT IN`, and `NOT EXISTS` to identify gaps and unmatched records—a critical skill for data quality checks.

- **Unmatched Records**: Identifying **"Customers who didn’t place any orders."**  
- **Transaction Gaps**: Finding **"Orders that have NO successful payment"**.  
- **Geographic Gaps**: Identifying "countries where NO customers have placed any orders."

### 4. Advanced Window Functions

Applying analytical functions for sophisticated temporal and partitioning analysis.

- **Running Totals**: Calculating the **cumulative total sales** (`SUM() OVER (ORDER BY order_date)`) over time, allowing for trend tracking without complex subqueries.

---

## 🚀 Getting Started

To explore and execute this SQL practice project, you only need a running SQL database environment.

### Prerequisites

- A compatible **SQL database engine** (e.g., MySQL, PostgreSQL, SQL Server, SQLite, etc.).  
- A **SQL client** (e.g., DBeaver, SQL Workbench, or even a command-line interface) to execute the script.

### Instructions

1. Clone the repository or download the `sql-practice 2.sql` file.  
2. Connect your SQL client to your database environment.  
3. Execute the entire content of the `sql-practice 2.sql` file.  
   - The script will first create and populate the `Customers`, `Orders`, and `Payments` tables.  
   - It will then execute the demonstrated queries, printing the results for each solved problem.

---

## 🤝 Contribution

Feel free to suggest new, challenging SQL practice problems to add to the script!

1. Fork the repository.  
2. Create your Feature Branch (`git checkout -b feature/new-sql-challenge`).  
3. Add new solved queries to the `.sql` file.  
4. Commit your changes and open a Pull Request.