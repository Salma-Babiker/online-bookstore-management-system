create database bookstore;

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(13) UNIQUE,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    publication_year YEAR,
    category_id INT,
    author_id INT
);

CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    birth_year YEAR
);

CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);


CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    address TEXT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
    status ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') DEFAULT 'pending',
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE RESTRICT,
    UNIQUE KEY unique_order_book (order_id, book_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_method ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer', 'cash_on_delivery') NOT NULL,
    status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    transaction_id VARCHAR(100) UNIQUE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);

ALTER TABLE books
ADD FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
ADD FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE SET NULL;


-- Categories
INSERT INTO categories (category_name, description)
VALUES
    ('Fiction', 'Literary and popular fiction'),
    ('Technology', 'Programming, IT, and computer science'),
    ('Self-Help', 'Personal development and motivation'),
    ('Classic Literature', 'Timeless works from renowned authors across centuries'),
    ('Science Fiction', 'Futuristic and speculative stories involving science and technology'),
    ('Fantasy', 'Imaginative worlds with magic, mythical creatures, and epic adventures'),
    ('Biography', 'Life stories and accounts of notable individuals'),
    ('History', 'Accounts of past events, civilizations, and historical figures'),
    ('Mystery', 'Suspenseful stories involving crime, investigation, and intrigue'),
    ('Business', 'Books on entrepreneurship, management, finance, and leadership');

-- Authors
INSERT INTO authors (name, bio, birth_year)
VALUES
    ('Jane Austen', 'English novelist known for Pride and Prejudice', 1775),
    ('Robert C. Martin', 'Software engineer and author of Clean Code', 1952),
    ('George Orwell', 'English writer and journalist, author of 1984 and Animal Farm', 1903),
    ('F. Scott Fitzgerald', 'American novelist and short story writer, known for The Great Gatsby', 1896),
    ('Harper Lee', 'American novelist and author of To Kill a Mockingbird', 1926),
    ('J.K. Rowling', 'British author, best known for the Harry Potter series', 1965),
    ('Paulo Coelho', 'Brazilian lyricist and novelist, author of The Alchemist', 1947),
    ('Frank Herbert', 'American science fiction writer, famous for the Dune series', 1920),
    ('J.R.R. Tolkien', 'English writer, poet, and creator of The Hobbit and The Lord of the Rings', 1892),
    ('Yuval Noah Harari', 'Israeli historian and author of Sapiens: A Brief History of Humankind', 1976);

-- Books
INSERT INTO books (title, isbn, price, stock_quantity, publication_year, category_id, author_id)
VALUES
    ('The Great Gatsby', '9780743273565', 12.99, 45, 1925, 1, 1),
    ('To Kill a Mockingbird', '9780061120084', 14.50, 32, 1960, 1, 2),
    ('1984', '9780451524935', 11.99, 67, 1949, 2, 3),
    ('Pride and Prejudice', '9780141439518', 9.99, 28, 1813, 3, 4),
    ('The Catcher in the Rye', '9780316769488', 13.75, 19, 1951, 1, 5),
    ('Harry Potter and the Sorcerer''s Stone', '9780590353427', 24.99, 120, 1997, 4, 6),
    ('The Alchemist', '9780061122415', 15.99, 85, 1988, 5, 7),
    ('Dune', '9780441172719', 18.50, 53, 1965, 6, 8),
    ('The Hobbit', '9780547928227', 16.99, 74, 1937, 4, 9),
    ('Sapiens: A Brief History of Humankind', '9780062316097', 22.50, 41, 2011, 7, 10);

