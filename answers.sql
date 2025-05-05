-- Question 1
SELECT
  OrderID,
  CustomerName,
  LTRIM(RTRIM(value)) AS Product
FROM
  ProductDetail
CROSS APPLY
  STRING_SPLIT(Products, ',');

  -- Question 2

-- 1) Create the parent table for orders
CREATE TABLE Orders (
  OrderID     INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

-- Populate it with one row per order
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT
  OrderID,
  CustomerName
FROM OrderDetails;


-- 2) Create the child table for order‐line items
CREATE TABLE OrderItems (
  OrderID  INT,
  Product   VARCHAR(100),
  Quantity  INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate it with the remaining columns
INSERT INTO OrderItems (OrderID, Product, Quantity)
SELECT
  OrderID,
  Product,
  Quantity
FROM OrderDetails;




