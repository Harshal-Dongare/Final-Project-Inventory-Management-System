# Inventory Management System - Phase 3 SQL Queries

This document provides an overview of the SQL queries developed for Phase 3 of the Inventory Management System. The queries are designed to perform various operations on the database tables, including arithmetic calculations, joins, subqueries, string manipulations, aggregate functions, and bitwise operations.

## Overview

### Tables Covered

The queries cover operations on the following tables:

- **Products**: Operations include calculating total stock value, retrieving product details with categories, finding high-priced products, and applying discounts.
- **Suppliers**: Queries involve calculating phone number lengths, retrieving supplier details with products, and counting suppliers by country.
- **Categories**: Operations include calculating description lengths, retrieving category details with product counts, and finding popular categories.
- **Orders**: Queries involve calculating discounted amounts, retrieving order details with customer information, and finding high-value orders.
- **Order Items**: Operations include calculating total prices, retrieving order item details with product information, and finding high-priced items.
- **Customers**: Queries involve calculating email lengths, retrieving customer details with orders, and counting customers by city.
- **Payments**: Operations include calculating total payment amounts with tax, retrieving payment details with order information, and finding high-value payments.
- **Shipments**: Queries involve calculating delivery times, retrieving shipment details with order information, and finding delayed shipments.
- **Product Reviews**: Operations include calculating average ratings, retrieving review details with product information, and finding highly-rated products.
- **Inventory Transactions**: Queries involve calculating total quantities, retrieving transaction details with product information, and finding high-quantity transactions.
- **Returns**: Operations include calculating total returned quantities, retrieving return details with product and customer information, and finding high-quantity returns.
- **Employee Details**: Queries involve calculating total salary costs, retrieving employee details with warehouse information, and finding high-salary employees.
- **Users**: Operations include calculating user creation counts, retrieving user details with roles, and finding inactive users.
- **Audit Logs**: Queries involve calculating action counts, retrieving audit logs with user details, and finding recent log entries.
- **Taxes**: Operations include calculating total tax revenue, retrieving tax details with product information, and finding high-tax rates.
- **Product Images**: Queries involve calculating image counts, retrieving image details with product information, and finding products with multiple images.
- **Shipping Methods**: Operations include calculating total shipping costs, retrieving shipping methods with order details, and finding expensive methods.
- **Promotions**: Queries involve calculating total discounts, retrieving promotions with product categories, and finding high-discount promotions.
- **Support Tickets**: Operations include calculating average priority levels, retrieving ticket details with customer information, and finding recent tickets.
- **Feedback**: Queries involve calculating average ratings, retrieving feedback with customer details, and finding high-rated feedback.
- **Activity Log**: Operations include calculating activity counts, retrieving activity logs with user details, and finding recent activities.
- **User Roles**: Queries involve calculating role counts, retrieving role details with user information, and finding recently assigned roles.
- **Brands**: Operations include calculating total revenue, retrieving brand details with product information, and finding high-revenue brands.
- **Discounts**: Queries involve calculating discounted prices, retrieving discount details with product information, and finding active discounts.
- **Warehouses**: Operations include calculating capacity usage, retrieving warehouse details with product information, and finding high-stock warehouses.

### Key Features

- **Arithmetic Calculations**: Queries perform calculations such as total stock value, discounted prices, and tax amounts.
- **Joins**: Retrieve related data from multiple tables, such as product details with categories or order details with customer information.
- **Subqueries**: Find records based on conditions like above-average prices or quantities.
- **String Functions**: Manipulate and extract parts of strings, such as extracting domains from emails or concatenating names.
- **Aggregate Functions**: Perform operations like counting, summing, and averaging across records.
- **Bitwise Operations**: Check specific bits in IDs for filtering or categorization.

### Usage

To use these queries, execute them in your SQL environment against the corresponding database tables. Ensure that the table names and column names match your database schema.

### Notes

- The queries are modular and can be adapted to different database schemas.
- Ensure that necessary indexes are in place for optimal performance, especially for large datasets.
- Some queries involve bitwise operations, which may require specific database support.

---

This README provides a concise overview of the SQL queries developed for Phase 3. For more detailed information, refer to the individual query comments in the SQL file.
