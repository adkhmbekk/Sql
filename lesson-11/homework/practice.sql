-- Готовое решение: SQL-код с комментариями, сгруппированный по уровням сложности
-- Все задачи решены с использованием простых и понятных методов (JOIN, WHERE, GROUP BY, HAVING и т.д.)

-- Уровень: Лёгкий (Easy-Level Tasks)
-- Задачи 1-7

-- Задача 1: Показать все заказы после 2022 года и имена клиентов
SELECT 
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '2022-12-31';

-- Задача 2: Сотрудники из отделов Sales или Marketing
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');

-- Задача 3: Максимальная зарплата по каждому отделу
SELECT 
    d.DepartmentName,
    MAX(e.Salary) AS MaxSalary
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;

-- Задача 4: Клиенты из США, сделавшие заказы в 2023 году
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' 
  AND YEAR(o.OrderDate) = 2023;

-- Задача 5: Количество заказов для каждого клиента
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- Задача 6: Продукты от поставщиков Gadget Supplies или Clothing Mart
SELECT 
    p.ProductName,
    s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');

-- Задача 7: Последний заказ для каждого клиента (включая тех, у кого нет заказов)
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- Уровень: Средний (Medium-Level Tasks)
-- Задачи 8-13

-- Задача 8: Клиенты, у которых есть заказы на сумму больше 500
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.TotalAmount AS OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount > 500;

-- Задача 9: Продажи в 2022 году или на сумму более 400
SELECT 
    p.ProductName,
    s.SaleDate,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400;

-- Задача 10: Общая сумма продаж по каждому продукту
SELECT 
    p.ProductName,
    SUM(s.SaleAmount) AS TotalSalesAmount
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName;

-- Задача 11: Сотрудники из HR с зарплатой выше 60000
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources' AND e.Salary > 60000;

-- Задача 12: Продукты, проданные в 2023 году и с остатком > 100
SELECT 
    p.ProductName,
    s.SaleDate,
    p.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = 2023 AND p.StockQuantity > 100;

-- Задача 13: Сотрудники из Sales или наняты после 2020 года
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' OR e.HireDate > '2020-12-31';

-- Уровень: Сложный (Hard-Level Tasks)
-- Задачи 14-19

-- Задача 14: Заказы клиентов из США, чей адрес начинается с 4 цифр
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';

-- Задача 15: Продажи электроники или на сумму > 350
SELECT 
    p.ProductName,
    p.Category,
    s.SaleAmount
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
WHERE p.Category = 'Electronics' OR s.SaleAmount > 350;

-- Задача 16: Количество продуктов в каждой категории
SELECT 
    cat.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories cat
LEFT JOIN Products p ON p.Category = cat.CategoryID
GROUP BY cat.CategoryID, cat.CategoryName;

-- Задача 17: Заказы от клиентов из Лос-Анджелеса с суммой > 300
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.City,
    o.OrderID,
    o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300;

-- Задача 18: Сотрудники из HR или Finance, или чьё имя содержит минимум 4 гласные
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Human Resources', 'Finance')
   OR (
        LEN(e.Name) - 
        LEN(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(e.Name), 'a', ''), 'e', ''), 'i', ''), 'o', ''), 'u', '')) >= 4
      );

-- Задача 19: Сотрудники из Sales или Marketing с зарплатой > 60000
SELECT 
    e.Name AS EmployeeName,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing') AND e.Salary > 60000;
