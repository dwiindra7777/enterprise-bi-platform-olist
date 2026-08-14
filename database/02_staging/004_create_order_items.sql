/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.order_items
Purpose : Transform and standardize order item source data
*/

DROP TABLE IF EXISTS staging.order_items;

CREATE TABLE staging.order_items AS
SELECT
    TRIM(order_id)::TEXT AS order_id,
    order_item_id::INTEGER AS order_item_id,
    TRIM(product_id)::TEXT AS product_id,
    TRIM(seller_id)::TEXT AS seller_id,
    shipping_limit_date::TIMESTAMP AS shipping_limit_date,
    price::NUMERIC(18,2) AS price,
    freight_value::NUMERIC(18,2) AS freight_value
FROM landing.order_items;