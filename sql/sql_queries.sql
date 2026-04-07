-- =====================================
-- Amazon Sales Data Analysis (SQL)
-- =====================================
-- Author: Sagar Sasmal
-- Purpose: Analyze revenue trends, category performance,
--          and fulfillment insights
-- =====================================


-- =====================================
-- 1. DATA PREPARATION
-- =====================================

-- Rename columns for consistency
ALTER TABLE amazon_report RENAME COLUMN `ï»¿index` TO `index`;
ALTER TABLE amazon_report RENAME COLUMN `Order ID` TO Order_ID;
ALTER TABLE amazon_report RENAME COLUMN `Sales Channel` TO Sales_channel;
ALTER TABLE amazon_report RENAME COLUMN `ship-service-level` TO ship_level;
ALTER TABLE amazon_report RENAME COLUMN `ship-state` TO state;
ALTER TABLE amazon_report RENAME COLUMN `Date` TO order_date;



-- =====================================
-- 2. REVENUE ANALYSIS
-- =====================================

-- Total Revenue by Category
-- Purpose: Identify top-performing categories
SELECT 
    category,
    SUM(Qty * Amount) AS total_revenue
FROM amazon_report
GROUP BY category
ORDER BY total_revenue DESC;


-- Revenue Contribution by Category
-- Purpose: Understand share of each category
SELECT 
    category,
    SUM(Qty * Amount) AS total_revenue,
    ROUND(SUM(Qty * Amount) * 1.0 / SUM(SUM(Qty * Amount)) OVER (), 2) AS revenue_contribution
FROM amazon_report
GROUP BY category;



-- =====================================
-- 3. TIME-BASED ANALYSIS
-- =====================================

-- Monthly Revenue Trend
-- Purpose: Identify seasonality and trends
SELECT 
    DATE_FORMAT(order_date, '%Y-%m-01') AS month,
    SUM(Qty * Amount) AS monthly_revenue
FROM amazon_report
GROUP BY month
ORDER BY month;


-- Month-over-Month Growth (MoM)
-- Purpose: Measure growth trends over time
SELECT 
    monthly_revenue,
    current_month,
    pre_month_revenue,
    ROUND((monthly_revenue - pre_month_revenue) * 1.0 / pre_month_revenue, 3) AS mom_growth
FROM (
    SELECT 
        monthly_revenue,
        current_month,
        LAG(monthly_revenue) OVER (ORDER BY current_month) AS pre_month_revenue
    FROM (
        SELECT 
            SUM(Qty * Amount) AS monthly_revenue,
            DATE_FORMAT(order_date, '%Y-%m-01') AS current_month
        FROM amazon_report
        GROUP BY current_month
    ) X
) t;


-- Quarterly Revenue Trend
SELECT 
    QUARTER(order_date) AS quarter,
    SUM(Qty * Amount) AS revenue
FROM amazon_report
GROUP BY quarter
ORDER BY quarter;



-- =====================================
-- 4. STATE / GEOGRAPHICAL ANALYSIS
-- =====================================

-- Revenue by State (Shipped Orders Only)
SELECT 
    state,
    SUM(Qty * Amount) AS revenue
FROM amazon_report
WHERE Status LIKE 'Ship%'
GROUP BY state
ORDER BY revenue DESC;


-- Total Shipped Orders by State
SELECT 
    state,
    COUNT(*) AS total_orders_shipped
FROM amazon_report
WHERE Status LIKE 'Ship%'
GROUP BY state
ORDER BY total_orders_shipped DESC;



-- =====================================
-- 5. FULFILLMENT ANALYSIS
-- =====================================

-- Revenue Split by Fulfillment Type (Amazon vs Merchant)
SELECT 
    state,
    SUM(Qty * Amount) AS total_revenue,
    
    COUNT(CASE WHEN Fulfilment = 'Amazon' THEN 1 END) AS amazon_orders,
    SUM(CASE WHEN Fulfilment = 'Amazon' THEN Qty * Amount ELSE 0 END) AS amazon_revenue,
    
    COUNT(CASE WHEN Fulfilment = 'Merchant' THEN 1 END) AS merchant_orders,
    SUM(CASE WHEN Fulfilment = 'Merchant' THEN Qty * Amount ELSE 0 END) AS merchant_revenue

FROM amazon_report
WHERE Status LIKE 'Ship%'
GROUP BY state
ORDER BY total_revenue DESC;



-- =====================================
-- 6. CATEGORY GROWTH ANALYSIS
-- =====================================

-- Overall Growth (First vs Last)
WITH first_last AS (
    SELECT 
        category,
        MIN(order_date) AS first_date,
        MAX(order_date) AS last_date
    FROM amazon_report
    GROUP BY category
),
revenue_calc AS (
    SELECT 
        s.category,
        SUM(CASE WHEN s.order_date = f.first_date THEN s.Qty * s.Amount END) AS first_rev,
        SUM(CASE WHEN s.order_date = f.last_date THEN s.Qty * s.Amount END) AS last_rev
    FROM amazon_report s
    JOIN first_last f ON s.category = f.category
    GROUP BY s.category
)
SELECT 
    category,
    ROUND((last_rev - first_rev) * 1.0 / first_rev, 2) AS growth_percentage
FROM revenue_calc;



-- =====================================
-- END OF FILE
-- =====================================
