
-- ------------------------------------------------------------------------------
-- 							Database : INVENTORYDB								|
-- ------------------------------------------------------------------------------

-- Create database INVENTORYDB if it does not exists
CREATE DATABASE IF NOT EXISTS inventorydb; 

-- Switch to INVENTORYDB database
USE inventorydb;

-- Drop database INVENTORYDB if it exists
DROP DATABASE IF EXISTS inventorydb;

-- ------------------------------------------------------------------------------
-- 							Table 1 : PRODUCTS									|
-- ------------------------------------------------------------------------------

/* 
PURPOSE: Product table is used to store and managed the details of each product in the inventory, such as
its name, category, stock quantity, and price
*/

-- Create table PRODUCTS
CREATE TABLE products(
	product_id VARCHAR(20) PRIMARY KEY,												-- Alphanumeric unique identifier for each product
    product_name VARCHAR(255) NOT NULL,												-- Name of the product, cannot be NULL
    category_id INT,																-- Category of the product
    quantity_in_stock INT NOT NULL CHECK(quantity_in_stock >= 0),					-- Quantity in stock
    price DECIMAL(10, 2) CHECK(price >= 0),											-- Price of the product
    supplier_id VARCHAR(20),														-- Supplier of the product
    reorder_level INT DEFAULT 0,													-- Reorder level (minimum stock), DEFAULT is 0
    description TEXT,																-- Description of the product, can be NULL
    location VARCHAR(255),															-- Location of the product in the warehouse
    status ENUM('Available', 'Out of Stock', 'Discontinued') NOT NULL,				-- Status of the product
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,									-- Timestamp for when the record was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		-- Timestamp for when the record was last updated
);



-- Insert each product information in the PRODUCTS table
INSERT INTO products(product_id, product_name, category_id, quantity_in_stock, price, supplier_id, reorder_level, description, location, status)
VALUES
('B07XJ8C8F5', 'Apple iPhone 13', 1, 50, 999.99, 'SUP006', 10, 'Latest Apple iPhone model', 'Aisle 3, Shelf 5', 'Available'),  
('B08N5WRWNW', 'Samsung Galaxy S21', 1, 40, 799.99, 'SUP007', 8, 'Samsung flagship smartphone', 'Aisle 3, Shelf 6', 'Available'),  
('B07HFGQJ69', 'Sony WH-1000XM4', 2, 30, 349.99, 'SUP008', 5, 'Noise-canceling wireless headphones', 'Aisle 4, Shelf 2', 'Available'),  
('B08L5NP6NG', 'Dell XPS 13', 3, 25, 1199.99, 'SUP009', 5, '13-inch ultrabook laptop', 'Aisle 5, Shelf 1', 'Available'),  
('B09G3HRMVB', 'Logitech MX Master 3', 2, 35, 99.99, 'SUP012', 7, 'Wireless ergonomic mouse', 'Aisle 4, Shelf 3', 'Available'),  
('B07FZ8S74R', 'Amazon Echo Dot', 4, 60, 49.99, 'SUP012', 15, 'Smart speaker with Alexa', 'Aisle 6, Shelf 4', 'Available'),  
('B07VJYZF6D', 'Nintendo Switch', 5, 20, 299.99, 'SUP018', 4, 'Handheld gaming console', 'Aisle 7, Shelf 1', 'Available'),  
('B0916FZWG2', 'Apple MacBook Air M1', 3, 18, 999.99, 'SUP006', 4, 'Lightweight and powerful laptop', 'Aisle 5, Shelf 2', 'Available'),  
('B07N4M4V14', 'Bose SoundLink Mini II', 2, 22, 179.99, 'SUP016', 6, 'Compact Bluetooth speaker', 'Aisle 4, Shelf 5', 'Available'),  
('B07K344J3N', 'Microsoft Surface Pro 7', 3, 12, 899.99, 'SUP011', 3, '2-in-1 detachable laptop', 'Aisle 5, Shelf 3', 'Available'),  
('B08HR5SXPS', 'Sony PlayStation 5', 5, 10, 499.99, 'SUP008', 2, 'Next-gen gaming console', 'Aisle 7, Shelf 2', 'Out of Stock'),  
('B08164VTWH', 'Samsung 32-inch 4K Monitor', 1, 15, 349.99, 'SUP007', 4, 'UHD Monitor with HDR', 'Aisle 3, Shelf 7', 'Available'),  
('B07PW9VBK5', 'HP Envy 13', 3, 14, 849.99, 'SUP010', 3, 'Slim and stylish ultrabook', 'Aisle 5, Shelf 4', 'Available'),  
('B07YLX795P', 'Google Nest Hub', 4, 25, 129.99, 'SUP017', 6, 'Smart display with Google Assistant', 'Aisle 6, Shelf 3', 'Available'),  
('B0932NR34V', 'Lenovo ThinkPad X1 Carbon', 3, 10, 1399.99, 'SUP013', 3, 'Business-grade premium laptop', 'Aisle 5, Shelf 5', 'Available'),  
('B07KR9L7Q6', 'JBL Flip 5', 2, 28, 99.99, 'SUP015', 5, 'Waterproof Bluetooth speaker', 'Aisle 4, Shelf 6', 'Available'),  
('B08H93ZRK9', 'Fitbit Charge 5', 6, 30, 149.99, 'SUP019', 7, 'Fitness tracker with heart rate monitor', 'Aisle 8, Shelf 2', 'Available'),  
('B08J5F3G18', 'Razer BlackWidow V3', 2, 18, 129.99, 'SUP018', 4, 'Mechanical gaming keyboard', 'Aisle 4, Shelf 7', 'Available'),  
('B07GB5WKH8', 'Garmin Forerunner 245', 6, 15, 299.99, 'SUP019', 4, 'GPS running smartwatch', 'Aisle 8, Shelf 3', 'Available'),  
('B081TQ92F3', 'Corsair K95 RGB Platinum', 2, 10, 199.99, 'SUP020', 3, 'High-end mechanical keyboard', 'Aisle 4, Shelf 8', 'Available');

-- View all PRODUCTS information
SELECT * FROM products;


-- ------------------------------------------------------------------------------
-- 							Table 2 : SUPPLIERS									|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The suppliers table stores detailed information about the vendors or suppliers who provide products to the inventory, 
enabling tracking and management of procurement sources.
*/

-- Create table SUPPLIERS
CREATE TABLE suppliers(
	supplier_id VARCHAR(20) PRIMARY KEY,											-- Unique identifier for the supplier
    supplier_name VARCHAR(255) NOT NULL,											-- Name of the supplier, cannot be NULL
    contact_name VARCHAR(255),														-- Name of the contact person
    contact_email VARCHAR(255) UNIQUE,												-- Contact email, must be unique
    contact_phone VARCHAR(20),														-- Contact phone number
    address TEXT,																	-- Address of the supplier
    city VARCHAR(100),																-- City where the supplier is located
    country VARCHAR(100),															-- Country of the supplier
    status ENUM('Active', 'Inactive') DEFAULT 'Active',								-- Status of the supplier, default is 'Active'\
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,									-- Record creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP		-- Last update timestamp
);

-- Insert each supplier information in the SUPPLIERS table
INSERT INTO suppliers(supplier_id, supplier_name, contact_name, contact_email, contact_phone, address, city, country, status)
VALUES
('SUP001', 'Fast Track Electronics', 'Amit Verma', 'amit.verma@fasttrack.com', '+91-9876543210', 'Building 21, Industrial Area', 'Mumbai', 'India', 'Active'),
('SUP002', 'Global Tech Supplies', 'Priya Sharma', 'priya.sharma@globaltech.com', '+91-8765432109', 'Sector 5, IT Park', 'Bangalore', 'India', 'Active'),
('SUP003', 'Quick Connect Distributors', 'Rajesh Gupta', 'rajesh.gupta@quickconnect.com', '+91-7654321098', 'Plot 12, Electronic City', 'Delhi', 'India', 'Active'),
('SUP004', 'Electro World', 'Sanjay Patel', 'sanjay.patel@electroworld.com', '+91-6543210987', 'Mall Road, Sector 9', 'Ahmedabad', 'India', 'Active'),
('SUP005', 'Techno Traders', 'Neha Kapoor', 'neha.kapoor@technotraders.com', '+91-5432109876', 'Industrial Estate', 'Hyderabad', 'India', 'Active'),
('SUP006', 'Bright Future Gadgets', 'Vikas Singh', 'vikas.singh@brightfuture.com', '+91-4321098765', 'Gadget Lane, Tech Market', 'Chennai', 'India', 'Active'),
('SUP007', 'Infinity Solutions', 'Anita Mehta', 'anita.mehta@infinity.com', '+91-3210987654', 'Near IT Plaza', 'Pune', 'India', 'Inactive'),
('SUP008', 'Smart Electronics', 'Deepak Choudhary', 'deepak.choudhary@smartelectronics.com', '+91-2109876543', 'Gadget Bazaar', 'Kolkata', 'India', 'Active'),
('SUP009', 'Digitron Distributors', 'Pooja Aggarwal', 'pooja.aggarwal@digitron.com', '+91-1098765432', 'Electronics Market', 'Jaipur', 'India', 'Active'),
('SUP010', 'NextGen Components', 'Aakash Malhotra', 'aakash.malhotra@nextgen.com', '+91-0987654321', 'Tech Hub', 'Lucknow', 'India', 'Active'),
('SUP011', 'Elite Tech Solutions', 'Ravi Desai', 'ravi.desai@elitetech.com', '+91-9876541230', 'Block C, IT Sector', 'Surat', 'India', 'Active'),
('SUP012', 'Precision Parts', 'Kiran Bhatia', 'kiran.bhatia@precisionparts.com', '+91-8765432101', 'Industrial Complex', 'Nagpur', 'India', 'Active'),
('SUP013', 'Gadget Hub', 'Manish Tiwari', 'manish.tiwari@gadgethub.com', '+91-7654321092', 'Tech Street', 'Indore', 'India', 'Active'),
('SUP014', 'Digital Era Suppliers', 'Anjali Singh', 'anjali.singh@digitalera.com', '+91-6543210983', 'Cyber Park', 'Chandigarh', 'India', 'Active'),
('SUP015', 'Tech Power Distributors', 'Rahul Sharma', 'rahul.sharma@techpower.com', '+91-5432109874', 'Silicon Valley', 'Noida', 'India', 'Active'),
('SUP016', 'Smart Solutions', 'Meera Joshi', 'meera.joshi@smartsolutions.com', '+91-4321098765', 'High-Tech Avenue', 'Bhopal', 'India', 'Active'),
('SUP017', 'Advanced Electronics', 'Suresh Iyer', 'suresh.iyer@advancedelectronics.com', '+91-3210987656', 'Innovation Park', 'Visakhapatnam', 'India', 'Active'),
('SUP018', 'FutureTech Distributors', 'Pankaj Mishra', 'pankaj.mishra@futuretech.com', '+91-2109876547', 'Tech Plaza', 'Cochin', 'India', 'Active'),
('SUP019', 'ElectroMart', 'Shalini Kapoor', 'shalini.kapoor@electromart.com', '+91-1098765438', 'Gadget Center', 'Patna', 'India', 'Active'),
('SUP020', 'Next Level Components', 'Vivek Gupta', 'vivek.gupta@nextlevel.com', '+91-0987654329', 'Innovation Hub', 'Dehradun', 'India', 'Active');

