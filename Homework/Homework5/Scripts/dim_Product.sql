DROP TABLE IF EXISTS Dim_Product;

CREATE TABLE Dim_Product
(
ProductKey INT PRIMARY KEY AUTO_INCREMENT,
ProductAltKey VARCHAR(10)NOT NULL,
ProductName VARCHAR(100),
ProductActualCost DECIMAL(9,2),
ProductSalesPrice DECIMAL(9,2)

);

INSERT INTO Dim_Product(ProductAltKey,ProductName, ProductActualCost, ProductSalesPrice)VALUES
('ITM-001','Wheat Flour 1kg',5.50,6.50),
('ITM-002','Jasmine Rice 5kg',22.50,24),
('ITM-003','SunFlower Oil 1 ltr',42,43.5),
('ITM-004','Dawn Dish Soap, case',18,20),
('ITM-005','Tide Laundry Detergent 1kg case',135,139);