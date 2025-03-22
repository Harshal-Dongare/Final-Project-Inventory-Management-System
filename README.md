# Inventory-Management-System

<p align="center">
  <img src="https://www.scnsoft.com/software-development-services/creating-inventory-management-system/creating-an-inventory-system_cover-upd.svg" width="800"/>
</p>
An SQL-based Inventory Management System project designed to efficiently track, manage, and organize product inventory, suppliers, orders, customers, and transactions with detailed database schema and sample data.

## Overview
This project is an SQL-based Inventory Management System designed to efficiently track, manage, and organize product inventory, suppliers, orders, customers, and transactions. It includes a detailed database schema with sample data to simulate real-world inventory management operations.

## Features
- **Product Management**: Track product details, stock levels, and pricing.
- **Supplier Management**: Manage supplier information and procurement sources.
- **Order Management**: Handle customer orders, order status, and payment details.
- **Customer Management**: Store customer information and order history.
- **Inventory Transactions**: Track stock additions, removals, and updates.
- **Returns & Refunds**: Manage product returns and refunds.
- **Discounts & Promotions**: Apply discounts and promotional offers to products.
- **Warehouse Management**: Track warehouse locations, capacity, and stock levels.
- **Employee Management**: Manage employee details and roles.
- **User Roles & Permissions**: Define user roles and access levels.
- **Audit Logs**: Track changes and actions performed in the system.

## Database Schema
The database consists of 25 tables, including:
- **Products**: Stores product details.
- **Suppliers**: Manages supplier information.
- **Orders**: Tracks customer orders.
- **Customers**: Stores customer data.
- **Inventory Transactions**: Logs stock changes.
- **Returns**: Manages product returns.
- **Discounts**: Applies discounts to products.
- **Warehouses**: Tracks warehouse details.
- **Employees**: Manages employee information.
- **Users**: Handles user authentication and roles.
- **Audit Logs**: Records system activities.

## Setup
1. **Database Creation**: Run the SQL script to create the `INVENTORYDB` database and all necessary tables.
2. **Sample Data**: Insert sample data provided in the script to populate the database.
3. **Foreign Keys**: Ensure all foreign key constraints are properly set up to maintain data integrity.

## Usage
- Use the provided SQL queries to interact with the database.
- Perform CRUD operations (Create, Read, Update, Delete) on various tables.
- Generate reports and insights using SQL queries.

## Example Queries
### View All Products:
```sql
SELECT * FROM products;
```
### View Orders by Customer:
```sql
SELECT * FROM orders WHERE customer_id = 1;
```
### Check Inventory Levels:
```sql
SELECT product_name, quantity_in_stock 
FROM products 
WHERE quantity_in_stock < reorder_level;
```

## Contributing
Feel free to contribute to this project by submitting pull requests or opening issues for bugs and feature requests.

## License
This project is open-source and available under the MIT License.

