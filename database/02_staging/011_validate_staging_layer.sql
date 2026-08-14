-- ============================================================
-- Tables CHECK
-- ============================================================

SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'staging'
ORDER BY table_name;

-- ============================================================
-- LANDING VS STAGING ROW COUNT CHECK
-- ============================================================

SELECT 'customers' AS table_name,
       (SELECT COUNT(*) FROM landing.customers) AS landing_count,
       (SELECT COUNT(*) FROM staging.customers) AS staging_count

UNION ALL

SELECT 'geolocation',
       (SELECT COUNT(*) FROM landing.geolocation),
       (SELECT COUNT(*) FROM staging.geolocation)

UNION ALL

SELECT 'order_items',
       (SELECT COUNT(*) FROM landing.order_items),
       (SELECT COUNT(*) FROM staging.order_items)

UNION ALL

SELECT 'order_payments',
       (SELECT COUNT(*) FROM landing.order_payments),
       (SELECT COUNT(*) FROM staging.order_payments)

UNION ALL

SELECT 'order_reviews',
       (SELECT COUNT(*) FROM landing.order_reviews),
       (SELECT COUNT(*) FROM staging.order_reviews)

UNION ALL

SELECT 'orders',
       (SELECT COUNT(*) FROM landing.orders),
       (SELECT COUNT(*) FROM staging.orders)

UNION ALL

SELECT 'products',
       (SELECT COUNT(*) FROM landing.products),
       (SELECT COUNT(*) FROM staging.products)

UNION ALL

SELECT 'sellers',
       (SELECT COUNT(*) FROM landing.sellers),
       (SELECT COUNT(*) FROM staging.sellers)

UNION ALL

SELECT 'product_category_translation',
       (SELECT COUNT(*) FROM landing.product_category_translation),
       (SELECT COUNT(*) FROM staging.product_category_translation)

ORDER BY table_name;

-- ============================================================
-- CROSS TABLE FOREIGN KEY COVERAGE CHECK
-- ============================================================

-- Orders → Customers

SELECT COUNT(*) AS orphan_orders
FROM staging.orders o
LEFT JOIN staging.customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Order Items → Orders

SELECT COUNT(*) AS orphan_order_items
FROM staging.order_items oi
LEFT JOIN staging.orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Order Items → Products

SELECT COUNT(*) AS orphan_order_items_products
FROM staging.order_items oi
LEFT JOIN staging.products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

--Payments → Orders

SELECT COUNT(*) AS orphan_payments
FROM staging.order_payments op
LEFT JOIN staging.orders o
    ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Reviews → Orders

SELECT COUNT(*) AS orphan_reviews
FROM staging.order_reviews r
LEFT JOIN staging.orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- ============================================================
-- PRODUCT CATEGORY COVERAGE CHECK
-- ============================================================

--
SELECT
    COUNT(*) AS products_with_category,
    COUNT(t.product_category_name) AS products_with_translation
FROM staging.products p
LEFT JOIN staging.product_category_translation t
    ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL;

--
SELECT DISTINCT
    p.product_category_name
FROM staging.products p
LEFT JOIN staging.product_category_translation t
    ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND t.product_category_name IS NULL
ORDER BY p.product_category_name;


-- ============================================================
-- ORDER ITEMS → PRODUCT CATEGORY COVERAGE CHECK
-- ============================================================

SELECT
    COUNT(*) AS total_order_items,
    COUNT(p.product_id) AS items_with_product,
    COUNT(p.product_category_name) AS items_with_category
FROM staging.order_items oi
LEFT JOIN staging.products p
    ON oi.product_id = p.product_id;

-- ============================================================
-- STAGING LAYER ANOMALY CHECK
-- ============================================================

SELECT
    'orders.carrier_before_purchase' AS validation_name,
    COUNT(*) AS affected_rows
FROM staging.orders
WHERE order_delivered_carrier_date < order_purchase_timestamp

UNION ALL

SELECT
    'products.category_null',
    COUNT(*)
FROM staging.products
WHERE product_category_name IS NULL

UNION ALL

SELECT
    'products.name_length_null',
    COUNT(*)
FROM staging.products
WHERE product_name_length IS NULL

UNION ALL

SELECT
    'products.description_length_null',
    COUNT(*)
FROM staging.products
WHERE product_description_length IS NULL;