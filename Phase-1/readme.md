# Inventory Management System - Phase 1

## Overview
This project is the first phase of an **Inventory Management System (IMS)** designed to manage and track products, suppliers, orders, customers, and other related entities. The system is built using **SQL** and includes a **comprehensive database schema** with multiple tables to handle various aspects of inventory management.

## Database Schema
The database schema consists of the following tables:

- **PRODUCTS**: Stores details of each product in the inventory, including product ID, name, category, stock quantity, price, supplier, and status.
- **SUPPLIERS**: Contains information about suppliers, including contact details and status.
- **CATEGORIES**: Organizes products into different categories for easy classification.
- **ORDERS**: Tracks customer orders, including order date, total amount, status, and shipping address.
- **ORDER_ITEMS**: Links products to orders and captures details about the quantity and price for each product in an order.
- **CUSTOMERS**: Stores customer information, including name, email, phone, and addresses.
- **PAYMENTS**: Tracks payment details for orders, including payment method and status.
- **SHIPMENTS**: Manages shipping details for orders, including shipment status and tracking information.
- **PRODUCT_REVIEWS**: Stores customer reviews and ratings for products.
- **INVENTORY_TRANSACTIONS**: Tracks changes in inventory stock, such as additions or removals.
- **RETURNS**: Manages product returns from customers, including reasons and status.
- **DISCOUNTS**: Stores information about discounts or offers applied to products.
- **WAREHOUSES**: Contains details about warehouses, including location and capacity.
- **EMPLOYEE_DETAILS**: Stores employee information, including their role and the warehouse they work in.
- **USERS**: Manages user authentication and access information for both customers and admin personnel.
- **AUDIT_LOGS**: Records every action performed in the system for tracking and security purposes.
- **TAXES**: Stores tax information applied to orders or individual products.
- **PRODUCT_IMAGES**: Stores information about images associated with products.
- **SHIPPING_METHODS**: Stores the shipping methods available for orders.
- **PROMOTIONS**: Stores details about ongoing promotions, including discount percentages and eligible product categories.
- **SUPPORT_TICKETS**: Tracks customer issues or inquiries submitted for assistance or resolution.
- **FEEDBACK**: Collects and stores customer opinions or reviews about products or services.
- **ACTIVITY_LOG**: Tracks and records user actions or system activities for monitoring and auditing purposes.
- **USER_ROLES**: Defines and manages different roles or permissions assigned to users in the system.
- **BRANDS**: Stores information about different product brands, including their names and other relevant details.

## Summary of Phase 1
In this phase, the **foundational structure** of the Inventory Management System has been established. The database schema includes **25 tables** that cover all essential aspects of inventory management, from product and supplier details to customer orders, payments, and shipping. The schema is designed to be **scalable** and can be extended in future phases to include additional features and functionalities.

### Key Features:
- **Product Management**: Track product details, stock levels, and pricing.
- **Supplier Management**: Maintain supplier information and track procurement sources.
- **Order Management**: Manage customer orders, including order items, payments, and shipments.
- **Customer Management**: Store customer information and manage customer interactions.
- **Inventory Tracking**: Monitor inventory changes through transactions and returns.
- **Discounts and Promotions**: Apply discounts and promotions to products.
- **User Roles and Permissions**: Define user roles and control access levels.
- **Audit and Activity Logging**: Track system activities and changes for security and auditing purposes.

### Future Enhancements:
- Integration with external systems (e.g., payment gateways, shipping carriers).
- Advanced reporting and analytics for inventory and sales.
- Enhanced user interface for easier management and interaction.

## File Structure
- **ProjectPhase1_Harshal_Dongare_Inventory_Management_System.sql**: The SQL script containing the database schema and initial data.

## How to Use
1. **Database Creation**: Run the SQL script to create the `inventorydb` database and all associated tables.
2. **Data Insertion**: The script includes sample data for each table, which can be used to populate the database for testing and development purposes.
3. **Querying**: Use SQL queries to interact with the database, retrieve information, and perform operations such as adding new products, updating stock levels, and managing orders.

## Conclusion
Phase 1 of the **Inventory Management System** provides a **robust foundation** for managing inventory, orders, and customer interactions. The **database schema** is designed to be **flexible and scalable**, allowing for future enhancements and integrations. This phase sets the stage for further development and refinement in subsequent phases.
