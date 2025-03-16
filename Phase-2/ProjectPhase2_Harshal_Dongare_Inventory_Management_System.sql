
-- --------------------------------------------------------------------
-- 								Table 1: PRODUCTS
-- --------------------------------------------------------------------
-- 1. Retrieve all products that are currently out of stock.
SELECT * FROM products WHERE status = 'Out of Stock';

-- 2. List all products sorted by their price in descending order.
SELECT product_name, price FROM products ORDER BY price DESC;

-- 3. Find the total number of products in each category.
SELECT category_id, COUNT(*) AS total_products 
FROM products 
GROUP BY category_id;

-- 4. Update the price of the product with ID B07XJ8C8F5 to $899.99.
UPDATE products SET price = 899.99 WHERE product_id = 'B07XJ8C8F5';

-- 5. Delete a product with ID B07N4M4V14.
DELETE FROM products WHERE product_id = 'B07N4M4V14';

-- 6. Retrieve products with a price greater than $500.
SELECT * FROM products WHERE price > 500;

-- 7. Find the average price of products in each category.
SELECT category_id, AVG(price) AS avg_price 
FROM products 
GROUP BY category_id;


-- --------------------------------------------------------------------
-- 								Table 2: SUPPLIERS
-- --------------------------------------------------------------------

-- 1. Retrieve all suppliers who are currently inactive.
SELECT * FROM suppliers WHERE status = 'Inactive';

-- 2. Find suppliers whose names start with "Tech".
SELECT * FROM suppliers WHERE supplier_name LIKE 'Tech%';

-- 3. Retrieve suppliers located in India or the USA.
SELECT * FROM suppliers WHERE country IN ('India', 'USA');

-- 4. Add a new supplier to the table.
INSERT INTO suppliers (supplier_id, supplier_name, contact_name, contact_email, contact_phone, address, city, country, status)
VALUES ('SUP021', 'New Tech Supplies', 'John Doe', 'john.doe@newtech.com', '+91-9876543210', '123 Tech Lane', 'Bangalore', 'India', 'Active');

-- 5. Delete a supplier with ID SUP007.
DELETE FROM suppliers WHERE supplier_id = 'SUP007';

-- 6. Retrieve suppliers with a contact email ending with .com.
SELECT * FROM suppliers WHERE contact_email LIKE '%.com';

-- 7. Count the total number of suppliers in each country.
SELECT country, COUNT(*) AS total_suppliers 
FROM suppliers 
GROUP BY country;


-- --------------------------------------------------------------------
-- 								Table 3: CATEGORIES
-- --------------------------------------------------------------------

-- 1. Retrieve all categories that have a description containing the word "Electronics".
SELECT * FROM categories WHERE description LIKE '%Electronics%';

-- 2. Get a list of unique category names.
SELECT DISTINCT category_name FROM categories;

-- 3. Count the total number of categories.
SELECT COUNT(*) AS total_categories FROM categories;

-- 4. Update the description of the category with ID 1.
UPDATE categories SET description = 'Latest electronic gadgets and devices' WHERE category_id = 1;

-- 5. Delete a category with ID 10.
DELETE FROM categories WHERE category_id = 10;

-- 6. Retrieve categories created after January 1, 2025.
SELECT * FROM categories WHERE created_at > '2025-01-01';

-- 7. Find the category with the longest description.
SELECT * FROM categories ORDER BY LENGTH(description) DESC LIMIT 1;

-- --------------------------------------------------------------------
-- 								Table 4: ORDERS
-- --------------------------------------------------------------------

-- 1. Retrieve all orders that are still pending.
SELECT * FROM orders WHERE status = 'Pending';

-- 2. Find orders placed between January 1, 2025, and January 15, 2025.
SELECT * FROM orders WHERE order_date BETWEEN '2025-01-01' AND '2025-01-15';

-- 3. Calculate the total revenue generated from all orders.
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- 4. Add a new order to the table.
INSERT INTO orders (customer_id, order_date, total_amount, status, shipping_address, payment_status)
VALUES (5, '2025-01-20 14:30:00', 299.99, 'Pending', '1234 Elm St, Springfield, IL, 62701', 'Pending');

