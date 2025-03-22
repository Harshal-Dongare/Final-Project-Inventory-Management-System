USE inventorydb;


-- ------------------------------------------------------------------------------
-- 							Table 1 : PRODUCTS									|
-- ------------------------------------------------------------------------------

-- 1. View: Create a view to show available products
CREATE VIEW AvailableProducts AS
SELECT product_name, quantity_in_stock, price
FROM products
WHERE status = 'Available';

-- 2. CTE: Get the total number of products in each category
WITH CategoryProductCount AS (
    SELECT category_id, COUNT(*) AS product_count
    FROM products
    GROUP BY category_id
)
SELECT * FROM CategoryProductCount;

-- 3. Stored Procedure: Get products by category
DELIMITER //
CREATE PROCEDURE GetProductsByCategory(IN category INT)
BEGIN
    SELECT * FROM products WHERE category_id = category;
END //
DELIMITER ;

-- 4. Window Function: Rank products by price within each category
SELECT product_name, price, 
       RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS price_rank
FROM products;

-- 5. TCL: Update product price and commit
START TRANSACTION;
UPDATE products SET price = price * 1.1 WHERE product_id = 'B07XJ8C8F5';
COMMIT;

-- 6. DCL: Grant SELECT permission on products table to a user
GRANT SELECT ON inventorydb.products TO 'username'@'localhost';

-- 7. Trigger: Update stock quantity after an order
DELIMITER //
CREATE TRIGGER UpdateStockAfterOrder
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET quantity_in_stock = quantity_in_stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 2 : SUPPLIERS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show active suppliers
CREATE VIEW ActiveSuppliers AS
SELECT supplier_name, contact_email, contact_phone
FROM suppliers
WHERE status = 'Active';

-- 2. CTE: Get the number of products supplied by each supplier
WITH SupplierProductCount AS (
    SELECT supplier_id, COUNT(*) AS product_count
    FROM products
    GROUP BY supplier_id
)
SELECT * FROM SupplierProductCount;

-- 3. Stored Procedure: Get suppliers by city
DELIMITER //
CREATE PROCEDURE GetSuppliersByCity(IN city_name VARCHAR(100))
BEGIN
    SELECT * FROM suppliers WHERE city = city_name;
END //
DELIMITER ;

-- 4. Window Function: Rank suppliers by the number of products they supply
SELECT supplier_name, 
       COUNT(*) OVER (PARTITION BY supplier_id) AS product_count
FROM products
JOIN suppliers ON products.supplier_id = suppliers.supplier_id;

-- 5. TCL: Update supplier status and rollback on error
START TRANSACTION;
UPDATE suppliers SET status = 'Inactive' WHERE supplier_id = 'SUP001';
ROLLBACK;

-- 6. DCL: Grant UPDATE permission on suppliers table to a user
GRANT UPDATE ON inventorydb.suppliers TO 'username'@'localhost';

-- 7. Trigger: Log supplier status changes
DELIMITER //
CREATE TRIGGER LogSupplierStatusChange
AFTER UPDATE ON suppliers
FOR EACH ROW
BEGIN
    INSERT INTO supplier_status_log (supplier_id, old_status, new_status, change_date)
    VALUES (OLD.supplier_id, OLD.status, NEW.status, NOW());
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 3 : CATEGORIES									|
-- ------------------------------------------------------------------------------

-- 1. View: Create a view to show categories with product count
CREATE VIEW CategoryProductCount AS
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM categories c
LEFT JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

-- 2. CTE: Get the average price of products in each category
WITH CategoryAvgPrice AS (
    SELECT category_id, AVG(price) AS avg_price
    FROM products
    GROUP BY category_id
)
SELECT * FROM CategoryAvgPrice;

-- 3. Stored Procedure: Get category by name
DELIMITER //
CREATE PROCEDURE GetCategoryByName(IN category_name VARCHAR(100))
BEGIN
    SELECT * FROM categories WHERE category_name = category_name;
END //
DELIMITER ;

-- 4. Window Function: Rank categories by the number of products
SELECT category_name, 
       COUNT(*) OVER (PARTITION BY category_id) AS product_count
FROM products
JOIN categories ON products.category_id = categories.category_id;

-- 5. TCL: Insert a new category and commit
START TRANSACTION;
INSERT INTO categories (category_name, description) VALUES ('New Category', 'New Description');
COMMIT;

-- 6. DCL: Grant INSERT permission on categories table to a user
GRANT INSERT ON inventorydb.categories TO 'username'@'localhost';

-- 7. Trigger: Update category description on update
DELIMITER //
CREATE TRIGGER UpdateCategoryDescription
BEFORE UPDATE ON categories
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 4 : ORDERS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show pending orders
CREATE VIEW PendingOrders AS
SELECT order_id, customer_id, total_amount
FROM orders
WHERE status = 'Pending';