-- View all SUPPLIERS information
SELECT * FROM suppliers;


-- ------------------------------------------------------------------------------
-- 							Table 3 : CATEGORIES								|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The categories table organizes products into different groups or types, helping to classify and manage products efficiently. 
It allows easy categorization, filtering, and search operations within the inventory system.
*/

-- Create CATEGORIES table
CREATE TABLE categories(
	category_id INT AUTO_INCREMENT PRIMARY KEY,						-- Unique identifier for each category
    category_name VARCHAR(100) NOT NULL UNIQUE,						-- Name of the category, must be unique
    description TEXT,												-- Description of the category
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,					-- Timestamp for when the record was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
				ON UPDATE CURRENT_TIMESTAMP							-- Last updated timestamp
);

-- Insert category information in CATEGORIES table
INSERT INTO categories (category_name, description) 
VALUES
('Electronics', 'Devices and gadgets such as smartphones, laptops, and accessories'),
('Home Appliances', 'Electrical machines used in households like refrigerators and washing machines'),
('Furniture', 'Household and office furniture including tables, chairs, and sofas'),
('Clothing', 'Apparel for men, women, and children including shirts, pants, and dresses'),
('Footwear', 'Different types of shoes, sandals, and slippers'),
('Beauty & Personal Care', 'Cosmetics, skincare, and personal grooming products'),
('Sports & Fitness', 'Gym equipment, sports gear, and fitness accessories'),
('Automobile Accessories', 'Car and bike accessories including helmets and seat covers'),
('Toys & Games', 'Toys, board games, and gaming consoles for all ages'),
('Books & Stationery', 'Books, notebooks, pens, and office supplies'),
('Groceries', 'Daily essentials like food grains, vegetables, and dairy products'),
('Medical Supplies', 'Health-related products such as medicines, masks, and sanitizers'),
('Jewelry & Accessories', 'Gold, silver, artificial jewelry, and fashion accessories'),
('Pet Supplies', 'Products for pet care including food, toys, and grooming items'),
('Music & Instruments', 'Musical instruments and accessories like guitars, keyboards, and microphones'),
('Cameras & Accessories', 'Cameras, tripods, and photography-related equipment'),
('Gaming', 'Gaming consoles, accessories, and PC gaming components'),
('Industrial Equipment', 'Heavy machinery, tools, and industrial-use equipment'),
('Office Supplies', 'Office furniture, printers, and accessories'),
('Smart Home Devices', 'IoT devices like smart lights, smart speakers, and security cameras');

-- View CATEGORY information
SELECT * FROM categories;

-- Connect the PRODUCT table with the CATEGORIES and SUPPLIERS tables using foreign keys
ALTER TABLE products 
ADD CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id),
ADD CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id);


-- ------------------------------------------------------------------------------
-- 								Table 4 : ORDERS								|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The orders table tracks customer orders in an inventory management system. It captures key details about the order, 
such as the products ordered, the customer who placed the order, the order's status, and payment information.
*/

-- Create ORDERS table
CREATE TABLE orders(
	order_id INT AUTO_INCREMENT PRIMARY KEY, 					-- Unique identifier for each order
    customer_id INT,											-- Reference to the customer placing the order
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,				-- Date and time the order placed
    total_amount DECIMAL(10, 2) NOT NULL,						-- Total price of the order
    status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') 
				Default 'Pending',								-- Status of the order, DEFAULT is 'Pending'
	shipping_address VARCHAR(255) NOT NULL,						-- Shipping address for the order
    payment_status ENUM('Pending', 'Completed', 'Failed')		
				DEFAULT 'Pending', 								-- Payment status of the order, DEFAULT is 'Pending'
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,				-- Timestamp for when the record was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
				ON UPDATE CURRENT_TIMESTAMP						-- Last updated timestamp
);

-- Inserting sample order records into the orders table
INSERT INTO orders(customer_id, order_date, total_amount, status, shipping_address, payment_status)
VALUES
(1, '2025-01-08 10:30:00', 299.99, 'Pending', '1234 Elm St, Springfield, IL, 62701', 'Pending'),
(2, '2025-01-09 12:15:00', 499.99, 'Shipped', '5678 Oak St, Springfield, IL, 62702', 'Completed'),
(3, '2025-01-10 09:45:00', 150.75, 'Delivered', '2345 Maple Ave, Springfield, IL, 62703', 'Completed'),
(4, '2025-01-11 14:30:00', 249.50, 'Pending', '6789 Pine Rd, Springfield, IL, 62704', 'Pending'),
(5, '2025-01-12 11:00:00', 125.20, 'Cancelled', '3456 Birch Blvd, Springfield, IL, 62705', 'Failed'),
(6, '2025-01-13 16:00:00', 350.00, 'Shipped', '4567 Cedar Ln, Springfield, IL, 62706', 'Completed'),
(7, '2025-01-14 13:30:00', 499.99, 'Pending', '5678 Redwood St, Springfield, IL, 62707', 'Pending'),
(8, '2025-01-15 10:00:00', 700.00, 'Delivered', '1234 Willow Dr, Springfield, IL, 62708', 'Completed'),
(9, '2025-01-16 17:45:00', 120.99, 'Shipped', '8765 Elmwood Rd, Springfield, IL, 62709', 'Completed'),
(10, '2025-01-17 11:30:00', 450.50, 'Cancelled', '2345 Oakwood Ave, Springfield, IL, 62710', 'Failed'),
(11, '2025-01-18 12:00:00', 220.00, 'Shipped', '6789 Pine St, Springfield, IL, 62711', 'Completed'),
(12, '2025-01-19 14:30:00', 350.75, 'Pending', '2345 Maple Rd, Springfield, IL, 62712', 'Pending'),
(13, '2025-01-20 09:15:00', 500.25, 'Delivered', '3456 Birch St, Springfield, IL, 62713', 'Completed'),
(14, '2025-01-21 13:00:00', 800.00, 'Shipped', '5678 Cedar Dr, Springfield, IL, 62714', 'Completed'),
(15, '2025-01-22 11:00:00', 100.00, 'Pending', '4567 Redwood Ln, Springfield, IL, 62715', 'Pending'),
(16, '2025-01-23 15:00:00', 275.99, 'Delivered', '6789 Willow Blvd, Springfield, IL, 62716', 'Completed'),
(17, '2025-01-24 10:45:00', 390.00, 'Shipped', '1234 Oakwood St, Springfield, IL, 62717', 'Completed'),
(18, '2025-01-25 12:30:00', 220.80, 'Pending', '2345 Cedar Rd, Springfield, IL, 62718', 'Pending'),
(19, '2025-01-26 11:15:00', 500.00, 'Shipped', '5678 Birch Dr, Springfield, IL, 62719', 'Completed'),
(20, '2025-01-27 14:00:00', 150.00, 'Cancelled', '6789 Maple Ln, Springfield, IL, 62720', 'Failed');

-- View ORDERS table
SELECT * FROM orders;

-- Add foreign key constraint to connect ORDERS table with CUSTOMERS table
ALTER TABLE orders
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
ON DELETE CASCADE;

-- ------------------------------------------------------------------------------
-- 								Table 5 : ORDER_ITEMS							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: This table tracks which products are included in each order. It connects products to orders and captures
details about the quantity and price for each product in a specific order.
*/

-- Create table ORDER_ITEMS
CREATE TABLE order_items(
	order_item_id INT AUTO_INCREMENT PRIMARY KEY, 					-- Unique identifier for each order item
    order_id INT,													-- ID of the order to which the item belongs
    product_id VARCHAR(20),											-- ID of the product being ordered
    quantity INT NOT NULL CHECK(quantity > 0),						-- Quantity of the product in the order
    unit_price DECIMAL(10, 2) CHECK(unit_price >= 0),				--  Price of one unit of the product
    total_price DECIMAL(10, 2) 
		GENERATED ALWAYS AS (quantity * unit_price) STORED, 		-- Total price for the product in the order
	
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
		ON DELETE CASCADE,											-- Foreign key referencing orders table 
	FOREIGN KEY (product_id) REFERENCES products(product_id)
		ON DELETE CASCADE											-- Foreign key referencing products table
);



-- Insert data into ORDER_ITEMS
INSERT INTO order_items(order_id, product_id, quantity, unit_price)
VALUES
(1, 'B07XJ8C8F5', 2, 999.99),
(1, 'B08N5WRWNW', 1, 799.99),
(2, 'B07HFGQJ69', 3, 349.99),
(3, 'B08L5NP6NG', 1, 1199.99),
(3, 'B09G3HRMVB', 2, 99.99),
(4, 'B07FZ8S74R', 2, 49.99),
(5, 'B07VJYZF6D', 1, 299.99),
(6, 'B0916FZWG2', 1, 999.99),
(6, 'B07N4M4V14', 2, 179.99),
(7, 'B07K344J3N', 1, 899.99),
(8, 'B08HR5SXPS', 1, 499.99),
(9, 'B08164VTWH', 1, 349.99),
(10, 'B07PW9VBK5', 3, 849.99),
(11, 'B07YLX795P', 1, 129.99),
(12, 'B0932NR34V', 2, 1399.99),
(13, 'B07KR9L7Q6', 1, 99.99),
(14, 'B08H93ZRK9', 2, 149.99),
(15, 'B08J5F3G18', 1, 129.99),
(16, 'B07GB5WKH8', 1, 299.99),
(17, 'B081TQ92F3', 1, 199.99);


-- View order_items data
SELECT * FROM order_items;

-- ------------------------------------------------------------------------------
-- 								Table 6 : CUSTOMERS								|
-- ------------------------------------------------------------------------------

-- Create CUSTOMERS table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,        		-- Unique identifier for each customer
    first_name VARCHAR(100) NOT NULL,                  		-- Customer's first name
    last_name VARCHAR(100) NOT NULL,                   		-- Customer's last name
    email VARCHAR(255) UNIQUE NOT NULL,                		-- Customer's email address, unique
    phone VARCHAR(15),                                 		-- Customer's phone number
    shipping_address TEXT,                             		-- Customer's shipping address
    billing_address TEXT,                              		-- Customer's billing address
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP  	-- Timestamp for when the customer registered
);

