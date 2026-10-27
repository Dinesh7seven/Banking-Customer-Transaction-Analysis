
import pandas as pd
from pathlib import Path

# Project paths
PROJECT_DIR = Path(__file__).resolve().parent.parent
RAW_FILE = PROJECT_DIR / "01_Data" / "raw" / "indian_banking_transactions.csv"

print("=" * 60)
print("BANKING TRANSACTION DATA - INITIAL INSPECTION")
print("=" * 60)

# Load raw dataset
df = pd.read_csv(RAW_FILE)

# Basic information
print("\n1. DATASET DIMENSIONS")
print("Rows:", df.shape[0])
print("Columns:", df.shape[1])

print("\n2. COLUMN NAMES")
print(df.columns.tolist())

print("\n3. FIRST FIVE RECORDS")
print(df.head().to_string())

print("\n4. DATA TYPES")
print(df.dtypes.to_string())

print("\n5. MISSING VALUES")
print(df.isna().sum().to_string())

print("\n6. EXACT DUPLICATE ROWS")
print(df.duplicated().sum())

print("\n7. TRANSACTION DATE SAMPLE")
if "transaction_date" in df.columns:
    print(df["transaction_date"].head(10).to_list())
else:
    print("transaction_date column not found.")

print("\n8. FRAUD FLAG DISTRIBUTION")
if "is_fraud" in df.columns:
    print(df["is_fraud"].value_counts(dropna=False).to_string())
else:
    print("is_fraud column not found.")

print("\nInspection completed.")
