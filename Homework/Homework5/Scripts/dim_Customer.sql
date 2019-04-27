drop TABLE if exists Dim_Customer;

CREATE TABLE Dim_Customer (
CustomerID INT PRIMARY KEY AUTO_INCREMENT,
CustomerAltID VARCHAR(10) NOT NULL,
CustomerName VARCHAR(50),
Gender VARCHAR(2)
);

INSERT INTO Dim_Customer(CustomerAltID,CustomerName,Gender)VALUES
('IMI-001','Harrison Ford','M'),
('IMI-002','Melinda Gates','F'),
('IMI-003','Elon Musk','M'),
('IMI-004','Aldous Huxley','M'),
('IMI-005','Linda Ronstadt','F');

