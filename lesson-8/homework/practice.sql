-- Easy Level Tasks

-- 1. Найти общее количество товаров в каждой категории
SELECT Category, COUNT(ProductID) AS ProductCount
FROM Products
GROUP BY Category;

-- 2. Найти среднюю цену товаров в категории 'Electronics'
SELECT AVG(Price) AS AveragePrice
FROM Products
WHERE Category = 'Electronics';

-- 3. Вывести всех клиентов из городов, начинающихся на 'L'
SELECT *
FROM Customers
WHERE City LIKE 'L%';

-- 4. Получить названия товаров, заканчивающиеся на 'er'
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';

-- 5. Вывести всех клиентов из стран, название которых заканчивается на 'A'
SELECT *
FROM Customers
WHERE Country LIKE '%A';

-- 6. Показать наивысшую цену среди всех товаров
SELECT MAX(Price) AS HighestPrice
FROM Products;

-- 7. Обозначить запас как 'Low Stock' если количество < 30, иначе 'Sufficient'
SELECT ProductName, 
       CASE 
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;

-- 8. Найти общее количество клиентов в каждой стране
SELECT Country, COUNT(CustomerID) AS CustomerCount
FROM Customers
GROUP BY Country;

-- 9. Найти минимальное и максимальное количество заказанных товаров
SELECT MIN(Quantity) AS MinQuantity, MAX(Quantity) AS MaxQuantity
FROM Orders;

-- Medium Level Tasks

-- 10. Клиенты, оформившие заказы в январе 2023 года, но без счетов
SELECT DISTINCT o.CustomerID
FROM Orders o
LEFT JOIN Invoices i ON o.CustomerID = i.CustomerID
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
  AND i.CustomerID IS NULL;

-- 11. Объединить все названия товаров из Products и Products_Discounted, включая дубликаты
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;

-- 12. Объединить все названия товаров из Products и Products_Discounted, без дубликатов
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

-- 13. Найти среднюю сумму заказа по годам
SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AverageOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);

-- 14. Группировка товаров по ценам: 'Low' (<100), 'Mid' (100-500), 'High' (>500)
SELECT ProductName,
       CASE 
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;

-- 15. PIVOT для city_population по годам
SELECT *
INTO Population_Each_Year
FROM (
    SELECT district_name, population, year
    FROM city_population
) src
PIVOT (
    SUM(population) FOR year IN ([2012], [2013])
) pvt;

-- 16. Найти общие продажи по ProductID
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;

-- 17. Найти продукты, содержащие 'oo' в названии
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';

-- 18. PIVOT по City: отдельные столбцы для Bektemir, Chilonzor, Yakkasaroy
SELECT *
INTO Population_Each_City
FROM (
    SELECT year, district_name, population
    FROM city_population
    WHERE district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) src
PIVOT (
    SUM(population) FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) pvt;

-- Hard Level Tasks

-- 19. Топ 3 клиента с наибольшей суммой счетов
SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

-- 20. Обратное преобразование Population_Each_Year -> city_population
SELECT district_name, [2012] AS population, '2012' AS year FROM Population_Each_Year
UNION ALL
SELECT district_name, [2013] AS population, '2013' AS year FROM Population_Each_Year;

-- 21. Количество продаж каждого товара с именем
SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;

-- 22. Обратное преобразование Population_Each_City -> city_population
SELECT 'Bektemir' AS district_name, Bektemir AS population, year
FROM Population_Each_City
UNION ALL
SELECT 'Chilonzor', Chilonzor, year
FROM Population_Each_City
UNION ALL
SELECT 'Yakkasaroy', Yakkasaroy, year
FROM Population_Each_City;
