SET GLOBAL local_infile = ON;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
USE mydb;

# 1

CREATE TABLE `categories` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    `description` VARCHAR(255),
    PRIMARY KEY (`id`)
);

LOAD DATA INFILE '/var/lib/mysql-files/categories.csv'
INTO TABLE `categories` FIELDS TERMINATED BY ','ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 
ROWS (`id`, `name`, `description`);

# 2 

CREATE TABLE `customers` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    `contact` VARCHAR(255),
    `address` VARCHAR(255),
    `city` VARCHAR(255),
    `postal_code` VARCHAR(255),
    `country` VARCHAR(255),
    PRIMARY KEY (`id`)
);

LOAD DATA INFILE '/var/lib/mysql-files/customers.csv'
INTO TABLE `customers` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`id`,`name`,`contact`,`address`,`city`,`postal_code`,`country`);

# 3

CREATE TABLE `employees` (
    `employee_id` INT(11) NOT NULL AUTO_INCREMENT,
    `last_name` VARCHAR(255),
    `first_name` VARCHAR(255),
    `birthdate` VARCHAR(255),
    `photo` VARCHAR(255),
    `notes` TEXT,
    PRIMARY KEY (`employee_id`)
);

LOAD DATA INFILE '/var/lib/mysql-files/employees.csv'
INTO TABLE `employees` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`employee_id`,`last_name`,`first_name`,`birthdate`,`photo`,`notes`);

# 8
CREATE TABLE `shippers` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    `phone` VARCHAR(255),
    PRIMARY KEY (`id`)
);

LOAD DATA INFILE '/var/lib/mysql-files/shippers.csv'
INTO TABLE `shippers` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`id`,`name`,`phone`);

# 4
CREATE TABLE `orders` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `customer_id` INT(11) NOT NULL,
    `employee_id` INT(11) NOT NULL,
    `date` DATE,
    `shipper_id` INT(11) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (shipper_id) REFERENCES shippers(id)
);

LOAD DATA INFILE '/var/lib/mysql-files/orders.csv'
INTO TABLE `orders` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`id`,`customer_id`,`employee_id`,`date`,`shipper_id`);


# 5
CREATE TABLE `suppliers` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    `contact` VARCHAR(255),
    `address` VARCHAR(255),
    `city` VARCHAR(255),
    `postal_code` VARCHAR(255),
    `country` VARCHAR(255),
    `phone` VARCHAR(255),
    PRIMARY KEY (`id`)
);

LOAD DATA INFILE '/var/lib/mysql-files/suppliers.csv'
INTO TABLE `suppliers` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`id`,`name`,`contact`,`address`,`city`,`postal_code`,`country`,`phone`);


# 6

CREATE TABLE `products` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255),
    `supplier_id` INT(11) NOT NULL,
    `category_id` INT(11) NOT NULL,
    `unit` VARCHAR(255),
    `price` DECIMAL(10, 2),
    PRIMARY KEY (`id`),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

LOAD DATA INFILE '/var/lib/mysql-files/products.csv'
INTO TABLE `products` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`id`,`name`,`supplier_id`,`category_id`,`unit`,`price`);

# 7
CREATE TABLE `order_details` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `order_id` INT(11) NOT NULL,
    `product_id` INT(11) NOT NULL,
    `quantity` INT,
    PRIMARY KEY (`id`),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

LOAD DATA INFILE '/var/lib/mysql-files/order_details.csv'
INTO TABLE `order_details` FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n'
IGNORE 1 ROWS (`id`,`order_id`,`product_id`,`quantity`);