-- 5. Update the status of an order with ID 3 to "Delivered".
UPDATE orders SET status = 'Delivered' WHERE order_id = 3;

-- 6. Retrieve orders with a total amount greater than $500.
SELECT * FROM orders WHERE total_amount > 500;

-- 7. Count the number of orders for each customer.
SELECT customer_id, COUNT(*) AS total_orders 
FROM orders 
GROUP BY customer_id;

-- --------------------------------------------------------------------
-- 								Table 5: ORDER_ITEMS
-- --------------------------------------------------------------------

-- 1. Retrieve all order items for order ID 1.
SELECT * FROM order_items WHERE order_id = 1;

-- 2. Calculate the total quantity of products ordered across all orders.
SELECT SUM(quantity) AS total_quantity_ordered FROM order_items;

-- 3. Retrieve the product names and quantities for order ID 2.
SELECT p.product_name, oi.quantity 
FROM order_items oi 
JOIN products p ON oi.product_id = p.product_id 
WHERE oi.order_id = 2;

-- 4. Add a new order item for order ID 3.
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (3, 'B07XJ8C8F5', 2, 999.99);

-- 5. Update the quantity of an order item with ID 5 to 3.
UPDATE order_items SET quantity = 3 WHERE order_item_id = 5;

-- 6. Delete an order item with ID 10.
DELETE FROM order_items WHERE order_item_id = 10;

-- 7. Find the total price for each order item.
SELECT order_item_id, quantity * unit_price AS total_price 
FROM order_items;

-- --------------------------------------------------------------------
-- 								Table 6: CUSTOMERS
-- --------------------------------------------------------------------

-- 1. Retrieve all customers whose first name is "John".
SELECT * FROM customers WHERE first_name = 'John';

-- 2. List all customers sorted by their registration date in ascending order.
SELECT * FROM customers ORDER BY registration_date ASC;

-- 3. Find the total number of customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- 4. Update the email of the customer with ID 5.
UPDATE customers SET email = 'new.email@example.com' WHERE customer_id = 5;

-- 5. Delete a customer with ID 10.
DELETE FROM customers WHERE customer_id = 10;

-- 6. Retrieve customers who registered after January 1, 2025.
SELECT * FROM customers WHERE registration_date > '2025-01-01';

-- 7. Find the customer with the most recent registration date.
SELECT * FROM customers ORDER BY registration_date DESC LIMIT 1;


-- --------------------------------------------------------------------
-- 								Table 7: PAYMENTS
-- --------------------------------------------------------------------

-- 1. Retrieve all payments with a status of "Completed".
SELECT * FROM payments WHERE payment_status = 'Completed';

-- 2. Find the total amount paid using the "Credit Card" payment method.
SELECT SUM(payment_amount) AS total_credit_card_payments 
FROM payments 
WHERE payment_method = 'Credit Card';

--  3. List all payments sorted by payment date in descending order.
SELECT * FROM payments ORDER BY payment_date DESC;

-- 4. Add a new payment record.
INSERT INTO payments (order_id, payment_amount, payment_method, payment_status, transaction_id)
VALUES (5, 199.99, 'PayPal', 'Completed', 'TXN123456789');

-- 5. Update the payment status of a payment with ID 3 to "Failed".
UPDATE payments SET payment_status = 'Failed' WHERE payment_id = 3;

-- 6. Delete a payment with ID 7.
DELETE FROM payments WHERE payment_id = 7;

-- 7. Retrieve payments with an amount greater than $100.
SELECT * FROM payments WHERE payment_amount > 100;


-- --------------------------------------------------------------------
-- 								Table 8: SHIPMENTS
-- --------------------------------------------------------------------

-- 1. Retrieve all shipments that are currently "Pending".
SELECT * FROM shipments WHERE shipment_status = 'Pending';

-- 2. Find the total number of shipments for each shipping method.
SELECT shipping_method, COUNT(*) AS total_shipments 
FROM shipments 
GROUP BY shipping_method;

-- 3. List all shipments sorted by shipment date in ascending order.
SELECT * FROM shipments ORDER BY shipment_date ASC;

