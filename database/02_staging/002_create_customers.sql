/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.customers
Purpose : Transform and standardize customer source data
*/

DROP TABLE IF EXISTS staging.customers;

CREATE TABLE staging.customers AS
SELECT
    TRIM(customer_id)::TEXT AS customer_id,
    TRIM(customer_unique_id)::TEXT AS customer_unique_id,
    TRIM(customer_zip_code_prefix)::TEXT AS customer_zip_code_prefix,
    TRIM(customer_city)::TEXT AS customer_city,
    UPPER(TRIM(customer_state))::TEXT AS customer_state
FROM landing.customers;