-- Customer
INSERT INTO customers (first_name, last_name, email, phone, address)
VALUES
    ('John', 'Doe', 'john@example.com', '1234567890', '123 Main St, New York, NY 10001'),
    ('Emma', 'Smith', 'emma.smith@email.com', '9876543210', '456 Oak Avenue, Los Angeles, CA 90001'),
    ('Michael', 'Johnson', 'michael.j@email.com', '5551234567', '789 Pine Road, Chicago, IL 60601'),
    ('Sophia', 'Williams', 'sophia.w@email.com', '4445556666', '321 Elm Street, Houston, TX 77001'),
    ('James', 'Brown', 'james.brown@email.com', '7778889999', '654 Maple Drive, Phoenix, AZ 85001'),
    ('Olivia', 'Garcia', 'olivia.garcia@email.com', '2223334444', '987 Cedar Lane, Philadelphia, PA 19101'),
    ('William', 'Martinez', 'william.m@email.com', '1112223333', '159 Birch Blvd, San Antonio, TX 78201'),
    ('Ava', 'Rodriguez', 'ava.rodriguez@email.com', '6667778888', '753 Walnut Court, San Diego, CA 92101'),
    ('Alexander', 'Lee', 'alex.lee@email.com', '9990001111', '246 Spruce Way, Dallas, TX 75201'),
    ('Isabella', 'Taylor', 'isabella.taylor@email.com', '3334445555', '135 Aspen Grove, Seattle, WA 98101');

-- Order
INSERT INTO orders (customer_id, total_amount, status, shipping_address) VALUES
(1, 58.98, 'pending', '123 Main St, NY');
(2, 120.50, 'shipped', '456 Oak Ave, CA'),
(3, 75.20, 'delivered', '789 Pine Rd, TX'),
(4, 33.99, 'pending', '321 Maple St, FL'),
(5, 210.00, 'processing', '654 Cedar Blvd, WA'),
(6, 89.45, 'shipped', '987 Birch Ln, IL'),
(7, 15.99, 'cancelled', '159 Spruce Dr, NV'),
(8, 49.99, 'delivered', '753 Elm St, GA'),
(9, 134.75, 'processing', '852 Willow Way, OH'),
(10, 67.30, 'pending', '951 Aspen Ct, CO');
-- Order details
INSERT INTO order_details (order_id, book_id, quantity, unit_price) VALUES
(1, 1, 1, 12.99),
(1, 2, 1, 45.99);
(2, 3, 2, 15.99),
(2, 4, 1, 22.50),
(3, 1, 1, 12.99),
(3, 5, 3, 9.99),
(4, 2, 2, 45.99),
(5, 6, 1, 18.75),
(6, 3, 1, 15.99),
(7, 4, 2, 22.50);


3. Data Dictionary:
books_Dictionary:
 
Attribute
Data Type
Constraint
Description
book_id 
INT
PK, Not null, Auto_increment
Each book’s unique ID. Primary key for this table
title
VARCHAR (255)
Not Null
Title of each book
isbn
VARCHAR (13)
Unique
Unique international standard book number for each book
price
DECIMAL (10,2)
Not Null, CHECK (price >=0)
Price of the book
stock_quantity
INT
Not Null, Default 0 check (stock_quantity>=0)
Number of books in the stock
publication_year
YEAR
 
Year of publication
category_id
INT
 
Category of the book
author_id
INT
FK
Id of book author. Foreign Key for this table and reference to the ‘author_id’ column in ‘authors’ table
 
 
‏authors_Dictionary:
 
‏Attribute
‏Data Type
‏Constraint
‏Description
‏author_id
‏INT
‏PK, Not null, Auto_increment
‏Each author’s unique ID. Primary key for this table
‏name
‏VARCHAR (100)
‏Not Null
‏Name of the author
‏bio
‏TEXT
 
‏Bio information of author
‏birth_year
‏YEAR
 
‏Author’s year of birth
 
 
‏categories_Dictionary:
 
‏Attribute
‏Data Type
‏Constraint
‏Description
‏category_id
‏INT
‏PK, Not null, Auto_increment
‏Id of Book Category. Primary key for this table
‏category_name
‏VARCHAR (50)
‏Not Null, Unique
‏Name of the category of the book
‏description
‏TEXT
 
‏Description of the book category
 
‏customers_Dictionary:
 
‏Attribute
‏Data Type
‏Constraint
‏Description
‏customer_id 
‏INT
‏PK, Not null, Auto_increment
‏Each customer’s unique ID. Primary key for this table
‏first_name
‏VARCHAR (50)
‏Not Null
‏First Name of each customer
‏last_name
‏VARCHAR (50)
‏Not Null
‏Last Name of each customer
‏email
‏VARCHAR (100)
‏Not Null, Unique
‏Customer’s personal email
‏phone
‏VARCHAR (15)
 
