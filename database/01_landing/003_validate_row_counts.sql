/*
Project : Enterprise Marketplace Business Intelligence Platform
Purpose : Validate Landing Layer
Author  : Dwi Indra
*/

-- ============================================================
-- ROW COUNT CHECK
-- ============================================================

SELECT 'customers' AS table_name, COUNT(*) AS row_count
FROM landing.customers

UNION ALL

SELECT 'geolocation', COUNT(*)
FROM landing.geolocation

UNION ALL

SELECT 'order_items', COUNT(*)
FROM landing.order_items

UNION ALL

SELECT 'order_payments', COUNT(*)
FROM landing.order_payments

UNION ALL

SELECT 'order_reviews', COUNT(*)
FROM landing.order_reviews

UNION ALL

SELECT 'orders', COUNT(*)
FROM landing.orders

UNION ALL

SELECT 'products', COUNT(*)
FROM landing.products

UNION ALL

SELECT 'sellers', COUNT(*)
FROM landing.sellers

UNION ALL

SELECT 'product_category_translation', COUNT(*)
FROM landing.product_category_translation

ORDER BY table_name;

-- ============================================================
-- NULL CHECK
-- ============================================================

SELECT
    'customers.customer_id' AS column_name,
    COUNT(*) AS null_count
FROM landing.customers
WHERE customer_id IS NULL

UNION ALL

SELECT
    'customers.customer_unique_id',
    COUNT(*)
FROM landing.customers
WHERE customer_unique_id IS NULL

UNION ALL

SELECT
    'orders.order_id',
    COUNT(*)
FROM landing.orders
WHERE order_id IS NULL

UNION ALL

SELECT
    'orders.customer_id',
    COUNT(*)
FROM landing.orders
WHERE customer_id IS NULL

UNION ALL

SELECT
    'order_items.order_id',
    COUNT(*)
FROM landing.order_items
WHERE order_id IS NULL

UNION ALL

SELECT
    'order_items.product_id',
    COUNT(*)
FROM landing.order_items
WHERE product_id IS NULL

UNION ALL

SELECT
    'order_items.seller_id',
    COUNT(*)
FROM landing.order_items
WHERE seller_id IS NULL

UNION ALL

SELECT
    'products.product_id',
    COUNT(*)
FROM landing.products
WHERE product_id IS NULL

UNION ALL

SELECT
    'sellers.seller_id',
    COUNT(*)
FROM landing.sellers
WHERE seller_id IS NULL;

-- ============================================================
-- DUPLICATE IDENTIFIER CHECK
-- ============================================================

SELECT
    'customers.customer_id' AS column_name,
    COUNT(*) - COUNT(DISTINCT customer_id) AS duplicate_count
FROM landing.customers

UNION ALL

SELECT
    'customers.customer_unique_id',
    COUNT(*) - COUNT(DISTINCT customer_unique_id)
FROM landing.customers

UNION ALL

SELECT
    'orders.order_id',
    COUNT(*) - COUNT(DISTINCT order_id)
FROM landing.orders

UNION ALL

SELECT
    'products.product_id',
    COUNT(*) - COUNT(DISTINCT product_id)
FROM landing.products

UNION ALL

SELECT
    'sellers.seller_id',
    COUNT(*) - COUNT(DISTINCT seller_id)
FROM landing.sellers;


-- ============================================================
-- REFERENTIAL INTEGRITY CHECK
-- ============================================================

SELECT COUNT(*) AS orphan_orders
FROM landing.orders o
LEFT JOIN landing.customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS orphan_order_items
FROM landing.order_items oi
LEFT JOIN landing.orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS orphan_order_items_products
FROM landing.order_items oi
LEFT JOIN landing.products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS orphan_order_items_sellers
FROM landing.order_items oi
LEFT JOIN landing.sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

SELECT COUNT(*) AS orphan_payments
FROM landing.order_payments op
LEFT JOIN landing.orders o
    ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS orphan_reviews
FROM landing.order_reviews r
LEFT JOIN landing.orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;