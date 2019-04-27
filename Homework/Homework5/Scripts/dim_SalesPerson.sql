DROP TABLE IF EXISTS Dim_SalesPerson; 

CREATE TABLE Dim_SalesPerson
(
SalesPersonID INT PRIMARY KEY AUTO_INCREMENT,
SalesPersonAltID VARCHAR(10)NOT NULL,
SalesPersonName VARCHAR(100),
StoreID INT,
City VARCHAR(100),
State VARCHAR(100),
Country VARCHAR(100)
);

INSERT INTO Dim_SalesPerson(SalesPersonAltID,SalesPersonName,StoreID,City,State,Country )VALUES
('SP-DMSPR1','Tom Petty',1,'Boulder','CO','USA'),
('SP-DMSPR2','John Paul Jones',1,'Longmont','CO','USA'),
('SP-DMNGR1','Danny Weller',2,'Berthoud','CO','USA'),
('SP-DMNGR2','Julian Brand',2,'Lyons','CO','USA'),
('SP-DMSVR1','Jasmin Farah',3,'Louisville','CO','USA'),
('SP-DMSVR2','Jacob Leis',3,'Lafayette','CO','USA');