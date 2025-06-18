# 👥 Customer Segmentation & Behavior Analysis using SQL

This project analyzes customer transaction behavior to segment customers into categories such as **VIP**, **Regular**, or **New**, based on their purchase patterns and relationship lifespan with the business.

---

## 🎯 Objective

To profile and segment customers using transactional sales and demographic data, enabling targeted marketing and retention strategies.

---

## 🗃️ Data Sources

This project uses two tables from a sales data warehouse (star schema):

- **`gold.fact_sales`**
  - Contains transactional data: `order_number`, `order_date`, `product_key`, `customer_key`, `sales_amount`, `quantity`

- **`gold.dim_customers`**
  - Contains customer demographics: `customer_key`, `customer_number`, `first_name`, `_
