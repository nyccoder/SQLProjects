/*
 * 
customers 3 rows
----------------
id (PK) INTEGER
name TEXT
email TEXT

orders 3 rows
------------------
id (PK) INTEGER
customer_id INTEGER
item TEXT
price REAL
*/

CREATE TABLE customers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT);
    
INSERT INTO customers (name, email) VALUES ("Doctor Who", "doctorwho@timelords.com");
INSERT INTO customers (name, email) VALUES ("Harry Potter", "harry@potter.com");
INSERT INTO customers (name, email) VALUES ("Captain Awesome", "captain@awesome.com");

CREATE TABLE orders (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    item TEXT,
    price REAL);

INSERT INTO orders (customer_id, item, price)
    VALUES (1, "Sonic Screwdriver", 1000.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (2, "High Quality Broomstick", 40.00);
INSERT INTO orders (customer_id, item, price)
    VALUES (1, "TARDIS", 1000000.00);
    
SELECT customers.name, customers.email, orders.item, SUM(orders.price) 
    FROM customers
    LEFT OUTER JOIN orders
    WHERE customers.id = orders.customer_id
    GROUP BY customers.name
    ORDER BY orders.price
    ;

SELECT * FROM customers;