‏Customer’s phone number
‏registration_date
‏TIMESTAMP
‏DEFAULT CURRENT_TIMESTAMP
‏Time of registration
‏address
‏TEXT
 
‏Address of customer
 
 
‏orders_Dictionary:
 
‏Attribute
‏Data Type
‏Constraint
‏Description
‏order_id
‏INT
‏PK, Not null, Auto_increment
‏Each order’s unique ID. Primary key for this table
‏customer_id
‏INT
‏FK, NOT NULL
‏Id of the customer who placed the order. Foreign Key for this table and reference to the ‘customer_id’ column in ‘customers’ table
‏order_date
‏TIMESTAMP
‏DEFAULT CURRENT_TIMESTAMP
‏Time of the order
‏total_amount
‏DECIMAL (10,2)
‏Not Null, CHECK(total_amount >= 0)
‏Total amount for this order
‏status
‏ENUM ('pending', 'processing', 'shipped', 'delivered', 'cancelled') 
‏DEFAULT 'pending'
‏Status of the order
‏shipping_address 
‏TEXT
‏Not Null
‏Address where to ship the order items
 
‏order_details_Dictionary:
 
‏Attribute
‏Data Type
‏Constraint
‏Description
‏order_detail_id
‏INT
‏PK, Not null, Auto_increment
‏Unique ID for order details. Primary key for this table.
‏order_id
‏INT
‏FK, Not Null
‏Foreign Key for this table and reference to the ‘order_id’ column in ‘orders’ table 
‏book_id
‏INT
‏FK, Not Null
‏Foreign Key for this table and reference to the ‘book_id’ column in ‘books’ table 
‏quantity
‏INT
‏Not Null, CHECK (quantity > 0)
‏Number of books ordered.
‏unit_price
‏DECIMAL (10,2)
‏Not Null, CHECK (unit_price >= 0)
‏Unit price of each book
 
 
‏unique_order_book
‏Composite key combining ‘order_id’ and ‘book_id’ columns 
 
 
‏payments_Dictionary:
 
‏Attribute
‏Data Type
‏Constraint
‏Description
‏payment_id
‏INT
‏PK, Not null, Auto_increment
‏Unique ID for each payment. Primary key for this table.
‏order_id
‏INT
‏FK, Not Null
‏Foreign Key for this table and reference to the ‘order_id’ column in ‘orders’ table
‏payment_date
‏TIMESTAMP
‏DEFAULT CURRENT_TIMESTAMP
‏Time of payment
‏amount
‏DECIMAL (10,2)
‏Not Null, CHECK (amount > 0)
‏Amount paid
‏payment_method
‏ENUM('credit_card', 'debit_card', 'paypal', 'bank_transfer', 'cash_on_delivery')
‏Not Null
‏Method of payment
‏status
‏ENUM('pending', 'completed', 'failed', 'refunded')
‏DEFAULT 'pending'
‏Status of payment
‏transaction_id
‏VARCHAR(100)
‏Unique
‏Id of transaction
CREATE OR REPLACE VIEW vw_book_catalog AS
SELECT
    b.book_id,
    b.title,
    b.isbn,
    b.price,
    b.stock_quantity,
    b.publication_year,
    a.name          AS author_name,
    c.category_name AS category
FROM books b
LEFT JOIN authors    a ON b.author_id   = a.author_id
LEFT JOIN categories c ON b.category_id = c.category_id;

SELECT * FROM vw_book_catalog WHERE category = 'Fiction' ORDER BY price;


CREATE OR REPLACE VIEW vw_customer_order_summary AS
SELECT
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    COUNT(o.order_id)                       AS total_orders,
    COALESCE(SUM(o.total_amount), 0)        AS total_spent,
    MAX(o.order_date)                        AS last_order_date
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.email;

SELECT * FROM vw_customer_order_summary ORDER BY total_spent DESC LIMIT 5;


CREATE OR REPLACE VIEW vw_order_details_full AS
SELECT
    o.order_id,
    o.order_date,
    o.status        AS order_status,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.email,
    b.title         AS book_title,
    od.quantity,
    od.unit_price,
    (od.quantity * od.unit_price) AS line_total,
    o.shipping_address
