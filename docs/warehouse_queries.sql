-- Example Analytics Queries

-- Daily revenue summary
SELECT
    transaction_date,
    SUM(total_amount) AS daily_revenue
FROM gold_daily_transaction_summary
GROUP BY transaction_date
ORDER BY transaction_date;


-- Customer spending analysis
SELECT
    customer_id,
    SUM(amount) AS total_spent
FROM fact_transactions
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


-- Monthly revenue trend
SELECT
    month,
    SUM(total_revenue) AS monthly_revenue
FROM gold_monthly_revenue_summary
GROUP BY month
ORDER BY month;


-- Fraud rate monitoring
SELECT
    transaction_date,
    fraud_rate
FROM gold_fraud_rate_by_day
ORDER BY transaction_date;
