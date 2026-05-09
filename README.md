# FinTech Operations Case Study

## Overview

This project simulates a real-world fintech operations scenario at QuickPay, where the goal is to clean transaction data, perform analysis, reconcile financial records, and build a monitoring dashboard.

The work is divided into three main parts:

* Spreadsheet-based data cleaning and transformation
* SQL-based analysis
* Python-based reconciliation and data processing
* Dashboard creation for business monitoring

---

## 1. Spreadsheet Cleaning and Transformation

I started with the raw transaction dataset and cleaned it using Google Sheets.

### Key steps:

* Standardized merchant names using trimming and casing
* Normalized status values (e.g., converting variations like "FAILED E05 TIMEOUT" into "failed")
* Cleaned risk scores using extraction logic to handle mixed formats
* Standardized date formats
* Mapped merchant regions using `merchant_master.csv`
* Converted transaction amounts using `exchange_rates.csv` with date-based matching

### Flags created:

* **High Value Flag** → based on region-specific thresholds
* **High Risk Flag** → risk score ≥ 70 OR chargeback status

### Output files:

* `cleaned_transactions.csv`
* `merchant_risk_summary.csv`

---

## 2. SQL Analysis

Using the cleaned dataset, I performed multiple SQL analyses to answer business questions.

### Key insights generated:

* Transaction distribution by status
* Merchant-level GMV contribution
* Top-performing merchants
* Daily transaction trends
* Chargeback ratios per merchant
* Region-level risk analysis
* Suspicious user activity detection
* Merchant-level chargeback exposure

### Files:

* `analysis_queries.sql` → contains all queries
* `sql_answers.md` → explanation and interpretation

---

## 3. Python Reconciliation Workflow

This part focuses on reconciling transactions between internal (ledger) and external (gateway) systems.

### Steps performed:

* Loaded and validated datasets (no duplicates or nulls found)
* Identified:

  * Missing transactions in gateway
  * Missing transactions in ledger
* Compared matching records to find:

  * Amount mismatches
  * Status mismatches

### Key results:

* 2 transactions missing in gateway
* 1 transaction missing in ledger
* 2 amount mismatches
* 1 status mismatch
* Total reconciliation issues: 6

### Financial insight:

* **Amount at Risk = 1490 USD**

### Output files:

* `missing_in_gateway.csv`
* `missing_in_ledger.csv`
* `amount_mismatches.csv`
* `status_mismatches.csv`
* `reconciliation_report.csv`
* `summary_metrics.json`

---

## 4. API Data Normalization

The API response contained nested JSON data, which I flattened into a structured format.

### What was done:

* Extracted merchant, settlement, and bank details
* Created a flat table where each row represents a settlement

### Output:

* `api_normalized.csv`

---

## 5. Aggregations for Dashboard

Using the normalized dataset, I created aggregated views for visualization.

### Files generated:

* `daily_summary.csv` → trend analysis
* `region_breakdown.csv` → region-level performance
* `merchant_performance_summary.csv` → merchant insights
* `payment_method_breakdown.csv` → payment channel analysis

---

## 6. Dashboard (Looker Studio)

The dashboard was built using multiple datasets, each serving a specific purpose.

### KPI Scorecards:

* Total GMV
* Confirmed GMV
* Amount at Risk
* Success Rate
* Total Transactions
* Average Transaction Value

### Visuals:

* Time-series chart for transaction trends
* Region-wise breakdown
* Merchant performance comparison
* Payment method distribution
* Detailed transaction table

### Filters added:

* Date
* Region
* Merchant
* Status

---

## Key Takeaways

* Clean data is critical before any analysis
* Reconciliation helps identify financial risks and inconsistencies
* Separating data preparation (Python) and visualization (Looker) improves clarity
* Using multiple datasets for dashboards is more efficient than forcing everything into one

---

## Folder Structure

* `01_data/` → raw and processed data
* `02_spreadsheet/` → Excel work + answers
* `03_sql/` → SQL queries and explanations
* `04_python/` → notebook and summary metrics
* 05_visualization/→  dashboard_link.txt

      

---

## Final Note

This project was built step-by-step with a focus on clarity, correctness, and real-world applicability. The goal was not just to complete tasks, but to structure the solution in a way that reflects how data workflows operate in an actual fintech environment.