FROM orders o
JOIN customers    c  ON o.customer_id      = c.customer_id
JOIN order_details od ON o.order_id        = od.order_id
JOIN books         b  ON od.book_id         = b.book_id;

SELECT * FROM vw_order_details_full WHERE order_id = 1;


CREATE OR REPLACE VIEW vw_low_stock_alert AS
SELECT
    b.book_id,
    b.title,
    a.name  AS author_name,
    b.stock_quantity,
    b.price
FROM books b
LEFT JOIN authors a ON b.author_id = a.author_id
WHERE b.stock_quantity < 10
ORDER BY b.stock_quantity ASC;
SELECT * FROM vw_low_stock_alert;

CREATE OR REPLACE VIEW vw_revenue_by_category AS
SELECT
    c.category_name,
    COUNT(DISTINCT od.order_id)     AS total_orders,
    SUM(od.quantity)                AS total_units_sold,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM categories c
JOIN books         b  ON c.category_id  = b.category_id
JOIN order_details od ON b.book_id       = od.book_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;
SELECT * FROM vw_revenue_by_category;

DELIMITER $$

CREATE PROCEDURE sp_place_order(
    IN  p_customer_id     INT,
    IN  p_book_id         INT,
    IN  p_quantity        INT,
    IN  p_shipping_address TEXT,
    OUT p_order_id        INT
)
BEGIN
    DECLARE v_price         DECIMAL(10,2);
    DECLARE v_stock         INT;
    DECLARE v_total         DECIMAL(10,2);

    -- Validate stock
    SELECT price, stock_quantity INTO v_price, v_stock
    FROM books WHERE book_id = p_book_id FOR UPDATE;

    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient stock for the requested book.';
    END IF;

    SET v_total = v_price * p_quantity;

    START TRANSACTION;

        -- Insert order header
        INSERT INTO orders (customer_id, total_amount, status, shipping_address)
        VALUES (p_customer_id, v_total, 'pending', p_shipping_address);

        SET p_order_id = LAST_INSERT_ID();

        -- Insert order line
        INSERT INTO order_details (order_id, book_id, quantity, unit_price)
        VALUES (p_order_id, p_book_id, p_quantity, v_price);

        -- Decrement stock
        UPDATE books
        SET stock_quantity = stock_quantity - p_quantity
        WHERE book_id = p_book_id;

    COMMIT;
END$$

DELIMITER ;
CALL sp_place_order(1, 3, 2, '123 Main St, NY', @new_order_id);
SELECT @new_order_id;

DELIMITER $$

CREATE PROCEDURE sp_update_order_status(
    IN p_order_id INT,
    IN p_new_status ENUM('pending','processing','shipped','delivered','cancelled')
)
BEGIN
    DECLARE v_current_status VARCHAR(20);

    SELECT status INTO v_current_status
    FROM orders WHERE order_id = p_order_id;

    IF v_current_status = 'cancelled' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot update a cancelled order.';
    END IF;

    UPDATE orders
    SET status = p_new_status
    WHERE order_id = p_order_id;

    SELECT CONCAT('Order ', p_order_id, ' updated to: ', p_new_status) AS result;
END$$

DELIMITER ;
CALL sp_update_order_status(1, 'shipped');


DELIMITER $$

CREATE PROCEDURE sp_process_payment(
    IN p_order_id        INT,
    IN p_amount          DECIMAL(10,2),
    IN p_payment_method  VARCHAR(50),
    IN p_transaction_id  VARCHAR(100)
)
BEGIN
    DECLARE v_order_total DECIMAL(10,2);

    SELECT total_amount INTO v_order_total
    FROM orders WHERE order_id = p_order_id;

    IF p_amount < v_order_total THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Payment amount is less than the order total.';
    END IF;

    INSERT INTO payments (
        order_id, amount, payment_method, status, transaction_id
    ) VALUES (
        p_order_id, p_amount, p_payment_method, 'completed', p_transaction_id
    );

    -- Advance order status
    UPDATE orders SET status = 'processing'
    WHERE order_id = p_order_id AND status = 'pending';

    SELECT 'Payment recorded successfully.' AS result;
END$$

DELIMITER ;
CALL sp_process_payment(1, 58.98, 'credit_card', 'TXN-20250401-001');


DELIMITER $$

