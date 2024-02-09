--1. total money_in
SELECT SUM(money_in) AS 'total_money_in'
FROM transactions;

--2. total money_out
SELECT SUM(money_out) AS 'total_money_out'
FROM transactions;

--3.Number of money_in transactions 
SELECT COUNT(money_in) AS 'num_of_money_in'
FROM transactions 
WHERE money_in IS NOT NULL;

--4. number of BIT currency
SELECT COUNT(money_in) 'num_of_BIT_currency'
FROM transactions 
WHERE currency = 'BIT';

--5. largest transaction in the table
SELECT MAX(money_in), MAX(money_out)
FROM transactions;

--6. average money_in for the currency ETH
SELECT AVG(money_in) AS 'max_ETH'
FROM transactions
WHERE currency = 'ETH';

--7. average money_in, average money_out grouped by date:
SELECT date, ROUND(AVG(money_in), 2) AS 'AVG_money_in', ROUND(AVG(money_out), 2) AS 'AVG_money_out'
FROM transactions
GROUP BY 1;
