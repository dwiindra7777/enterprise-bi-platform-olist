/*
Project : Enterprise Marketplace Business Intelligence Platform
Layer   : Staging
Table   : staging.order_payments
Purpose : Transform and standardize order payment source data
*/

DROP TABLE IF EXISTS staging.order_payments;

CREATE TABLE staging.order_payments AS
SELECT
    TRIM(order_id)::TEXT AS order_id,
    payment_sequential::INTEGER AS payment_sequential,
    LOWER(TRIM(payment_type))::TEXT AS payment_type,
    payment_installments::INTEGER AS payment_installments,
    payment_value::NUMERIC(18,2) AS payment_value
FROM landing.order_payments;