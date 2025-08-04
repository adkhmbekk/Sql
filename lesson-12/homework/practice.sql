-- Уровень: Лёгкий (Easy-Level Tasks)
-- Задачи 1-7

-- Задача 1: Показать всех сотрудников и их отделы (объединение двух таблиц)
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;

-- Задача 2: Сотрудники, которые зарабатывают больше своих менеджеров
SELECT 
    e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;

-- Задача 3: Найти дублирующиеся email
SELECT 
    email AS Email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

-- Задача 4: Удалить дублирующиеся email, оставив только с минимальным id
DELETE p1
FROM Person p1
JOIN Person p2 ON p1.email = p2.email
WHERE p1.id > p2.id;

-- Задача 5: Найти родителей, у которых только девочки (нет мальчиков)
SELECT DISTINCT
    g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (SELECT ParentName FROM boys);

-- Задача 6: Общая сумма продаж и минимальный вес для заказов с весом > 50 (для TSQL2012)
-- Примечание: Так как мы не можем подключиться к TSQL2012 напрямую, это шаблон запроса
SELECT 
    CustomerID,
    SUM(val) AS TotalSales,
    MIN(freight) AS LeastWeight
FROM Sales.Orders
WHERE freight > 50
GROUP BY CustomerID;

-- Задача 7: Объединение двух таблиц корзин (Cart1 и Cart2) — полное внешнее соединение
SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2 ON c1.Item = c2.Item;

-- Уровень: Средний (Medium-Level Tasks)
-- Задачи 8-9

-- Задача 8: Клиенты, которые никогда не делали заказов
SELECT 
    c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;

-- Задача 9: Количество экзаменов, сданных каждым студентом по каждому предмету
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;