CREATE PROCEDURE sp_get_customer_report(IN p_customer_id INT)
BEGIN
    -- Customer profile
    SELECT customer_id,
           CONCAT(first_name, ' ', last_name) AS full_name,
           email, phone, registration_date
    FROM customers
    WHERE customer_id = p_customer_id;

    -- Order history
    SELECT o.order_id, o.order_date, o.status,
           o.total_amount, o.shipping_address
    FROM orders o
    WHERE o.customer_id = p_customer_id
    ORDER BY o.order_date DESC;

    -- Spend summary
    SELECT COUNT(*)          AS total_orders,
           SUM(total_amount) AS grand_total_spent
    FROM orders
    WHERE customer_id = p_customer_id;
END$$

DELIMITER ;
DELIMITER $$

CREATE EVENT IF NOT EXISTS evt_cancel_stale_pending_orders
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    -- Restore stock for books in stale pending orders
    UPDATE books b
    JOIN order_details od ON b.book_id = od.book_id
    JOIN orders o         ON od.order_id = o.order_id
    SET b.stock_quantity = b.stock_quantity + od.quantity
    WHERE o.status = 'pending'
      AND o.order_date < NOW() - INTERVAL 24 HOUR
      AND NOT EXISTS (
            SELECT 1 FROM payments p
            WHERE p.order_id = o.order_id
              AND p.status = 'completed'
          );

    -- Cancel the stale orders
    UPDATE orders
    SET status = 'cancelled'
    WHERE status = 'pending'
      AND order_date < NOW() - INTERVAL 24 HOUR
      AND NOT EXISTS (
            SELECT 1 FROM payments p
            WHERE p.order_id = orders.order_id
              AND p.status = 'completed'
          );
END$$

DELIMITER ;
-- Supporting table (run once):
CREATE TABLE IF NOT EXISTS bookstore_daily_sales (
    snapshot_date DATE PRIMARY KEY,
    total_orders  INT            DEFAULT 0,
    total_revenue DECIMAL(12,2)  DEFAULT 0.00
);

DELIMITER $$

CREATE EVENT IF NOT EXISTS evt_daily_sales_snapshot
ON SCHEDULE EVERY 1 DAY
STARTS CONCAT(CURDATE(), ' 23:59:00')
DO
BEGIN
    INSERT INTO bookstore_daily_sales (snapshot_date, total_orders, total_revenue)
    SELECT
        CURDATE(),
        COUNT(*),
        COALESCE(SUM(total_amount), 0)
    FROM orders
    WHERE DATE(order_date) = CURDATE()
    ON DUPLICATE KEY UPDATE
        total_orders  = VALUES(total_orders),
        total_revenue = VALUES(total_revenue);
END$$

