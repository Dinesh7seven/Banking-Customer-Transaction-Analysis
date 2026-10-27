
USE banking_analytics;

-- 1. Transaction amount checks
SELECT
    MIN(transaction_amount) AS minimum_amount,
    MAX(transaction_amount) AS maximum_amount,
    ROUND(AVG(transaction_amount), 2) AS average_amount,
    SUM(transaction_amount <= 0) AS non_positive_amounts,
    SUM(transaction_amount IS NULL) AS missing_amounts
FROM banking_transactions;

-- 2. Transaction status distribution
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

-- 3. Loan data quality
SELECT
    has_loan,
    COUNT(*) AS total_records,
    SUM(loan_type IS NULL OR TRIM(loan_type) = '') AS missing_loan_type,
    SUM(emi_amount = 0) AS zero_emi_records,
    SUM(emi_amount > 0) AS positive_emi_records
FROM banking_transactions
GROUP BY has_loan
ORDER BY has_loan;

-- 4. Fraud flag distribution
SELECT
    is_fraud,
    COUNT(*) AS total_records,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM banking_transactions), 2
    ) AS percentage
FROM banking_transactions
GROUP BY is_fraud
ORDER BY is_fraud;
