select * from customer;


1.Which retailers contribute the most revenue and profit?

SELECT
    retailer,
    retailer_id,
    SUM(total_sales) AS total_revenue,
    SUM(operating_profit) AS total_profit
FROM customer
GROUP BY retailer, retailer_id
ORDER BY total_revenue DESC
LIMIT 10;

2.Are our top-selling products also our most profitable products?
WITH category_performance AS (
    SELECT
        product_category,
        SUM(total_sales) AS total_sales,
        SUM(operating_profit) AS total_profit
    FROM customer
    GROUP BY product_category
)
SELECT
    product_category,
    total_sales,
    total_profit,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank
FROM category_performance
ORDER BY sales_rank;


3.Which products are high-revenue but low-margin?

WITH category_performance AS (
    SELECT
        product_category,
        SUM(total_sales) AS total_sales,
        SUM(operating_profit) AS total_profit,
        SUM(operating_profit)
            / NULLIF(SUM(total_sales), 0) * 100 AS profit_margin
    FROM customer
    GROUP BY product_category
),
benchmarks AS (
    SELECT
        AVG(total_sales) AS avg_sales,
        AVG(profit_margin) AS avg_margin
    FROM category_performance
)
SELECT
    c.product_category,
    ROUND(c.total_sales::numeric, 2) AS total_sales,
    ROUND(c.total_profit::numeric, 2) AS total_profit,
    ROUND(c.profit_margin::numeric, 2) AS profit_margin
FROM category_performance c
CROSS JOIN benchmarks b
WHERE c.total_sales > b.avg_sales
  AND c.profit_margin < b.avg_margin
ORDER BY c.total_sales DESC;

4.Which regions have the greatest growth potential?

WITH regional_performance AS (
    SELECT
        region,
        SUM(total_sales) AS sales,
        SUM(operating_profit) AS profit,
        SUM(units_sold) AS units
    FROM customer
    GROUP BY region
)
SELECT
    region,
    sales,
    profit,
    units,
    ROUND((
        profit / NULLIF(sales, 0) * 100)::numeric,
        2
    ) AS margin_pct
FROM regional_performance
ORDER BY margin_pct DESC, sales DESC;


5.Which states/cities are underperforming relative to their sales volume?

SELECT
    state,
    SUM(total_sales) AS total_sales,
    SUM(units_sold) AS units_sold,
    SUM(operating_profit) AS total_profit,
    ROUND(
        (SUM(operating_profit) /
        NULLIF(SUM(total_sales), 0) * 100)::numeric,
        2
    ) AS profit_margin_pct
FROM customer
GROUP BY state
ORDER BY profit_margin_pct ASC;

6.How does price per unit affect units sold?

SELECT
    product_category,
    ROUND(
        CORR(price_per_unit, units_sold)::numeric,
        3
    ) AS price_demand_correlation
FROM customer
GROUP BY product_category
ORDER BY price_demand_correlation;

7.What is the optimal price range for maximizing profit?

WITH price_bands AS (
    SELECT
        *,
        NTILE(5) OVER (
            ORDER BY price_per_unit
        ) AS price_band
    FROM customer
)
SELECT
    price_band,
    ROUND(MIN(price_per_unit), 2) AS min_price,
    ROUND(MAX(price_per_unit), 2) AS max_price,
    SUM(units_sold) AS units_sold,
    SUM(total_sales) AS total_sales,
    SUM(operating_profit) AS total_profit
FROM price_bands
GROUP BY price_band
ORDER BY price_band;

8.Which sales method produces the highest profitability?

SELECT
    sales_method,
    SUM(total_sales) AS total_sales,
    SUM(operating_profit) AS total_profit,
    SUM(units_sold) AS units_sold,
    ROUND(
        (SUM(operating_profit) /
        NULLIF(SUM(total_sales), 0) * 100)::numeric,
        2
    ) AS profit_margin_pct
FROM customer
GROUP BY sales_method
ORDER BY profit_margin_pct DESC;

9.Which product categories perform best across different sales methods?

SELECT
    sales_method,
    product_category,
    SUM(total_sales) AS total_sales,
    SUM(operating_profit) AS total_profit,
    SUM(units_sold) AS units_sold,
    ROUND(
        (SUM(operating_profit) /
        NULLIF(SUM(total_sales), 0) * 100)::numeric,
        2
    ) AS profit_margin_pct
FROM customer
GROUP BY sales_method, product_category
ORDER BY sales_method, total_profit DESC;

10.What are the seasonal patterns in sales and profitability?

