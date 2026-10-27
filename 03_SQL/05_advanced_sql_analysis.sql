
USE banking_analytics;

-- 1. Rank customers by transaction value
WITH customer_summary AS (
    SELECT
        customer_id,
        COUNT(*) AS total_transactions,
        SUM(transaction_amount) AS total_transaction_value
    FROM banking_transactions
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_transactions,
    ROUND(total_transaction_value, 2) AS total_transaction_value,
    DENSE_RANK() OVER (
        ORDER BY total_transaction_value DESC
    ) AS customer_rank
FROM customer_summary
ORDER BY customer_rank
LIMIT 20;

-- 2. Month-over-month transaction growth
WITH monthly_summary AS (
    SELECT
        DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
        COUNT(*) AS total_transactions,
        SUM(transaction_amount) AS total_transaction_value
    FROM banking_transactions
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
),
monthly_comparison AS (
    SELECT
        transaction_month,
        total_transactions,
        LAG(total_transactions) OVER (
            ORDER BY transaction_month
        ) AS previous_month_transactions
    FROM monthly_summary
)
SELECT
    transaction_month,
    total_transactions,
    previous_month_transactions,
    total_transactions - previous_month_transactions AS transaction_change,
    ROUND(
        100.0 * (total_transactions - previous_month_transactions)
        / NULLIF(previous_month_transactions, 0), 2
    ) AS month_over_month_growth_percentage
FROM monthly_comparison
ORDER BY transaction_month;

-- 3. Daily cumulative transaction value
WITH daily_summary AS (
    SELECT
        transaction_date,
        COUNT(*) AS daily_transactions,
        SUM(transaction_amount) AS daily_transaction_value
    FROM banking_transactions
    GROUP BY transaction_date
)
SELECT
    transaction_date,
    daily_transactions,
    ROUND(daily_transaction_value, 2) AS daily_transaction_value,
    ROUND(
        SUM(daily_transaction_value) OVER (
            ORDER BY transaction_date
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ), 2
    ) AS cumulative_transaction_value
FROM daily_summary
ORDER BY transaction_date;

-- 4. Rank channels by volume and compare failure rates
WITH channel_summary AS (
    SELECT
        channel,
        COUNT(*) AS total_transactions,
        SUM(transaction_amount) AS total_transaction_value,
        SUM(CASE WHEN transaction_status = 'Failed' THEN 1 ELSE 0 END)
            AS failed_transactions
    FROM banking_transactions
    GROUP BY channel
)
SELECT
    channel,
    total_transactions,
    ROUND(total_transaction_value, 2) AS total_transaction_value,
    failed_transactions,
    ROUND(
        100.0 * failed_transactions / NULLIF(total_transactions, 0), 2
    ) AS failure_rate_percentage,
    DENSE_RANK() OVER (
        ORDER BY total_transactions DESC
    ) AS volume_rank
FROM channel_summary
ORDER BY volume_rank;

-- 5. Compare transactions against channel average
SELECT
    transaction_id,
    channel,
    transaction_amount,
    ROUND(AVG(transaction_amount) OVER (
        PARTITION BY channel
    ), 2) AS channel_average_amount,
    ROUND(
        transaction_amount - AVG(transaction_amount) OVER (
            PARTITION BY channel
        ), 2
    ) AS difference_from_channel_average
FROM banking_transactions
LIMIT 50;
