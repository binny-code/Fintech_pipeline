# Spreadsheet Answers

## Cleaning Steps
- Removed null and invalid transaction records where key fields such as transaction_id or amount were missing
- Eliminated duplicate records to ensure data consistency
- Ensured all columns had consistent data types (numeric, date, text)
- Handled malformed values in risk_score using extraction logic

## Standardization Rules
- Merchant names were standardized using TRIM and UPPER to remove inconsistencies
- Dates were converted into a consistent date format using DATEVALUE
- Status values were normalized using LOWER and TRIM functions
- Risk scores were cleaned using regex extraction to handle mixed text formats
- Gateway regions were standardized using lookup mapping from merchant_master

## Lookup and Enrichment Logic
- Merchant data was enriched by matching standardized merchant_name between transactions and merchant_master
- Gateway region was mapped using INDEX-MATCH based on merchant_name
- Transaction amounts were converted into a single reporting currency (USD) using exchange_rates.csv
- Currency conversion was performed using both currency and transaction date to ensure accurate time-based rates

## Final Answers
- Total raw rows: [206]
- Total cleaned rows: [161]
- Invalid or missing rows handled: [50]
- Top region by GMV: [APAC : $82594]
- Number of high value transactions: [7]
- Number of high risk transactions: [9]
- Top merchant by captured GMV: [BETA STORES : $33431]

## Formula Samples
- Standardized Merchant Name:
  =UPPER(TRIM(N2))

- Standardized Risk Score:
  =IF(ISNUMBER(R2), R2, IFERROR(VALUE(REGEXEXTRACT(R2, "\d+\.?\d*")), 0))

- Gateway Region Mapping:
  =IFERROR(INDEX(merchant_master!E:E, MATCH(D2, merchant_master!F:F, 0)), "UNKNOWN")

- Amount Conversion (Currency + Date):
 =IFERROR(
  O2 * INDEX(exchange_rates!C:C,
    MATCH(1,
      (exchange_rates!A:A=M2) *
      (exchange_rates!B:B=P2),
    0)
  ),
"")

- High Value Flag:
=IF(OR(
  AND(H2="APAC", I2>5000),
  AND(H2="EU", I2>6000),
  AND(H2="US", I2>7000)
), 1, 0)

- High Risk Flag:
  =IF(
  OR(
    G2>=70,
    F2="chargeback"
  ),
1,
0
)