-- 2. CTE: Get the total amount spent by each customer
WITH CustomerTotalSpent AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM CustomerTotalSpent;

-- 3. Stored Procedure: Get orders by status
DELIMITER //
CREATE PROCEDURE GetOrdersByStatus(IN order_status VARCHAR(50))
BEGIN
    SELECT * FROM orders WHERE status = order_status;
END //
DELIMITER ;

-- 4. Window Function: Rank orders by total amount
SELECT order_id, total_amount, 
       RANK() OVER (ORDER BY total_amount DESC) AS amount_rank
FROM orders;

-- 5. TCL: Update order status and commit
START TRANSACTION;
UPDATE orders SET status = 'Shipped' WHERE order_id = 1;
COMMIT;

-- 6. DCL: Grant DELETE permission on orders table to a user
GRANT DELETE ON inventorydb.orders TO 'username'@'localhost';

-- 7. Trigger: Log order status changes
DELIMITER //
CREATE TRIGGER LogOrderStatusChange
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_status_log (order_id, old_status, new_status, change_date)
    VALUES (OLD.order_id, OLD.status, NEW.status, NOW());
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 5 : ORDER_ITEMS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show order items with product details
CREATE VIEW OrderItemDetails AS
SELECT oi.order_id, p.product_name, oi.quantity, oi.unit_price
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 2. CTE: Get the total quantity of each product ordered
WITH ProductOrderQuantity AS (
    SELECT product_id, SUM(quantity) AS total_ordered
    FROM order_items
    GROUP BY product_id
)
SELECT * FROM ProductOrderQuantity;

-- 3. Stored Procedure: Get order items by order ID
DELIMITER //
CREATE PROCEDURE GetOrderItemsByOrderId(IN order_id INT)
BEGIN
    SELECT * FROM order_items WHERE order_id = order_id;
END //
DELIMITER ;

-- 4. Window Function: Rank products by total quantity ordered
SELECT product_id, 
       SUM(quantity) OVER (PARTITION BY product_id) AS total_ordered
FROM order_items;

-- 5. TCL: Insert a new order item and commit
START TRANSACTION;
INSERT INTO order_items (order_id, product_id, quantity, unit_price) 
VALUES (1, 'B07XJ8C8F5', 2, 999.99);
COMMIT;

-- 6. DCL: Grant SELECT permission on order_items table to a user
GRANT SELECT ON inventorydb.order_items TO 'username'@'localhost';

-- 7. Trigger: Update total amount in orders table after inserting order items
DELIMITER //
CREATE TRIGGER UpdateOrderTotalAmount
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE orders
    SET total_amount = total_amount + NEW.total_price
    WHERE order_id = NEW.order_id;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 6 : CUSTOMERS									|
