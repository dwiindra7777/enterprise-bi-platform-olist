/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.product_category_translation
Purpose : Transform and standardize product category translation data
*/

DROP TABLE IF EXISTS staging.product_category_translation;

CREATE TABLE staging.product_category_translation AS
SELECT
    LOWER(TRIM(product_category_name))::TEXT AS product_category_name,
    LOWER(TRIM(product_category_name_english))::TEXT AS product_category_name_english
FROM landing.product_category_translation;