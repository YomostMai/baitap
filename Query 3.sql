-- Tạo cơ sở dữ liệu ECommerceDB
CREATE DATABASE if not exists ECommerceDB2;
USE ECommerceDB2;

-- Tạo bảng Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    PriceAtOrder DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Tạo bảng Reviews
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    UserID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
-- Thêm 3 người dùng mới vào bảng Users
INSERT INTO Users (Username, PasswordHash, Email) VALUES 
('user1', 'hash1', 'user1@example.com'),
('user2', 'hash2', 'user2@example.com'),
('user3', 'hash3', 'user3@example.com');

-- Thêm 5 sản phẩm mới vào bảng Products
INSERT INTO Products (ProductName, Description, Price, Stock) VALUES 
('Product A', 'Description of Product A', 10.00, 100),
('Product B', 'Description of Product B', 20.00, 50),
('Product C', 'Description of Product C', 15.00, 70),
('Product D', 'Description of Product D', 30.00, 200),
('Product E', 'Description of Product E', 25.00, 120);

-- Thêm 2 đơn hàng mới vào bảng Orders
INSERT INTO Orders (UserID, TotalAmount) VALUES 
(1, 30.00),
(2, 50.00);

-- Thêm chi tiết cho các đơn hàng trong bảng OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, PriceAtOrder) VALUES 
(1, 1, 2, 10.00),
(1, 2, 1, 20.00),
(2, 3, 1, 15.00),
(2, 4, 1, 30.00);

-- Thêm ít nhất 3 đánh giá vào bảng Reviews
INSERT INTO Reviews (ProductID, UserID, Rating, ReviewText) VALUES 
(1, 1, 4, 'Good product!'),
(2, 2, 5, 'Excellent quality!'),
(3, 3, 3, 'Average product, value for money');

-- Cập nhật giá của một sản phẩm trong bảng Products
UPDATE Products SET Price = 18.00 WHERE ProductID = 3;

-- Cập nhật số lượng sản phẩm trong kho của một sản phẩm cụ thể
UPDATE Products SET Stock = 60 WHERE ProductID = 2;

-- Thay đổi địa chỉ email của một người dùng trong bảng Users
UPDATE Users SET Email = 'newemail@example.com' WHERE UserID = 1;

-- Xóa một sản phẩm khỏi bảng Products và xử lý các bản ghi liên quan
DELETE FROM OrderDetails WHERE ProductID = 3;
DELETE FROM Reviews WHERE ProductID = 3;
DELETE FROM Products WHERE ProductID = 3;

-- Xóa một đơn hàng cụ thể và các chi tiết liên quan trong bảng OrderDetails
DELETE FROM OrderDetails WHERE OrderID = 2;
DELETE FROM Orders WHERE OrderID = 2;
