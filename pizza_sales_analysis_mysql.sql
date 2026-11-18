
-- A. KEY PERFORMANCE INDICATORS (KPIs)

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- 2. Average Order Value
SELECT
    SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT
    ROUND(
        SUM(quantity) / COUNT(DISTINCT order_id),
        2
    ) AS Avg_Pizzas_Per_Order
FROM pizza_sales;


-- B. DAILY TREND FOR TOTAL ORDERS
SELECT
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);


-- C. HOURLY TREND FOR ORDERS
SELECT
    HOUR(order_time) AS order_hours,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY order_hours;


-- D. PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT
    pizza_category,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC;


-- E. PERCENTAGE OF SALES BY PIZZA SIZE
SELECT
    pizza_size,
    ROUND(SUM(total_price), 2) AS total_revenue,
    ROUND(
        SUM(total_price) * 100.0 /
        (SELECT SUM(total_price) FROM pizza_sales),
        2
    ) AS sales_percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- F. TOTAL PIZZAS SOLD BY CATEGORY IN FEBRUARY
-- Source query filters MONTH(order_date) = 2.
SELECT
    pizza_category,
    SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- G. TOP 5 BEST-SELLING PIZZAS BY QUANTITY
SELECT
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;


-- H. BOTTOM 5 BEST-SELLING PIZZAS BY QUANTITY
SELECT
    pizza_name,
    SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;


-- OPTIONAL DATE FILTER EXAMPLES
-- January daily order trend:
SELECT
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);

-- First-quarter daily order trend:
SELECT
    DAYNAME(order_date) AS order_day,
    COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
WHERE QUARTER(order_date) = 1
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);
