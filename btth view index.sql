CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    ContactName VARCHAR(255),
    Country VARCHAR(255)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Price DECIMAL(10, 2)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE VIEW OrderInfo AS
SELECT 
    Orders.OrderID,
    Customers.CustomerName,
    Customers.Country,
    Orders.OrderDate,
    Orders.TotalAmount
FROM 
    Orders
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID;
    
    
    
    CREATE VIEW OrderDetailsInfo AS
SELECT 
    Orders.OrderID,
    Customers.CustomerName,
    Products.ProductName,
    OrderDetails.Quantity,
    OrderDetails.UnitPrice,
    (OrderDetails.Quantity * OrderDetails.UnitPrice) AS TotalPrice
FROM 
    OrderDetails
JOIN 
    Orders ON OrderDetails.OrderID = Orders.OrderID
JOIN 
    Customers ON Orders.CustomerID = Customers.CustomerID
JOIN 
    Products ON OrderDetails.ProductID = Products.ProductID;


CREATE INDEX idx_order_date ON Orders(OrderDate);
CREATE INDEX idx_orderdetails_orderid ON OrderDetails(OrderID);



