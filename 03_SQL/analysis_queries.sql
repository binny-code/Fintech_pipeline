## Q1
### Query

SELECT status, COUNT(*) AS transaction_count
FROM cleaned_transactions
GROUP BY status;


## Q2
### Query

SELECT merchant_name, SUM(amount_usd) AS total_captured_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name;


## Q3
### Query

SELECT merchant_name, SUM(amount_usd) AS total_captured_gmv
FROM cleaned_transactions
WHERE status = 'captured'
GROUP BY merchant_name
ORDER BY total_captured_gmv DESC
LIMIT 10;


## Q4
### Query

SELECT standardized_transaction_date,
       SUM(amount_usd) AS daily_gmv,
       COUNT(CASE WHEN status='%captured%' THEN 1 END) AS successful_txn_count
FROM cleaned_transactions
GROUP BY standardized_transaction_date;


## Q5
### Query

SELECT merchant_name,
       SUM(CASE WHEN LOWER(status) LIKE '%chargeback%' THEN 1 ELSE 0 END)*1.0/COUNT(*) AS chargeback_ratio
FROM cleaned_transactions
GROUP BY merchant_name
HAVING chargeback_ratio > 0.01


## Q6
### Query

SELECT standardize_gateway_region AS region,
       AVG(risk_score) AS avg_risk_score,
       COUNT(*) AS txn_count
FROM cleaned_transactions
GROUP BY standardize_gateway_region
HAVING AVG(risk_score) > 50 AND COUNT(*) > 20;


## Q7
### Query

SELECT user_id, standardized_transaction_date,
       COUNT(*) AS failed_or_cb_txn
FROM cleaned_transactions
WHERE LOWER(status) IN ('failed','chargeback')
GROUP BY user_id, standardized_transaction_date
HAVING COUNT(*) >= 3;


## Q8
### Query

SELECT merchant_name,
       COUNT(*) AS chargeback_count,
       COUNT(DISTINCT user_id) AS unique_users,
       SUM(amount_usd) AS chargeback_amount
FROM cleaned_transactions
WHERE LOWER(status) LIKE '%chargeback%'
GROUP BY merchant_name;


