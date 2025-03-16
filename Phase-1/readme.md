
# Inventory Management System - Phase 1

## Overview
This project is the first phase of an **Inventory Management System** designed to manage and track products, suppliers, orders, customers, and other related entities. The system is built using **SQL** and includes a comprehensive database schema with multiple tables to handle various aspects of inventory management.

---

## Database Schema
The database schema consists of the following tables:

1. **Products**: Stores details of each product, including name, category, stock quantity, price, and supplier.
2. **Suppliers**: Contains information about suppliers who provide products to the inventory.
3. **Categories**: Organizes products into different groups or types for easy classification.
4. **Orders**: Tracks customer orders, including order status, payment information, and shipping details.
5. **Order Items**: Links products to orders and captures details about the quantity and price for each product in an order.
6. **Customers**: Stores customer information, including name, email, phone, and addresses.
7. **Payments**: Records payment details for orders.
8. **Shipments**: Tracks shipping details for orders, including status, method, and delivery date.
9. **Product Reviews**: Stores customer reviews and ratings for products.
10. **Inventory Transactions**: Tracks changes in product stock levels, such as additions or removals.
11. **Returns**: Manages product returns from customers.
12. **Discounts**: Stores information about discounts or offers applied to products.
13. **Warehouses**: Contains details about warehouses where products are stored.
14. **Employee Details**: Stores information about employees, including their roles and the warehouses they work in.
15. **Users**: Manages user authentication and access information for both customers and admin personnel.
16. **Audit Logs**: Records every action performed in the system for tracking and security purposes.
17. **Taxes**: Stores tax information applied to orders or individual products.
18. **Product Images**: Stores information about images associated with products.
19. **Shipping Methods**: Stores available shipping methods for orders.
20. **Promotions**: Stores details about ongoing promotions, including discount percentages and eligible product categories.
21. **Support Tickets**: Tracks customer issues or inquiries submitted for assistance or resolution.
22. **Feedback**: Collects and stores customer opinions or reviews about products or services.
23. **Activity Log**: Tracks and records user actions or system activities for monitoring and auditing purposes.
24. **User Roles**: Defines and manages different roles or permissions assigned to users in the system.
25. **Brands**: Stores information about different product brands, including their names and other relevant details.

---

## Setup Instructions

1. **Create the Database**:
   - Run the SQL script to create the `inventorydb` database and all the necessary tables.

2. **Populate the Database**:
   - Insert sample data into the tables using the provided `INSERT` statements.

3. **Run Queries**:
   - Use the `SELECT` statements provided to view the data in each table and verify that the database is set up correctly.

---

## Usage
This database can be used to:
- Manage inventory.
- Track orders.
- Handle customer interactions.
- Monitor various aspects of the supply chain.

The schema is designed to be **flexible** and **scalable**, allowing for future enhancements and additional features.

---

## Future Enhancements
- Implement user authentication and role-based access control.
- Add more advanced reporting and analytics features.
- Integrate with external systems for order processing and shipping.

---

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your changes.

---

## License
This project is licensed under the **MIT License**. See the [LICENSE](LICENSE) file for more details.

---

This README provides a high-level overview of the project. For detailed information, refer to the SQL script and the comments within each table definition.