-- 4. Add a new shipment record.
INSERT INTO shipments (order_id, shipment_date, shipment_status, shipping_method, tracking_number, delivery_date, shipping_address)
VALUES (5, '2025-01-25 10:00:00', 'Shipped', 'Standard', 'TRACK123456789', '2025-01-27 12:00:00', '1234 Elm St, Springfield, IL, 62701');

-- 5. Update the shipment status of a shipment with ID 4 to "Delivered".
UPDATE shipments SET shipment_status = 'Delivered' WHERE shipment_id = 4;

-- 6. Delete a shipment with ID 10.
DELETE FROM shipments WHERE shipment_id = 10;

-- 7. Retrieve shipments with a delivery date after January 20, 2025.
SELECT * FROM shipments WHERE delivery_date > '2025-01-20';

-- --------------------------------------------------------------------
-- 							Table 9: PRODUCT_REVIEWS
-- --------------------------------------------------------------------

-- 1. Retrieve all reviews with a rating of 5.
SELECT * FROM product_reviews WHERE rating = 5;

-- 2. Find the average rating for each product.
SELECT product_id, AVG(rating) AS avg_rating 
FROM product_reviews 
GROUP BY product_id;

-- 3. List all reviews sorted by review date in descending order.
SELECT * FROM product_reviews ORDER BY review_date DESC;

-- 4. Add a new product review.
INSERT INTO product_reviews (product_id, customer_id, rating, review_comment)
VALUES ('B07XJ8C8F5', 5, 4, 'Great product, but a bit expensive.');

-- 5. Update the rating of a review with ID 3 to 4.
UPDATE product_reviews SET rating = 4 WHERE review_id = 3;

-- 6. Delete a review with ID 7.
DELETE FROM product_reviews WHERE review_id = 7;

-- 7. Retrieve reviews for a specific product (e.g., B07XJ8C8F5).
SELECT * FROM product_reviews WHERE product_id = 'B07XJ8C8F5';


-- --------------------------------------------------------------------
-- 							Table 10: INVENTORY_TRANSACTIONS
-- --------------------------------------------------------------------

-- 1. Retrieve all inventory transactions of type "Stock Addition".
SELECT * FROM inventory_transactions WHERE transaction_type = 'Stock Addition';

-- 2. Find the total quantity of products added to the inventory.
SELECT SUM(quantity) AS total_stock_added 
FROM inventory_transactions 
WHERE transaction_type = 'Stock Addition';

-- 3. List all inventory transactions sorted by transaction date in ascending order.
SELECT * FROM inventory_transactions ORDER BY transaction_date ASC;

-- 4. Add a new inventory transaction.
INSERT INTO inventory_transactions (product_id, transaction_type, quantity, reason)
VALUES ('B07XJ8C8F5', 'Stock Addition', 50, 'Restocking');

-- 5. Update the quantity of a transaction with ID 5 to 100.
UPDATE inventory_transactions SET quantity = 100 WHERE transaction_id = 5;

-- 6. Delete a transaction with ID 10.
DELETE FROM inventory_transactions WHERE transaction_id = 10;

-- 7. Retrieve transactions for a specific product (e.g., B07XJ8C8F5).
SELECT * FROM inventory_transactions WHERE product_id = 'B07XJ8C8F5';

-- --------------------------------------------------------------------
-- 							Table 11: INVENTORY_TRANSACTIONS
-- --------------------------------------------------------------------

-- 1. Retrieve all returns with a status of "Approved".
SELECT * FROM returns WHERE status = 'Approved';

-- 2. Find the total number of returns for each product.
SELECT product_id, COUNT(*) AS total_returns 
FROM returns 
GROUP BY product_id;

-- 3. List all returns sorted by return date in descending order.
SELECT * FROM returns ORDER BY return_date DESC;

-- 4. Add a new return record.
INSERT INTO returns (order_id, customer_id, product_id, quantity, reason, status, refunded)
VALUES (5, 5, 'B07XJ8C8F5', 1, 'Defective product', 'Pending', FALSE);

-- 5. Update the status of a return with ID 3 to "Rejected".
UPDATE returns SET status = 'Rejected' WHERE return_id = 3;

