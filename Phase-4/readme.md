
# Inventory Management System - Phase 4 SQL Queries

This document provides an overview of the SQL queries developed for Phase 4 of the Inventory Management System. The queries include advanced SQL features such as views, Common Table Expressions (CTEs), stored procedures, window functions, Transaction Control Language (TCL), Data Control Language (DCL), and triggers.

## Overview

### Tables Covered

The queries cover operations on the following tables:

- **Products**: Operations include creating views for available products, using CTEs to count products by category, and implementing triggers to update stock after orders.
- **Suppliers**: Queries involve creating views for active suppliers, using CTEs to count products supplied by each supplier, and implementing triggers to log supplier status changes.
- **Categories**: Operations include creating views for categories with product counts, using CTEs to calculate average product prices by category, and implementing triggers to update category descriptions.
- **Orders**: Queries involve creating views for pending orders, using CTEs to calculate total amounts spent by customers, and implementing triggers to log order status changes.
- **Order Items**: Operations include creating views for order item details, using CTEs to calculate total quantities ordered, and implementing triggers to update order total amounts.
- **Customers**: Queries involve creating views for customer order summaries, using CTEs to calculate total amounts spent by customers, and implementing triggers to log customer email changes.
- **Payments**: Operations include creating views for completed payments, using CTEs to calculate total amounts paid by payment method, and implementing triggers to update order payment status.
- **Shipments**: Queries involve creating views for shipped orders, using CTEs to count shipments by status, and implementing triggers to log shipment status changes.
- **Product Reviews**: Operations include creating views for product reviews with ratings, using CTEs to calculate average ratings, and implementing triggers to update product average ratings.
- **Inventory Transactions**: Queries involve creating views for stock additions, using CTEs to calculate net quantities, and implementing triggers to update product stock.
- **Returns**: Operations include creating views for approved returns, using CTEs to calculate total quantities returned, and implementing triggers to log return status changes.
- **Discounts**: Queries involve creating views for active discounts, using CTEs to calculate total discount values, and implementing triggers to update product prices after discount expiration.
- **Warehouses**: Operations include creating views for warehouses with available capacity, using CTEs to calculate total capacity and stock, and implementing triggers to log warehouse capacity changes.
- **Employee Details**: Queries involve creating views for active employees, using CTEs to find employees with above-average salaries, and implementing triggers to log salary changes.
- **Users**: Operations include creating views for admin users, using CTEs to find recently created users, and implementing triggers to log user role changes.
- **Audit Logs**: Queries involve creating views for recent audit logs, using CTEs to filter logs by table, and implementing triggers to prevent deletion of audit logs.
- **Taxes**: Operations include creating views for active taxes, using CTEs to filter taxes by country, and implementing triggers to log tax rate changes.
- **Product Images**: Queries involve creating views for primary images, using CTEs to filter images by product, and implementing triggers to prevent deletion of primary images.
- **Shipping Methods**: Operations include creating views for active shipping methods, using CTEs to filter methods by price range, and implementing triggers to log shipping method changes.
- **Promotions**: Queries involve creating views for active promotions, using CTEs to filter promotions by category, and implementing triggers to prevent deletion of active promotions.
- **Support Tickets**: Operations include creating views for open tickets, using CTEs to filter tickets by priority, and implementing triggers to log ticket status changes.
- **Feedback**: Queries involve creating views for high-rated feedback, using CTEs to filter feedback by customer, and implementing triggers to prevent deletion of feedback.
- **Activity Log**: Operations include creating views for failed login attempts, using CTEs to filter logs by user, and implementing triggers to prevent deletion of activity logs.
- **User Roles**: Queries involve creating views for active roles, using CTEs to filter roles by assigned user, and implementing triggers to log role status changes.
- **Brands**: Operations include creating views for active brands, using CTEs to filter brands by country, and implementing triggers to log brand status changes.

### Key Features

- **Views**: Simplify complex queries by creating reusable views for common data selections.
- **CTEs**: Use Common Table Expressions to break down complex queries into simpler parts.
- **Stored Procedures**: Encapsulate business logic in reusable procedures.
- **Window Functions**: Perform calculations across sets of rows related to the current row.
- **TCL**: Manage transactions with `START TRANSACTION`, `COMMIT`, and `ROLLBACK`.
- **DCL**: Control access to database objects with `GRANT` and `REVOKE`.
- **Triggers**: Automate actions such as logging changes or enforcing business rules.

### Usage

To use these queries, execute them in your SQL environment against the corresponding database tables. Ensure that the table names and column names match your database schema.

### Notes

- The queries are modular and can be adapted to different database schemas.
- Ensure that necessary indexes are in place for optimal performance, especially for large datasets.
- Some queries involve advanced SQL features, which may require specific database support.

---

This README provides a concise overview of the SQL queries developed for Phase 4. For more detailed information, refer to the individual query comments in the SQL file.
