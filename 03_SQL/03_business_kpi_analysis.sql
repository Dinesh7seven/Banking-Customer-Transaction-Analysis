
USE banking_analytics;

-- 1. Overall business KPIs
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(transaction_amount), 2) AS total_transaction_value,
    ROUND(AVG(transaction_amount), 2) AS average_transaction_value
FROM banking_transactions;

-- 2. Transaction success and failure rates
SELECT
    transaction_status,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM banking_transactions), 2
    ) AS percentage
FROM banking_transactions
GROUP BY transaction_status
ORDER BY total_transactions DESC;

-- 3. Monthly transaction trends
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS transaction_month,
    COUNT(*) AS total_transactions,
    ROUND(SUM(transaction_amount), 2) AS transaction_value,
    ROUND(AVG(transaction_amount), 2) AS average_transaction_value
FROM banking_transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY transaction_month;

-- 4. Channel performance
SELECT
    channel,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM banking_transactions), 2
    ) AS transaction_share_percentage,
    ROUND(SUM(transaction_amount), 2) AS total_transaction_value,
    ROUND(AVG(transaction_amount), 2) AS average_transaction_value
FROM banking_transactions
GROUP BY channel
ORDER BY total_transactions DESC;

-- 5. Debit versus credit
SELECT
    transaction_direction,
    COUNT(*) AS total_transactions,
    ROUND(AVG(transaction_amount), 2) AS average_amount,
    ROUND(SUM(transaction_amount), 2) AS total_amount
FROM banking_transactions
GROUP BY transaction_direction
ORDER BY total_transactions DESC;