-- Insert data into CUSTOMERS table
INSERT INTO customers (first_name, last_name, email, phone, shipping_address, billing_address)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '1234 Elm Street, Springfield', '1234 Elm Street, Springfield'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '5678 Oak Avenue, Springfield', '5678 Oak Avenue, Springfield'),
('Alice', 'Johnson', 'alice.johnson@example.com', '1122334455', '91011 Pine Road, Springfield', '91011 Pine Road, Springfield'),
('Bob', 'Brown', 'bob.brown@example.com', '2233445566', '1213 Maple Street, Springfield', '1213 Maple Street, Springfield'),
('Charlie', 'Davis', 'charlie.davis@example.com', '3344556677', '1415 Cedar Lane, Springfield', '1415 Cedar Lane, Springfield'),
('David', 'Miller', 'david.miller@example.com', '4455667788', '1617 Birch Blvd, Springfield', '1617 Birch Blvd, Springfield'),
('Eva', 'Wilson', 'eva.wilson@example.com', '5566778899', '1819 Elmwood Circle, Springfield', '1819 Elmwood Circle, Springfield'),
('Frank', 'Moore', 'frank.moore@example.com', '6677889900', '2021 Maplewood Dr, Springfield', '2021 Maplewood Dr, Springfield'),
('Grace', 'Taylor', 'grace.taylor@example.com', '7788990011', '2223 Pinecrest Avenue, Springfield', '2223 Pinecrest Avenue, Springfield'),
('Henry', 'Anderson', 'henry.anderson@example.com', '8899001122', '2425 Oakwood Road, Springfield', '2425 Oakwood Road, Springfield'),
('Isabella', 'Thomas', 'isabella.thomas@example.com', '9900112233', '2627 Cedarwood Drive, Springfield', '2627 Cedarwood Drive, Springfield'),
('Jack', 'Jackson', 'jack.jackson@example.com', '1011122233', '2829 Birchwood Lane, Springfield', '2829 Birchwood Lane, Springfield'),
('Katherine', 'White', 'katherine.white@example.com', '1122334455', '3031 Spruce Road, Springfield', '3031 Spruce Road, Springfield'),
('Liam', 'Harris', 'liam.harris@example.com', '2233445566', '3233 Redwood Street, Springfield', '3233 Redwood Street, Springfield'),
('Mia', 'Clark', 'mia.clark@example.com', '3344556677', '3435 Willow Way, Springfield', '3435 Willow Way, Springfield'),
('Noah', 'Lewis', 'noah.lewis@example.com', '4455667788', '3637 Pinehill Drive, Springfield', '3637 Pinehill Drive, Springfield'),
('Olivia', 'Walker', 'olivia.walker@example.com', '5566778899', '3839 Maple Grove, Springfield', '3839 Maple Grove, Springfield'),
('Paul', 'Young', 'paul.young@example.com', '6677889900', '4041 Oakview Terrace, Springfield', '4041 Oakview Terrace, Springfield'),
('Quinn', 'King', 'quinn.king@example.com', '7788990011', '4243 Cedarwood Crescent, Springfield', '4243 Cedarwood Crescent, Springfield'),
('Riley', 'Scott', 'riley.scott@example.com', '8899001122', '4445 Birchhill Drive, Springfield', '4445 Birchhill Drive, Springfield');


-- View CUSTOMERS data
SELECT * FROM customers;


-- ------------------------------------------------------------------------------
-- 								Table 7 : PAYMENTS								|
-- ------------------------------------------------------------------------------

-- Create PAYMENTS table
CREATE TABLE payments(
	payment_id INT AUTO_INCREMENT PRIMARY KEY, 							-- Unique identifier for each payment
    order_id INT,														-- Foreign key to the orders table
	payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,					-- Date and time when payment was made
    payment_amount DECIMAL(10, 2) CHECK(payment_amount >= 0),			-- Amount paid for the order
	payment_method ENUM('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash on Delivery') NOT NULL,  -- Payment method used
    payment_status ENUM('Pending', 'Completed', 'Failed') NOT NULL,  	-- Status of the payment
    transaction_id VARCHAR(100),                              			-- Unique transaction identifier for the payment
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE  -- Linking to orders table
);

-- Insert data into PAYMENTS table
INSERT INTO payments (order_id, payment_amount, payment_method, payment_status, transaction_id)
VALUES
(1, 299.99, 'Credit Card', 'Completed', 'TXN123456789'),
(2, 349.99, 'Debit Card', 'Completed', 'TXN123456790'),
(3, 1199.99, 'PayPal', 'Pending', 'TXN123456791'),
(4, 999.99, 'Credit Card', 'Completed', 'TXN123456792'),
(5, 99.99, 'Cash on Delivery', 'Pending', 'TXN123456793'),
(6, 149.99, 'Bank Transfer', 'Failed', 'TXN123456794'),
(7, 299.99, 'Debit Card', 'Completed', 'TXN123456795'),
(8, 999.99, 'PayPal', 'Completed', 'TXN123456796'),
(9, 179.99, 'Credit Card', 'Pending', 'TXN123456797'),
(10, 129.99, 'Debit Card', 'Completed', 'TXN123456798'),
(11, 349.99, 'Cash on Delivery', 'Failed', 'TXN123456799'),
(12, 1399.99, 'Bank Transfer', 'Completed', 'TXN123456800'),
(13, 99.99, 'Credit Card', 'Completed', 'TXN123456801'),
(14, 149.99, 'PayPal', 'Completed', 'TXN123456802'),
(15, 129.99, 'Debit Card', 'Pending', 'TXN123456803'),
(16, 299.99, 'Bank Transfer', 'Failed', 'TXN123456804'),
(17, 199.99, 'Cash on Delivery', 'Completed', 'TXN123456805'),
(18, 199.99, 'PayPal', 'Completed', 'TXN123456806'),
(19, 299.99, 'Credit Card', 'Completed', 'TXN123456807'),
(20, 299.99, 'Bank Transfer', 'Pending', 'TXN123456808');

-- View payments information
SELECT * FROM payments;

-- ------------------------------------------------------------------------------
-- 								Table 8 : SHIPMENTS								|
-- ------------------------------------------------------------------------------

/*
The shipments table tracks the shipping details of orders, including status, method, tracking information, 
and delivery date.
*/

-- Create SHIPMENTS table
CREATE TABLE shipments(
	shipment_id INT AUTO_INCREMENT PRIMARY KEY,                      				-- Unique identifier for each shipment
    order_id INT,                                            						-- Foreign key to the orders table
    shipment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                				-- Date when the shipment was made
    shipment_status ENUM('Pending', 'Shipped', 'Delivered', 'Returned') NOT NULL, 	-- Current status of the shipment
    shipping_method ENUM('Standard', 'Express', 'Overnight') NOT NULL,  			-- Method used for shipping
    tracking_number VARCHAR(100),                                     				-- Tracking number provided by the shipping company
    delivery_date TIMESTAMP,                                          				-- Date when the shipment was delivered
    shipping_address VARCHAR(255),                                     				-- Shipping address for the order
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE  			-- Linking to orders table
);

-- Insert data into SHIPMENTS table
INSERT INTO shipments (order_id, shipment_date, shipment_status, shipping_method, tracking_number, delivery_date, shipping_address)
VALUES
(1, '2025-01-10 14:30:00', 'Shipped', 'Standard', 'TRACK123456789', '2025-01-12 10:00:00', '1234 Elm Street, Springfield'),
(2, '2025-01-09 15:00:00', 'Delivered', 'Express', 'TRACK123456790', '2025-01-10 12:00:00', '5678 Oak Avenue, Springfield'),
(3, '2025-01-08 16:00:00', 'Pending', 'Overnight', 'TRACK123456791', NULL, '1234 Elm Street, Springfield'),
(4, '2025-01-11 10:00:00', 'Shipped', 'Standard', 'TRACK123456792', '2025-01-13 14:00:00', '9876 Pine Road, Springfield'),
(5, '2025-01-07 09:00:00', 'Delivered', 'Express', 'TRACK123456793', '2025-01-08 11:00:00', '5678 Oak Avenue, Springfield'),
(6, '2025-01-06 13:30:00', 'Returned', 'Standard', 'TRACK123456794', '2025-01-07 09:00:00', '1234 Elm Street, Springfield'),
(7, '2025-01-07 10:30:00', 'Shipped', 'Overnight', 'TRACK123456795', '2025-01-09 08:30:00', '5678 Oak Avenue, Springfield'),
(8, '2025-01-06 14:00:00', 'Delivered', 'Express', 'TRACK123456796', '2025-01-08 13:00:00', '9876 Pine Road, Springfield'),
(9, '2025-01-09 15:30:00', 'Shipped', 'Standard', 'TRACK123456797', '2025-01-10 16:00:00', '1234 Elm Street, Springfield'),
(10, '2025-01-08 14:00:00', 'Pending', 'Overnight', 'TRACK123456798', NULL, '5678 Oak Avenue, Springfield'),
(11, '2025-01-05 12:30:00', 'Delivered', 'Express', 'TRACK123456799', '2025-01-07 09:30:00', '9876 Pine Road, Springfield'),
(12, '2025-01-12 11:00:00', 'Shipped', 'Standard', 'TRACK123456800', '2025-01-14 14:30:00', '1234 Elm Street, Springfield'),
(13, '2025-01-04 16:30:00', 'Returned', 'Express', 'TRACK123456801', '2025-01-06 10:00:00', '5678 Oak Avenue, Springfield'),
(14, '2025-01-03 10:00:00', 'Shipped', 'Overnight', 'TRACK123456802', '2025-01-05 09:30:00', '9876 Pine Road, Springfield'),
(15, '2025-01-02 08:30:00', 'Delivered', 'Standard', 'TRACK123456803', '2025-01-04 10:00:00', '1234 Elm Street, Springfield'),
(16, '2025-01-01 11:30:00', 'Pending', 'Express', 'TRACK123456804', NULL, '5678 Oak Avenue, Springfield'),
(17, '2025-01-02 12:00:00', 'Shipped', 'Overnight', 'TRACK123456805', '2025-01-04 13:30:00', '9876 Pine Road, Springfield'),
(18, '2025-01-03 09:30:00', 'Shipped', 'Standard', 'TRACK123456806', '2025-01-05 14:30:00', '1234 Elm Street, Springfield'),
(19, '2025-01-04 15:00:00', 'Delivered', 'Express', 'TRACK123456807', '2025-01-06 16:00:00', '5678 Oak Avenue, Springfield'),
(20, '2025-01-05 12:00:00', 'Returned', 'Standard', 'TRACK123456808', '2025-01-07 10:00:00', '9876 Pine Road, Springfield');

-- View SHIPMENTS information
SELECT * FROM shipments;


-- ------------------------------------------------------------------------------
-- 								Table 9 : PRODUCT_REVIEWS						|
-- ------------------------------------------------------------------------------

-- Create PRODUCT_REVIEWS table
CREATE TABLE product_reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,                              			-- Unique identifier for each review
    product_id VARCHAR(20),			                                        		-- Foreign key linking to the products table
    customer_id INT,			                                               		-- Foreign key linking to the customers table
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),                     		-- Rating given by the customer (1 to 5)
    review_comment TEXT,                                                    		-- Review comment provided by the customer
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                        		-- Timestamp for when the review was submitted
    
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE, 	-- Foreign key to products table
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE 	-- Foreign key to customers table
);


