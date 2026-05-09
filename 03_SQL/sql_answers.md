# SQL Answers

## Q1

### Query

SELECT status, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status;


### Result Summary

The dataset shows the distribution of transactions across different status. The majority of transactions are successfully captured, while a smaller proportion consists of failed and chargeback transactions.

---

## Q2

### Query

SELECT merchant_name, SUM(amount_usd) AS total_captured_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name;

### Result Summary

This query calculates the total captured GMV (Gross Merchandise Value) for each merchant. It helps identify merchants contributing the most revenue to the platform.

---

## Q3

### Query

SELECT merchant_name, SUM(amount_usd) AS total_captured_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY total_captured_gmv DESC
LIMIT 10;

### Result Summary

The top 10 merchants by captured GMV represent the highest revenue-generating merchants. This helps prioritize key merchants for business focus and partnerships.

---

## Q4

### Query

SELECT standardized_transaction_date,
       SUM(amount_usd) AS daily_gmv,
       COUNT(CASE WHEN status='%captured%' THEN 1 END) AS successful_txn_count
FROM cleaned_transactions
GROUP BY standardized_transaction_date;
### Result Summary

This query provides a daily view of GMV and successful transactions. It helps track business performance trends over time and monitor transaction success rates.

---

## Q5

### Query

SELECT merchant_name,
       SUM(CASE WHEN LOWER(status) LIKE '%chargeback%' THEN 1 ELSE 0 END)*1.0/COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING chargeback_ratio > 0.01
### Result Summary

Merchants with a chargeback ratio greater than 1% are identified as high-risk. These merchants may require further investigation or stricter monitoring to reduce financial risk.

---

## Q6

### Query

SELECT standardize_gateway_region AS region,
       AVG(risk_score) AS avg_risk_score,
       COUNT(*) AS txn_count
FROM cleaned_transactions
GROUP BY standardize_gateway_region
HAVING AVG(risk_score) > 50 AND COUNT(*) > 20;


### Result Summary

Regions with an average risk score above 50 and more than 20 transactions are flagged. This highlights regions with consistently high-risk activity and sufficient transaction volume to be statistically significant.

---

## Q7

### Query

SELECT user_id, standardized_transaction_date,
       COUNT(*) AS failed_or_cb_txn
FROM cleaned_transactions
WHERE LOWER(status) IN ('failed','chargeback')
GROUP BY user_id, standardized_transaction_date
HAVING COUNT(*) >= 3;

### Result Summary

Users with three or more failed or chargeback transactions in a single day are identified as potentially suspicious. This pattern may indicate fraudulent behavior or system misuse.

---

## Q8

### Query

SELECT merchant_name,
       COUNT(*) AS chargeback_count,
       COUNT(DISTINCT user_id) AS unique_users,
       SUM(amount_usd) AS chargeback_amount
FROM cleaned_transactions
WHERE LOWER(status) LIKE '%chargeback%'
GROUP BY merchant_name;


### Result Summary

This query provides chargeback metrics per merchant, including total chargebacks, affected users, and financial impact. It helps assess merchant-level risk and potential revenue loss.
