# Banking Customer Transaction Analysis

## Project Overview
An end-to-end data analytics project that analyzes banking transaction activity, customer behavior, transaction channels, transaction statuses, and transactions flagged for potential fraud.

## Business Objectives
- Measure overall transaction volume and transaction value.
- Analyze customer activity and account-type distribution.
- Compare debit and credit transaction patterns.
- Identify transaction channels with high activity and failure counts.
- Examine transaction status and hourly activity.
- Analyze records flagged by the dataset's fraud indicator.

## Tools & Technologies
- **SQL:** Data validation, aggregations, joins, CTEs, subqueries, and window functions.
- **Python:** Pandas and data-quality checks.
- **Power BI:** Interactive dashboards, KPI cards, charts, and slicers.
- **MySQL:** Data storage and analytical queries.

## Dataset
- Source: Banking transaction CSV dataset.
- Records: 550,000 transactions.
- Unique transaction IDs: 550,000.
- Unique customers: 79,916.
- Date coverage: January 2019 to January 2024.

## Project Workflow
1. Collected and inspected the transaction dataset.
2. Cleaned and validated data using Python.
3. Imported the dataset into MySQL.
4. Developed SQL queries for data quality and business analysis.
5. Built interactive Power BI dashboards.

## Power BI Dashboards

### 1. Executive Overview
- Total transactions and unique customers.
- Total and average transaction value.
- Monthly transaction trends.
- Transaction status distribution.
- Channel analysis.

### 2. Customer & Channel Analysis
- Transactions by account type.
- Debit versus credit transaction value.
- Top 10 customers by transaction value.
- State-wise transaction activity.
- Interactive slicers.

### 3. Fraud & Operations
- Transactions flagged by the dataset's fraud indicator.
- Flagged transaction rate.
- Failed transaction counts.
- Flagged transactions by channel.
- Hourly transaction activity.
- Failed transactions by channel.

## Data Quality & Interpretation
The dataset contains 550,000 transaction records with unique transaction IDs. The `is_fraud` field identifies records flagged by the dataset; these flags should not be interpreted as independently verified fraud cases.

## Project Structure
- `01_Data/` — Raw and cleaned datasets.
- `02_Python/` — Data inspection and cleaning scripts.
- `03_SQL/` — SQL analysis scripts.
- `04_Power_BI/` — Power BI report and supporting exports.

## Key Skills Demonstrated
SQL analytics, Python data preparation, data validation, KPI development, customer analysis, dashboard design, and business reporting.
