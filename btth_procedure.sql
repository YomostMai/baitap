-- Tạo cơ sở dữ liệu SalesDB
CREATE DATABASE SalesDB;
USE SalesDB;

-- Tạo bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Tạo bảng Promotions
CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    PromotionName VARCHAR(100) NOT NULL,
    DiscountPercentage DECIMAL(5, 2) NOT NULL
);

-- Tạo bảng Sales
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    SaleDate DATE NOT NULL,
    SaleAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Thêm chỉ số để cải thiện hiệu suất truy vấn
-- Chỉ số cho cột Email trong bảng Customers
CREATE INDEX idx_email ON Customers (Email);

-- Chỉ số cho cột ProductName trong bảng Products
CREATE INDEX idx_product_name ON Products (ProductName);

-- Chỉ số cho cột OrderDate trong bảng Orders
CREATE INDEX idx_order_date ON Orders (OrderDate);

-- Chỉ số cho cột SaleDate trong bảng Sales
CREATE INDEX idx_sale_date ON Sales (SaleDate);


-- Thêm dữ liệu vào bảng Customers
INSERT INTO Customers (FirstName, LastName, Email)
VALUES 
('John', 'Doe', 'john.doe@example.com'),
('Jane', 'Smith', 'jane.smith@example.com'),
('Alice', 'Brown', 'alice.brown@example.com'),
('Bob', 'White', 'bob.white@example.com');

-- Thêm dữ liệu vào bảng Products
INSERT INTO Products (ProductName, Price)
VALUES 
('Laptop', 1200.50),
('Smartphone', 800.00),
('Tablet', 450.75),
('Headphones', 150.25);

-- Thêm dữ liệu vào bảng Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES 
(1, '2024-11-01', 1250.50),
(2, '2024-11-03', 800.00),
(3, '2024-11-10', 450.75),
(4, '2024-11-15', 300.00);

-- Thêm dữ liệu vào bảng Promotions
INSERT INTO Promotions (PromotionName, DiscountPercentage)
VALUES 
('Black Friday Sale', 20.00),
('Cyber Monday Sale', 15.00),
('Holiday Discount', 10.00),
('New Year Sale', 25.00);

-- Thêm dữ liệu vào bảng Sales
INSERT INTO Sales (OrderID, SaleDate, SaleAmount)
VALUES 
(1, '2024-11-01', 1250.50),
(2, '2024-11-03', 800.00),
(3, '2024-11-10', 450.75),
(4, '2024-11-15', 300.00);


DELIMITER $$

CREATE PROCEDURE CalculateMonthlyRevenueAndApplyPromotion(
    IN monthYear VARCHAR(7), 
    IN revenueThreshold DECIMAL(10, 2)
)
BEGIN
    DECLARE promoName VARCHAR(100);
    DECLARE promoDiscount DECIMAL(5, 2);

    -- Đặt tên và mức giảm giá cho chương trình khuyến mãi
    SET promoName = CONCAT('Special Promo for ', monthYear);
    SET promoDiscount = 10.00; -- Giảm giá 10%

    -- Tạo bảng tạm để lưu tổng doanh thu hàng tháng của từng khách hàng
    CREATE TEMPORARY TABLE MonthlyRevenue (
        CustomerID INT,
        TotalRevenue DECIMAL(10, 2)
    );

    -- Tính tổng doanh thu hàng tháng cho từng khách hàng
    INSERT INTO MonthlyRevenue (CustomerID, TotalRevenue)
    SELECT 
        o.CustomerID,
        SUM(s.SaleAmount) AS TotalRevenue
    FROM 
        Orders o
    INNER JOIN Sales s ON o.OrderID = s.OrderID
    WHERE 
        DATE_FORMAT(s.SaleDate, '%Y-%m') = monthYear
    GROUP BY 
        o.CustomerID;

    -- Kiểm tra khách hàng có tổng doanh thu vượt qua ngưỡng và thêm khuyến mãi
    INSERT INTO Promotions (PromotionName, DiscountPercentage)
    SELECT 
        promoName,
        promoDiscount
    FROM 
        MonthlyRevenue
    WHERE 
        TotalRevenue > revenueThreshold;

    -- Xóa bảng tạm
    DROP TEMPORARY TABLE MonthlyRevenue;
END$$

DELIMITER ;


CALL CalculateMonthlyRevenueAndApplyPromotion('2024-07', 5000);