-- 6. Delete a return with ID 7.
DELETE FROM returns WHERE return_id = 7;

-- 7. Retrieve returns for a specific customer (e.g., customer ID 5).
SELECT * FROM returns WHERE customer_id = 5;

-- --------------------------------------------------------------------
-- 							Table 12: DISCOUNTS
-- --------------------------------------------------------------------

-- 1. Retrieve all active discounts.
SELECT * FROM discounts WHERE status = 'Active';

-- 2. Find the total number of discounts for each product.
SELECT product_id, COUNT(*) AS total_discounts 
FROM discounts 
GROUP BY product_id;

-- 3. List all discounts sorted by start date in ascending order.
SELECT * FROM discounts ORDER BY start_date ASC;

-- 4. Add a new discount record.
INSERT INTO discounts (product_id, discount_type, discount_value, start_date, end_date, status)
VALUES ('B07XJ8C8F5', 'Percentage', 15.00, '2025-02-01', '2025-02-28', 'Active');

-- 5. Update the discount value of a discount with ID 5 to 20.00.
UPDATE discounts SET discount_value = 20.00 WHERE discount_id = 5;

-- 6. Delete a discount with ID 10.
DELETE FROM discounts WHERE discount_id = 10;

-- 7. Retrieve discounts for a specific product (e.g., B07XJ8C8F5).
SELECT * FROM discounts WHERE product_id = 'B07XJ8C8F5';

-- --------------------------------------------------------------------
-- 							Table 13: WAREHOUSES
-- --------------------------------------------------------------------

-- 1. Retrieve all warehouses with a capacity greater than 500.
SELECT * FROM warehouses WHERE capacity > 500;

-- 2. Find the total number of warehouses in each location.
SELECT location, COUNT(*) AS total_warehouses 
FROM warehouses 
GROUP BY location;

-- 3. List all warehouses sorted by current stock in descending order.
SELECT * FROM warehouses ORDER BY current_stock DESC;

-- 4. Add a new warehouse record.
INSERT INTO warehouses (warehouse_name, location, capacity, current_stock)
VALUES ('New Warehouse', 'Aisle 20, Row 10', 1000, 500);

-- 5. Update the capacity of a warehouse with ID 5 to 1200.
UPDATE warehouses SET capacity = 1200 WHERE warehouse_id = 5;

-- 6. Delete a warehouse with ID 10.
DELETE FROM warehouses WHERE warehouse_id = 10;

-- 7. Retrieve warehouses with a current stock less than 100.
SELECT * FROM warehouses WHERE current_stock < 100;

-- --------------------------------------------------------------------
-- 							Table 14: EMPLOYEE_DETAILS
-- --------------------------------------------------------------------

-- 1. Retrieve all employees with a status of "Active".
SELECT * FROM employee_details WHERE status = 'Active';

-- 2. Find the total number of employees in each position.
SELECT position, COUNT(*) AS total_employees 
FROM employee_details 
GROUP BY position;

-- 3. List all employees sorted by hire date in ascending order.
SELECT * FROM employee_details ORDER BY hire_date ASC;

-- 4. Add a new employee record.
INSERT INTO employee_details (first_name, last_name, email, phone_number, position, warehouse_id, hire_date, salary, status)
VALUES ('John', 'Doe', 'john.doe@example.com', '555-1234', 'Warehouse Manager', 1, '2025-01-01', 55000.00, 'Active');

-- 5. Update the salary of an employee with ID 5 to 60000.00.
UPDATE employee_details SET salary = 60000.00 WHERE employee_id = 5;

-- 6. Delete an employee with ID 10.
DELETE FROM employee_details WHERE employee_id = 10;

-- 7. Retrieve employees with a salary greater than $50000.
SELECT * FROM employee_details WHERE salary > 50000;

-- --------------------------------------------------------------------
-- 							Table 15: USERS
-- --------------------------------------------------------------------

-- 1. Retrieve all users with a role of "admin".
SELECT * FROM users WHERE role = 'admin';

-- 2. Find the total number of users in each role.
SELECT role, COUNT(*) AS total_users 
FROM users 
GROUP BY role;

-- 3. List all users sorted by creation date in descending order.
SELECT * FROM users ORDER BY created_at DESC;

