CREATE TABLE HD_Product (
    product_id int NOT NULL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_description VARCHAR(500) DEFAULT '',
    product_color VARCHAR(50) DEFAULT '',
    product_size VARCHAR(20) DEFAULT '',
    product_price DECIMAL(10, 2) NOT NULL
);