-- Insert data into product_reviews table
INSERT INTO product_reviews (product_id, customer_id, rating, review_comment)
VALUES
('B07XJ8C8F5', 1, 5, 'Excellent phone, highly recommend!'),
('B08N5WRWNW', 2, 4, 'Great phone but a bit expensive.'),
('B07HFGQJ69', 3, 5, 'Best noise-canceling headphones I’ve used!'),
('B08L5NP6NG', 4, 4, 'Good laptop but battery life could be better.'),
('B09G3HRMVB', 5, 3, 'Nice mouse, but it’s a bit small for my hand.'),
('B07FZ8S74R', 6, 5, 'Great speaker with clear sound.'),
('B07VJYZF6D', 7, 4, 'Fun console, but a bit pricey.'),
('B0916FZWG2', 8, 5, 'Love the performance and battery life.'),
('B07N4M4V14', 9, 4, 'Great speaker, but lacks bass.'),
('B07K344J3N', 10, 5, 'Fantastic device, love the screen quality.'),
('B08HR5SXPS', 11, 3, 'Expensive and hard to find.'),
('B08164VTWH', 12, 5, 'Amazing 4K quality, great for gaming.'),
('B07PW9VBK5', 13, 4, 'Nice design and good performance.'),
('B07YLX795P', 14, 4, 'Great display and features, but a bit slow.'),
('B0932NR34V', 15, 5, 'Best laptop for work, highly recommended.'),
('B07KR9L7Q6', 16, 4, 'Good keyboard, but takes a little getting used to.'),
('B08H93ZRK9', 17, 5, 'Great fitness tracker, love the features.'),
('B08J5F3G18', 18, 3, 'Decent keyboard but not worth the price.'),
('B07GB5WKH8', 19, 4, 'Nice watch, helps with tracking my runs.'),
('B081TQ92F3', 20, 5, 'Fantastic quality and lighting, perfect for gaming.');

-- View all reviews
SELECT * FROM product_reviews;


-- ------------------------------------------------------------------------------
-- 							Table 10 : INVENTORY_TRANSACTIONS					|
-- ------------------------------------------------------------------------------

/*
The inventory_transactions table helps track any changes made to the stock of products in the warehouse. 
It records when products are added or removed from the inventory.
*/

-- Create INVENTORY_TRANSACTIONS table
CREATE TABLE inventory_transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,                         					-- Unique identifier for each transaction
    product_id VARCHAR(20) NOT NULL,                                       					-- Foreign key linking to the products table
    transaction_type ENUM('Stock Addition', 'Stock Removal', 'Stock Update') NOT NULL,  	-- Type of transaction
    quantity INT NOT NULL CHECK(quantity >= 0),                            					-- Quantity of product added/removed
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                  					-- Timestamp of when the transaction occurred
    reason TEXT,                                                           					-- Reason for the transaction (e.g., restocking, order fulfillment)
    
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE  			-- Foreign key to products table
);

-- Insert data into INVENTORY_TRANSACTIONS table
INSERT INTO inventory_transactions (product_id, transaction_type, quantity, reason)
VALUES
('B07XJ8C8F5', 'Stock Removal', 10, 'Order Fulfillment for Order ID 1'),
('B08N5WRWNW', 'Stock Removal', 8, 'Order Fulfillment for Order ID 2'),
('B07HFGQJ69', 'Stock Removal', 5, 'Order Fulfillment for Order ID 3'),
('B08L5NP6NG', 'Stock Removal', 4, 'Order Fulfillment for Order ID 4'),
('B09G3HRMVB', 'Stock Removal', 7, 'Order Fulfillment for Order ID 5'),
('B07FZ8S74R', 'Stock Removal', 15, 'Order Fulfillment for Order ID 6'),
('B07VJYZF6D', 'Stock Removal', 3, 'Order Fulfillment for Order ID 7'),
('B0916FZWG2', 'Stock Removal', 2, 'Order Fulfillment for Order ID 8'),
('B07N4M4V14', 'Stock Removal', 6, 'Order Fulfillment for Order ID 9'),
('B07K344J3N', 'Stock Removal', 3, 'Order Fulfillment for Order ID 10'),
('B08HR5SXPS', 'Stock Removal', 2, 'Order Fulfillment for Order ID 11'),
('B08164VTWH', 'Stock Removal', 4, 'Order Fulfillment for Order ID 12'),
('B07PW9VBK5', 'Stock Removal', 3, 'Order Fulfillment for Order ID 13'),
('B07YLX795P', 'Stock Removal', 6, 'Order Fulfillment for Order ID 14'),
('B0932NR34V', 'Stock Removal', 3, 'Order Fulfillment for Order ID 15'),
('B07KR9L7Q6', 'Stock Removal', 5, 'Order Fulfillment for Order ID 16'),
('B08H93ZRK9', 'Stock Removal', 7, 'Order Fulfillment for Order ID 17'),
('B08J5F3G18', 'Stock Removal', 4, 'Order Fulfillment for Order ID 18'),
('B07GB5WKH8', 'Stock Removal', 4, 'Order Fulfillment for Order ID 19'),
('B081TQ92F3', 'Stock Removal', 3, 'Order Fulfillment for Order ID 20');

-- View all data
SELECT * FROM inventory_transactions;


-- ------------------------------------------------------------------------------
-- 								Table 11 : RETURNS								|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The RETURNS table keeps track of products that customers return after purchase.
*/

