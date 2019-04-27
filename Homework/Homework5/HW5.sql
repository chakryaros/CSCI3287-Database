SELECT FP.SalesPersonID, ds.SalesPersonName, 
	SUM(FP.SalesPrice * FP.Quantity) as TotalRevenue 
	FROM Fact_ProductSales FP JOIN Dim_SalesPerson ds 
	ON ds.SalesPersonID = FP.SalesPersonID 
	GROUP BY FP.SalesPersonID ORDER BY TotalRevenue DESC LIMIT 1;
SELECT dc.CustomerID, dc.CustomerName, SUM(FP.SalesPrice * FP.Quantity) as Amount 
	FROM Dim_Customer dc JOIN Fact_ProductSales FP 
	ON FP.CustomerID = dc.CustomerID 
	JOIN Dim_date dd ON FP.SalesDateKey = dd.DateKey 
	WHERE dd.YEAR BETWEEN 2012 AND 2013
 	GROUP BY FP.CustomerID ORDER BY Amount DESC LIMIT 1;
SELECT ds.StoreID, ds.StoreName, dd.YEAR, SUM(FP.SalesPrice * FP.Quantity) AS Amount
	FROM Dim_Store ds
	JOIN Fact_ProductSales FP ON ds.StoreID = FP.StoreID 
	JOIN Dim_Date dd ON FP.SalesDatekey = dd.DateKey 
	GROUP BY FP.StoreID, dd.YEAR ORDER BY dd.YEAR ASC, Amount DESC;
SELECT p.ProductKey, p.ProductName,
	SUM((p.ProductSalesPrice - p.ProductActualCost) * FP.Quantity) AS Profit
	FROM Fact_ProductSales FP JOIN Dim_Product p ON FP.ProductID = p.ProductKey
	JOIN Dim_Date dd ON dd.Datekey = FP.SalesDateKey WHERE dd.YEAR = '2015' 
	GROUP BY FP.ProductID ORDER BY Profit DESC LIMIT 1;
SELECT ds.StoreID, ds.StoreName, ds.City, sum(fp.SalesPrice* Quantity) as TotalRevenue, dd.QUARTER
	FROM Dim_Store ds JOIN Fact_ProductSales fp ON ds.StoreID = fp.StoreID 
	JOIN Dim_Date dd ON dd.DateKey = fp.SalesDateKey 
	WHERE ds.City = 'Boulder' AND dd.Year = '2016'
	GROUP BY dd.QUARTER, fp.StoreID ORDER BY TotalRevenue DESC LIMIT 1;
