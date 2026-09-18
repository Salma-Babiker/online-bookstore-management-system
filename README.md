# Online Bookstore Management System

Project Overview

The Online Bookstore Management System is a relational database solution designed to manage books, authors, categories, customers, orders, payments, inventory, and sales activities.

The project demonstrates how SQL can be used to design a structured database, automate business processes, manage inventory, process orders and payments, generate reports, and control user access through role-based permissions.

Business Problem

An online bookstore needs an organized system to manage:

* Book and author information
* Book categories
* Customer information
* Orders and order details
* Payments
* Inventory levels
* Sales and revenue
* User access and permissions

This database provides a centralized solution for managing these operations using MySQL.

Database Architecture

The database contains the following main tables:

* books
* authors
* categories
* customers
* orders
* order_details
* payments

Primary keys and foreign keys are used to maintain relationships and data integrity between the tables.

Main Relationships

* Authors → Books
* Categories → Books
* Customers → Orders
* Orders → Order Details
* Books → Order Details
* Orders → Payments

The database follows a normalized relational structure to reduce data duplication and improve data consistency.

Views

Several SQL views were created to simplify reporting and data analysis.

Book Catalog

vw_book_catalog

Provides a searchable book catalog including:

* Book title
* ISBN
* Price
* Stock quantity
* Publication year
* Author
* Category

Customer Order Summary

vw_customer_order_summary

Provides customer-level order information, including:

* Customer name
* Email
* Total orders
* Total amount spent
* Last order date

Order Details Full

vw_order_details_full

Combines customer, order, book, and payment-related information to provide detailed order-level information.

Low Stock Alert

vw_low_stock_alert

Identifies books with inventory levels below the defined threshold.

Revenue by Category

vw_revenue_by_category

Aggregates sales information by category, including:

* Number of orders
* Total units sold
* Total revenue

Stored Procedures

The database includes stored procedures to automate common business operations.

Place Order

sp_place_order

The procedure:

1. Validates available inventory.
2. Calculates the order total.
3. Creates the order.
4. Creates the order detail.
5. Decreases the book inventory.
6. Completes the transaction.

Update Order Status

sp_update_order_status

Updates the status of an order, such as:

* Pending
* Processing
* Shipped
* Delivered
* Cancelled

Process Payment

sp_process_payment

Validates the payment amount, records the payment, and updates the related order status.

Get Customer Report

sp_get_customer_report

Generates customer information and order history, including total orders and total spending.

SQL Functions

Several user-defined functions were created to support business calculations and reporting.

Calculate Order Total

fn_calculate_order_total

Recalculates an order total based on its order details.

Get Customer Full Name

fn_get_customer_full_name

Returns a customer’s full name using the customer ID.

Apply Discount

fn_apply_discount

Calculates a discounted price based on a specified discount percentage.

Days Since Order

fn_days_since_order

Calculates the number of days since an order was placed.

These functions demonstrate the use of SQL business logic and reusable calculations.

Events & Automation

MySQL scheduled events were implemented to automate recurring database tasks.

Cancel Stale Pending Orders

evt_cancel_stale_pending_orders

Automatically identifies old pending orders, checks payment status, restores inventory when applicable, and updates the order status.

Daily Sales Snapshot

evt_daily_sales_snapshot

Creates a daily summary of:

* Total orders
* Total revenue

The results are stored in a supporting table for historical reporting.

Weekly Low Stock Flag

evt_weekly_low_stock_flag

Automatically identifies books with low inventory and records them in a supporting table for monitoring.

Security & Role-Based Access Control

The database includes role-based permissions to control access to the system.

Admin Role

The Admin role provides broad database access for managing the bookstore system.

Seller Role

The Seller role provides access to operational data and selected stored procedures needed to manage bookstore activities.

Customer Role

The Customer role provides limited access to bookstore information and selected database operations.

MySQL GRANT, CREATE USER, and role permissions are used to demonstrate database security and access control.

Data Integrity

The database uses several SQL constraints to maintain data quality, including:

* Primary Keys
* Foreign Keys
* NOT NULL
* UNIQUE
* CHECK
* DEFAULT
* ENUM

Foreign key actions such as CASCADE, RESTRICT, and SET NULL are also used where appropriate.

SQL Skills Demonstrated

This project demonstrates practical experience with:

* MySQL
* Database Design
* Relational Database Modeling
* Primary & Foreign Keys
* Data Integrity Constraints
* SQL Joins
* Views
* Stored Procedures
* User-Defined Functions
* Transactions
* Inventory Management
* Payment Processing
* Scheduled Events
* Automation
* Role-Based Access Control
* GRANT Permissions
* SQL Reporting
* Business Logic

Project Files

* online_bookstore.sql — Complete MySQL database script
* Database tables and relationships
* Views
* Stored procedures
* User-defined functions
* Scheduled events
* Roles and permissions
* Sample data and SQL queries

Conclusion

The Online Bookstore Management System demonstrates an end-to-end SQL database solution for managing an online bookstore.

The project combines database design, business logic, automation, reporting, inventory management, payment processing, and security into one relational database system.
