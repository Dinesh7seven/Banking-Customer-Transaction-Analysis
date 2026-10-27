
# SQL Analysis

This folder contains SQL scripts used to validate and analyze the banking transaction dataset.

## Scripts

- `01_data_validation.sql` — row counts, unique transaction IDs, missing fields, and date validation.
- `02_data_quality_analysis.sql` — transaction amounts, statuses, loan fields, and fraud flags.
- `03_business_kpi_analysis.sql` — transaction KPIs, monthly trends, channel performance, and debit/credit analysis.
- `04_customer_segmentation.sql` — customer activity, account types, and fraud-flag comparisons.
- `05_advanced_sql_analysis.sql` — CTEs, DENSE_RANK, LAG, running totals, and window functions.

## Database

- Database: `banking_analytics`
- Table: `banking_transactions`
- Dataset size: 550,000 transaction records

## Tools

- MySQL 8.0
- MySQL Command Line Client
- SQL CTEs, aggregate functions, conditional aggregation, and window functions
