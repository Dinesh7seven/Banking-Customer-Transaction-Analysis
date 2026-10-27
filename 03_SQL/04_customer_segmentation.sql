
USE banking_analytics;

-- 1. Top 10 customers by transaction value
SELECT
    customer_id,
    COUNT(*) AS total_transactions,
    ROUND(SUM(transaction_amount), 2) AS total_transaction_value,
    ROUND(AVG(transaction_amount), 2) AS average_transaction_value
FROM banking_transactions
GROUP BY customer_id
ORDER BY total_transaction_value DESC
LIMIT 10;

-- 2. Account type analysis
SELECT
    account_type,
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(transaction_amount), 2) AS total_transaction_value,
    ROUND(AVG(transaction_amount), 2) AS average_transaction_value
FROM banking_transactions
GROUP BY account_type
ORDER BY total_transaction_value DESC;

-- 3. Fraud flags by channel
SELECT
    channel,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS flagged_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS flagged_rate_percentage
FROM banking_transactions
GROUP BY channel
ORDER BY flagged_rate_percentage DESC;

-- 4. Fraud flags by transaction status
SELECT
    transaction_status,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END) AS flagged_transactions,
    ROUND(
        100.0 * SUM(CASE WHEN is_fraud = 1 THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS flagged_rate_percentage
FROM banking_transactions
GROUP BY transaction_status
ORDER BY flagged_rate_percentage DESC;

-- 5. Customer activity segmentation
WITH customer_activity AS (
    SELECT
        customer_id,
        COUNT(*) AS transaction_count,
        SUM(transaction_amount) AS total_transaction_value
    FROM banking_transactions
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN transaction_count >= 20 THEN 'High Activity'
        WHEN transaction_count >= 10 THEN 'Medium Activity'
        ELSE 'Low Activity'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(transaction_count), 2) AS avg_transactions_per_customer,
    ROUND(SUM(total_transaction_value), 2) AS segment_transaction_value
FROM customer_activity
GROUP BY customer_segment
ORDER BY customer_count DESC;