-- -------------------------------------------------------------------------------- 
-- 1. View: Create a view to show customers with their total orders
CREATE VIEW CustomerOrderSummary AS
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 2. CTE: Get the total amount spent by each customer
WITH CustomerTotalSpent AS (
    SELECT customer_id, SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM CustomerTotalSpent;

-- 3. Stored Procedure: Get customer by email
DELIMITER //
CREATE PROCEDURE GetCustomerByEmail(IN email VARCHAR(255))
BEGIN
    SELECT * FROM customers WHERE email = email;
END //
DELIMITER ;

-- 4. Window Function: Rank customers by total amount spent
SELECT customer_id, 
       SUM(total_amount) OVER (PARTITION BY customer_id) AS total_spent
FROM orders;

-- 5. TCL: Update customer email and commit
START TRANSACTION;
UPDATE customers SET email = 'new.email@example.com' WHERE customer_id = 1;
COMMIT;

-- 6. DCL: Grant UPDATE permission on customers table to a user
GRANT UPDATE ON inventorydb.customers TO 'username'@'localhost';

-- 7. Trigger: Log customer email changes
DELIMITER //
CREATE TRIGGER LogCustomerEmailChange
AFTER UPDATE ON customers
FOR EACH ROW
BEGIN
    INSERT INTO customer_email_log (customer_id, old_email, new_email, change_date)
    VALUES (OLD.customer_id, OLD.email, NEW.email, NOW());
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 7 : PAYMENTS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show completed payments
CREATE VIEW CompletedPayments AS
SELECT payment_id, order_id, payment_amount, payment_method
FROM payments
WHERE payment_status = 'Completed';

-- 2. CTE: Get the total amount paid by each payment method
WITH PaymentMethodTotal AS (
    SELECT payment_method, SUM(payment_amount) AS total_paid
    FROM payments
    GROUP BY payment_method
)
SELECT * FROM PaymentMethodTotal;

-- 3. Stored Procedure: Get payments by status
DELIMITER //
CREATE PROCEDURE GetPaymentsByStatus(IN payment_status VARCHAR(50))
BEGIN
    SELECT * FROM payments WHERE payment_status = payment_status;
END //
DELIMITER ;

-- 4. Window Function: Rank payments by amount
SELECT payment_id, payment_amount, 
       RANK() OVER (ORDER BY payment_amount DESC) AS amount_rank
FROM payments;

-- 5. TCL: Insert a new payment and commit
START TRANSACTION;
INSERT INTO payments (order_id, payment_amount, payment_method, payment_status, transaction_id) 
VALUES (1, 299.99, 'Credit Card', 'Completed', 'TXN123456789');
COMMIT;

-- 6. DCL: Grant SELECT permission on payments table to a user
GRANT SELECT ON inventorydb.payments TO 'username'@'localhost';

-- 7. Trigger: Update order payment status after inserting a payment
DELIMITER //
CREATE TRIGGER UpdateOrderPaymentStatus
AFTER INSERT ON payments
FOR EACH ROW
BEGIN
    UPDATE orders
    SET payment_status = NEW.payment_status
    WHERE order_id = NEW.order_id;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 8 : SHIPMENTS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show shipped orders
CREATE VIEW ShippedOrders AS
SELECT shipment_id, order_id, shipment_status, shipping_method
FROM shipments
WHERE shipment_status = 'Shipped';

-- 2. CTE: Get the total number of shipments by status
WITH ShipmentStatusCount AS (
    SELECT shipment_status, COUNT(*) AS shipment_count
    FROM shipments
    GROUP BY shipment_status
)
SELECT * FROM ShipmentStatusCount;

-- 3. Stored Procedure: Get shipments by order ID
DELIMITER //
CREATE PROCEDURE GetShipmentsByOrderId(IN order_id INT)
BEGIN
    SELECT * FROM shipments WHERE order_id = order_id;
END //
DELIMITER ;

-- 4. Window Function: Rank shipments by delivery date
SELECT shipment_id, delivery_date, 
       RANK() OVER (ORDER BY delivery_date) AS delivery_rank
FROM shipments;

-- 5. TCL: Update shipment status and commit
START TRANSACTION;
UPDATE shipments SET shipment_status = 'Delivered' WHERE shipment_id = 1;
COMMIT;

-- 6. DCL: Grant DELETE permission on shipments table to a user
GRANT DELETE ON inventorydb.shipments TO 'username'@'localhost';

-- 7. Trigger: Log shipment status changes
DELIMITER //
CREATE TRIGGER LogShipmentStatusChange
AFTER UPDATE ON shipments
FOR EACH ROW
BEGIN
    INSERT INTO shipment_status_log (shipment_id, old_status, new_status, change_date)
    VALUES (OLD.shipment_id, OLD.shipment_status, NEW.shipment_status, NOW());
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 9 : PRODUCT_REVIEWS								|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show product reviews with ratings
CREATE VIEW ProductReviewsWithRatings AS
SELECT pr.product_id, pr.rating, pr.review_comment, p.product_name
FROM product_reviews pr
JOIN products p ON pr.product_id = p.product_id;

-- 2. CTE: Get the average rating for each product
WITH ProductAvgRating AS (
    SELECT product_id, AVG(rating) AS avg_rating
    FROM product_reviews
    GROUP BY product_id
)
SELECT * FROM ProductAvgRating;

-- 3. Stored Procedure: Get reviews by product ID
DELIMITER //
CREATE PROCEDURE GetReviewsByProductId(IN product_id VARCHAR(20))
BEGIN
    SELECT * FROM product_reviews WHERE product_id = product_id;
END //
DELIMITER ;

-- 4. Window Function: Rank products by average rating
SELECT product_id, 
       AVG(rating) OVER (PARTITION BY product_id) AS avg_rating
FROM product_reviews;

-- 5. TCL: Insert a new review and commit
START TRANSACTION;
INSERT INTO product_reviews (product_id, customer_id, rating, review_comment) 
VALUES ('B07XJ8C8F5', 1, 5, 'Great product!');
COMMIT;

-- 6. DCL: Grant INSERT permission on product_reviews table to a user
GRANT INSERT ON inventorydb.product_reviews TO 'username'@'localhost';

-- 7. Trigger: Update product average rating after inserting a review
DELIMITER //
CREATE TRIGGER UpdateProductAvgRating
AFTER INSERT ON product_reviews
FOR EACH ROW
BEGIN
    UPDATE products
    SET avg_rating = (SELECT AVG(rating) FROM product_reviews WHERE product_id = NEW.product_id)
    WHERE product_id = NEW.product_id;
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 10 : INVENTORY_TRANSACTIONS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show stock additions
CREATE VIEW StockAdditions AS
SELECT transaction_id, product_id, quantity, transaction_date
FROM inventory_transactions
WHERE transaction_type = 'Stock Addition';

-- 2. CTE: Get the total quantity added or removed for each product
WITH ProductTransactionSummary AS (
    SELECT product_id, 
           SUM(CASE WHEN transaction_type = 'Stock Addition' THEN quantity ELSE -quantity END) AS net_quantity
    FROM inventory_transactions
    GROUP BY product_id
)
SELECT * FROM ProductTransactionSummary;

-- 3. Stored Procedure: Get transactions by product ID
DELIMITER //
CREATE PROCEDURE GetTransactionsByProductId(IN product_id VARCHAR(20))
BEGIN
    SELECT * FROM inventory_transactions WHERE product_id = product_id;
END //
DELIMITER ;

-- 4. Window Function: Rank products by total stock changes
SELECT product_id, 
       SUM(quantity) OVER (PARTITION BY product_id) AS total_stock_change
FROM inventory_transactions;

-- 5. TCL: Insert a new transaction and commit
START TRANSACTION;
INSERT INTO inventory_transactions (product_id, transaction_type, quantity, reason) 
VALUES ('B07XJ8C8F5', 'Stock Addition', 10, 'Restocking');
COMMIT;

-- 6. DCL: Grant SELECT permission on inventory_transactions table to a user
GRANT SELECT ON inventorydb.inventory_transactions TO 'username'@'localhost';

-- 7. Trigger: Update product stock after inventory transaction
DELIMITER //
CREATE TRIGGER UpdateProductStock
AFTER INSERT ON inventory_transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'Stock Addition' THEN
        UPDATE products
        SET quantity_in_stock = quantity_in_stock + NEW.quantity
        WHERE product_id = NEW.product_id;
    ELSE
        UPDATE products
        SET quantity_in_stock = quantity_in_stock - NEW.quantity
        WHERE product_id = NEW.product_id;
    END IF;
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 11 : RETURNS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show approved returns
CREATE VIEW ApprovedReturns AS
SELECT return_id, order_id, product_id, quantity, reason
FROM returns
WHERE status = 'Approved';

-- 2. CTE: Get the total quantity returned for each product
WITH ProductReturnSummary AS (
    SELECT product_id, SUM(quantity) AS total_returned
    FROM returns
    GROUP BY product_id
)
SELECT * FROM ProductReturnSummary;

-- 3. Stored Procedure: Get returns by status
DELIMITER //
CREATE PROCEDURE GetReturnsByStatus(IN return_status VARCHAR(50))
BEGIN
    SELECT * FROM returns WHERE status = return_status;
END //
DELIMITER ;

-- 4. Window Function: Rank products by total returns
SELECT product_id, 
       SUM(quantity) OVER (PARTITION BY product_id) AS total_returns
FROM returns;

-- 5. TCL: Update return status and commit
START TRANSACTION


-- ------------------------------------------------------------------------------
-- 							Table 12 : DISCOUNTS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show active discounts
CREATE VIEW ActiveDiscounts AS
SELECT discount_id, product_id, discount_type, discount_value
FROM discounts
WHERE status = 'Active';

-- 2. CTE: Get the total discount value for each product
WITH ProductDiscountSummary AS (
    SELECT product_id, SUM(discount_value) AS total_discount
    FROM discounts
    GROUP BY product_id
)
SELECT * FROM ProductDiscountSummary;

-- 3. Stored Procedure: Get discounts by product ID
DELIMITER //
CREATE PROCEDURE GetDiscountsByProductId(IN product_id VARCHAR(20))
BEGIN
    SELECT * FROM discounts WHERE product_id = product_id;
END //
DELIMITER ;

-- 4. Window Function: Rank products by total discount value
SELECT product_id, 
       SUM(discount_value) OVER (PARTITION BY product_id) AS total_discount
FROM discounts;

-- 5. TCL: Insert a new discount and commit
START TRANSACTION;
INSERT INTO discounts (product_id, discount_type, discount_value, start_date, end_date, status) 
VALUES ('B07XJ8C8F5', 'Percentage', 10.00, '2025-01-01', '2025-01-31', 'Active');
COMMIT;

-- 6. DCL: Grant SELECT permission on discounts table to a user
GRANT SELECT ON inventorydb.discounts TO 'username'@'localhost';

-- 7. Trigger: Update product price after discount expiration
DELIMITER //
CREATE TRIGGER UpdatePriceAfterDiscountExpiry
AFTER UPDATE ON discounts
FOR EACH ROW
BEGIN
    IF NEW.status = 'Expired' THEN
        UPDATE products
        SET price = price / (1 - OLD.discount_value / 100)
        WHERE product_id = OLD.product_id;
    END IF;
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 13 : WAREHOUSES									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show warehouses with available capacity
CREATE VIEW WarehousesWithAvailableCapacity AS
SELECT warehouse_name, location, capacity - current_stock AS available_capacity
FROM warehouses;

-- 2. CTE: Get the total capacity and current stock for each warehouse
WITH WarehouseSummary AS (
    SELECT warehouse_name, SUM(capacity) AS total_capacity, SUM(current_stock) AS total_stock
    FROM warehouses
    GROUP BY warehouse_name
)
SELECT * FROM WarehouseSummary;

-- 3. Stored Procedure: Get warehouses by location
DELIMITER //
CREATE PROCEDURE GetWarehousesByLocation(IN location_name VARCHAR(255))
BEGIN
    SELECT * FROM warehouses WHERE location = location_name;
END //
DELIMITER ;

-- 4. Window Function: Rank warehouses by current stock
SELECT warehouse_name, 
       SUM(current_stock) OVER (PARTITION BY warehouse_id) AS total_stock
FROM warehouses;

-- 5. TCL: Update warehouse capacity and commit
START TRANSACTION;
UPDATE warehouses SET capacity = 1000 WHERE warehouse_id = 1;
COMMIT;

-- 6. DCL: Grant UPDATE permission on warehouses table to a user
GRANT UPDATE ON inventorydb.warehouses TO 'username'@'localhost';

-- 7. Trigger: Log warehouse capacity changes
DELIMITER //
CREATE TRIGGER LogWarehouseCapacityChange
AFTER UPDATE ON warehouses
FOR EACH ROW
BEGIN
    INSERT INTO warehouse_capacity_log (warehouse_id, old_capacity, new_capacity, change_date)
    VALUES (OLD.warehouse_id, OLD.capacity, NEW.capacity, NOW());
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 14 : EMPLOYEE_DETAILS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show active employees
CREATE VIEW active_employees AS
SELECT * FROM employee_details WHERE status = 'Active';

-- 2. CTE: Get employees with salary above average
WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal FROM employee_details
)
SELECT * FROM employee_details WHERE salary > (SELECT avg_sal FROM avg_salary);