-- Create RETURNS table
CREATE TABLE returns(
	return_id INT AUTO_INCREMENT PRIMARY KEY, 					-- Unique ID for each return
    order_id INT NOT NULL,										-- Links to the ORDERS table
    customer_id INT NOT NULL,									-- Links to the CUSTOMERS table
    product_id VARCHAR(20) NOT NULL,									-- Links to the PRODUCTS table
    return_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 			-- Date and Time of the return
    quantity INT NOT NULL CHECK(quantity > 0),					-- Quantity of product being return
    reason TEXT NOT NULL, 										-- Reason for the return 
    status ENUM('Pending', 'Approved', 'Rejected') NOT NULL, 	-- Status of the return process
    refunded BOOLEAN DEFAULT FALSE, 							-- Whether the refund has been processed
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,				-- Timestamp for when the record was created
    updated_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
				ON UPDATE CURRENT_TIMESTAMP,					-- Last updated timestamp
    
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES products(product_id)
		ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Insert data into RETURNS table
INSERT INTO returns(order_id, customer_id, product_id, quantity, reason, status, refunded)
VALUES
(1, 1, 'B07XJ8C8F5', 1, 'Defective product', 'Approved', TRUE),
(2, 2, 'B08N5WRWNW', 1, 'Incorrect product', 'Approved', TRUE),
(3, 3, 'B07HFGQJ69', 1, 'Product damaged', 'Pending', FALSE),
(4, 4, 'B08L5NP6NG', 1, 'Changed mind', 'Rejected', FALSE),
(5, 5, 'B09G3HRMVB', 2, 'Size mismatch', 'Approved', TRUE),
(6, 6, 'B07FZ8S74R', 1, 'Defective product', 'Approved', TRUE),
(7, 7, 'B07VJYZF6D', 1, 'Not as described', 'Pending', FALSE),
(8, 8, 'B0916FZWG2', 1, 'Product not working', 'Approved', TRUE),
(9, 9, 'B07N4M4V14', 1, 'Changed mind', 'Approved', TRUE),
(10, 10, 'B07K344J3N', 1, 'Wrong color', 'Rejected', FALSE),
(11, 11, 'B08HR5SXPS', 1, 'Product damaged', 'Pending', FALSE),
(12, 12, 'B08164VTWH', 1, 'Not compatible', 'Approved', TRUE),
(13, 13, 'B07PW9VBK5', 1, 'Ordered by mistake', 'Rejected', FALSE),
(14, 14, 'B07YLX795P', 1, 'Product defective', 'Approved', TRUE),
(15, 15, 'B0932NR34V', 1, 'Wrong model', 'Pending', FALSE),
(16, 16, 'B07KR9L7Q6', 1, 'Not needed anymore', 'Approved', TRUE),
(17, 17, 'B08H93ZRK9', 1, 'Product defective', 'Approved', TRUE),
(18, 18, 'B08J5F3G18', 1, 'Product did not work', 'Pending', FALSE),
(19, 19, 'B07GB5WKH8', 1, 'Changed mind', 'Rejected', FALSE),
(20, 20, 'B081TQ92F3', 1, 'Not as expected', 'Pending', FALSE);


-- ------------------------------------------------------------------------------
-- 								Table 12 : DISCOUNTS							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The DISCOUNTS table stores information about discounts or offers applied to products in the inventory.
*/

-- Create DISCOUNTS table
CREATE TABLE discounts(
	discount_id INT AUTO_INCREMENT PRIMARY KEY, 					-- Unique identifier for each discount
    product_id VARCHAR(20),											-- ID of the product to which the discount applies
    discount_type ENUM('Percentage', 'Flat Amount') NOT NULL,		-- Type of discount (percentage or fixed amount)
    discount_value DECIMAL(10, 2) NOT NULL, 						-- Value of the discount
    start_date DATE NOT NULL,										-- Start date of the discount
    end_Date DATE NOT NULL,											-- End date of the discount
    status ENUM('Active', 'Expired') DEFAULT 'Active',				-- Status of the discount
    
    FOREIGN KEY (product_id) REFERENCES products(product_id)		-- Links to the PRODUCTS table
			ON DELETE CASCADE										-- Removes discount if the product is deleted
);


-- Insert data into DISCOUNTS table
INSERT INTO discounts(product_id, discount_type, discount_value, start_date, end_date, status)
VALUES
('B07XJ8C8F5', 'Percentage', 10.00, '2025-01-01', '2025-01-31', 'Active'),
('B08N5WRWNW', 'Flat Amount', 50.00, '2025-01-05', '2025-01-25', 'Active'),
('B07HFGQJ69', 'Percentage', 15.00, '2025-01-10', '2025-01-20', 'Expired'),
('B08L5NP6NG', 'Flat Amount', 100.00, '2025-01-01', '2025-01-15', 'Active'),
('B09G3HRMVB', 'Percentage', 20.00, '2025-01-02', '2025-01-20', 'Active'),
('B07FZ8S74R', 'Flat Amount', 30.00, '2025-01-05', '2025-01-25', 'Active'),
('B07VJYZF6D', 'Percentage', 10.00, '2025-01-15', '2025-02-15', 'Expired'),
('B0916FZWG2', 'Percentage', 25.00, '2025-01-10', '2025-01-31', 'Active'),
('B07N4M4V14', 'Flat Amount', 40.00, '2025-01-01', '2025-01-20', 'Active'),
('B07K344J3N', 'Percentage', 5.00, '2025-01-01', '2025-01-10', 'Expired');



-- ------------------------------------------------------------------------------
-- 								Table 13 : WAREHOUSES							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: This table stores information about different warehouses, where products are stored. It will also 
include location details.
*/

-- Create WAREHOUSES table
CREATE TABLE warehouses(
	warehouse_id INT AUTO_INCREMENT PRIMARY KEY, 					-- Unique identifier for each warehouse
    warehouse_name VARCHAR(255) NOT NULL,							-- Name of the warehouse
    location VARCHAR(255) NOT NULL,									-- Physical location of the warehouse
    capacity INT NOT NULL CHECK(capacity >= 0),						-- Total capacity of the warehouse (Number of units/products)
    current_stock INT NOT NULL CHECK(current_stock >= 0),			-- Actual number of products(units) that are physically available in the warehouse			
    contact_number VARCHAR(20),										-- Contact number for the warehouse
    manager_name VARCHAR(255),										-- Name of the manager
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,					-- Timestamp when the warehouse record was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
			ON UPDATE CURRENT_TIMESTAMP								-- Timestamp when the warehouse record was last updated
);

-- Insert data into WAREHOUSES table
INSERT INTO warehouses (warehouse_name, location, capacity, current_stock) 
VALUES
('Main Warehouse', 'Aisle 1, Row 2', 500, 250),
('Secondary Warehouse', 'Aisle 2, Row 3', 600, 350),
('East Coast Warehouse', 'Aisle 3, Row 1', 400, 180),
('West Coast Warehouse', 'Aisle 4, Row 4', 700, 500),
('Regional Warehouse', 'Aisle 5, Row 2', 300, 120),
('Central Warehouse', 'Aisle 6, Row 5', 800, 450),
('Backup Warehouse', 'Aisle 7, Row 6', 900, 600),
('Overflow Warehouse', 'Aisle 8, Row 1', 1000, 750),
('Distribution Center', 'Aisle 9, Row 7', 550, 300),
('Import Warehouse', 'Aisle 10, Row 8', 650, 400),
('Local Warehouse', 'Aisle 11, Row 2', 400, 150),
('Temporary Warehouse', 'Aisle 12, Row 3', 300, 100),
('Expansion Warehouse', 'Aisle 13, Row 4', 1100, 950),
('Warehouse 1', 'Aisle 14, Row 5', 500, 320),
('Warehouse 2', 'Aisle 15, Row 6', 600, 450),
('Warehouse 3', 'Aisle 16, Row 7', 700, 560),
('Warehouse 4', 'Aisle 17, Row 8', 550, 300),
('Warehouse 5', 'Aisle 18, Row 9', 450, 220),
('Warehouse 6', 'Aisle 19, Row 10', 650, 550);

SELECT * FROM warehouses;

-- ------------------------------------------------------------------------------
-- 							Table 14 : EMPLOYEE_DETAILS							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: This table will store details like employee ID, name, position, and the warehouse they work 
in (linked to the warehouses table).
*/

-- Create EMPLOYEE_DETAILS table
CREATE TABLE employee_details(
	employee_id INT AUTO_INCREMENT PRIMARY KEY,                      	-- Unique employee identifier
    first_name VARCHAR(100) NOT NULL,                                 	-- First name of the employee
    last_name VARCHAR(100) NOT NULL,                                  	-- Last name of the employee
    email VARCHAR(255) UNIQUE NOT NULL,                        			-- Employee's email (unique)
    phone_number VARCHAR(20),                          					-- Employee's phone number
    position VARCHAR(100),                                           	-- Job position (e.g., Warehouse Manager, Stock Clerk)
    warehouse_id INT,                                                 	-- Foreign key to the warehouses table
    hire_date DATE NOT NULL,                                          	-- Date of hire
    salary DECIMAL(10, 2) CHECK(salary >= 0),                         	-- Employee's salary
    status ENUM('Active', 'Inactive', 'On Leave') NOT NULL,           	-- Employee status
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(warehouse_id) 
					ON DELETE SET NULL									-- Foreign key linking to the warehouses table
);

-- Insert data into EMPLOYEE_DETAILS tables
INSERT INTO employee_details (first_name, last_name, email, phone_number, position, warehouse_id, hire_date, salary, status)
VALUES
('John', 'Doe', 'john.doe@example.com', '555-1234', 'Warehouse Manager', 1, '2021-06-15', 55000.00, 'Active'),
('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 'Inventory Clerk', 2, '2022-03-01', 35000.00, 'Active'),
('David', 'Johnson', 'david.johnson@example.com', '555-9101', 'Shipping Coordinator', 3, '2020-11-25', 40000.00, 'Active'),
('Emily', 'Davis', 'emily.davis@example.com', '555-1213', 'Warehouse Assistant', 4, '2022-05-17', 30000.00, 'Active'),
('Michael', 'Brown', 'michael.brown@example.com', '555-1415', 'Warehouse Manager', 5, '2019-09-10', 60000.00, 'Active'),
('Sarah', 'Wilson', 'sarah.wilson@example.com', '555-1617', 'Forklift Operator', 6, '2021-07-25', 37000.00, 'Active'),
('Matthew', 'Miller', 'matthew.miller@example.com', '555-1819', 'Inventory Clerk', 7, '2020-01-14', 32000.00, 'Active'),
('Jessica', 'Taylor', 'jessica.taylor@example.com', '555-2021', 'Shipping Coordinator', 8, '2021-04-03', 45000.00, 'Active'),
('Andrew', 'Moore', 'andrew.moore@example.com', '555-2223', 'Warehouse Assistant', 9, '2022-02-20', 28000.00, 'Active'),
('Olivia', 'Martin', 'olivia.martin@example.com', '555-2425', 'Warehouse Supervisor', 10, '2020-08-05', 52000.00, 'Active'),
('James', 'Garcia', 'james.garcia@example.com', '555-2627', 'Forklift Operator', 11, '2021-01-18', 36000.00, 'Active'),
('Sophia', 'Rodriguez', 'sophia.rodriguez@example.com', '555-2829', 'Inventory Clerk', 12, '2020-04-22', 33000.00, 'Active'),
('Benjamin', 'Martinez', 'benjamin.martinez@example.com', '555-3031', 'Warehouse Manager', 13, '2019-06-10', 58000.00, 'Active'),
('Ava', 'Hernandez', 'ava.hernandez@example.com', '555-3233', 'Shipping Coordinator', 14, '2022-01-05', 42000.00, 'Active'),
('Elijah', 'White', 'elijah.white@example.com', '555-3435', 'Warehouse Assistant', 15, '2021-10-12', 31000.00, 'Active'),
('Mason', 'Lopez', 'mason.lopez@example.com', '555-3637', 'Inventory Clerk', 16, '2020-09-17', 34000.00, 'Active'),
('Lily', 'Gonzalez', 'lily.gonzalez@example.com', '555-3839', 'Warehouse Supervisor', 17, '2019-12-20', 50000.00, 'Active'),
('Lucas', 'Perez', 'lucas.perez@example.com', '555-4041', 'Forklift Operator', 18, '2021-02-14', 35000.00, 'Active'),
('Charlotte', 'Roberts', 'charlotte.roberts@example.com', '555-4243', 'Warehouse Assistant', 19, '2022-06-30', 29000.00, 'Active');


-- ------------------------------------------------------------------------------
-- 								Table 15 : USERS								|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The users table typically stores authentication and access information for both customers and admin personnel who interact with the system. 
This table will define the different roles (e.g., customer, admin, etc.) and keep track of login credentials.
*/

-- Create USERS table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,             						-- Unique identifier for each user
    username VARCHAR(50) NOT NULL UNIQUE,               						-- Username for login, must be unique
    password_hash VARCHAR(255) NOT NULL,                						-- Securely stored password (hashed)
    email VARCHAR(100) NOT NULL UNIQUE,                 						-- User's email, must be unique
    role ENUM('customer', 'admin', 'employee', 'manager') NOT NULL, 			-- User role in the system (customer, admin, or employee)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,     						-- Timestamp when the user was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 	-- Timestamp when the record was last updated
);

-- Insert data into USERS table
INSERT INTO users (username, password_hash, email, role)
VALUES
('john_doe', 'hashed_password_123', 'john.doe@example.com', 'customer'),
('jane_smith', 'hashed_password_124', 'jane.smith@example.com', 'customer'),
('admin_user', 'hashed_password_125', 'admin@example.com', 'admin'),
('mary_jones', 'hashed_password_126', 'mary.jones@example.com', 'customer'),
('mike_taylor', 'hashed_password_127', 'mike.taylor@example.com', 'employee'),
('susan_brown', 'hashed_password_128', 'susan.brown@example.com', 'customer'),
('james_white', 'hashed_password_129', 'james.white@example.com', 'customer'),
('emily_williams', 'hashed_password_130', 'emily.williams@example.com', 'employee'),
('david_martin', 'hashed_password_131', 'david.martin@example.com', 'admin'),
('laura_clark', 'hashed_password_132', 'laura.clark@example.com', 'customer'),
('robert_hall', 'hashed_password_133', 'robert.hall@example.com', 'employee'),
('alice_moore', 'hashed_password_134', 'alice.moore@example.com', 'customer'),
('charles_lee', 'hashed_password_135', 'charles.lee@example.com', 'customer'),
('olivia_harris', 'hashed_password_136', 'olivia.harris@example.com', 'admin'),
('peter_smith', 'hashed_password_137', 'peter.smith@example.com', 'employee'),
('kate_jones', 'hashed_password_138', 'kate.jones@example.com', 'customer'),
('tom_baker', 'hashed_password_139', 'tom.baker@example.com', 'employee'),
('joseph_davis', 'hashed_password_140', 'joseph.davis@example.com', 'customer'),
('emma_wilson', 'hashed_password_141', 'emma.wilson@example.com', 'customer'),
('rahul_sharma', 'hashed_password_142', 'rahul.sharma@example.com', 'customer'),
('ankit_gupta', 'hashed_password_143', 'ankit.gupta@example.com', 'employee'),
('neha_kumar', 'hashed_password_144', 'neha.kumar@example.com', 'customer'),
('deepak_singh', 'hashed_password_145', 'deepak.singh@example.com', 'admin'),
('priya_verma', 'hashed_password_146', 'priya.verma@example.com', 'employee');


SELECT * FROM users;
-- ------------------------------------------------------------------------------
-- 								Table 16 : AUDIT_LOGS							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The Audit Logs table records every action performed in the system for tracking and security purposes. 
It helps track changes to records such as insertions, updates, deletions, and any other activities that occur within the database.
*/


-- Create AUDIT_LOGS table
CREATE TABLE audit_logs (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,                  								-- Unique identifier for each audit log
    action_type ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,   								-- Type of action performed (Insert, Update, or Delete)
    table_name VARCHAR(255) NOT NULL,                           							-- Name of the table where the action occurred
    record_id VARCHAR(20),                                     								-- ID of the record that was modified
    record_type ENUM('product', 'order', 'customer', 'payment', 'shipment') NOT NULL, 		-- Type of record being modified
    user_id INT,                                               								-- ID of the user who performed the action
    action_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,       							-- Timestamp of when the action occurred
    old_value TEXT,                                            								-- The old value (for updates or deletes)
    new_value TEXT,                                            								-- The new value (for updates or inserts)

    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE 						-- Foreign key reference to the users table
																							-- No foreign key constraint for record_id because it can refer to different tables
);



-- Insert data into AUDIT_LOGS
INSERT INTO audit_logs (action_type, table_name, record_id, user_id, action_timestamp, old_value, new_value)
VALUES 
('INSERT', 'products', 'B07XJ8C8F5', 1, '2025-01-09 10:00:00', NULL, '{"product_name": "Apple iPhone 13", "category": "Electronics", "price": "999.99"}'),
('UPDATE', 'products', 'B08N5WRWNW', 2, '2025-01-10 14:00:00', '{"price": "799.99"}', '{"price": "749.99"}'),
('DELETE', 'products', 'B07N4M4V14', 6, '2025-01-14 09:00:00', '{"product_name": "Bose SoundLink Mini II"}', NULL),
('INSERT', 'orders', '1001', 4, '2025-01-12 12:15:00', NULL, '{"order_date": "2025-01-12", "total_amount": "299.99"}'),
('UPDATE', 'orders', '1001', 5, '2025-01-13 08:30:00', '{"status": "Pending"}', '{"status": "Shipped"}'),
('DELETE', 'customers', '3', 3, '2025-01-11 11:30:00', '{"first_name": "Susan", "last_name": "Brown"}', NULL),
('INSERT', 'returns', 'B07XJ8C8F5', 7, '2025-01-15 10:00:00', NULL, '{"quantity": "1", "reason": "Defective product", "status": "Approved"}'),
('UPDATE', 'payments', '2002', 8, '2025-01-16 14:20:00', '{"payment_status": "Pending"}', '{"payment_status": "Completed"}'),
('DELETE', 'warehouses', '3', 9, '2025-01-17 13:40:00', '{"warehouse_name": "East Warehouse"}', NULL),
('INSERT', 'product_reviews', 'B07XJ8C8F5', 10, '2025-01-18 15:30:00', NULL, '{"rating": "5", "review_comment": "Excellent product!"}'),
('UPDATE', 'inventory_transactions', 'B07XJ8C8F5', 11, '2025-01-19 09:00:00', '{"quantity": "5"}', '{"quantity": "8"}'),
('DELETE', 'employee_details', '12', 12, '2025-01-20 10:30:00', '{"first_name": "David", "last_name": "Martin"}', NULL),
('INSERT', 'shipments', '1001', 13, '2025-01-21 11:45:00', NULL, '{"shipment_status": "Shipped", "shipping_method": "Express"}'),
('UPDATE', 'shipments', '1001', 14, '2025-01-22 16:00:00', '{"shipment_status": "Pending"}', '{"shipment_status": "Delivered"}'),
('DELETE', 'discounts', 'B07XJ8C8F5', 15, '2025-01-23 17:15:00', '{"discount_value": "10.00", "status": "Active"}', NULL),
('INSERT', 'payments', '2003', 16, '2025-01-24 18:00:00', NULL, '{"payment_status": "Pending", "payment_method": "Credit Card"}'),
('UPDATE', 'users', 'john_doe', 17, '2025-01-25 10:00:00', '{"role": "customer"}', '{"role": "employee"}'),
('DELETE', 'order_items', '5', 18, '2025-01-26 11:30:00', '{"quantity": "2"}', NULL),
('INSERT', 'audit_logs', 'B07XJ8C8F5', 19, '2025-01-27 12:00:00', NULL, '{"action_type": "INSERT", "table_name": "products", "record_id": "B07XJ8C8F5"}'),
('UPDATE', 'audit_logs', 'B07XJ8C8F5', 20, '2025-01-28 13:00:00', '{"old_value": "{}"}', '{"new_value": "{\"product_name\": \"Apple iPhone 13\", \"price\": \"999.99\"}"}');



-- ------------------------------------------------------------------------------
-- 									Table 17 : TAXES							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: This table stores tax information applied to orders or individual products, including the tax rate and the type of tax.
*/

-- Create TAXES table
CREATE TABLE taxes (
    tax_id INT AUTO_INCREMENT PRIMARY KEY,                        				-- Unique identifier for each tax
    tax_type ENUM('Sales Tax', 'Value Added Tax', 'Service Tax') NOT NULL,  	-- Type of tax
    tax_rate DECIMAL(5, 2) NOT NULL CHECK(tax_rate >= 0),          				-- Tax rate (percentage)
    country VARCHAR(100),                                          				-- Country where the tax is applied
    state VARCHAR(100),                                            				-- State where the tax is applied (if applicable)
    product_id VARCHAR(20),                                         			-- Foreign key for product (if tax applies to product)
    order_id INT,                                                  				-- Foreign key for order (if tax applies to order)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                				-- Timestamp of when the record was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
			ON UPDATE CURRENT_TIMESTAMP, 										-- Timestamp for when record was updated
            
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
			ON DELETE CASCADE,  												-- Foreign key to products table
    FOREIGN KEY (order_id) REFERENCES orders(order_id) 
			ON DELETE CASCADE    												-- Foreign key to orders table
);

-- Insert data into TAXES
INSERT INTO taxes (tax_type, tax_rate, country, state, product_id, order_id)
VALUES
('Sales Tax', 5.00, 'USA', 'California', 'B07XJ8C8F5', NULL),
('Sales Tax', 8.00, 'USA', 'New York', 'B08N5WRWNW', NULL),
('Sales Tax', 7.50, 'USA', 'Texas', 'B07HFGQJ69', NULL),
('Value Added Tax', 18.00, 'India', 'Maharashtra', 'B08L5NP6NG', NULL),
('Value Added Tax', 15.00, 'UK', 'England', 'B09G3HRMVB', NULL),
('Sales Tax', 6.50, 'USA', 'Florida', 'B07FZ8S74R', NULL),
('Service Tax', 12.00, 'India', 'Delhi', 'B07VJYZF6D', NULL),
('Value Added Tax', 10.00, 'Germany', 'Berlin', 'B0916FZWG2', NULL),
('Sales Tax', 7.00, 'USA', 'Nevada', 'B07N4M4V14', NULL),
('Sales Tax', 9.00, 'USA', 'Texas', 'B07K344J3N', NULL),
('Value Added Tax', 5.00, 'India', 'Karnataka', 'B08HR5SXPS', NULL),
('Value Added Tax', 20.00, 'France', 'Paris', 'B08164VTWH', NULL),
('Sales Tax', 6.00, 'USA', 'Illinois', 'B07PW9VBK5', NULL),
('Service Tax', 14.00, 'India', 'Tamil Nadu', 'B07YLX795P', NULL),
('Sales Tax', 8.50, 'USA', 'Michigan', 'B0932NR34V', NULL),
('Value Added Tax', 12.50, 'Italy', 'Rome', 'B07KR9L7Q6', NULL),
('Sales Tax', 7.75, 'USA', 'Colorado', 'B08J5F3G18', NULL),
('Service Tax', 10.00, 'India', 'Uttar Pradesh', 'B07GB5WKH8', NULL),
('Value Added Tax', 17.00, 'Spain', 'Madrid', 'B081TQ92F3', NULL),
('Sales Tax', 5.50, 'USA', 'Georgia', 'B07XJ8C8F5', NULL);


-- ------------------------------------------------------------------------------
-- 							Table 18 : PRODUCT_IMAGES							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: This table can store information about images associated with the products.
*/

-- Create PRODUCT_IMAGES table
CREATE TABLE product_images (
    image_id INT AUTO_INCREMENT PRIMARY KEY,  					-- Unique ID for each image
    product_id VARCHAR(20) NOT NULL,          					-- Product ID the image is associated with
    image_url VARCHAR(255) NOT NULL,          					-- URL of the image
    image_description TEXT,                   					-- Optional description of the image
    is_primary BOOLEAN DEFAULT FALSE,         					-- Whether this image is the primary one for the product
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  			-- Timestamp when the image was added
    
    FOREIGN KEY (product_id) REFERENCES products(product_id)	-- Links to the PRODUCTS table
);

-- Insert data into PRODUCT_IMAGES table
INSERT INTO product_images (product_id, image_url, image_description, is_primary)
VALUES
('B07XJ8C8F5', 'https://example.com/images/iphone13_front.jpg', 'Front view of Apple iPhone 13', TRUE),
('B08N5WRWNW', 'https://example.com/images/galaxyS21_front.jpg', 'Front view of Samsung Galaxy S21', TRUE),
('B07HFGQJ69', 'https://example.com/images/sony_wh1000xm4.jpg', 'Side view of Sony WH-1000XM4', TRUE),
('B08L5NP6NG', 'https://example.com/images/dell_xps13.jpg', 'Dell XPS 13 Laptop', TRUE),
('B09G3HRMVB', 'https://example.com/images/logitech_mx_master3.jpg', 'Logitech MX Master 3 Mouse', TRUE),
('B07FZ8S74R', 'https://example.com/images/echo_dot.jpg', 'Amazon Echo Dot - Front View', TRUE),
('B07VJYZF6D', 'https://example.com/images/nintendo_switch.jpg', 'Nintendo Switch Console', TRUE),
('B0916FZWG2', 'https://example.com/images/macbook_air_m1.jpg', 'Apple MacBook Air M1', TRUE),
('B07N4M4V14', 'https://example.com/images/bose_soundlink_mini_ii.jpg', 'Bose SoundLink Mini II Bluetooth Speaker', TRUE),
('B07K344J3N', 'https://example.com/images/surface_pro_7.jpg', 'Microsoft Surface Pro 7', TRUE),
('B08HR5SXPS', 'https://example.com/images/ps5_front.jpg', 'Sony PlayStation 5 Front View', TRUE),
('B08164VTWH', 'https://example.com/images/samsung_monitor_32inch.jpg', 'Samsung 32-inch 4K Monitor', TRUE),
('B07PW9VBK5', 'https://example.com/images/hp_envy_13.jpg', 'HP Envy 13 Laptop', TRUE),
('B07YLX795P', 'https://example.com/images/google_nest_hub.jpg', 'Google Nest Hub Smart Display', TRUE),
('B0932NR34V', 'https://example.com/images/thinkpad_x1_carbon.jpg', 'Lenovo ThinkPad X1 Carbon', TRUE),
('B07KR9L7Q6', 'https://example.com/images/jbl_flip5.jpg', 'JBL Flip 5 Waterproof Bluetooth Speaker', TRUE),
('B08J5F3G18', 'https://example.com/images/razer_blackwidow_v3.jpg', 'Razer BlackWidow V3 Mechanical Keyboard', TRUE),
('B07GB5WKH8', 'https://example.com/images/garmin_forerunner_245.jpg', 'Garmin Forerunner 245 GPS Running Smartwatch', TRUE),
('B081TQ92F3', 'https://example.com/images/corsair_k95_rgb.jpg', 'Corsair K95 RGB Platinum Mechanical Keyboard', TRUE),
('B07XJ8C8F5', 'https://example.com/images/iphone13_back.jpg', 'Back view of Apple iPhone 13', FALSE);


-- ------------------------------------------------------------------------------
-- 							Table 19 : SHIPPING_METHODS							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: This table will store the shipping methods available for orders.
*/

-- Create SHIPPING_METHODS table
CREATE TABLE shipping_methods (
    method_id INT AUTO_INCREMENT PRIMARY KEY,    		-- Unique identifier for each shipping method
    method_name VARCHAR(100) NOT NULL,           		-- Name of the shipping method (e.g., Standard, Express)
    delivery_time VARCHAR(50),                   		-- Estimated delivery time (e.g., "3-5 business days")
    price DECIMAL(10, 2) NOT NULL,               		-- Shipping cost for this method
    is_active BOOLEAN DEFAULT TRUE,              		-- Whether the shipping method is currently available
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  	-- Timestamp for when the record was created
);

-- Insert data into SHIPPING_METHODS
INSERT INTO shipping_methods (method_name, delivery_time, price, is_active)
VALUES 
('Standard Shipping', '5-7 business days', 5.99, TRUE),
('Express Shipping', '2-3 business days', 12.99, TRUE),
('Overnight Shipping', '1 business day', 19.99, TRUE),
('Same Day Delivery', 'Same day', 25.00, TRUE),
('International Shipping', '7-14 business days', 20.00, TRUE),
('Economy Shipping', '7-10 business days', 3.99, TRUE),
('Two-Day Shipping', '2 business days', 8.99, TRUE),
('Free Shipping', '5-7 business days', 0.00, TRUE),
('Priority Shipping', '3-4 business days', 9.99, TRUE),
('Next-Day Air', '1 business day', 24.99, TRUE),
('Surface Shipping', '10-15 business days', 2.99, TRUE),
('Standard International', '10-15 business days', 18.99, TRUE),
('USPS First-Class', '3-5 business days', 4.50, TRUE),
('USPS Priority Mail', '2-3 business days', 8.50, TRUE),
('FedEx Ground', '5-7 business days', 6.99, TRUE),
('FedEx Express', '1-2 business days', 14.99, TRUE),
('UPS Ground', '5-7 business days', 6.49, TRUE),
('UPS Next Day Air', '1 business day', 22.99, TRUE),
('Global Express', '7-14 business days', 30.00, TRUE);


-- ------------------------------------------------------------------------------
-- 								Table 20 : PROMOTIONS							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: This table will store details about ongoing promotions, like discount percentages, promotional codes, 
start/end dates, and eligible product categories.
*/

-- Create PROMOTIONS table
CREATE TABLE promotions (
    promotion_id INT PRIMARY KEY AUTO_INCREMENT,          -- Unique identifier for the promotion
    promo_code VARCHAR(50) NOT NULL,                      -- The promotional code (e.g., "SUMMER21")
    discount_percentage DECIMAL(5, 2) NOT NULL 
			CHECK(discount_percentage BETWEEN 0 AND 100), -- Discount percentage (0 to 100%)
    start_date DATE NOT NULL,                             -- Start date of the promotion
    end_date DATE NOT NULL,                               -- End date of the promotion
    eligible_category VARCHAR(100),                       -- The product category eligible for the promotion
    is_active BOOLEAN DEFAULT TRUE,                       -- Status of the promotion (active or not)
    description TEXT                                      -- Description of the promotion
);

-- Insert data into PROMOTIONS table
INSERT INTO promotions (promo_code, discount_percentage, start_date, end_date, eligible_category, is_active, description)
VALUES
('SUMMER21', 15.00, '2021-06-01', '2021-08-31', 'Electronics', TRUE, 'Summer sale for all electronic products.'),
('WINTER15', 20.00, '2021-12-01', '2021-12-31', 'Apparel', TRUE, 'Winter sale offering 20% off on apparel.'),
('BOGO20', 0.00, '2021-09-01', '2021-09-30', 'Footwear', TRUE, 'Buy one, get one free on selected footwear items.'),
('BLACKFRIDAY25', 25.00, '2021-11-26', '2021-11-28', 'All', TRUE, 'Black Friday sale with 25% off on all items.'),
('NEWYEAR10', 10.00, '2021-12-31', '2022-01-02', 'Home Appliances', TRUE, 'New Year Sale – 10% off on home appliances.'),
('STUDENT15', 15.00, '2021-08-01', '2021-08-31', 'Books', TRUE, '15% discount for students on all book purchases.'),
('FREESHIP', 0.00, '2021-07-01', '2021-07-31', 'All', TRUE, 'Free shipping on all orders over $50.'),
('SUMMERCLEARANCE30', 30.00, '2021-06-15', '2021-06-30', 'Furniture', TRUE, 'Clearance sale for furniture items – 30% off.'),
('XMAS50', 50.00, '2021-12-20', '2021-12-25', 'Toys', TRUE, '50% off on selected toys for Christmas.'),
('VIP20', 20.00, '2021-09-15', '2021-09-25', 'All', TRUE, 'Exclusive VIP offer: 20% off on all orders.');



-- ------------------------------------------------------------------------------
-- 								Table 21 : SUPPORT_TICKETS						|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The purpose of the support_tickets table is to track and manage customer issues or 
inquiries submitted for assistance or resolution.
*/

-- Create table for Support Tickets
CREATE TABLE support_tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,                       -- Unique identifier for each support ticket
    customer_id INT,                                                -- Reference to the customer who raised the ticket
    issue_description TEXT NOT NULL,                                -- Detailed description of the issue
    status ENUM('Open', 'In Progress', 'Resolved', 'Closed') 
        NOT NULL DEFAULT 'Open',                                    -- Current status of the ticket
    priority ENUM('Low', 'Medium', 'High', 'Critical') 
        NOT NULL DEFAULT 'Low',                                     -- Priority level of the issue
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                 -- Timestamp when the ticket was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,                                -- Timestamp for the last update on the ticket
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
		ON DELETE CASCADE          									-- Foreign key linking to customers table
);

