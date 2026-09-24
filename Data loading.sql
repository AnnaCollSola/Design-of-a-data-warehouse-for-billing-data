-- LOAD THE DATA IN THE DATA WAREHOUSE CREATED

-- Create a staging table

CREATE TABLE staging_billing (
    customerid INTEGER,
    category VARCHAR(50),
    country VARCHAR(50),
    industry VARCHAR(100),
    month VARCHAR(10),
    billedamount INTEGER
);

-- Import the data in the cloud-billing-dataset csv to the staging_billing table (header = True)


-- Create dim_month

INSERT INTO "dim_month"
(monthid, year, month, monthname, quarter, quartername)
SELECT DISTINCT
    (year * 100 + month) AS monthid,
    year,
    month,
    TO_CHAR(TO_DATE(month::text, 'MM'), 'Mon') AS monthname,
    ((month - 1) / 3) + 1 AS quarter,
    'Q' || (((month - 1) / 3) + 1) AS quartername
FROM (
    SELECT
        SPLIT_PART(month, '-', 1)::INT AS year,
        SPLIT_PART(month, '-', 2)::INT AS month
    FROM staging_billing
) t;


-- Create dim_customer

INSERT INTO "dim_customer"(customerid, category, country, industry)
SELECT DISTINCT
    customerid,
    category,
    country,
    industry
FROM staging_billing;


-- Create fact_billing

INSERT INTO "fact_billing"(rowid, customerid, monthid, billedamount)
SELECT
    ROW_NUMBER() OVER () AS rowid,
    sb.customerid,
    (SPLIT_PART(sb.month,'-',1)::INT * 100 +
     SPLIT_PART(sb.month,'-',2)::INT) AS monthid,
    sb.billedamount
FROM staging_billing sb;