-- 3. Stored Procedure: Get employees by position
DELIMITER //
CREATE PROCEDURE GetEmployeesByPosition(IN pos VARCHAR(100))
BEGIN
    SELECT * FROM employee_details WHERE position = pos;
END //
DELIMITER ;

-- 4. Window Function: Rank employees by salary
SELECT employee_id, first_name, last_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employee_details;

-- 5. TCL: Update salary and commit
START TRANSACTION;
UPDATE employee_details SET salary = salary + 5000 WHERE employee_id = 1;
COMMIT;

-- 6. DCL: Grant SELECT permission to a user
GRANT SELECT ON employee_details TO 'username'@'localhost';

-- 7. Trigger: Log salary changes
DELIMITER //
CREATE TRIGGER log_salary_change
AFTER UPDATE ON employee_details
FOR EACH ROW
BEGIN
    IF OLD.salary <> NEW.salary THEN
        INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
        VALUES ('UPDATE', 'employee_details', OLD.employee_id, 1, OLD.salary, NEW.salary);
    END IF;
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 15 : USERS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show admin users
CREATE VIEW admin_users AS
SELECT * FROM users WHERE role = 'admin';

-- 2. CTE: Get users created in the last year
WITH recent_users AS (
    SELECT * FROM users WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
)
SELECT * FROM recent_users;