-- Insert data intp SUPPORT_TICKETS table
INSERT INTO support_tickets (customer_id, issue_description, status, priority)
VALUES
(1, 'Unable to login to my account after password reset.', 'Open', 'High'),
(2, 'Received a damaged product (Apple iPhone 13).', 'In Progress', 'Critical'),
(3, 'Order not shipped yet, need an update on the delivery date.', 'Open', 'Medium'),
(4, 'Item missing from my order, need a replacement.', 'Resolved', 'High'),
(5, 'Request to change shipping address for my current order.', 'Open', 'Low'),
(6, 'Payment not processed for my last order, facing transaction issues.', 'In Progress', 'Critical'),
(7, 'Product not as described on the website, requesting return.', 'Closed', 'Medium'),
(8, 'Received wrong size of shoes, need to exchange.', 'Open', 'Low'),
(9, 'Issue with promo code not applying at checkout.', 'Resolved', 'Medium'),
(10, 'Need assistance with creating a new user account on the website.', 'Open', 'Low'),
(11, 'Product out of stock, need to know restock date.', 'In Progress', 'Medium'),
(12, 'Facing issues with payment gateway, unable to complete the purchase.', 'Open', 'Critical'),
(13, 'Request for a refund for the damaged laptop received.', 'Resolved', 'High'),
(14, 'Requesting a replacement for faulty headphones.', 'In Progress', 'High'),
(15, 'Shipping status not updated for my order, please check.', 'Open', 'Medium'),
(16, 'Unable to apply my gift card code during checkout.', 'Closed', 'Low'),
(17, 'Order delivered to the wrong address, requesting investigation.', 'Open', 'Critical'),
(18, 'Requesting to update my email address linked with the account.', 'Resolved', 'Low'),
(19, 'I am unable to track my order after dispatch, need assistance.', 'In Progress', 'Medium'),
(20, 'Received a different color of phone case than ordered, need exchange.', 'Resolved', 'Low');

