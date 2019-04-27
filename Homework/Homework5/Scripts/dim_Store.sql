DROP TABLE IF EXISTS Dim_Store;

CREATE TABLE Dim_Store
(
StoreID INT PRIMARY KEY AUTO_INCREMENT,
StoreAltID VARCHAR(10)NOT NULL,
StoreName VARCHAR(100),
StoreLocation VARCHAR(100),
City VARCHAR(100),
State VARCHAR(100),
Country VARCHAR(100)
);

INSERT INTO Dim_Store(StoreAltID,StoreName,StoreLocation,City,State,Country )VALUES
('LOC-A1','ValueMart Boulder','1234 Ringer Road','Boulder','CO','USA'),
('LOC-A2','ValueMart Lyons','8624 Fenton Park','Lyons','CO','USA'),
('LOC-A3','ValueMart Berthoud','9337 Cherry Lane','Berthoud','CO','USA');