-- 3. Stored Procedure: Get users by role
DELIMITER //
CREATE PROCEDURE GetUsersByRole(IN user_role VARCHAR(100))
BEGIN
    SELECT * FROM users WHERE role = user_role;
END //
DELIMITER ;

-- 4. Window Function: Rank users by creation date
SELECT user_id, username, created_at,
       RANK() OVER (ORDER BY created_at DESC) AS creation_rank
FROM users;

-- 5. TCL: Update user role and rollback on error
START TRANSACTION;
UPDATE users SET role = 'manager' WHERE user_id = 1;
ROLLBACK;

-- 6. DCL: Revoke DELETE permission from a user
REVOKE DELETE ON users FROM 'username'@'localhost';

-- 7. Trigger: Log user role changes
DELIMITER //
CREATE TRIGGER log_role_change
AFTER UPDATE ON users
FOR EACH ROW
BEGIN
    IF OLD.role <> NEW.role THEN
        INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
        VALUES ('UPDATE', 'users', OLD.user_id, 1, OLD.role, NEW.role);
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 16 : AUDIT_LOGS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show recent audit logs
CREATE VIEW recent_audit_logs AS
SELECT * FROM audit_logs WHERE action_timestamp >= DATE_SUB(NOW(), INTERVAL 7 DAY);

-- 2. CTE: Get audit logs for a specific table
WITH table_audits AS (
    SELECT * FROM audit_logs WHERE table_name = 'products'
)
SELECT * FROM table_audits;

-- 3. Stored Procedure: Get audit logs by action type
DELIMITER //
CREATE PROCEDURE GetAuditLogsByAction(IN action VARCHAR(100))
BEGIN
    SELECT * FROM audit_logs WHERE action_type = action;