DELIMITER ;
-- Supporting table (run once):
CREATE TABLE IF NOT EXISTS low_stock_log (
    log_id       INT PRIMARY KEY AUTO_INCREMENT,
    book_id      INT,
    title        VARCHAR(255),
    stock_qty    INT,
    flagged_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE EVENT IF NOT EXISTS evt_weekly_low_stock_flag
ON SCHEDULE EVERY 1 WEEK
STARTS CONCAT(CURDATE() + INTERVAL (2 - DAYOFWEEK(CURDATE())) DAY, ' 07:00:00')
DO
BEGIN
    INSERT INTO low_stock_log (book_id, title, stock_qty)
    SELECT book_id, title, stock_quantity
    FROM books
    WHERE stock_quantity < 10;
END$$

DELIMITER ;

-- List all events
SHOW EVENTS FROM bookstore;

-- Temporarily disable an event
ALTER EVENT evt_daily_sales_snapshot DISABLE;

-- Re-enable an event
ALTER EVENT evt_daily_sales_snapshot ENABLE;

-- Drop an event
DROP EVENT IF EXISTS evt_cancel_stale_pending_orders;

DELIMITER $$

CREATE FUNCTION fn_calculate_order_total(p_order_id INT)
RETURNS DECIMAL(10,2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10,2) DEFAULT 0.00;

    SELECT COALESCE(SUM(quantity * unit_price), 0)
    INTO v_total
    FROM order_details
    WHERE order_id = p_order_id;

    RETURN v_total;
END$$

DELIMITER ;
-- Validate stored totals vs recalculated totals
SELECT order_id,
       total_amount                          AS stored_total,
       fn_calculate_order_total(order_id)    AS recalculated_total
FROM orders;

DELIMITER $$

CREATE FUNCTION fn_get_customer_full_name(p_customer_id INT)
RETURNS VARCHAR(120)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_name VARCHAR(120);

    SELECT CONCAT(first_name, ' ', last_name)
    INTO v_name
    FROM customers
    WHERE customer_id = p_customer_id;

    RETURN IFNULL(v_name, 'Unknown Customer');
END$$

DELIMITER ;
SELECT order_id,
       fn_get_customer_full_name(customer_id) AS customer_name,
       total_amount
FROM orders
ORDER BY order_date DESC;

DELIMITER $$

CREATE FUNCTION fn_apply_discount(
    p_original_price  DECIMAL(10,2),
    p_discount_pct    DECIMAL(5,2)   -- e.g. 10 means 10%
)
RETURNS DECIMAL(10,2)
NO SQL
DETERMINISTIC
BEGIN
    IF p_discount_pct < 0 OR p_discount_pct > 100 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Discount percentage must be between 0 and 100.';
    END IF;

    RETURN ROUND(p_original_price * (1 - p_discount_pct / 100), 2);
END$$

DELIMITER ;
-- Show all books with a 15% promotional discount applied
SELECT title,
       price                          AS original_price,
       fn_apply_discount(price, 15)   AS discounted_price
FROM books
ORDER BY title;

DELIMITER $$

CREATE FUNCTION fn_days_since_order(p_order_id INT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_order_date TIMESTAMP;

    SELECT order_date INTO v_order_date
    FROM orders
    WHERE order_id = p_order_id;

    RETURN DATEDIFF(NOW(), v_order_date);
END$$

DELIMITER ;
-- Flag orders that have been processing for more than 3 days
SELECT order_id,
       fn_get_customer_full_name(customer_id) AS customer,
       status,
       fn_days_since_order(order_id)           AS days_old
FROM orders
WHERE status IN ('pending', 'processing')
  AND fn_days_since_order(order_id) > 3
ORDER BY days_old DESC;

-- ADMIN ROLE and PERMISSION:
-- SQL command for granting permissions to admin:
GRANT ALL PRIVILEGES ON bookstore.* TO admin;

This access privileges gives a user full control over all tables, queries, views, stored procedures, functions etc. who has admin role within the ‘bookstore’ database.
-- SQL command to create a user intended for admin role: 
CREATE USER 'group1admin'@'localhost' IDENTIFIED BY 'G!admin'; 

-- SQL command for assigning admin role to ‘group1admin’ user: 
GRANT 'admin' TO 'group1admin'@'localhost';

-- SELLER ROLE AND PERMISION:
-- SQL command for granting SELECT permissions to seller: 
GRANT SELECT ON bookstore.* TO seller; 

-- SQL command for granting permission to execute all stored procedure by seller role
GRANT EXECUTE ON bookstore.* TO seller;

-- SQL command for granting permission to execute a single stored procedure by seller role
GRANT EXECUTE ON PROCEDURE sp_update_order_status TO seller; 

-- SQL command to create a user intended for seller role: 
CREATE USER 'group1seller'@'localhost' IDENTIFIED BY 'G!seller'; 

-- SQL command for assigning seller role to ‘group1seller’ user: 
GRANT 'seller' TO 'group1seller'@'localhost';

-- CUSTOMER ROLE
-- SQL command for granting SELECT permissions to customer role on BOOKS table only:
GRANT SELECT ON books TO customer;

-- SQL command for granting SELECT permissions to customer role on books table's selected columns only: 
GRANT SELECT (book_id, title, price, stock_quantity) ON books TO customer; 

-- SQL command for granting EXECUTE specific STORED PROCEDURE permissions to customer role: 
GRANT EXECUTE ON PROCEDURE sp_place_order TO customer; 

-- SQL command to create a user intended for customer role: 
CREATE USER 'group1customer'@'localhost' IDENTIFIED BY 'G!customer'; 

-- SQL command for assigning customer role to ‘group1customer’ user: 
GRANT 'customer' TO 'group1customer'@'localhost';