-- View SUPPORT_TICKETS table
SELECT * FROM support_tickets;


-- ------------------------------------------------------------------------------
-- 								Table 22 : FEEDBACK								|
-- ------------------------------------------------------------------------------

/*
SUPPORT: The purpose of the feedback table is to collect and store customer opinions or reviews about products or services.
*/

-- Create FEEDBACK table
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,           		-- Unique identifier for each feedback entry
    customer_id INT NOT NULL,                             		-- Foreign key referencing customers table
    rating INT CHECK (rating BETWEEN 1 AND 5),            		-- Rating out of 5
    comments TEXT,                                        		-- Optional customer comments
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,     		-- Timestamp when feedback was submitted
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
        ON DELETE CASCADE                                 		-- Ensures feedback is removed if a customer is deleted
);

-- Insert data into feedback table
INSERT INTO feedback (customer_id, rating, comments) 
VALUES
(1, 5, 'Excellent service! The product arrived on time and in perfect condition.'),
(2, 4, 'Good quality product, but delivery was a bit delayed.'),
(3, 3, 'Product quality was okay, but packaging could have been better.'),
(4, 5, 'Very satisfied with my purchase, will definitely buy again!'),
(5, 2, 'The product did not meet my expectations. Would like to return it.'),
(6, 4, 'Great experience overall, but customer service could improve.'),
(7, 5, 'Amazing product, exactly as described! Very happy with the purchase.'),
(8, 3, 'Product is good, but there was an issue with the payment process.'),
(9, 5, 'Fantastic! Fast shipping and great quality.'),
(10, 4, 'Good product but slightly overpriced for the features.'),
(11, 3, 'Item was fine, but the delivery process was frustrating.'),
(12, 5, 'Highly recommend this product, works as expected and very durable.'),
(13, 1, 'Received a defective product, very disappointed.'),
(14, 4, 'Good product, but I had to wait longer than expected for it to be delivered.'),
(15, 4, 'Great experience, but I wish the website had more information about the product.'),
(16, 5, 'Absolutely loved it! It works great and looks amazing.'),
(17, 2, 'Product quality is poor, did not match my expectations.'),
(18, 4, 'Satisfied with the purchase, but it would be nice if there was a warranty included.'),
(19, 5, 'Perfect purchase! Great quality and fast delivery.'),
(20, 3, 'The product is good, but the customer service was not very helpful when I had issues.');

-- View FEEDBACK data of user
SELECT * FROM feedback;

-- ------------------------------------------------------------------------------
-- 								Table 23 : ACTIVITY_LOG							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The purpose of the activity_log table is to track and record user actions or system activities for monitoring 
and auditing purposes.
*/

-- Create ACTIVITY_LOG table
CREATE TABLE activity_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,                      		-- Unique identifier for each log entry
    user_id INT NOT NULL,                                       		-- ID of the user performing the activity
    activity_type VARCHAR(100) NOT NULL,                       			-- Type of activity (e.g., Login, Update, Delete)
    activity_description TEXT,                                 			-- Detailed description of the activity
    activity_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    			-- Timestamp of the activity
    ip_address VARCHAR(50),                                    			-- IP address of the user
    device_type VARCHAR(100),                                  			-- Device used (e.g., Desktop, Mobile)
    location VARCHAR(100),                                     			-- Physical location (e.g., city or region) if tracked
    success_status ENUM('Success', 'Failure') DEFAULT 'Success', 		-- Status of the activity
    error_message TEXT,                                        			-- Error message in case of failure
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE 	-- Links to the Users table
);