END //
DELIMITER ;

-- 4. Window Function: Rank audit logs by timestamp
SELECT audit_id, action_type, table_name, action_timestamp,
       RANK() OVER (ORDER BY action_timestamp DESC) AS log_rank
FROM audit_logs;

-- 5. TCL: Insert audit log and commit
START TRANSACTION;
INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
VALUES ('INSERT', 'products', 'B07XJ8C8F5', 1, NULL, '{"product_name": "Apple iPhone 13"}');
COMMIT;

-- 6. DCL: Grant INSERT permission to a user
GRANT INSERT ON audit_logs TO 'username'@'localhost';

-- 7. Trigger: Prevent deletion of audit logs
DELIMITER //
CREATE TRIGGER prevent_audit_log_deletion
BEFORE DELETE ON audit_logs
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion of audit logs is not allowed';
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 17 : TAXES									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show active taxes
CREATE VIEW active_taxes AS
SELECT * FROM taxes WHERE tax_rate > 0;

-- 2. CTE: Get taxes by country
WITH country_taxes AS (
    SELECT * FROM taxes WHERE country = 'USA'
)
SELECT * FROM country_taxes;

-- 3. Stored Procedure: Get taxes by type
DELIMITER //
CREATE PROCEDURE GetTaxesByType(IN tax_type VARCHAR(100))
BEGIN
    SELECT * FROM taxes WHERE tax_type = tax_type;
END //
DELIMITER ;

-- 4. Window Function: Rank taxes by rate
SELECT tax_id, tax_type, tax_rate,
       RANK() OVER (ORDER BY tax_rate DESC) AS tax_rate_rank
FROM taxes;

-- 5. TCL: Update tax rate and commit
START TRANSACTION;
UPDATE taxes SET tax_rate = 10.00 WHERE tax_id = 1;
COMMIT;

-- 6. DCL: Grant UPDATE permission to a user
GRANT UPDATE ON taxes TO 'username'@'localhost';

-- 7. Trigger: Log tax rate changes
DELIMITER //
CREATE TRIGGER log_tax_rate_change
AFTER UPDATE ON taxes
FOR EACH ROW
BEGIN
    IF OLD.tax_rate <> NEW.tax_rate THEN
        INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
        VALUES ('UPDATE', 'taxes', OLD.tax_id, 1, OLD.tax_rate, NEW.tax_rate);
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 18 : PRODUCT_IMAGES							|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show primary images
CREATE VIEW primary_images AS
SELECT * FROM product_images WHERE is_primary = TRUE;

-- 2. CTE: Get images for a specific product
WITH product_images_cte AS (
    SELECT * FROM product_images WHERE product_id = 'B07XJ8C8F5'
)
SELECT * FROM product_images_cte;

-- 3. Stored Procedure: Get images by product
DELIMITER //
CREATE PROCEDURE GetImagesByProduct(IN prod_id VARCHAR(20))
BEGIN
    SELECT * FROM product_images WHERE product_id = prod_id;
END //
DELIMITER ;

-- 4. Window Function: Rank images by creation date
SELECT image_id, product_id, created_at,
       RANK() OVER (PARTITION BY product_id ORDER BY created_at DESC) AS image_rank
FROM product_images;

-- 5. TCL: Insert image and commit
START TRANSACTION;
INSERT INTO product_images (product_id, image_url, image_description, is_primary)
VALUES ('B07XJ8C8F5', 'https://example.com/images/iphone13_back.jpg', 'Back view of Apple iPhone 13', FALSE);
COMMIT;

-- 6. DCL: Grant DELETE permission to a user
GRANT DELETE ON product_images TO 'username'@'localhost';

-- 7. Trigger: Prevent deletion of primary images
DELIMITER //
CREATE TRIGGER prevent_primary_image_deletion
BEFORE DELETE ON product_images
FOR EACH ROW
BEGIN
    IF OLD.is_primary = TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion of primary images is not allowed';
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 19 : SHIPPING_METHODS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show active shipping methods
CREATE VIEW active_shipping_methods AS
SELECT * FROM shipping_methods WHERE is_active = TRUE;

-- 2. CTE: Get shipping methods by price range
WITH cheap_shipping AS (
    SELECT * FROM shipping_methods WHERE price < 10.00
)
SELECT * FROM cheap_shipping;

-- 3. Stored Procedure: Get shipping methods by delivery time
DELIMITER //
CREATE PROCEDURE GetShippingMethodsByTime(IN delivery_time VARCHAR(50))
BEGIN
    SELECT * FROM shipping_methods WHERE delivery_time = delivery_time;
END //
DELIMITER ;

-- 4. Window Function: Rank shipping methods by price
SELECT method_id, method_name, price,
       RANK() OVER (ORDER BY price ASC) AS price_rank
FROM shipping_methods;

