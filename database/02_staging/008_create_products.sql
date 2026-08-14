/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.products
Purpose : Transform and standardize product source data
*/

DROP TABLE IF EXISTS staging.products;

CREATE TABLE staging.products AS
SELECT
    TRIM(product_id)::TEXT AS product_id,
    LOWER(TRIM(product_category_name))::TEXT AS product_category_name,
    product_name_lenght::INTEGER AS product_name_length,
    product_description_lenght::INTEGER AS product_description_length,
    product_photos_qty::INTEGER AS product_photos_qty,
    product_weight_g::INTEGER AS product_weight_g,
    product_length_cm::INTEGER AS product_length_cm,
    product_height_cm::INTEGER AS product_height_cm,
    product_width_cm::INTEGER AS product_width_cm
FROM landing.products;