--Basic-Level Tasks

--1
create table Employees (EmpID int, Name varchar(50), Salary decimal(10,2))

--2
 insert into Employees values (1, 'Aziz', 1000000.00)
 insert into Employees values (2, 'Samir', 500000.00), (3, 'Nosir', 750000.00)

--3
 update Employees set Salary = 7000 where EmpID = 1

--4
delete from Employees where EmpID = 2

--5
--Команды DELETE, TRUNCATE и DROP в SQL Server все используются для удаления, но работают по-разному и применяются в разных ситуациях.
--DELETE используется для удаления одной, нескольких или всех строк из таблицы. Ты можешь использовать WHERE, чтобы указать конкретные условия удаления. При этом структура таблицы, её связи, индексы, колонки — всё сохраняется. Удаление записей через DELETE можно обернуть в транзакцию и откатить при необходимости. Также при DELETE срабатывают триггеры (AFTER DELETE, INSTEAD OF DELETE), если они есть.
--TRUNCATE используется для быстрого удаления всех строк из таблицы без возможности задать условия. Это более быстрый способ, чем DELETE, потому что SQL Server просто сбрасывает данные, а не обрабатывает их построчно. При этом структура таблицы остаётся: колонки, ограничения, индексы не трогаются. Но важно знать, что TRUNCATE нельзя использовать, если таблица участвует в внешнем ключе (foreign key), и триггеры на нём не срабатывают. Также, если не использовать транзакцию, TRUNCATE необратим.
--DROP — самая жёсткая команда. Она полностью удаляет таблицу из базы данных, включая все её данные, структуру, индексы, ключи, связи и даже саму ссылку на неё. После DROP TABLE таблица больше не существует вообще. Это действие нельзя отменить даже внутри транзакции (в обычных условиях), и использовать его стоит только тогда, когда ты точно больше не нуждаешься в этой таблице.

--6 
alter table Employees
alter column Name varchar(100)

--7
alter table Employees
add Department varchar(100)

--8
alter table Employees
alter column Salary float

--9  
create table Departments (DepartmentID int primary key, DepartmentName varchar(50))

--10
truncate table Employees

--Чтобы удостовериться:
select * from Employees

--Intermediate-Level Tasks

--11
 INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR'
UNION ALL
SELECT 2, 'Finance'
UNION ALL
SELECT 3, 'IT'
UNION ALL
SELECT 4, 'Marketing'
UNION ALL
SELECT 5, 'Operations';

--12 
update Employees 
set Department = 'Management' 
where Salary > 5000

--13
truncate table Employees

--14
alter table Employees
drop column Department

--15
exec sp_rename 'Employees', 'StaffMembers'

--16
drop table Departments

--Advanced-Level Tasks

--17
CREATE TABLE Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(100), ProductCategory VARCHAR(50), Price DECIMAL(10, 2), Description VARCHAR(200))

--18
alter table Products
ADD CONSTRAINT CHK_Price_Positive check (Price > 0)

--19
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50

--20
EXEC sp_rename 'Products.ProductCategory', 'Category', 'COLUMN'

--21
INSERT INTO Products VALUES 
(1, 'Laptop', 'Electronics', 1200.00, 'Gaming laptop'),
(2, 'Phone', 'Electronics', 700.00, 'Smartphone'),
(3, 'Desk', 'Furniture', 250.00, 'Wooden desk'),
(4, 'Chair', 'Furniture', 150.00, 'Ergonomic chair'),
(5, 'Headphones', 'Electronics', 85.50, 'Wireless headphones')

--22
SELECT * INTO Products_Backup
FROM Products

--23
EXEC sp_rename 'Products', 'Inventory'

--24
ALTER TABLE Inventory
DROP CONSTRAINT CHK_Price_Positive

ALTER TABLE Inventory
ALTER COLUMN Price FLOAT

ALTER TABLE Inventory
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0)

--25
CREATE TABLE Inventory_New (
    ProductCode INT IDENTITY(1000, 5) PRIMARY KEY,
    ProductID INT,
    ProductName VARCHAR(100),
    ProductCategory VARCHAR(50),
    Price FLOAT,
    Description VARCHAR(200),
    StockQuantity INT
)

INSERT INTO Inventory_New (ProductID, ProductName, ProductCategory, Price, Description, StockQuantity)
SELECT ProductID, ProductName, ProductCategory, Price, Description, StockQuantity
FROM Inventory




