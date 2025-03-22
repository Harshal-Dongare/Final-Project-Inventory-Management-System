
-- ------------------------------------------------------------------------------
-- 							Table 1 : PRODUCTS									|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the total value of each product in stock (quantity_in_stock * price)
SELECT product_id, product_name, quantity_in_stock * price AS total_value
FROM products;

-- 2. Joins: Retrieve product details along with their category names
SELECT p.product_id, p.product_name, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 3. Subquery: Find products with a price higher than the average price
SELECT product_id, product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- 4. String Function: Display product names in uppercase
SELECT UPPER(product_name) AS product_name_upper
FROM products;

-- 5. Aggregate Function: Find the total number of products in each category
SELECT category_id, COUNT(*) AS total_products
FROM products
GROUP BY category_id;

-- 6. Bitwise: Check if the product_id has a specific bit set (e.g., bit 2)
SELECT product_id, product_name
FROM products
WHERE (ASCII(SUBSTRING(product_id, 1, 1)) & 2 = 2;

-- 7. Arithmetic: Calculate the discount price (10% off) for each product
SELECT product_id, product_name, price, price * 0.9 AS discounted_price
FROM products;

-- ------------------------------------------------------------------------------
-- 							Table 2 : SUPPLIERS									|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the length of the supplier's contact phone number
SELECT supplier_id, supplier_name, LENGTH(contact_phone) AS phone_length
FROM suppliers;

-- 2. Joins: Retrieve supplier details along with the products they supply
SELECT s.supplier_id, s.supplier_name, p.product_name
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id;

-- 3. Subquery: Find suppliers who supply more than 5 products
SELECT supplier_id, supplier_name
FROM suppliers
WHERE supplier_id IN (SELECT supplier_id FROM products GROUP BY supplier_id HAVING COUNT(*) > 5);

-- 4. String Function: Concatenate supplier name and city
SELECT CONCAT(supplier_name, ' - ', city) AS supplier_info
FROM suppliers;

-- 5. Aggregate Function: Count the number of suppliers in each country
SELECT country, COUNT(*) AS total_suppliers
FROM suppliers
GROUP BY country;

-- 6. Bitwise: Check if the supplier_id has a specific bit set (e.g., bit 3)
SELECT supplier_id, supplier_name
FROM suppliers
WHERE (ASCII(SUBSTRING(supplier_id, 1, 1)) & 4 = 4;

-- 7. Arithmetic: Calculate the total number of characters in the supplier's address
SELECT supplier_id, supplier_name, LENGTH(address) AS address_length
FROM suppliers;

-- ------------------------------------------------------------------------------
-- 							Table 3 : CATEGORIES								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the length of the category description
SELECT category_id, category_name, LENGTH(description) AS description_length
FROM categories;

-- 2. Joins: Retrieve category details along with the number of products in each category
SELECT c.category_id, c.category_name, COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_id;

-- 3. Subquery: Find categories with more than 5 products
SELECT category_id, category_name
FROM categories
WHERE category_id IN (SELECT category_id FROM products GROUP BY category_id HAVING COUNT(*) > 5);

-- 4. String Function: Display category names in lowercase
SELECT LOWER(category_name) AS category_name_lower
FROM categories;

-- 5. Aggregate Function: Find the average length of category descriptions
SELECT AVG(LENGTH(description)) AS avg_description_length
FROM categories;

-- 6. Bitwise: Check if the category_id has a specific bit set (e.g., bit 1)
SELECT category_id, category_name
FROM categories
WHERE category_id & 1 = 1;

-- 7. Arithmetic: Calculate the total number of characters in the category name and description
SELECT category_id, category_name, LENGTH(category_name) + LENGTH(description) AS total_length
FROM categories;

-- ------------------------------------------------------------------------------
-- 								Table 4 : ORDERS								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the total amount after a 10% discount
SELECT order_id, total_amount, total_amount * 0.9 AS discounted_amount
FROM orders;

-- 2. Joins: Retrieve order details along with customer information
SELECT o.order_id, o.total_amount, c.first_name, c.last_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 3. Subquery: Find orders with a total amount greater than the average order amount
SELECT order_id, total_amount
FROM orders
WHERE total_amount > (SELECT AVG(total_amount) FROM orders);

-- 4. String Function: Extract the first 10 characters of the shipping address
SELECT order_id, LEFT(shipping_address, 10) AS short_address
FROM orders;

-- 5. Aggregate Function: Find the total revenue generated from orders
SELECT SUM(total_amount) AS total_revenue
FROM orders;

-- 6. Bitwise: Check if the order_id has a specific bit set (e.g., bit 4)
SELECT order_id, total_amount
FROM orders
WHERE order_id & 8 = 8;

-- 7. Arithmetic: Calculate the length of the shipping address
SELECT order_id, LENGTH(shipping_address) AS address_length
FROM orders;

-- ------------------------------------------------------------------------------
-- 								Table 5 : ORDER_ITEMS							|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the total price for each order item
SELECT order_item_id, quantity * unit_price AS total_price
FROM order_items;

-- 2. Joins: Retrieve order item details along with product information
SELECT oi.order_item_id, p.product_name, oi.quantity, oi.unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 3. Subquery: Find order items with a unit price greater than the average unit price
SELECT order_item_id, unit_price
FROM order_items
WHERE unit_price > (SELECT AVG(unit_price) FROM order_items);

-- 4. String Function: Display product IDs in uppercase
SELECT UPPER(product_id) AS product_id_upper
FROM order_items;

-- 5. Aggregate Function: Find the total quantity of products ordered
SELECT SUM(quantity) AS total_quantity_ordered
FROM order_items;

-- 6. Bitwise: Check if the order_item_id has a specific bit set (e.g., bit 5)
SELECT order_item_id, unit_price
FROM order_items
WHERE order_item_id & 16 = 16;

-- 7. Arithmetic: Calculate the total revenue generated from each product
SELECT product_id, SUM(quantity * unit_price) AS total_revenue
FROM order_items
GROUP BY product_id;

-- ------------------------------------------------------------------------------
-- 								Table 6 : CUSTOMERS								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the length of the customer's email
SELECT customer_id, email, LENGTH(email) AS email_length
FROM customers;

-- 2. Joins: Retrieve customer details along with their orders
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 3. Subquery: Find customers who have placed more than 3 orders
SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(*) > 3);

-- 4. String Function: Concatenate first and last names
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;

-- 5. Aggregate Function: Count the number of customers in each city
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city;

-- 6. Bitwise: Check if the customer_id has a specific bit set (e.g., bit 6)
SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id & 32 = 32;

-- 7. Arithmetic: Calculate the total number of characters in the customer's full name
SELECT customer_id, LENGTH(CONCAT(first_name, last_name)) AS name_length
FROM customers;

-- ------------------------------------------------------------------------------
-- 								Table 7 : PAYMENTS								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the total payment amount after a 5% tax
SELECT payment_id, payment_amount, payment_amount * 1.05 AS total_with_tax
FROM payments;

-- 2. Joins: Retrieve payment details along with order information
SELECT p.payment_id, o.order_id, p.payment_amount, o.total_amount
FROM payments p
JOIN orders o ON p.order_id = o.order_id;

-- 3. Subquery: Find payments with an amount greater than the average payment amount
SELECT payment_id, payment_amount
FROM payments
WHERE payment_amount > (SELECT AVG(payment_amount) FROM payments);

-- 4. String Function: Extract the first 5 characters of the transaction ID
SELECT payment_id, LEFT(transaction_id, 5) AS short_transaction_id
FROM payments;

-- 5. Aggregate Function: Find the total amount paid
SELECT SUM(payment_amount) AS total_payments
FROM payments;

-- 6. Bitwise: Check if the payment_id has a specific bit set (e.g., bit 7)
SELECT payment_id, payment_amount
FROM payments
WHERE payment_id & 64 = 64;

-- 7. Arithmetic: Calculate the length of the transaction ID
SELECT payment_id, LENGTH(transaction_id) AS transaction_id_length
FROM payments;

-- ------------------------------------------------------------------------------
-- 								Table 8 : SHIPMENTS								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the number of days between shipment and delivery
SELECT shipment_id, DATEDIFF(delivery_date, shipment_date) AS days_to_deliver
FROM shipments;

-- 2. Joins: Retrieve shipment details along with order information
SELECT s.shipment_id, o.order_id, s.shipment_status, o.total_amount
FROM shipments s
JOIN orders o ON s.order_id = o.order_id;

-- 3. Subquery: Find shipments that took more than 3 days to deliver
SELECT shipment_id, shipment_status
FROM shipments
WHERE DATEDIFF(delivery_date, shipment_date) > 3;

-- 4. String Function: Extract the first 10 characters of the tracking number
SELECT shipment_id, LEFT(tracking_number, 10) AS short_tracking_number
FROM shipments;

-- 5. Aggregate Function: Count the number of shipments by status
SELECT shipment_status, COUNT(*) AS total_shipments
FROM shipments
GROUP BY shipment_status;

-- 6. Bitwise: Check if the shipment_id has a specific bit set (e.g., bit 8)
SELECT shipment_id, shipment_status
FROM shipments
WHERE shipment_id & 128 = 128;

-- 7. Arithmetic: Calculate the length of the shipping address
SELECT shipment_id, LENGTH(shipping_address) AS address_length
FROM shipments;

-- ------------------------------------------------------------------------------
-- 								Table 9 : PRODUCT_REVIEWS						|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the average rating for each product
SELECT product_id, AVG(rating) AS avg_rating
FROM product_reviews
GROUP BY product_id;

-- 2. Joins: Retrieve review details along with product information
SELECT pr.review_id, p.product_name, pr.rating, pr.review_comment
FROM product_reviews pr
JOIN products p ON pr.product_id = p.product_id;

-- 3. Subquery: Find products with an average rating greater than 4
SELECT product_id, AVG(rating) AS avg_rating
FROM product_reviews
GROUP BY product_id
HAVING AVG(rating) > 4;

-- 4. String Function: Extract the first 50 characters of the review comment
SELECT review_id, LEFT(review_comment, 50) AS short_comment
FROM product_reviews;

-- 5. Aggregate Function: Count the number of reviews for each product
SELECT product_id, COUNT(*) AS total_reviews
FROM product_reviews
GROUP BY product_id;

-- 6. Bitwise: Check if the review_id has a specific bit set (e.g., bit 9)
SELECT review_id, rating
FROM product_reviews
WHERE review_id & 256 = 256;

-- 7. Arithmetic: Calculate the length of the review comment
SELECT review_id, LENGTH(review_comment) AS comment_length
FROM product_reviews;

-- ------------------------------------------------------------------------------
-- 							Table 10 : INVENTORY_TRANSACTIONS					|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the total quantity of products added or removed
SELECT transaction_id, SUM(quantity) AS total_quantity
FROM inventory_transactions
GROUP BY transaction_id;

-- 2. Joins: Retrieve transaction details along with product information
SELECT it.transaction_id, p.product_name, it.transaction_type, it.quantity
FROM inventory_transactions it
JOIN products p ON it.product_id = p.product_id;

-- 3. Subquery: Find transactions where the quantity is greater than the average quantity
SELECT transaction_id, quantity
FROM inventory_transactions
WHERE quantity > (SELECT AVG(quantity) FROM inventory_transactions);

-- 4. String Function: Extract the first 10 characters of the reason
SELECT transaction_id, LEFT(reason, 10) AS short_reason
FROM inventory_transactions;

-- 5. Aggregate Function: Count the number of transactions by type
SELECT transaction_type, COUNT(*) AS total_transactions
FROM inventory_transactions
GROUP BY transaction_type;

-- 6. Bitwise: Check if the transaction_id has a specific bit set (e.g., bit 10)
SELECT transaction_id, transaction_type
FROM inventory_transactions
WHERE transaction_id & 512 = 512;

-- 7. Arithmetic: Calculate the length of the reason
SELECT transaction_id, LENGTH(reason) AS reason_length
FROM inventory_transactions;

-- ------------------------------------------------------------------------------
-- 								Table 11 : RETURNS								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the total quantity of products returned
SELECT return_id, SUM(quantity) AS total_quantity_returned
FROM returns
GROUP BY return_id;

-- 2. Joins: Retrieve return details along with product and customer information
SELECT r.return_id, p.product_name, c.first_name, c.last_name, r.quantity
FROM returns r
JOIN products p ON r.product_id = p.product_id
JOIN customers c ON r.customer_id = c.customer_id;

-- 3. Subquery: Find returns where the quantity is greater than the average quantity returned
SELECT return_id, quantity
FROM returns
WHERE quantity > (SELECT AVG(quantity) FROM returns);

-- 4. String Function: Extract the first 10 characters of the reason
SELECT return_id, LEFT(reason, 10) AS short_reason
FROM returns;

-- 5. Aggregate Function: Count the number of returns by status
SELECT status, COUNT(*) AS total_returns
FROM returns
GROUP BY status;

-- 6. Bitwise: Check if the return_id has a specific bit set (e.g., bit 11)
SELECT return_id, status
FROM returns
WHERE return_id & 1024 = 1024;

-- 7. Arithmetic: Calculate the length of the reason
SELECT return_id, LENGTH(reason) AS reason_length
FROM returns;

-- ------------------------------------------------------------------------------
-- 								Table 12 : EMPLOYEE_DETAILS								|
-- ------------------------------------------------------------------------------
-- Arithmetic: Calculate the total salary cost for all active employees
SELECT SUM(salary) AS total_salary_cost FROM employee_details WHERE status = 'Active';

-- Joins: Get employee details along with warehouse information
SELECT ed.*, w.warehouse_name 
FROM employee_details ed
JOIN warehouses w ON ed.warehouse_id = w.warehouse_id;

-- Subquery: Find employees whose salary is above the average salary
SELECT * FROM employee_details 
WHERE salary > (SELECT AVG(salary) FROM employee_details);

-- String Function: Concatenate first and last names to create full names
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employee_details;

-- Aggregate Function: Count the number of employees in each position
SELECT position, COUNT(*) AS employee_count 
FROM employee_details 
GROUP BY position;

-- Bitwise: Check if employee_id is even (using bitwise AND)
SELECT * FROM employee_details WHERE (employee_id & 1) = 0;

-- Arithmetic: Calculate the total salary after a 10% raise for all employees
SELECT employee_id, first_name, last_name, salary * 1.10 AS new_salary FROM employee_details;


-- ------------------------------------------------------------------------------
-- 								Table 13 : USERS								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total number of users created each year
SELECT YEAR(created_at) AS year, COUNT(*) AS user_count 
FROM users 
GROUP BY YEAR(created_at);

-- Joins: Get user details along with their roles
SELECT u.*, ur.role_name 
FROM users u
JOIN user_roles ur ON u.role = ur.role_name;

-- Subquery: Find users who have not logged in yet (assuming no activity log entry)
SELECT * FROM users 
WHERE user_id NOT IN (SELECT user_id FROM activity_log);

-- String Function: Extract the domain from user emails
SELECT email, SUBSTRING(email, LOCATE('@', email) + 1) AS email_domain 
FROM users;

-- Aggregate Function: Count the number of users in each role
SELECT role, COUNT(*) AS user_count 
FROM users 
GROUP BY role;

-- Bitwise: Check if user_id is odd (using bitwise AND)
SELECT * FROM users WHERE (user_id & 1) = 1;

-- Arithmetic: Calculate the average length of usernames
SELECT AVG(LENGTH(username)) AS avg_username_length FROM users;


-- ------------------------------------------------------------------------------
-- 								Table 14 : AUDIT_LOGS								|
-- ------------------------------------------------------------------------------
-- Arithmetic: Calculate the total number of actions per day
SELECT DATE(action_timestamp) AS action_date, COUNT(*) AS action_count 
FROM audit_logs 
GROUP BY DATE(action_timestamp);

-- Joins: Get audit logs along with user details
SELECT al.*, u.username 
FROM audit_logs al
JOIN users u ON al.user_id = u.user_id;

-- Subquery: Find the most recent audit log entry
SELECT * FROM audit_logs 
WHERE action_timestamp = (SELECT MAX(action_timestamp) FROM audit_logs);

-- String Function: Extract the table name from the audit log
SELECT table_name, SUBSTRING(table_name, 1, 5) AS table_prefix 
FROM audit_logs;

-- Aggregate Function: Count the number of actions by type
SELECT action_type, COUNT(*) AS action_count 
FROM audit_logs 
GROUP BY action_type;

-- Bitwise: Check if audit_id is even (using bitwise AND)
SELECT * FROM audit_logs WHERE (audit_id & 1) = 0;

-- Arithmetic: Calculate the average length of old_value and new_value
SELECT AVG(LENGTH(old_value)) AS avg_old_value_length, AVG(LENGTH(new_value)) AS avg_new_value_length 
FROM audit_logs;

-- ------------------------------------------------------------------------------
-- 								Table 15 : TAXES								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total tax revenue per country
SELECT country, SUM(tax_rate) AS total_tax_revenue 
FROM taxes 
GROUP BY country;

-- Joins: Get tax details along with product information
SELECT t.*, p.product_name 
FROM taxes t
JOIN products p ON t.product_id = p.product_id;

-- Subquery: Find taxes with rates above the average tax rate
SELECT * FROM taxes 
WHERE tax_rate > (SELECT AVG(tax_rate) FROM taxes);

-- String Function: Concatenate country and state for tax location
SELECT CONCAT(country, ' - ', state) AS tax_location 
FROM taxes;

-- Aggregate Function: Count the number of taxes per type
SELECT tax_type, COUNT(*) AS tax_count 
FROM taxes 
GROUP BY tax_type;

-- Bitwise: Check if tax_id is odd (using bitwise AND)
SELECT * FROM taxes WHERE (tax_id & 1) = 1;

-- Arithmetic: Calculate the total tax revenue for each product
SELECT product_id, SUM(tax_rate) AS total_tax_revenue 
FROM taxes 
GROUP BY product_id;

-- ------------------------------------------------------------------------------
-- 								Table 16 : PRODUCT_IMAGES								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total number of images per product
SELECT product_id, COUNT(*) AS image_count 
FROM product_images 
GROUP BY product_id;

-- Joins: Get product images along with product details
SELECT pi.*, p.product_name 
FROM product_images pi
JOIN products p ON pi.product_id = p.product_id;

-- Subquery: Find products with more than 1 image
SELECT * FROM products 
WHERE product_id IN (SELECT product_id FROM product_images GROUP BY product_id HAVING COUNT(*) > 1);

-- String Function: Extract the domain from image URLs
SELECT image_url, SUBSTRING(image_url, 1, LOCATE('/', image_url, 9)) AS image_domain 
FROM product_images;

-- Aggregate Function: Count the number of primary images
SELECT COUNT(*) AS primary_image_count 
FROM product_images 
WHERE is_primary = TRUE;

-- Bitwise: Check if image_id is even (using bitwise AND)
SELECT * FROM product_images WHERE (image_id & 1) = 0;

-- Arithmetic: Calculate the average length of image descriptions
SELECT AVG(LENGTH(image_description)) AS avg_description_length 
FROM product_images;

-- ------------------------------------------------------------------------------
-- 								Table 17 : SHIPPING_METHODS								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total shipping cost for all active methods
SELECT SUM(price) AS total_shipping_cost 
FROM shipping_methods 
WHERE is_active = TRUE;

-- Joins: Get shipping methods along with order details (assuming orders table exists)
SELECT sm.*, o.order_id 
FROM shipping_methods sm
JOIN orders o ON sm.method_id = o.shipping_method_id;

-- Subquery: Find the most expensive shipping method
SELECT * FROM shipping_methods 
WHERE price = (SELECT MAX(price) FROM shipping_methods);

-- String Function: Extract the first word from the method name
SELECT method_name, SUBSTRING(method_name, 1, LOCATE(' ', method_name) - 1) AS first_word 
FROM shipping_methods;

-- Aggregate Function: Count the number of active and inactive shipping methods
SELECT is_active, COUNT(*) AS method_count 
FROM shipping_methods 
GROUP BY is_active;

-- Bitwise: Check if method_id is odd (using bitwise AND)
SELECT * FROM shipping_methods WHERE (method_id & 1) = 1;

-- Arithmetic: Calculate the average shipping price
SELECT AVG(price) AS avg_shipping_price 
FROM shipping_methods;


-- ------------------------------------------------------------------------------
-- 								Table 18 : PROMOTIONS								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total discount percentage for all active promotions
SELECT SUM(discount_percentage) AS total_discount 
FROM promotions 
WHERE is_active = TRUE;

-- Joins: Get promotions along with eligible product categories (assuming products table exists)
SELECT p.*, pr.product_name 
FROM promotions p
JOIN products pr ON p.eligible_category = pr.category;

-- Subquery: Find promotions with the highest discount percentage
SELECT * FROM promotions 
WHERE discount_percentage = (SELECT MAX(discount_percentage) FROM promotions);

-- String Function: Extract the year from the start date
SELECT promo_code, YEAR(start_date) AS start_year 
FROM promotions;

-- Aggregate Function: Count the number of promotions per category
SELECT eligible_category, COUNT(*) AS promotion_count 
FROM promotions 
GROUP BY eligible_category;

-- Bitwise: Check if promotion_id is even (using bitwise AND)
SELECT * FROM promotions WHERE (promotion_id & 1) = 0;

-- Arithmetic: Calculate the average discount percentage
SELECT AVG(discount_percentage) AS avg_discount 
FROM promotions;

-- ------------------------------------------------------------------------------
-- 								Table 19 : SUPPORT_TICKETS								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the average priority level of tickets
SELECT AVG(priority) AS avg_priority 
FROM support_tickets;

-- Joins: Get support tickets along with customer details
SELECT st.*, c.first_name, c.last_name 
FROM support_tickets st
JOIN customers c ON st.customer_id = c.customer_id;

-- Subquery: Find the most recent support ticket
SELECT * FROM support_tickets 
WHERE created_at = (SELECT MAX(created_at) FROM support_tickets);

-- String Function: Extract the first 50 characters of the issue description
SELECT ticket_id, SUBSTRING(issue_description, 1, 50) AS short_description 
FROM support_tickets;

-- Aggregate Function: Count the number of tickets per status
SELECT status, COUNT(*) AS ticket_count 
FROM support_tickets 
GROUP BY status;

-- Bitwise: Check if ticket_id is odd (using bitwise AND)
SELECT * FROM support_tickets WHERE (ticket_id & 1) = 1;

-- Arithmetic: Calculate the total number of tickets per priority level
SELECT priority, COUNT(*) AS ticket_count 
FROM support_tickets 
GROUP BY priority;

-- ------------------------------------------------------------------------------
-- 								Table 20 : FEEDBACK								|
-- ------------------------------------------------------------------------------
-- Arithmetic: Calculate the average rating given by customers
SELECT AVG(rating) AS avg_rating 
FROM feedback;

-- Joins: Get feedback along with customer details
SELECT f.*, c.first_name, c.last_name 
FROM feedback f
JOIN customers c ON f.customer_id = c.customer_id;

-- Subquery: Find feedback with the highest rating
SELECT * FROM feedback 
WHERE rating = (SELECT MAX(rating) FROM feedback);

-- String Function: Extract the first 20 characters of the comments
SELECT feedback_id, SUBSTRING(comments, 1, 20) AS short_comment 
FROM feedback;

-- Aggregate Function: Count the number of feedback entries per rating
SELECT rating, COUNT(*) AS feedback_count 
FROM feedback 
GROUP BY rating;

-- Bitwise: Check if feedback_id is even (using bitwise AND)
SELECT * FROM feedback WHERE (feedback_id & 1) = 0;

-- Arithmetic: Calculate the total number of feedback entries per customer
SELECT customer_id, COUNT(*) AS feedback_count 
FROM feedback 
GROUP BY customer_id;

-- ------------------------------------------------------------------------------
-- 								Table 21 : ACTIVITY_LOG								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total number of activities per user
SELECT user_id, COUNT(*) AS activity_count 
FROM activity_log 
GROUP BY user_id;

-- Joins: Get activity logs along with user details
SELECT al.*, u.username 
FROM activity_log al
JOIN users u ON al.user_id = u.user_id;

-- Subquery: Find the most recent activity log entry
SELECT * FROM activity_log 
WHERE activity_timestamp = (SELECT MAX(activity_timestamp) FROM activity_log);

-- String Function: Extract the first 10 characters of the activity description
SELECT log_id, SUBSTRING(activity_description, 1, 10) AS short_description 
FROM activity_log;

-- Aggregate Function: Count the number of activities per type
SELECT activity_type, COUNT(*) AS activity_count 
FROM activity_log 
GROUP BY activity_type;

-- Bitwise: Check if log_id is odd (using bitwise AND)
SELECT * FROM activity_log WHERE (log_id & 1) = 1;

-- Arithmetic: Calculate the average length of activity descriptions
SELECT AVG(LENGTH(activity_description)) AS avg_description_length 
FROM activity_log;


-- ------------------------------------------------------------------------------
-- 								Table 22 : USER_ROLES								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total number of roles assigned per user
SELECT assigned_by, COUNT(*) AS role_count 
FROM user_roles 
GROUP BY assigned_by;

-- Joins: Get user roles along with user details
SELECT ur.*, u.username 
FROM user_roles ur
JOIN users u ON ur.assigned_by = u.user_id;

-- Subquery: Find the most recently assigned role
SELECT * FROM user_roles 
WHERE assigned_at = (SELECT MAX(assigned_at) FROM user_roles);

-- String Function: Extract the first 10 characters of the role description
SELECT role_id, SUBSTRING(role_description, 1, 10) AS short_description 
FROM user_roles;

-- Aggregate Function: Count the number of roles per type
SELECT role_name, COUNT(*) AS role_count 
FROM user_roles 
GROUP BY role_name;

-- Bitwise: Check if role_id is even (using bitwise AND)
SELECT * FROM user_roles WHERE (role_id & 1) = 0;

-- Arithmetic: Calculate the average length of role descriptions
SELECT AVG(LENGTH(role_description)) AS avg_description_length 
FROM user_roles;

-- ------------------------------------------------------------------------------
-- 								Table 23 : BRANDS								|
-- ------------------------------------------------------------------------------

-- Arithmetic: Calculate the total revenue of all active brands
SELECT SUM(revenue) AS total_revenue 
FROM brands 
WHERE status = 'Active';

-- Joins: Get brand details along with product information (assuming products table exists)
SELECT b.*, p.product_name 
FROM brands b
JOIN products p ON b.brand_name = p.brand;

-- Subquery: Find the brand with the highest revenue
SELECT * FROM brands 
WHERE revenue = (SELECT MAX(revenue) FROM brands);

-- String Function: Extract the first 5 characters of the brand name
SELECT brand_name, SUBSTRING(brand_name, 1, 5) AS brand_prefix 
FROM brands;

-- Aggregate Function: Count the number of brands per country
SELECT country_of_origin, COUNT(*) AS brand_count 
FROM brands 
GROUP BY country_of_origin;

-- Bitwise: Check if brand_id is odd (using bitwise AND)
SELECT * FROM brands WHERE (brand_id & 1) = 1;

-- Arithmetic: Calculate the average number of employees per brand
SELECT AVG(number_of_employees) AS avg_employees 
FROM brands;

-- ------------------------------------------------------------------------------
-- 								Table 13 : DISCOUNTS								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the discounted price for a product with a 10% discount
SELECT product_id, discount_value, 
       (100 - discount_value) / 100 * 100 AS discounted_price_percentage
FROM discounts
WHERE discount_type = 'Percentage' AND discount_value = 10.00;

-- 2. Joins: Get product details along with discount information
SELECT p.product_id, p.product_name, d.discount_type, d.discount_value, d.start_date, d.end_date
FROM products p
JOIN discounts d ON p.product_id = d.product_id;

-- 3. Subquery: Find products with active discounts that have a discount value greater than the average discount value
SELECT product_id, discount_value
FROM discounts
WHERE discount_value > (SELECT AVG(discount_value) FROM discounts WHERE status = 'Active')
AND status = 'Active';

-- 4. String Function: Extract the year from the start date of discounts
SELECT discount_id, product_id, 
       YEAR(start_date) AS discount_start_year
FROM discounts;

-- 5. Aggregate Function: Get the total number of active discounts
SELECT COUNT(*) AS total_active_discounts
FROM discounts
WHERE status = 'Active';

-- 6. Bitwise: Check if the discount_id is even (using bitwise AND)
SELECT discount_id, product_id
FROM discounts
WHERE (discount_id & 1) = 0;

-- 7. Arithmetic: Calculate the duration of each discount in days
SELECT discount_id, product_id, 
       DATEDIFF(end_date, start_date) AS discount_duration_days
FROM discounts;

-- ------------------------------------------------------------------------------
-- 								Table 13 : WAREHOUSES								|
-- ------------------------------------------------------------------------------

-- 1. Arithmetic: Calculate the percentage of warehouse capacity used
SELECT warehouse_id, warehouse_name, 
       (current_stock / capacity) * 100 AS capacity_used_percentage
FROM warehouses;

-- 2. Joins: Get warehouse details along with product details (assuming a PRODUCTS table exists)
SELECT w.warehouse_id, w.warehouse_name, p.product_id, p.product_name
FROM warehouses w
JOIN products p ON w.warehouse_id = p.warehouse_id;

-- 3. Subquery: Find warehouses with current stock greater than the average current stock
SELECT warehouse_id, warehouse_name, current_stock
FROM warehouses
WHERE current_stock > (SELECT AVG(current_stock) FROM warehouses);

-- 4. String Function: Concatenate warehouse name and location
SELECT warehouse_id, 
       CONCAT(warehouse_name, ' - ', location) AS warehouse_info
FROM warehouses;

-- 5. Aggregate Function: Get the total capacity of all warehouses
SELECT SUM(capacity) AS total_capacity
FROM warehouses;

-- 6. Bitwise: Check if the warehouse_id is odd (using bitwise AND)
SELECT warehouse_id, warehouse_name
FROM warehouses
WHERE (warehouse_id & 1) = 1;

-- 7. Arithmetic: Calculate the remaining capacity of each warehouse
SELECT warehouse_id, warehouse_name, 
       capacity - current_stock AS remaining_capacity
FROM warehouses;
