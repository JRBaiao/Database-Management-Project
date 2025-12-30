# Brazilian E-commerce Database Management System

A comprehensive database design and analysis project for a Brazilian e-commerce platform, implementing relational database principles and business intelligence queries using MySQL.

## 📋 Project Overview

This project demonstrates the design, implementation, and analysis of an e-commerce database system based on real-world Brazilian marketplace data. The database structure supports order management, product cataloging, customer tracking, and business analytics.

## 🗄️ Database Schema

### Entity Relationship Design

The database consists of four core tables with established relationships:

#### **olist_customers**
Stores customer information and geographic data.
- `customer_id` (PK): Unique customer identifier
- `customer_unique_id`: Persistent customer identifier across orders
- `customer_zip_code_prefix`: ZIP code prefix
- `customer_city`: Customer city
- `customer_state`: Two-letter state code

#### **product_category_name_translation**
Provides English translations for Portuguese product categories.
- `product_category_name` (PK): Original category name
- `product_category_name_english`: English translation

#### **olist_products**
Contains detailed product specifications and attributes.
- `product_id` (PK): Unique product identifier
- `product_category_name` (FK): Product category
- `product_name_lenght`: Length of product name
- `product_description_lenght`: Length of product description
- `product_photos_qty`: Number of product photos
- `product_weight_g`: Product weight in grams
- `product_length_cm`: Product length
- `product_height_cm`: Product height
- `product_width_cm`: Product width

#### **olist_order_items**
Tracks individual items within orders and their pricing.
- `order_id` (PK, composite): Order identifier
- `order_item_id` (PK, composite): Item sequence within order
- `product_id` (FK): Product reference
- `seller_id`: Seller identifier
- `shipping_limit_date`: Shipping deadline
- `price`: Item price
- `freight_value`: Shipping cost

### Relationships

```
product_category_name_translation (1) ──→ (N) olist_products
olist_products (1) ──→ (N) olist_order_items
```

## 🚀 Key Features

### 1. **Referential Integrity**
- Foreign key constraints ensure data consistency
- Cascading relationships between products, categories, and orders

### 2. **Strategic Indexing**
Optimized indexes for common query patterns:
- Product lookups by ID
- Category-based filtering
- Price range queries
- Geographic customer distribution
- Composite index for weight and category analysis

### 3. **Comprehensive Analytics**
Pre-built analytical queries covering:
- Revenue analysis by category
- Demand forecasting (best-selling products)
- Market reach (customer distribution)
- Operational efficiency (freight cost analysis)
- Pricing strategies (category-based pricing)

## 📊 Analysis Capabilities

### Business Performance Metrics
- **Total revenue by product category**: Identifies top-performing segments
- **Average order item price per category**: Reveals pricing patterns
- **Freight cost impact analysis**: Operational cost insights

### Demand Analysis
- **Top 10 best-selling products**: Inventory planning
- **Units sold tracking**: Demand forecasting
- **Product catalog distribution**: Portfolio analysis

### Market Intelligence
- **Customer distribution by state**: Geographic market penetration
- **Product size vs. price correlation**: Pricing optimization opportunities

## 💻 Getting Started

### Prerequisites
- MySQL Server 8.0 or higher
- MySQL Workbench (optional, for GUI management)

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/brazil-ecommerce-db.git
cd brazil-ecommerce-db
```

2. **Create the database and tables**
```bash
mysql -u your_username -p < "Table Creation - DBM (Final Paper).sql"
```

3. **Load your data** (if you have CSV files)
```sql
LOAD DATA INFILE 'path/to/customers.csv' 
INTO TABLE olist_customers 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;
```

4. **Run analysis queries**
```bash
mysql -u your_username -p Brazil_Ecommerce_DB < "Analysis - DBM (Final Paper).sql"
```

## 📈 Sample Queries

### Find Top Revenue-Generating Categories
```sql
SELECT t.product_category_name_english AS category, 
       SUM(oi.price) AS total_revenue
FROM olist_order_items oi
JOIN olist_products p ON oi.product_id = p.product_id
JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY t.product_category_name_english
ORDER BY total_revenue DESC;
```

### Analyze Customer Geographic Distribution
```sql
SELECT customer_state, 
       COUNT(customer_id) AS total_customers
FROM olist_customers
GROUP BY customer_state
ORDER BY total_customers DESC;
```

## 🛠️ Database Optimization

### Indexing Strategy
- **Single-column indexes**: Fast lookups on frequently queried fields
- **Composite indexes**: Optimized for multi-field queries (category + weight)
- **Unique indexes**: Enforce data integrity on natural keys

### Performance Considerations
- Indexed foreign keys for efficient joins
- Strategic use of DECIMAL for monetary values
- Appropriate data types to minimize storage

## 📁 Project Structure

```
brazil-ecommerce-db/
├── Table Creation - DBM (Final Paper).sql    # Schema definition
├── Analysis - DBM (Final Paper).sql          # Analytical queries
├── README.md                                 # Project documentation
└── data/                                     # (Optional) Sample datasets
```

## 🎯 Use Cases

This database design supports:
- **E-commerce Platform Management**: Order processing and inventory tracking
- **Business Intelligence**: Revenue analysis and performance metrics
- **Market Research**: Customer behavior and geographic analysis
- **Supply Chain Optimization**: Freight cost analysis and logistics planning
- **Product Strategy**: Category performance and pricing optimization

## 🔮 Future Enhancements

Potential extensions to consider:
- [ ] Add `olist_orders` table for order-level attributes (status, timestamps)
- [ ] Implement `olist_order_reviews` for customer satisfaction analysis
- [ ] Include `olist_geolocation` for detailed geographic analytics
- [ ] Add temporal indexes for time-series analysis
- [ ] Create views for frequently accessed analytics
- [ ] Implement stored procedures for complex business logic
- [ ] Add triggers for automated data validation

## 📝 License

This project is available under the MIT License. See LICENSE file for details.

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the issues page.

## 👤 Author
- GitHub: JRBaiao (https://github.com/JRBaiao)
- LinkedIn: João Rafael A. Baião ([https://linkedin.com/in/yourprofile](https://www.linkedin.com/in/jo%C3%A3o-rafael-a-bai%C3%A3o-466b16283/))

## 🙏 Acknowledgments

- Dataset inspired by the Olist Brazilian E-commerce Public Dataset
- Database design principles from modern e-commerce architecture patterns

---

⭐ If you found this project helpful, please consider giving it a star!