-- 5. TCL: Update shipping price and commit
START TRANSACTION;
UPDATE shipping_methods SET price = 15.00 WHERE method_id = 1;
COMMIT;

-- 6. DCL: Grant SELECT permission to a user
GRANT SELECT ON shipping_methods TO 'username'@'localhost';

-- 7. Trigger: Log shipping method changes
DELIMITER //
CREATE TRIGGER log_shipping_method_change
AFTER UPDATE ON shipping_methods
FOR EACH ROW
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
        VALUES ('UPDATE', 'shipping_methods', OLD.method_id, 1, OLD.price, NEW.price);
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 20 : PROMOTIONS								|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show active promotions
CREATE VIEW active_promotions AS
SELECT * FROM promotions WHERE is_active = TRUE;

-- 2. CTE: Get promotions by category
WITH electronics_promotions AS (
    SELECT * FROM promotions WHERE eligible_category = 'Electronics'
)
SELECT * FROM electronics_promotions;

-- 3. Stored Procedure: Get promotions by date range
DELIMITER //
CREATE PROCEDURE GetPromotionsByDateRange(IN start_date DATE, IN end_date DATE)
BEGIN
    SELECT * FROM promotions WHERE start_date >= start_date AND end_date <= end_date;
END //
DELIMITER ;

-- 4. Window Function: Rank promotions by discount percentage
SELECT promotion_id, promo_code, discount_percentage,
       RANK() OVER (ORDER BY discount_percentage DESC) AS discount_rank
FROM promotions;

-- 5. TCL: Insert promotion and commit
START TRANSACTION;
INSERT INTO promotions (promo_code, discount_percentage, start_date, end_date, eligible_category, is_active, description)
VALUES ('SUMMER25', 25.00, '2023-06-01', '2023-08-31', 'Electronics', TRUE, 'Summer sale for electronics');
COMMIT;

-- 6. DCL: Grant UPDATE permission to a user
GRANT UPDATE ON promotions TO 'username'@'localhost';

-- 7. Trigger: Prevent deletion of active promotions
DELIMITER //
CREATE TRIGGER prevent_active_promotion_deletion
BEFORE DELETE ON promotions
FOR EACH ROW
BEGIN
    IF OLD.is_active = TRUE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion of active promotions is not allowed';
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 21 : SUPPORT_TICKETS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show open tickets
CREATE VIEW open_tickets AS
SELECT * FROM support_tickets WHERE status = 'Open';

-- 2. CTE: Get tickets by priority
WITH high_priority_tickets AS (
    SELECT * FROM support_tickets WHERE priority = 'High'
)
SELECT * FROM high_priority_tickets;

-- 3. Stored Procedure: Get tickets by status
DELIMITER //
CREATE PROCEDURE GetTicketsByStatus(IN ticket_status VARCHAR(50))
BEGIN
    SELECT * FROM support_tickets WHERE status = ticket_status;
END //
DELIMITER ;

-- 4. Window Function: Rank tickets by creation date
SELECT ticket_id, customer_id, created_at,
       RANK() OVER (ORDER BY created_at DESC) AS ticket_rank
FROM support_tickets;

-- 5. TCL: Update ticket status and commit
START TRANSACTION;
UPDATE support_tickets SET status = 'Resolved' WHERE ticket_id = 1;
COMMIT;

-- 6. DCL: Grant SELECT permission to a user
GRANT SELECT ON support_tickets TO 'username'@'localhost';

-- 7. Trigger: Log ticket status changes
DELIMITER //
CREATE TRIGGER log_ticket_status_change
AFTER UPDATE ON support_tickets
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
        VALUES ('UPDATE', 'support_tickets', OLD.ticket_id, 1, OLD.status, NEW.status);
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 22 : FEEDBACK									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show feedback with high ratings
CREATE VIEW high_ratings_feedback AS
SELECT * FROM feedback WHERE rating >= 4;

-- 2. CTE: Get feedback by customer
WITH customer_feedback AS (
    SELECT * FROM feedback WHERE customer_id = 1
)
SELECT * FROM customer_feedback;

-- 3. Stored Procedure: Get feedback by rating
DELIMITER //
CREATE PROCEDURE GetFeedbackByRating(IN rating_value INT)
BEGIN
    SELECT * FROM feedback WHERE rating = rating_value;
END //
DELIMITER ;

-- 4. Window Function: Rank feedback by submission date
SELECT feedback_id, customer_id, submitted_at,
       RANK() OVER (ORDER BY submitted_at DESC) AS feedback_rank
FROM feedback;

-- 5. TCL: Insert feedback and commit
START TRANSACTION;
INSERT INTO feedback (customer_id, rating, comments)
VALUES (1, 5, 'Excellent service!');
COMMIT;

-- 6. DCL: Grant INSERT permission to a user
GRANT INSERT ON feedback TO 'username'@'localhost';

