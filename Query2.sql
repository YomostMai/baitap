-- Tạo cơ sở dữ liệu
CREATE DATABASE ConstructionDB;
USE ConstructionDB;

-- Bảng host
CREATE TABLE host (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    address VARCHAR(45)
);

-- Bảng contractor
CREATE TABLE contractor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    address VARCHAR(255),
    contractor VARCHAR(45)
);

-- Bảng architect
CREATE TABLE architect (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    sex TINYINT(1),
    birthday DATE,
    place VARCHAR(255),
    address VARCHAR(255)
);

-- Bảng building
CREATE TABLE building (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    address VARCHAR(45),
    city VARCHAR(45),
    cost FLOAT,
    start DATE,
    host_id INT,
    contractor_id INT,
    FOREIGN KEY (host_id) REFERENCES host(id),
    FOREIGN KEY (contractor_id) REFERENCES contractor(id)
);

-- Bảng design
CREATE TABLE design (
    building_id INT,
    architect_id INT,
    benefit VARCHAR(45),
    PRIMARY KEY (building_id, architect_id),
    FOREIGN KEY (building_id) REFERENCES building(id),
    FOREIGN KEY (architect_id) REFERENCES architect(id)
);

-- Bảng worker
CREATE TABLE worker (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45),
    birthday VARCHAR(45),
    year VARCHAR(45),
    skill VARCHAR(45)
);

-- Bảng work
CREATE TABLE work (
    building_id INT,
    worker_id INT,
    date DATE,
    total VARCHAR(45),
    PRIMARY KEY (building_id, worker_id),
    FOREIGN KEY (building_id) REFERENCES building(id),
    FOREIGN KEY (worker_id) REFERENCES worker(id)
);
