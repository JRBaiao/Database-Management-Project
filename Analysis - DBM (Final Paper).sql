USE Brazil_Ecommerce_DB

# Indexig Queries (to provide a quick overview).
-- 1. 
SELECT product_id, COUNT(*) AS units_sold
FROM olist_order_items
GROUP BY product_id
ORDER BY units_sold DESC
LIMIT 10;

-- 2. 
SELECT t.product_category_name_english, COUNT(p.product_id) AS total_products
FROM olist_products p
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english;

-- 3. 
SELECT p.product_id, SUM(oi.price) AS total_revenue
FROM olist_order_items oi
JOIN olist_products p ON oi.product_id = p.product_id
GROUP BY p.product_id;

-- 4. 
SELECT customer_state, COUNT(*) AS total_customers
FROM olist_customers
GROUP BY customer_state;

-- 5. 
SELECT t.product_category_name_english, SUM(oi.price) AS total_revenue
FROM olist_order_items oi
JOIN olist_products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english;

-- 6. 
SELECT t.product_category_name_english,
AVG(p.product_weight_g) AS avg_weight
FROM olist_products p
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
WHERE p.product_weight_g IS NOT NULL
GROUP BY t.product_category_name_english;

# Deep Analysis (detalied overview)
-- 1. Total revenue by product category (Business Performance) 
SELECT t.product_category_name_english AS category, SUM(oi.price) AS total_revenue
FROM olist_order_items oi
JOIN olist_products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC;

-- 2. Average order item price olist_order_itemsper category
SELECT t.product_category_name_english AS category,
AVG(oi.price) AS avg_item_price
FROM olist_order_items oi
JOIN olist_products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY avg_item_price DESC;

-- 3. Number of Products per Category (Catalog Analysis) 
SELECT t.product_category_name_english AS category, COUNT(p.product_id) AS total_products
FROM olist_products p
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_products DESC;

-- 4. Top 10 best-selling products (demand analysis)
SELECT oi.product_id, COUNT(*) AS units_sold, SUM(oi.price) AS total_sales
FROM olist_order_items oi
GROUP BY oi.product_id
ORDER BY units_sold DESC
LIMIT 10;

-- 5. Customer Distribution by State (Market Reach)
SELECT customer_state, COUNT(customer_id) AS total_customers
FROM olist_customers
GROUP BY customer_state
ORDER BY total_customers DESC;

-- 6. Product size vs Price (operational insight)
SELECT p.product_weight_g, oi.price
FROM olist_products p
JOIN olist_order_items oi ON p.product_id = oi.product_id
WHERE p.product_weight_g IS NOT NULL;

-- 7. Categories with the highest freight cost impact
SELECT t.product_category_name_english AS category, AVG(oi.freight_value) AS avg_freight_cost
FROM olist_order_items oi
JOIN olist_products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY avg_freight_cost DESC;