-- 7. Trigger: Prevent deletion of feedback
DELIMITER //
CREATE TRIGGER prevent_feedback_deletion
BEFORE DELETE ON feedback
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion of feedback is not allowed';
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 23 : ACTIVITY_LOG									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show failed login attempts
CREATE VIEW failed_logins AS
SELECT * FROM activity_log WHERE success_status = 'Failure';

-- 2. CTE: Get activity logs by user
WITH user_activity AS (
    SELECT * FROM activity_log WHERE user_id = 1
)
SELECT * FROM user_activity;

-- 3. Stored Procedure: Get activity logs by type
DELIMITER //
CREATE PROCEDURE GetActivityLogsByType(IN activity_type VARCHAR(100))
BEGIN
    SELECT * FROM activity_log WHERE activity_type = activity_type;
END //
DELIMITER ;

-- 4. Window Function: Rank activity logs by timestamp
SELECT log_id, user_id, activity_timestamp,
       RANK() OVER (ORDER BY activity_timestamp DESC) AS activity_rank
FROM activity_log;

-- 5. TCL: Insert activity log and commit
START TRANSACTION;
INSERT INTO activity_log (user_id, activity_type, activity_description, ip_address, device_type, location, success_status)
VALUES (1, 'Login', 'User logged into the system', '192.168.1.1', 'Desktop', 'New York, USA', 'Success');
COMMIT;

-- 6. DCL: Grant SELECT permission to a user
GRANT SELECT ON activity_log TO 'username'@'localhost';

-- 7. Trigger: Prevent deletion of activity logs
DELIMITER //
CREATE TRIGGER prevent_activity_log_deletion
BEFORE DELETE ON activity_log
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Deletion of activity logs is not allowed';
END //
DELIMITER ;


-- ------------------------------------------------------------------------------
-- 							Table 24 : USER_ROLES									|
-- ------------------------------------------------------------------------------

-- 1. View: Create a view to show active roles
CREATE VIEW active_roles AS
SELECT * FROM user_roles WHERE is_active = TRUE;

-- 2. CTE: Get roles by assigned user
WITH assigned_roles AS (
    SELECT * FROM user_roles WHERE assigned_by = 1
)
SELECT * FROM assigned_roles;

-- 3. Stored Procedure: Get roles by name
DELIMITER //
CREATE PROCEDURE GetRolesByName(IN role_name VARCHAR(100))
BEGIN
    SELECT * FROM user_roles WHERE role_name = role_name;
END //
DELIMITER ;

-- 4. Window Function: Rank roles by creation date
SELECT role_id, role_name, created_at,
       RANK() OVER (ORDER BY created_at DESC) AS role_rank
FROM user_roles;

-- 5. TCL: Update role status and commit
START TRANSACTION;
UPDATE user_roles SET is_active = FALSE WHERE role_id = 1;
COMMIT;

-- 6. DCL: Grant UPDATE permission to a user
GRANT UPDATE ON user_roles TO 'username'@'localhost';

-- 7. Trigger: Log role status changes
DELIMITER //
CREATE TRIGGER log_role_status_change
AFTER UPDATE ON user_roles
FOR EACH ROW
BEGIN
    IF OLD.is_active <> NEW.is_active THEN
        INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
        VALUES ('UPDATE', 'user_roles', OLD.role_id, 1, OLD.is_active, NEW.is_active);
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------------------------
-- 							Table 25 : BRANDS									|
-- ------------------------------------------------------------------------------
-- 1. View: Create a view to show active brands
CREATE VIEW active_brands AS
SELECT * FROM brands WHERE status = 'Active';

-- 2. CTE: Get brands by country
WITH usa_brands AS (
    SELECT * FROM brands WHERE country_of_origin = 'USA'
)
SELECT * FROM usa_brands;

-- 3. Stored Procedure: Get brands by category
DELIMITER //
CREATE PROCEDURE GetBrandsByCategory(IN category VARCHAR(100))
BEGIN
    SELECT * FROM brands WHERE product_categories LIKE CONCAT('%', category, '%');
END //
DELIMITER ;

-- 4. Window Function: Rank brands by revenue
SELECT brand_id, brand_name, revenue,
       RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM brands;

-- 5. TCL: Update brand status and commit
START TRANSACTION;
UPDATE brands SET status = 'Inactive' WHERE brand_id = 1;
COMMIT;

-- 6. DCL: Grant SELECT permission to a user
GRANT SELECT ON brands TO 'username'@'localhost';

-- 7. Trigger: Log brand status changes
DELIMITER //
CREATE TRIGGER log_brand_status_change
AFTER UPDATE ON brands
FOR EACH ROW
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO audit_logs (action_type, table_name, record_id, user_id, old_value, new_value)
        VALUES ('UPDATE', 'brands', OLD.brand_id, 1, OLD.status, NEW.status);
    END IF;
END //
DELIMITER ;

