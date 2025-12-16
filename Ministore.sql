create database MiniStoreDB;
use MiniStoreDB;

create table customers (
customers_id varchar(10) primary key,
Name varchar(255) not null ,
Email varchar(255),
city varchar(100),
Registration_data date,
age int check (age > 0 and age < 120),
total_spent decimal(10,2) check (total_spent >=0)
);

create table products(
product_id varchar(10) primary key,
product_Name varchar(255) not null,
Category varchar(100),
Supplier varchar(100),
Price decimal(10,2) check (price > 0),
Quantity_in_stock int check (Quantity_in_stock >=0 ),
Reorder_level int,
Rating decimal(3,1) check (rating >=0 and rating <=5)
);

create table orders(
order_id varchar(10) primary key,
customer_id varchar(10) not null,
order_date date,
payment_mode ENUM('Cash','Credit','Installment'),
employee_id varchar(10),
total_amount decimal(10,2) check (total_amount >=0),
discount decimal(10,2) check (discount >=0),
FOREIGN kEY (customer_id) REFERENCES customers(customers_id)
  on update cascade on delete cascade
);  

CREATE TABLE order_items (
    Order_Item_ID VARCHAR(10) PRIMARY KEY,
    Order_ID VARCHAR(10) NOT NULL,
    Product_ID VARCHAR(10) NOT NULL,
    Quantity INT CHECK (Quantity > 0),
    Unit_Price DECIMAL(10,2) CHECK (Unit_Price > 0),
    Total_Price DECIMAL(10,2) CHECK (Total_Price > 0),
    FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

select * from customers;
select * from order_items;
select * from orders;
select * from products;

#Level 1 – Basics & Filtering

-- 1.List all customers who have spent more than 10,000.
 select * from customers
 where total_spent >10000;
 
 -- 2.Retrieve all products in the “Furniture” category.
 select * from products
 where category ="Furniture";
 
 
 -- 3.Show all orders placed in 2025.
 select * from orders
 where Year(order_date) = 2025;
 
 -- 4.Find products with a rating greater than 4.
 select * from products
 where rating > 4;
 
 #Level 2 – Aggregation & Grouping
 
 -- 5 Calculate total revenue per product.
 
select product_id,SUM(total_amount) as total_revenue
from orders
group by product_id;

# THIS QUERY IS NOT POSSIBLE USING AGGREGATION AS PRODUCTS HAVE NO TOTAL_AMOUNT IN THE 
#TABLE SO ,THE  AGGREGATION IN ONLY DONE ON TABLE WITH MEASURES , WE CAN PERFORM THIS THROUGH 
# JOINS

SELECT p.product_id,SUM(oi.total_price) as total_revenue
from products p
join order_items oi
on p.product_id=oi.product_id
group by p.product_id;

-- 6.Find the number of orders per customer.

select  customer_id ,count(order_id) as total_orders
from orders
group by customer_id;

-- 7.Find the highest-spending customer.
select customer_id ,SUM(total_amount) as total_spent
from orders
group by customer_id 
order by total_spent desc
limit 1;

-- 8.Find average quantity sold per product.
select product_id,avg(Quantity) as quantity_sold
from order_items
group by product_id;

# Joins
-- 9.Show order details including customer name, product name, and quantity.
select o.order_id,c.name as customer_name,p.product_name,oi.quantity
from orders o
join customers c
on o.customer_id =c.customers_id
join order_items oi
on o.order_id = oi.order_id
join products p
on oi.product_id =p.product_id;

-- 10.Find total revenue per customer using JOIN.
select c.customers_id,c.name,sum(o.total_amount) as total_revenue 
from customers c
join orders o
on o.customer_id =c.customers_id
group by c.customers_id,c.name;

-- 11.List products never ordered.
select p.product_id,p.product_Name
from products p
left join order_items oi
on p.product_id = oi.product_id
where oi.product_id is null;

-- 12.Find customers who ordered products from "DellStore".
select distinct c.customers_id,c.name
from customers c
join orders o
on c.customers_id =o.customer_id
join order_items oi
on o.order_id =oi.order_id
join products p
on oi.product_id =p.product_id
where p.Supplier="DellStore";

-- Level 4 – WHERE, HAVING & CASE
-- List orders with total amount > 5000
select * from orders
where total_amount > 5000;

-- Show total revenue per product category having revenue > 10,000
select p.Category, sum(oi.Total_Price) as total_revenue
from products p
join order_items oi
on p.product_id =oi.product_ID
group by p.category 
having sum(oi.Total_price) > 10000;

-- Categorize customers as High Spender (>10000) or Low Spender

select c.customers_id,c.name,sum(o.total_amount) as total_spent,
case
when sum(o.total_amount) > 10000 then "high spender"
else "low spender"
end as spender_category 
from customers c
join orders o
on c.customers_id =o.customer_id
group by c.customers_id ,c.Name;

#Advanced Joins & Sorting
-- Rank products by total quantity sold
select p.product_id,p.product_name,sum(oi.quantity) as total_quantity_sold
from products p
join order_items oi
on p.product_id = oi.product_ID
group by p.product_id ,p.product_name
order by total_quantity_sold desc;

-- List top 5 customers based on total spending
select c.customers_id,c.Name,sum(o.total_amount) as total_spent
from customers c
join orders o
on c.customers_id =o.customer_id
group by c.customers_id,c.Name
order by total_spent desc
limit 5;

-- Find the most popular category (highest quantity sold)
select p.category,sum(oi.quantity) as total_quantity_sold
from products p
join order_items oi
on p.product_id =oi.product_ID
group by p.category
order by total_quantity_sold desc
limit 1;

-- Identify products below reorder level
select product_id,product_name,Quantity_in_stock,Reorder_level
from products
where Quantity_in_stock < Reorder_level;

-- Find employees who handled the most orders
select employee_id,count(order_id) as total_orders_handled
from orders
group by employee_id
order by total_orders_handled desc
limit 1;