-- 4. Add a new user record.
INSERT INTO users (username, password_hash, email, role)
VALUES ('new_user', 'hashed_password_123', 'new.user@example.com', 'customer');

-- 5. Update the role of a user with ID 5 to "employee".
UPDATE users SET role = 'employee' WHERE user_id = 5;

-- 6. Delete a user with ID 10.
DELETE FROM users WHERE user_id = 10;

-- 7. Retrieve users with an email ending with .com.
SELECT * FROM users WHERE email LIKE '%.com';

-- --------------------------------------------------------------------
-- 							Table 16: AUDIT_LOGS
-- --------------------------------------------------------------------

-- 1. Retrieve all audit logs of type "UPDATE".
SELECT * FROM audit_logs WHERE action_type = 'UPDATE';

-- 2. Find the total number of audit logs for each table.
SELECT table_name, COUNT(*) AS total_logs 
FROM audit_logs 
GROUP BY table_name;

-- 3. List all audit logs sorted by action timestamp in descending order.
SELECT * FROM audit_logs ORDER BY action_timestamp DESC;

-- 4. Add a new audit log record.
INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
VALUES ('INSERT', 'products', 'B07XJ8C8F5', 1, NULL, '{"product_name": "Apple iPhone 13"}');

-- 5. Update the old value of an audit log with ID 5.
UPDATE audit_logs SET old_value = '{"price": "999.99"}' WHERE audit_id = 5;

-- 6. Delete an audit log with ID 10.
DELETE FROM audit_logs WHERE audit_id = 10;

-- 7. Retrieve audit logs for a specific user (e.g., user ID 1).
SELECT * FROM audit_logs WHERE user_id = 1;

-- --------------------------------------------------------------------
-- 							Table 17: TAXES
-- --------------------------------------------------------------------

-- 1. Retrieve all taxes of type "Sales Tax".
SELECT * FROM taxes WHERE tax_type = 'Sales Tax';

-- 2. Find the total number of taxes for each country.
SELECT country, COUNT(*) AS total_taxes 
FROM taxes 
GROUP BY country;

-- 3. List all taxes sorted by tax rate in ascending order.
SELECT * FROM taxes ORDER BY tax_rate ASC;

-- 4. Add a new tax record.
INSERT INTO taxes (tax_type, tax_rate, country, state, product_id, order_id)
VALUES ('Sales Tax', 8.00, 'USA', 'California', 'B07XJ8C8F5', NULL);

-- 5. Update the tax rate of a tax with ID 5 to 10.00.
UPDATE taxes SET tax_rate = 10.00 WHERE tax_id = 5;

-- 6. Delete a tax with ID 10.
DELETE FROM taxes WHERE tax_id = 10;

-- 7. Retrieve taxes for a specific product (e.g., B07XJ8C8F5).
SELECT * FROM taxes WHERE product_id = 'B07XJ8C8F5';

-- --------------------------------------------------------------------
-- 							Table 18: PRODUCT_IMAGES
-- --------------------------------------------------------------------

-- 1. Retrieve all primary images for products.
SELECT * FROM product_images WHERE is_primary = TRUE;

-- 2. Find the total number of images for each product.
SELECT product_id, COUNT(*) AS total_images 
FROM product_images 
GROUP BY product_id;

-- 3. List all product images sorted by creation date in descending order.
SELECT * FROM product_images ORDER BY created_at DESC;

-- 4. Add a new product image record.
INSERT INTO product_images (product_id, image_url, image_description, is_primary)
VALUES ('B07XJ8C8F5', 'https://example.com/images/iphone13_back.jpg', 'Back view of Apple iPhone 13', FALSE);

-- 5. Update the description of an image with ID 5.
UPDATE product_images SET image_description = 'Updated description' WHERE image_id = 5;

-- 6. Delete an image with ID 10.
DELETE FROM product_images WHERE image_id = 10;

-- 7. Retrieve images for a specific product (e.g., B07XJ8C8F5).
SELECT * FROM product_images WHERE product_id = 'B07XJ8C8F5';

