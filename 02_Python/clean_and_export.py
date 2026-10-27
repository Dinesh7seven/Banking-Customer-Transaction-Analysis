
import pandas as pd
from pathlib import Path

PROJECT_DIR = Path(__file__).resolve().parent.parent
RAW_FILE = PROJECT_DIR / "01_Data" / "raw" / "indian_banking_transactions.csv"
OUTPUT_DIR = PROJECT_DIR / "01_Data" / "cleaned"
OUTPUT_FILE = OUTPUT_DIR / "banking_transactions_cleaned.csv"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

print("Loading raw dataset...")
df = pd.read_csv(RAW_FILE)

print("Original rows:", len(df))

# Standardize column names
df.columns = (
    df.columns.str.strip()
    .str.lower()
    .str.replace(r"\s+", "_", regex=True)
)

# Remove exact duplicate rows
duplicates = df.duplicated().sum()
df = df.drop_duplicates().copy()
print("Exact duplicate rows removed:", duplicates)

# Parse dates using the verified DD-MM-YYYY format
raw_dates = df["transaction_date"].astype("string").str.strip()
parsed_dates = pd.to_datetime(
    raw_dates,
    format="%d-%m-%Y",
    errors="coerce"
)

invalid_dates = parsed_dates.isna().sum()
print("Invalid or missing dates:", invalid_dates)

# Stop if any dates could not be parsed.
# This prevents silently exporting incorrect dates.
if invalid_dates > 0:
    print("\nCleaning stopped: inspect the invalid date values before continuing.")
    print(raw_dates[parsed_dates.isna()].value_counts(dropna=False).head(20))
    raise ValueError("Resolve invalid transaction dates before exporting.")

# Store dates in ISO format for reliable SQL import
df["transaction_date"] = parsed_dates.dt.strftime("%Y-%m-%d")

# Normalize whitespace in text columns
for col in df.select_dtypes(include=["object", "string"]).columns:
    df[col] = df[col].str.strip()

# Validate transaction amounts
df["transaction_amount"] = pd.to_numeric(
    df["transaction_amount"], errors="coerce"
)

invalid_amounts = df["transaction_amount"].isna().sum()
print("Missing or invalid transaction amounts:", invalid_amounts)

if invalid_amounts > 0:
    raise ValueError("Resolve invalid transaction amounts before exporting.")

# Check fraud flags
print("\nFraud distribution:")
print(df["is_fraud"].value_counts(dropna=False))

# Export cleaned data
df.to_csv(OUTPUT_FILE, index=False, date_format="%Y-%m-%d")

print("\nCleaning completed.")
print("Final rows:", len(df))
print("Final columns:", len(df.columns))
print("Output:", OUTPUT_FILE)
