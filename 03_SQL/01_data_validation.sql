
USE banking_analytics;

-- 1. Total number of imported records
SELECT COUNT(*) AS total_records
FROM banking_transactions;

-- 2. Check unique transaction IDs and duplicates
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT transaction_id) AS unique_transaction_ids,
    COUNT(*) - COUNT(DISTINCT transaction_id) AS duplicate_ids
FROM banking_transactions;

-- 3. Check missing key fields
SELECT
    SUM(transaction_id IS NULL OR TRIM(transaction_id) = '') AS missing_transaction_ids,
    SUM(customer_id IS NULL OR TRIM(customer_id) = '') AS missing_customer_ids,
    SUM(transaction_date IS NULL) AS missing_dates,
    SUM(transaction_amount IS NULL) AS missing_amounts,
    SUM(transaction_status IS NULL OR TRIM(transaction_status) = '') AS missing_statuses,
    SUM(state IS NULL OR TRIM(state) = '') AS missing_states
FROM banking_transactions;

-- 4. Validate transaction dates
SELECT
    COUNT(*) AS total_records,
    SUM(transaction_date IS NULL) AS null_dates,
    MIN(transaction_date) AS first_date,
    MAX(transaction_date) AS last_date
FROM banking_transactions;