-- --------------------------------------------------------------------
-- 							Table 19: SHIPPING_METHODS
-- --------------------------------------------------------------------

-- 1. Retrieve all active shipping methods.
SELECT * FROM shipping_methods WHERE is_active = TRUE;

-- 2. Find the total number of shipping methods.
SELECT COUNT(*) AS total_shipping_methods FROM shipping_methods;

-- 3. List all shipping methods sorted by price in ascending order.
SELECT * FROM shipping_methods ORDER BY price ASC;

-- 4. Add a new shipping method record.
INSERT INTO shipping_methods (method_name, delivery_time, price, is_active)
VALUES ('Next-Day Delivery', '1 business day', 24.99, TRUE);

-- 5. Update the price of a shipping method with ID 5 to 15.99.
UPDATE shipping_methods SET price = 15.99 WHERE method_id = 5;

-- 6. Delete a shipping method with ID 10.
DELETE FROM shipping_methods WHERE method_id = 10;

-- 7. Retrieve shipping methods with a price less than $10.
SELECT * FROM shipping_methods WHERE price < 10;

-- --------------------------------------------------------------------
-- 							Table 20: PROMOTIONS
-- --------------------------------------------------------------------

-- 1. Retrieve all active promotions.
SELECT * FROM promotions WHERE is_active = TRUE;

-- 2. Find the total number of promotions for each eligible category.
SELECT eligible_category, COUNT(*) AS total_promotions 
FROM promotions 
GROUP BY eligible_category;

-- 3. List all promotions sorted by start date in ascending order.
SELECT * FROM promotions ORDER BY start_date ASC;

-- 4. Add a new promotion record.
INSERT INTO promotions (promo_code, discount_percentage, start_date, end_date, eligible_category, is_active, description)
VALUES ('SPRING25', 25.00, '2025-03-01', '2025-03-31', 'Electronics', TRUE, 'Spring sale for electronics.');

-- 5. Update the discount percentage of a promotion with ID 5 to 30.00.
UPDATE promotions SET discount_percentage = 30.00 WHERE promotion_id = 5;

-- 6. Delete a promotion with ID 10.
DELETE FROM promotions WHERE promotion_id = 10;

-- 7. Retrieve promotions for a specific category (e.g., "Electronics").
SELECT * FROM promotions WHERE eligible_category = 'Electronics';


-- --------------------------------------------------------------------
-- 							Table 21: PROMOTIONS
-- --------------------------------------------------------------------

-- 1. Retrieve all support tickets with a status of "Open".
SELECT * FROM support_tickets WHERE status = 'Open';

-- 2. Find the total number of tickets for each priority level.
SELECT priority, COUNT(*) AS total_tickets 
FROM support_tickets 
GROUP BY priority;

-- 3. List all support tickets sorted by creation date in descending order.
SELECT * FROM support_tickets ORDER BY created_at DESC;

-- 4. Add a new support ticket record.
INSERT INTO support_tickets (customer_id, issue_description, status, priority)
VALUES (5, 'Product not working as expected.', 'Open', 'High');

-- 5.Update the status of a ticket with ID 3 to "Resolved".
UPDATE support_tickets SET status = 'Resolved' WHERE ticket_id = 3;

-- 6. Delete a support ticket with ID 10.
DELETE FROM support_tickets WHERE ticket_id = 10;

-- 7. Retrieve support tickets for a specific customer (e.g., customer ID 5).
SELECT * FROM support_tickets WHERE customer_id = 5;

-- --------------------------------------------------------------------
-- 							Table 22: FEEDBACK
-- --------------------------------------------------------------------

-- 1. Retrieve all feedback with a rating of 5.
SELECT * FROM feedback WHERE rating = 5;

-- 2. Find the average rating of feedback submitted by each customer.
SELECT customer_id, AVG(rating) AS avg_rating 
FROM feedback 
GROUP BY customer_id;

-- 3. List all feedback sorted by submission date in descending order.
SELECT * FROM feedback ORDER BY submitted_at DESC;

-- 4. Add a new feedback record.
INSERT INTO feedback (customer_id, rating, comments)
VALUES (5, 4, 'Great service, but delivery was delayed.');