SELECT
    year,
    month,
    SUM(total_sales) AS total_sales,
    SUM(operating_profit) AS total_profit,
    SUM(units_sold) AS units_sold,
    ROUND((
        SUM(operating_profit) /
        NULLIF(SUM(total_sales), 0) * 100)::numeric,
        2
    ) AS profit_margin_pct
FROM customer
GROUP BY year, month
ORDER BY year, month;

11.Are weekend sales significantly different from weekday sales?

SELECT
    CASE
        WHEN is_weekend = 1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,

    COUNT(DISTINCT invoice_date) AS number_of_days,

    ROUND((
        SUM(total_sales) /
        COUNT(DISTINCT invoice_date))::numeric,
        2
    ) AS avg_daily_sales,

    ROUND(
        (SUM(operating_profit) /
        COUNT(DISTINCT invoice_date))::numeric,
        2
    ) AS avg_daily_profit

FROM customer
GROUP BY day_type;

12.Which retailers show declining performance or margins?

WITH yearly_retailer AS (
    SELECT
        retailer,
        retailer_id,
        year,
        SUM(total_sales) AS sales,
        SUM(operating_profit) AS profit,
        SUM(operating_profit) /
            NULLIF(SUM(total_sales), 0) * 100 AS margin
    FROM customer
    GROUP BY retailer, retailer_id, year
),
comparison AS (
    SELECT
        *,
        LAG(sales) OVER (
            PARTITION BY retailer_id
            ORDER BY year
        ) AS previous_sales,

        LAG(margin) OVER (
            PARTITION BY retailer_id
            ORDER BY year
        ) AS previous_margin
    FROM yearly_retailer
)
SELECT
    retailer,
    retailer_id,
    year,
    ROUND(sales, 2) AS sales,
    ROUND(previous_sales, 2) AS previous_sales,

    ROUND((
        (sales - previous_sales) /
        NULLIF(previous_sales, 0) * 100)::numeric,
        2
    ) AS sales_growth_pct,

    ROUND(margin::numeric, 2) AS current_margin,
    ROUND(previous_margin::numeric, 2) AS previous_margin,

    ROUND((margin - previous_margin)::numeric, 2) AS margin_change

FROM comparison
WHERE previous_sales IS NOT NULL
ORDER BY sales_growth_pct ASC;

13.Can retailers be segmented based on sales and profitability?

WITH retailer_metrics AS (
    SELECT
        retailer,
        retailer_id,
        SUM(total_sales) AS sales,
        SUM(operating_profit) AS profit,
        SUM(units_sold) AS units,
        SUM(operating_profit) /
            NULLIF(SUM(total_sales), 0) * 100 AS margin
    FROM customer
    GROUP BY retailer, retailer_id
),
benchmarks AS (
    SELECT
        AVG(sales) AS avg_sales,
        AVG(profit) AS avg_profit
    FROM retailer_metrics
)
SELECT
    r.retailer,
    r.retailer_id,
    ROUND(r.sales::numeric, 2) AS sales,
    ROUND(r.profit::numeric, 2) AS profit,
    ROUND(r.margin::numeric, 2) AS margin,

    CASE
        WHEN r.sales >= b.avg_sales
             AND r.profit >= b.avg_profit
            THEN 'Strategic Retailer'

        WHEN r.sales >= b.avg_sales
             AND r.profit < b.avg_profit
            THEN 'High Sales - Low Profit'

        WHEN r.sales < b.avg_sales
             AND r.profit >= b.avg_profit
            THEN 'Growth Opportunity'

        ELSE 'Low Priority'
    END AS retailer_segment

FROM retailer_metrics r
CROSS JOIN benchmarks b
ORDER BY profit DESC;

14.Which transactions represent sales/profit anomalies?

WITH quartiles AS (
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY total_sales) AS q1,

        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY total_sales) AS q3

    FROM customer
),
bounds AS (
    SELECT
        q1,
        q3,
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM quartiles
)
SELECT
    c.*
FROM customer c
CROSS JOIN bounds b
WHERE c.total_sales < b.lower_bound
   OR c.total_sales > b.upper_bound
ORDER BY c.total_sales DESC;

15.What are the expected sales for the next month/quarter?

SELECT
    DATE_TRUNC('month', invoice_date)::date AS sales_month,
    SUM(total_sales) AS monthly_sales,
    SUM(operating_profit) AS monthly_profit,
    SUM(units_sold) AS monthly_units
FROM customer
GROUP BY DATE_TRUNC('month', invoice_date)
ORDER BY sales_month;