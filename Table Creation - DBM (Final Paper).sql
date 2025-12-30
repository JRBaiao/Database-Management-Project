CREATE DATABASE Brazil_Ecommerce_DB;
USE Brazil_Ecommerce_DB

# Table Creation
CREATE TABLE olist_customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    customer_unique_id VARCHAR(50) NOT NULL,
    customer_zip_code_prefix INT NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    customer_state CHAR(2) NOT NULL
);

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR(100) PRIMARY KEY,
    product_category_name_english VARCHAR(100) NOT NULL
);

CREATE TABLE olist_products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(100),
    product_name_lenght FLOAT,
    product_description_lenght FLOAT,
    product_photos_qty FLOAT,
    product_weight_g FLOAT,
    product_length_cm FLOAT,
    product_height_cm FLOAT,
    product_width_cm FLOAT,
    CONSTRAINT fk_product_category
        FOREIGN KEY (product_category_name)
        REFERENCES product_category_name_translation(product_category_name)
);

CREATE TABLE olist_geolocation (
    geolocation_zip_code_prefix INT NOT NULL,
    geolocation_lat DECIMAL(10, 6) NOT NULL,
    geolocation_lng DECIMAL(10, 6) NOT NULL,
    geolocation_city VARCHAR(100) NOT NULL,
    geolocation_state CHAR(2) NOT NULL,
    INDEX idx_geo_zip (geolocation_zip_code_prefix)
);
DROP TABLE olist_geolocation;

CREATE TABLE olist_order_items (
    order_id VARCHAR(50) NOT NULL,
    order_item_id INT NOT NULL,
    product_id VARCHAR(50) NOT NULL,
    seller_id VARCHAR(50) NOT NULL,
    shipping_limit_date DATETIME NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    freight_value DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, order_item_id),
    CONSTRAINT fk_order_items_product
        FOREIGN KEY (product_id)
        REFERENCES olist_products(product_id)
);

CREATE TABLE olist_order_reviews (
    review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50) NOT NULL,
    review_score INT NOT NULL,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date DATETIME NOT NULL,
    review_answer_timestamp DATETIME
);
DROP TABLE olist_order_reviews;

-- Indexing tables.
CREATE INDEX idx_order_items_product_id
ON olist_order_items (product_id);

CREATE INDEX idx_products_category
ON olist_products (product_category_name);

CREATE INDEX idx_order_items_product_price
ON olist_order_items (product_id, price);

CREATE INDEX idx_customers_state
ON olist_customers (customer_state);

CREATE UNIQUE INDEX idx_category_translation_pk
ON product_category_name_translation (product_category_name);

CREATE INDEX idx_products_weight_category # Composite Index
ON olist_products (product_category_name, product_weight_g);