-- 5. Update the rating of a feedback entry with ID 3 to 5.
UPDATE feedback SET rating = 5 WHERE feedback_id = 3;

-- 6. Delete a feedback entry with ID 10.
DELETE FROM feedback WHERE feedback_id = 10;

-- 7. Retrieve feedback for a specific customer (e.g., customer ID 5).
SELECT * FROM feedback WHERE customer_id = 5;

-- --------------------------------------------------------------------
-- 							Table 23: ACTIVITY_LOG
-- --------------------------------------------------------------------

-- 1. Retrieve all activity logs of type "Login".
SELECT * FROM activity_log WHERE activity_type = 'Login';

-- 2. Find the total number of activities for each user.
SELECT user_id, COUNT(*) AS total_activities 
FROM activity_log 
GROUP BY user_id;

-- 3. List all activity logs sorted by activity timestamp in descending order.
SELECT * FROM activity_log ORDER BY activity_timestamp DESC;

-- 4. Add a new activity log record.
INSERT INTO activity_log (user_id, activity_type, activity_description, ip_address, device_type, location, success_status)
VALUES (5, 'Login', 'User logged into the system', '192.168.1.1', 'Desktop', 'New York, USA', 'Success');

-- 5. Update the success status of an activity log with ID 3 to "Failure".
UPDATE activity_log SET success_status = 'Failure' WHERE log_id = 3;

-- 6. Delete an activity log with ID 10.
DELETE FROM activity_log WHERE log_id = 10;

-- 7. Retrieve activity logs for a specific user (e.g., user ID 5).
SELECT * FROM activity_log WHERE user_id = 5;

-- --------------------------------------------------------------------
-- 							Table 24: USER_ROLES
-- --------------------------------------------------------------------

-- 1. Retrieve all active user roles.
SELECT * FROM user_roles WHERE is_active = TRUE;

-- 2. Find the total number of roles assigned by each user.
SELECT assigned_by, COUNT(*) AS total_roles_assigned 
FROM user_roles 
GROUP BY assigned_by;

-- 3. List all user roles sorted by creation date in descending order.
SELECT * FROM user_roles ORDER BY created_at DESC;

-- 4. Add a new user role record.
INSERT INTO user_roles (role_name, role_description, permissions, is_active, assigned_by, valid_from, valid_until)
VALUES ('Analyst', 'Data analyst role with read-only access.', 'Read, Analyze Reports', TRUE, 1, '2025-01-01', '2025-12-31');

-- 5. Update the permissions of a role with ID 5.
UPDATE user_roles SET permissions = 'Read, Write, Update' WHERE role_id = 5;

-- 6. Delete a user role with ID 10.
DELETE FROM user_roles WHERE role_id = 10;

-- 7. Retrieve roles assigned by a specific user (e.g., user ID 1).
SELECT * FROM user_roles WHERE assigned_by = 1;


-- --------------------------------------------------------------------
-- 							Table 25: BRANDS
-- --------------------------------------------------------------------

-- 1. Retrieve all active brands.
SELECT * FROM brands WHERE status = 'Active';

-- 2. Find the total number of brands in each country.
SELECT country_of_origin, COUNT(*) AS total_brands 
FROM brands 
GROUP BY country_of_origin;

-- 3. List all brands sorted by established year in ascending order.
SELECT * FROM brands ORDER BY established_year ASC;

-- 4. Add a new brand record.
INSERT INTO brands (brand_name, country_of_origin, established_year, status, website, headquarters_location, number_of_employees, revenue, product_categories, ceo_name, is_public, logo_image_url)
VALUES ('New Brand', 'USA', 2020, 'Active', 'https://www.newbrand.com', 'New York, USA', 500, 1000000000, 'Electronics, Wearables', 'John Doe', TRUE, 'https://www.newbrand.com/logo.png');

-- 5. Update the revenue of a brand with ID 5 to 2000000000.
UPDATE brands SET revenue = 2000000000 WHERE brand_id = 5;

-- 6. Delete a brand with ID 10.
DELETE FROM brands WHERE brand_id = 10;

-- 7. Retrieve brands with a revenue greater than $1 billion.
SELECT * FROM brands WHERE revenue > 1000000000;