-- Insert data into ACTIVITY_LOG table
INSERT INTO activity_log (user_id, activity_type, activity_description, ip_address, device_type, location, success_status) 
VALUES
(1, 'Login', 'User logged into the system', '192.168.1.1', 'Desktop', 'New York, USA', 'Success'),
(2, 'Update', 'User updated their account details', '192.168.1.2', 'Mobile', 'San Francisco, USA', 'Success'),
(3, 'Delete', 'User deleted a product from the cart', '192.168.1.3', 'Tablet', 'Los Angeles, USA', 'Success'),
(4, 'Login', 'User logged into the system', '192.168.1.4', 'Desktop', 'Chicago, USA', 'Success'),
(5, 'Failed Login', 'User attempted to log in with incorrect password', '192.168.1.5', 'Mobile', 'Houston, USA', 'Failure'),
(6, 'Login', 'User logged into the system', '192.168.1.6', 'Desktop', 'Dallas, USA', 'Success'),
(7, 'Update', 'User updated their payment method', '192.168.1.7', 'Mobile', 'Miami, USA', 'Success'),
(8, 'Delete', 'User removed an item from the wishlist', '192.168.1.8', 'Mobile', 'Seattle, USA', 'Success'),
(9, 'Login', 'User logged into the system', '192.168.1.9', 'Laptop', 'Phoenix, USA', 'Success'),
(10, 'Update', 'User updated their shipping address', '192.168.1.10', 'Desktop', 'Denver, USA', 'Success'),
(11, 'Failed Login', 'User failed to log in with incorrect credentials', '192.168.1.11', 'Mobile', 'Boston, USA', 'Failure'),
(12, 'Delete', 'User deleted their account', '192.168.1.12', 'Tablet', 'Austin, USA', 'Success'),
(13, 'Login', 'User logged into the system', '192.168.1.13', 'Desktop', 'San Diego, USA', 'Success'),
(14, 'Update', 'User updated their email address', '192.168.1.14', 'Laptop', 'Orlando, USA', 'Success'),
(15, 'Delete', 'User deleted an order', '192.168.1.15', 'Mobile', 'Atlanta, USA', 'Success'),
(16, 'Login', 'User logged into the system', '192.168.1.16', 'Desktop', 'Las Vegas, USA', 'Success'),
(17, 'Failed Login', 'User tried to log in with incorrect password multiple times', '192.168.1.17', 'Mobile', 'Boston, USA', 'Failure'),
(18, 'Update', 'User changed their contact number', '192.168.1.18', 'Tablet', 'Charlotte, USA', 'Success'),
(19, 'Login', 'User logged into the system', '192.168.1.19', 'Desktop', 'Minneapolis, USA', 'Success'),
(20, 'Delete', 'User deleted a review', '192.168.1.20', 'Mobile', 'Portland, USA', 'Success');

-- View ACTIVITY_LOG data
SELECT * FROM activity_log;


-- ------------------------------------------------------------------------------
-- 								Table 24 : USER_ROLES							|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The purpose of the user_roles table is to define and manage different roles or permissions assigned to users in the system, 
helping control access levels.
*/

-- Create USER_ROLES table
CREATE TABLE user_roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,                        				-- Unique identifier for the role
    role_name VARCHAR(100) NOT NULL,                               				-- Name of the role (e.g., Admin, Manager, User)
    role_description TEXT,                                         				-- Description of the role
    permissions TEXT,                                              				-- List of permissions assigned to the role (e.g., 'Read, Write, Update')
    is_active BOOLEAN DEFAULT TRUE,                                 			-- Indicates if the role is active
    assigned_by INT,                                               				-- User ID who assigned the role
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                			-- Timestamp when the role was assigned
    valid_from TIMESTAMP,                                          				-- Start date for when the role is valid
    valid_until TIMESTAMP,                                         				-- End date for when the role expires
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,                				-- Timestamp for when the role was created
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 	-- Timestamp for when the role was last updated
);

-- Insert data into USER_ROLES table
INSERT INTO user_roles (role_name, role_description, permissions, is_active, assigned_by, assigned_at, valid_from, valid_until) 
VALUES
('Admin', 'Administrator with full access to all system features.', 'Read, Write, Update, Delete', TRUE, 1, '2025-01-01 09:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Manager', 'Manager with limited access to manage users and monitor operations.', 'Read, Update, Approve', TRUE, 2, '2025-01-05 09:30:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Customer', 'General user with access to view and place orders.', 'Read, Place Orders', TRUE, 3, '2025-01-10 10:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Support', 'Support staff with access to customer service features.', 'Read, Assist Customers', TRUE, 4, '2025-01-15 11:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Guest', 'Guest user with limited access, can view products.', 'Read', TRUE, NULL, '2025-01-20 12:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Warehouse Manager', 'Manager overseeing warehouse operations and stock management.', 'Read, Update, Stock Management', TRUE, 2, '2025-01-25 09:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Product Manager', 'Manager responsible for product listing and categorization.', 'Read, Write, Update Products', TRUE, 2, '2025-02-01 10:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Shipping Clerk', 'Employee responsible for managing shipment details and orders.', 'Read, Update, Ship Orders', TRUE, 5, '2025-02-05 11:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('HR', 'Human resources role responsible for managing employee information.', 'Read, Update, Manage Employees', TRUE, 6, '2025-02-10 08:30:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59'),
('Analytics', 'Data analyst role with read-only access to sales and operations data.', 'Read, Analyze Reports', TRUE, 7, '2025-02-15 14:00:00', '2025-01-01 00:00:00', '2025-12-31 23:59:59');


-- ------------------------------------------------------------------------------
-- 								Table 25 : BRANDS								|
-- ------------------------------------------------------------------------------

/*
PURPOSE: The purpose of the brands table is to store information about different product brands, including 
their names and other relevant details.
*/

-- Create table BRANDS table
CREATE TABLE brands (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,           -- Unique identifier for each brand
    brand_name VARCHAR(255) NOT NULL,                  -- Name of the brand
    country_of_origin VARCHAR(100),                    -- Country where the brand originated
    established_year INT,                              -- Year the brand was established
    status ENUM('Active', 'Inactive') NOT NULL,        -- Whether the brand is active or not
    website VARCHAR(255),                              -- Official website of the brand
    headquarters_location VARCHAR(255),                -- Location of the brand’s headquarters
    number_of_employees INT,                           -- Number of employees in the brand’s company
    revenue DECIMAL(15, 2),                            -- Revenue of the brand (in millions/billions)
    product_categories TEXT,                           -- Categories of products the brand offers (e.g., 'Electronics, Wearables')
    ceo_name VARCHAR(255),                             -- Name of the CEO of the brand
    is_public BOOLEAN DEFAULT TRUE,                    -- Whether the brand is publicly traded
    logo_image_url VARCHAR(255)                        -- URL link to the brand’s logo image
);

-- Insert data into BRANDS table
INSERT INTO brands (brand_name, country_of_origin, established_year, status, website, headquarters_location, number_of_employees, revenue, product_categories, ceo_name, is_public, logo_image_url)
VALUES
('Apple', 'USA', 1976, 'Active', 'https://www.apple.com', 'Cupertino, CA', 147000, 274515000000, 'Electronics, Wearables', 'Tim Cook', TRUE, 'https://www.apple.com/ac/structured-data/images/knowledge_graph_logo.png'),
('Samsung', 'South Korea', 1938, 'Active', 'https://www.samsung.com', 'Seoul, South Korea', 320000, 211937000000, 'Electronics, Appliances, Wearables', 'Kim Ki Nam', TRUE, 'https://www.samsung.com/etc/designs/samsung/global/common/images/samsung-logo.png'),
('Nike', 'USA', 1964, 'Active', 'https://www.nike.com', 'Beaverton, OR', 75000, 44364000000, 'Apparel, Footwear', 'John Donahoe', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/a/a6/Logo_of_Nike_2011.svg'),
('Sony', 'Japan', 1946, 'Active', 'https://www.sony.com', 'Tokyo, Japan', 110000, 82467000000, 'Electronics, Entertainment', 'Kenichiro Yoshida', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Sony_Logo.svg'),
('Dell', 'USA', 1984, 'Active', 'https://www.dell.com', 'Round Rock, TX', 165000, 94266000000, 'Electronics, Computers', 'Michael Dell', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/4/47/Dell_Logo_2016.png'),
('Toshiba', 'Japan', 1875, 'Inactive', 'https://www.toshiba.com', 'Tokyo, Japan', 140000, 37000000000, 'Electronics, Appliances', 'Nobuaki Kurumatani', FALSE, 'https://upload.wikimedia.org/wikipedia/commons/6/6a/Toshiba_logo.svg'),
('Bose', 'USA', 1964, 'Active', 'https://www.bose.com', 'Framingham, MA', 8000, 4000000000, 'Electronics, Audio', 'Philippe Kahn', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/0/0e/Bose_logo.svg'),
('Instant Pot', 'Canada', 2009, 'Active', 'https://www.instantpot.com', 'Ottawa, Canada', 150, 1500000000, 'Home Appliances', 'Robert Wang', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/2/2b/Instant_Pot_Logo.png'),
('HP', 'USA', 1939, 'Active', 'https://www.hp.com', 'Palo Alto, CA', 55000, 63000000000, 'Electronics, Printers', 'Enrique Lores', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/0/0e/HP_logo_2012.png'),
('LG Electronics', 'South Korea', 1958, 'Active', 'https://www.lg.com', 'Seoul, South Korea', 75000, 55540000000, 'Electronics, Appliances', 'Koo Kwang-mo', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/6/63/LG_logo_%282016%29.svg'),
('Microsoft', 'USA', 1975, 'Active', 'https://www.microsoft.com', 'Redmond, WA', 181000, 168000000000, 'Software, Electronics', 'Satya Nadella', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Microsoft_logo_%282012%29.svg'),
('Google', 'USA', 1998, 'Active', 'https://www.google.com', 'Mountain View, CA', 156000, 182527000000, 'Technology, Software', 'Sundar Pichai', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/4/42/Google_2015_logo.svg'),
('Tesla', 'USA', 2003, 'Active', 'https://www.tesla.com', 'Palo Alto, CA', 48016, 31900000000, 'Automotive, Solar Energy', 'Elon Musk', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/e/e8/Tesla_logo.png'),
('Amazon', 'USA', 1994, 'Active', 'https://www.amazon.com', 'Seattle, WA', 798000, 469800000000, 'E-commerce, Cloud Computing', 'Andy Jassy', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/a/a9/Amazon_logo.svg'),
('Intel', 'USA', 1968, 'Active', 'https://www.intel.com', 'Santa Clara, CA', 110600, 77900000000, 'Semiconductors', 'Pat Gelsinger', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/d/d7/Intel_logo_2006.svg'),
('Coca-Cola', 'USA', 1892, 'Active', 'https://www.coca-cola.com', 'Atlanta, GA', 86000, 37400000000, 'Beverages', 'James Quincey', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/4/46/Coca-Cola_logo.png'),
('PepsiCo', 'USA', 1965, 'Active', 'https://www.pepsico.com', 'Purchase, NY', 267000, 71100000000, 'Beverages, Snacks', 'Ramon Laguarta', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/4/46/Pepsi_logo_2014.png'),
('Adidas', 'Germany', 1949, 'Active', 'https://www.adidas.com', 'Herzogenaurach, Germany', 59000, 23500000000, 'Apparel, Footwear', 'Kasper Rørsted', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/2/2f/Adidas_Logo_2011.svg'),
('BMW', 'Germany', 1916, 'Active', 'https://www.bmw.com', 'Munich, Germany', 133000, 104000000000, 'Automotive', 'Oliver Zipse', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/4/44/BMW.svg'),
('Audi', 'Germany', 1909, 'Active', 'https://www.audi.com', 'Ingolstadt, Germany', 91000, 58000000000, 'Automotive', 'Markus Duesmann', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/2/2d/Audi_logo_%282019%29.svg'),
('Ford', 'USA', 1903, 'Active', 'https://www.ford.com', 'Dearborn, MI', 190000, 158000000000, 'Automotive', 'Jim Farley', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/5/54/Ford_logo_2017.svg'),
('Toyota', 'Japan', 1937, 'Active', 'https://www.toyota.com', 'Toyota City, Japan', 360000, 275000000000, 'Automotive', 'Akio Toyoda', TRUE, 'https://upload.wikimedia.org/wikipedia/commons/9/90/Toyota_logo.svg');


-- View BRAND data
SELECT * FROM brands;
