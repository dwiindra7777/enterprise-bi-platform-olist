/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.sellers
Purpose : Transform and standardize seller source data
*/

DROP TABLE IF EXISTS staging.sellers;

CREATE TABLE staging.sellers AS
SELECT
    TRIM(seller_id)::TEXT AS seller_id,
    TRIM(seller_zip_code_prefix)::TEXT AS seller_zip_code_prefix,
    LOWER(TRIM(seller_city))::TEXT AS seller_city,
    UPPER(TRIM(seller_state))::TEXT AS seller_state
FROM landing.sellers;