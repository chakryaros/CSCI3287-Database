ALTER TABLE Fact_ProductSales ADD CONSTRAINT 
FK_StoreID FOREIGN KEY (StoreID)REFERENCES Dim_Store(StoreID);

ALTER TABLE Fact_ProductSales ADD CONSTRAINT 
FK_CustomerID FOREIGN KEY (CustomerID)REFERENCES Dim_customer(CustomerID);

ALTER TABLE Fact_ProductSales ADD CONSTRAINT 
FK_ProductKey FOREIGN KEY (ProductID)REFERENCES Dim_product(ProductKey);

ALTER TABLE Fact_ProductSales ADD CONSTRAINT 
FK_SalesPersonID FOREIGN KEY (SalesPersonID)REFERENCES Dim_salesperson(SalesPersonID);

ALTER TABLE Fact_ProductSales ADD CONSTRAINT 
FK_SalesDateKey FOREIGN KEY (SalesDateKey)REFERENCES Dim_Date(DateKey);
