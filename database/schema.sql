-- ============================================================
-- CSC 411/511 Course Project - Option 2: Automobile Company
-- Database Schema (DDL) - MySQL
-- Student: Stone Barnard
-- ============================================================

DROP DATABASE IF EXISTS auto_company;
CREATE DATABASE auto_company;
USE auto_company;

-- Company (top-level entity)
CREATE TABLE company (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    headquarters VARCHAR(200),
    founded_year INT,
    website VARCHAR(200)
);

CREATE TABLE brand (
    brand_id INT PRIMARY KEY AUTO_INCREMENT,
    brand_name VARCHAR(50) NOT NULL,
    company_id INT NOT NULL,
    country_of_origin VARCHAR(50),
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE
);

CREATE TABLE model (
    model_id INT PRIMARY KEY AUTO_INCREMENT,
    model_name VARCHAR(50) NOT NULL,
    brand_id INT NOT NULL,
    body_style VARCHAR(30) NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    year INT NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id) ON DELETE CASCADE
);

CREATE TABLE vehicle_option (
    option_id INT PRIMARY KEY AUTO_INCREMENT,
    option_name VARCHAR(100) NOT NULL,
    option_type VARCHAR(30) NOT NULL,
    additional_cost DECIMAL(10,2) DEFAULT 0.00
);

CREATE TABLE supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    supplier_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    phone VARCHAR(20),
    contact_person VARCHAR(100)
);

CREATE TABLE plant (
    plant_id INT PRIMARY KEY AUTO_INCREMENT,
    plant_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    plant_type VARCHAR(30) NOT NULL,
    company_id INT NOT NULL,
    FOREIGN KEY (company_id) REFERENCES company(company_id) ON DELETE CASCADE
);

CREATE TABLE part (
    part_id INT PRIMARY KEY AUTO_INCREMENT,
    part_name VARCHAR(100) NOT NULL,
    part_number VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE dealer (
    dealer_id INT PRIMARY KEY AUTO_INCREMENT,
    dealer_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    zip VARCHAR(10),
    phone VARCHAR(20),
    manager_name VARCHAR(100)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(50),
    state VARCHAR(50),
    zip VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    gender CHAR(1),
    annual_income DECIMAL(12,2)
);

CREATE TABLE vehicle (
    vin VARCHAR(17) PRIMARY KEY,
    model_id INT NOT NULL,
    year INT NOT NULL,
    color VARCHAR(30),
    engine_type VARCHAR(50),
    transmission VARCHAR(30),
    manufacture_date DATE,
    plant_id INT,
    msrp DECIMAL(10,2),
    FOREIGN KEY (model_id) REFERENCES model(model_id),
    FOREIGN KEY (plant_id) REFERENCES plant(plant_id)
);

CREATE TABLE vehicle_has_option (
    vin VARCHAR(17),
    option_id INT,
    PRIMARY KEY (vin, option_id),
    FOREIGN KEY (vin) REFERENCES vehicle(vin) ON DELETE CASCADE,
    FOREIGN KEY (option_id) REFERENCES vehicle_option(option_id)
);

CREATE TABLE supplier_part (
    supplier_id INT,
    part_id INT,
    supplier_plant_location VARCHAR(100),
    supply_date_start DATE,
    supply_date_end DATE,
    PRIMARY KEY (supplier_id, part_id),
    FOREIGN KEY (supplier_id) REFERENCES supplier(supplier_id),
    FOREIGN KEY (part_id) REFERENCES part(part_id)
);

CREATE TABLE model_part (
    model_id INT,
    part_id INT,
    quantity_needed INT DEFAULT 1,
    PRIMARY KEY (model_id, part_id),
    FOREIGN KEY (model_id) REFERENCES model(model_id),
    FOREIGN KEY (part_id) REFERENCES part(part_id)
);

CREATE TABLE plant_part (
    plant_id INT,
    part_id INT,
    PRIMARY KEY (plant_id, part_id),
    FOREIGN KEY (plant_id) REFERENCES plant(plant_id),
    FOREIGN KEY (part_id) REFERENCES part(part_id)
);

CREATE TABLE plant_assembly (
    plant_id INT,
    model_id INT,
    PRIMARY KEY (plant_id, model_id),
    FOREIGN KEY (plant_id) REFERENCES plant(plant_id),
    FOREIGN KEY (model_id) REFERENCES model(model_id)
);

CREATE TABLE dealer_brand (
    dealer_id INT,
    brand_id INT,
    PRIMARY KEY (dealer_id, brand_id),
    FOREIGN KEY (dealer_id) REFERENCES dealer(dealer_id),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
);

CREATE TABLE dealer_inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    dealer_id INT NOT NULL,
    vin VARCHAR(17) NOT NULL UNIQUE,
    date_received DATE NOT NULL,
    date_sold DATE,
    status VARCHAR(20) DEFAULT 'available',
    FOREIGN KEY (dealer_id) REFERENCES dealer(dealer_id),
    FOREIGN KEY (vin) REFERENCES vehicle(vin)
);

CREATE TABLE sale (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    vin VARCHAR(17) NOT NULL,
    customer_id INT NOT NULL,
    dealer_id INT NOT NULL,
    sale_date DATE NOT NULL,
    sale_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (vin) REFERENCES vehicle(vin),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (dealer_id) REFERENCES dealer(dealer_id)
);

-- Indices
CREATE INDEX idx_vehicle_model ON vehicle(model_id);
CREATE INDEX idx_vehicle_year ON vehicle(year);
CREATE INDEX idx_sale_date ON sale(sale_date);
CREATE INDEX idx_sale_dealer ON sale(dealer_id);
CREATE INDEX idx_sale_customer ON sale(customer_id);
CREATE INDEX idx_model_brand ON model(brand_id);
CREATE INDEX idx_brand_company ON brand(company_id);
CREATE INDEX idx_customer_gender ON customer(gender);
CREATE INDEX idx_customer_income ON customer(annual_income);
CREATE INDEX idx_dealer_inventory_status ON dealer_inventory(status);
CREATE INDEX idx_dealer_inventory_dates ON dealer_inventory(date_received, date_sold);
