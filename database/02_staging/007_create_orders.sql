/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.orders
Purpose : Transform and standardize order source data
*/

DROP TABLE IF EXISTS staging.orders;

CREATE TABLE staging.orders AS
SELECT
    TRIM(order_id)::TEXT AS order_id,
    TRIM(customer_id)::TEXT AS customer_id,
    LOWER(TRIM(order_status))::TEXT AS order_status,
    order_purchase_timestamp::TIMESTAMP AS order_purchase_timestamp,
    order_approved_at::TIMESTAMP AS order_approved_at,
    order_delivered_carrier_date::TIMESTAMP AS order_delivered_carrier_date,
    order_delivered_customer_date::TIMESTAMP AS order_delivered_customer_date,
    order_estimated_delivery_date::TIMESTAMP AS order_estimated_delivery_date
FROM landing.orders;