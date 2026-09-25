# Design-of-a-data-warehouse-for-billing-data (PostgreSQL)

Design of a data warehouse using a star schema with fact and dimension tables for optimizing data retrieval.
The billing data is in the csv file cloud-billing-dataset.csv

Details of the billing data:
- customerid: Id of the customer
- category: Category of the customer. Example: Individual or Company
- country: Country of the customer
- industry: Which domain/industry the customer belongs to. Example: Legal, Engineering
- month: The billed month, stored as YYYY-MM. Example: 2009-01 refers to the month January in the year 2009
- billedamount: Amount charged by the cloud services provided for that month in USD

The data warehouse has to support the queries listed below:
- average billing per customer
- billing by country
- top 10 customers
- top 10 countries
- billing by industry
- billing by category
- billing by year
- billing by month
- billing by quarter
- average billing per industry per month
- average billing per industry per quarter
- average billing per country per quarter
- average billing per country per industry per quarter

Fact table:
- billid: Primary key - Unique identifier for every bill
- customerid: Foreign Key - Id of the customer
- monthid: Foreign Key - Id of the month. We can resolve the billed month info using this
- billedamount: Amount charged by the cloud services provided for that month in USD

Dimension tables:

  Customer information table:
  - customerid: Primary Key - Id of the customer
  - category: Category of the customer. Example: Individual or Company
  - country: Country of the customer
  - industry: Which domain/industry the customer belongs to. Example: Legal, Engineering

  Date information table:
  - monthid: Primary Key - Id of the month
  - year: Year derived from the month field of the original data. Example: 2010
  - month: Month number derived from the month field of the original data. Example: 1, 2, 3
  - monthname: Month name derived from the month field of the original data. Example: March
  - quarter: Quarter number derived from the month field of the original data. Example: 1, 2, 3, 4
  - quartername: Quarter name derived from the month field of the original data. Example: Q1, Q2, Q3, Q4


The tables are arranged in Star Schema style.

