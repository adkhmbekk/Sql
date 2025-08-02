
-- EASY LEVEL (10 задач)
-- 1. Получить список всех продуктов и их категорий
SELECT p.product_name, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id;

-- 2. Получить список сотрудников и названия отделов, в которых они работают
SELECT e.employee_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 3. Получить список заказов с именами клиентов, которые их сделали
SELECT o.order_id, c.customer_name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 4. Получить список платежей с именами сотрудников, которые их обработали
SELECT p.payment_id, e.employee_name
FROM payments p
JOIN employees e ON p.employee_id = e.employee_id;

-- 5. Получить список продуктов с их поставщиками
SELECT p.product_name, s.supplier_name
FROM products p
JOIN suppliers s ON p.supplier_id = s.supplier_id;

-- 6. Получить список всех заказов и названия отделов, в которых работает обработавший их сотрудник
SELECT o.order_id, d.department_name
FROM orders o
JOIN employees e ON o.employee_id = e.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- 7. Получить список клиентов и количество их заказов
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 8. Получить список всех сотрудников и количество обработанных ими платежей
SELECT e.employee_name, COUNT(p.payment_id) AS payment_count
FROM employees e
LEFT JOIN payments p ON e.employee_id = p.employee_id
GROUP BY e.employee_name;

-- 9. Получить список продуктов и количество заказов каждого продукта
SELECT p.product_name, COUNT(oi.order_id) AS order_count
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;

-- 10. Получить список всех клиентов и их последних заказов (по дате)
SELECT c.customer_name, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date = (
    SELECT MAX(o2.order_date)
    FROM orders o2
    WHERE o2.customer_id = c.customer_id
);

-- MEDIUM LEVEL (10 задач)
-- 11. Получить список продуктов, которые ни разу не были заказаны
SELECT p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;

-- 12. Получить список сотрудников, которые не обработали ни одного платежа
SELECT e.employee_name
FROM employees e
LEFT JOIN payments p ON e.employee_id = p.employee_id
WHERE p.payment_id IS NULL;

-- 13. Получить список клиентов, которые сделали больше 5 заказов
SELECT c.customer_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 5;

-- 14. Получить список отделов и количество сотрудников в каждом из них
SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 15. Получить список поставщиков и количество продуктов от каждого
SELECT s.supplier_name, COUNT(p.product_id) AS product_count
FROM suppliers s
LEFT JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name;

-- 16. Получить список заказов с общими суммами (цена * количество) каждого заказа
SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS total_amount
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

-- 17. Получить список клиентов и их общую сумму покупок
SELECT c.customer_name, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name;

-- 18. Получить список сотрудников, которые обработали более 10 платежей
SELECT e.employee_name, COUNT(p.payment_id) AS payment_count
FROM employees e
JOIN payments p ON e.employee_id = p.employee_id
GROUP BY e.employee_name
HAVING COUNT(p.payment_id) > 10;

-- 19. Получить список клиентов и даты их первого заказа
SELECT c.customer_name, MIN(o.order_date) AS first_order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- 20. Получить список продуктов и даты их последнего заказа
SELECT p.product_name, MAX(o.order_date) AS last_order_date
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_name;

-- HARD LEVEL (5 задач)
-- 21. Получить список клиентов, которые сделали заказы на сумму более 1000
SELECT c.customer_name, SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_name
HAVING SUM(oi.quantity * oi.unit_price) > 1000;

-- 22. Получить список сотрудников и среднюю сумму платежей, которые они обработали
SELECT e.employee_name, AVG(p.amount) AS avg_payment_amount
FROM employees e
JOIN payments p ON e.employee_id = p.employee_id
GROUP BY e.employee_name;

-- 23. Получить список заказов, в которых есть более 3-х разных продуктов
SELECT o.order_id, COUNT(DISTINCT oi.product_id) AS product_count
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id
HAVING COUNT(DISTINCT oi.product_id) > 3;

-- 24. Получить список продуктов, которые заказали более 10 разных клиентов
SELECT p.product_name, COUNT(DISTINCT o.customer_id) AS customer_count
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
GROUP BY p.product_name
HAVING COUNT(DISTINCT o.customer_id) > 10;

-- 25. Получить список отделов, в которых сотрудники обработали платежи на сумму более 5000
SELECT d.department_name, SUM(p.amount) AS total_payments
FROM departments d
JOIN employees e ON d.department_id = e.department_id
JOIN payments p ON e.employee_id = p.employee_id
GROUP BY d.department_name
HAVING SUM(p.amount) > 5000;
