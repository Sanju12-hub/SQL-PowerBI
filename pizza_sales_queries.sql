-- 📊 KPI Queries

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order
FROM pizza_sales;

-- 📈 Trend Analysis

-- Daily Trend for Total Orders
SELECT DATENAME(WEEKDAY, order_date) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(WEEKDAY, order_date);

-- Monthly Trend for Orders
SELECT DATENAME(MONTH, order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date);

-- 🧹 Category-Based Analysis

-- % of Sales by Pizza Category
SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- % of Sales by Pizza Size
SELECT pizza_size,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(SUM(total_price) * 100.0 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;

-- 🔝 Best & Worst Performers

-- Top 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC;

-- Bottom 5 Pizzas by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC;

-- Top 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC;

-- Bottom 5 Pizzas by Quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC;

-- Top 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC;

-- Bottom 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders ASC;

-- 🔍 Filters Example

-- Top 5 by Orders for Classic Pizzas
SELECT TOP 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
WHERE pizza_category = 'Classic'
GROUP BY pizza_name
ORDER BY Total_Orders DESC;
