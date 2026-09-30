-- ФИО: Родионова К.М.
-- Группа: ИНБО-20-23
-- Вариант: нет

\echo '=== 1. Row counts ==='
SELECT 'customers' AS table_name, count(*) AS row_count FROM olist.customers
UNION ALL SELECT 'geolocation', count(*) FROM olist.geolocation
UNION ALL SELECT 'orders', count(*) FROM olist.orders
UNION ALL SELECT 'order_items', count(*) FROM olist.order_items
UNION ALL SELECT 'order_payments', count(*) FROM olist.order_payments
UNION ALL SELECT 'order_reviews', count(*) FROM olist.order_reviews
UNION ALL SELECT 'products', count(*) FROM olist.products
UNION ALL SELECT 'sellers', count(*) FROM olist.sellers
UNION ALL SELECT 'product_category_name_translation', count(*) FROM olist.product_category_name_translation
ORDER BY table_name;

\echo '=== 2. NULLs in key fields ==='
SELECT 'customers.customer_id' AS field, count(*) FILTER (WHERE customer_id IS NULL) AS nulls FROM olist.customers
UNION ALL SELECT 'orders.order_id', count(*) FILTER (WHERE order_id IS NULL) FROM olist.orders
UNION ALL SELECT 'orders.customer_id', count(*) FILTER (WHERE customer_id IS NULL) FROM olist.orders
UNION ALL SELECT 'order_items.order_id', count(*) FILTER (WHERE order_id IS NULL) FROM olist.order_items
UNION ALL SELECT 'order_items.product_id', count(*) FILTER (WHERE product_id IS NULL) FROM olist.order_items
UNION ALL SELECT 'order_items.seller_id', count(*) FILTER (WHERE seller_id IS NULL) FROM olist.order_items
UNION ALL SELECT 'products.product_id', count(*) FILTER (WHERE product_id IS NULL) FROM olist.products
UNION ALL SELECT 'sellers.seller_id', count(*) FILTER (WHERE seller_id IS NULL) FROM olist.sellers
UNION ALL SELECT 'order_payments.order_id', count(*) FILTER (WHERE order_id IS NULL) FROM olist.order_payments
UNION ALL SELECT 'order_reviews.order_id', count(*) FILTER (WHERE order_id IS NULL) FROM olist.order_reviews;

\echo '=== 3. Orphan checks ==='
SELECT count(*) AS orphan_items_orders
FROM olist.order_items oi
LEFT JOIN olist.orders o ON o.order_id = oi.order_id
WHERE o.order_id IS NULL;

SELECT count(*) AS orphan_items_products
FROM olist.order_items oi
LEFT JOIN olist.products p ON p.product_id = oi.product_id
WHERE p.product_id IS NULL;

SELECT count(*) AS orphan_items_sellers
FROM olist.order_items oi
LEFT JOIN olist.sellers s ON s.seller_id = oi.seller_id
WHERE s.seller_id IS NULL;

SELECT count(*) AS orphan_orders_customers
FROM olist.orders o
LEFT JOIN olist.customers c ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

SELECT count(*) AS orphan_payments_orders
FROM olist.order_payments op
LEFT JOIN olist.orders o ON o.order_id = op.order_id
WHERE o.order_id IS NULL;

SELECT count(*) AS orphan_reviews_orders
FROM olist.order_reviews r
LEFT JOIN olist.orders o ON o.order_id = r.order_id
WHERE o.order_id IS NULL;

\echo '=== 4. ANALYZE ==='
ANALYZE;
\echo 'ANALYZE done.'
