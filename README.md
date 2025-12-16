Mini Store Management System (SQL Project)
**Project Overview**

The Mini Store Management System is a relational database project built using MySQL to manage customers, products, orders, and sales transactions.
This project demonstrates real-world SQL querying, joins, aggregations, filtering, and business insights generation using a structured retail dataset.

**Objectives**

Design a normalized relational database for a retail store

Analyze customer spending and purchasing behavior

Track product performance and inventory status

Generate business insights using SQL queries

Practice beginner to advanced SQL concepts in a real scenario

 **Database Schema**

The database consists of four core tables:

**Customers**

Stores customer personal and spending details

Tracks registration date and total spending

 **Products**

Stores product details such as category, supplier, price, rating

Manages inventory and reorder levels

 **Orders**

Captures customer orders and payment information

Linked to customers using foreign keys

 **Order_Items**

Line-item level details for each order

Connects products with orders

Enables accurate revenue and quantity calculations

 **Relationships**

One customer → many orders

One order → many order items

One product → many order items

Foreign key constraints are enforced with CASCADE rules to maintain referential integrity.

**SQL Concepts Used**

CREATE DATABASE, CREATE TABLE

Primary Keys & Foreign Keys

SELECT, WHERE

JOIN (INNER, LEFT)

GROUP BY, HAVING

Aggregate functions (SUM, COUNT, AVG)

CASE statements

Sorting & ranking (ORDER BY, LIMIT)

Data validation using CHECK constraints

 **Analysis Levels Covered**
 
 **Level 1 – Basics & Filtering**

Customers spending above a threshold

Products by category

Orders by year

High-rated products

 **Level 2 – Aggregation & Grouping**

Total revenue per product

Orders per customer

Highest spending customer

Average quantity sold

 **Level 3 – Joins**

Order details with customer & product information

Revenue per customer

Products never ordered

Supplier-specific customer analysis

**Level 4 – WHERE, HAVING & CASE**

High-value orders

Revenue by product category

Customer segmentation (High vs Low spenders)

**Advanced Analysis**

Product ranking by quantity sold

Top customers by spending

Most popular product category

Inventory below reorder level

Employee performance analysis

 **Key Insights Generated**

Identified top-spending customers driving major revenue

Determined best-selling products and categories

Detected products requiring restocking

Classified customers based on spending behavior

Found employees handling maximum orders

 **Tools & Technologies**

Database: MySQL

IDE: MySQL Workbench

Language: SQL

**Learning Outcomes**

Strong understanding of relational database design

Hands-on experience with complex SQL joins

Ability to translate business questions into SQL queries

Improved analytical thinking using structured data

**Future Enhancements**

Add triggers for automatic inventory updates

Create stored procedures for repeated queries

Integrate views for reporting

Connect database with Python for EDA and visualization
