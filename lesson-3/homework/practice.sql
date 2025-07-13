--Easy-Level Tasks

--1. BULK INSERT — определение и назначение
--BULK INSERT — это команда в SQL Server, позволяющая массово загружать данные из внешнего файла (обычно .txt, .csv и т. д.) в таблицу базы данных. Она используется для быстрого переноса большого объема данных без ручного ввода. BULK INSERT особенно полезен при миграции, экспорте/импорте данных и работе с системами интеграции.

--2. Четыре формата файлов, которые можно импортировать в SQL Server:

--CSV (comma-separated values)

--TXT (text file, часто табличный или с разделителями)

--DAT (data file, с любым разделителем)

--XML (может быть импортирован через OPENXML или BULK)

--3. 
create table Products (ProductID INT PRIMARY KEY, ProductName VARCHAR(50), Price DECIMAL(10,2))

--4.
insert into Products values
(1, 'book', '35000.00'),
(2, 'pen', '8000.00'),
(3, 'eraser', '5000.00')

--5. Разница между NULL и NOT NULL:
--NULL означает «неизвестное» или «отсутствующее значение». Это не то же самое, что 0 или пустая строка — это именно отсутствие данных.
--NOT NULL — это ограничение, запрещающее хранить пустые значения в столбце. Если столбец NOT NULL, ты обязан указать значение при вставке данных.

--6.
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);

--7
--the main purpose if that is to add constraint

--8
ALTER TABLE Products
ADD CategoryID INT;

--9
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

--10
--IDENTITY — это свойство столбца, которое автоматически генерирует уникальные значения при вставке новых строк. Например, IDENTITY(1,1) начнёт с 1 и будет увеличивать значение на 1 при каждой новой вставке. Это часто используется для автоинкрементных первичных ключей.

--Medium-Level Tasks
--11
bulk insert Products
from 'C:\Users\Admin\Downloads\Telegram Desktop\test.csv'
with 
(
firstrow = 2,
FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n'
)

--12
select * from Products
select * from Categories
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

--13
--13. Разница между PRIMARY KEY и UNIQUE:

--PRIMARY KEY обеспечивает уникальность и не допускает NULL — может быть только один на таблицу.

--UNIQUE тоже обеспечивает уникальность, но допускает одно значение NULL. И можно иметь несколько UNIQUE-ограничений в таблице.

--14
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

--15
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

--16
SELECT ProductName, ISNULL(Price, 0) AS Price
FROM Products;

--17
--Назначение и использование FOREIGN KEY:
--FOREIGN KEY используется для обеспечения ссылочной целостности: значения в дочерней таблице должны существовать в родительской. Например, CategoryID в Products должен существовать в Categories.

--Hard-Level Tasks
--18
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT CHECK (Age >= 18)
);

--19
CREATE TABLE NumberSeries (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    Value VARCHAR(50)
);

--20
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);

--21
--Оба используются для замены NULL, но:

--ISNULL(expr, value) возвращает value, если expr — NULL.

--COALESCE(expr1, expr2, ..., exprN) возвращает первое не-NULL значение из списка.
--COALESCE более гибкий и ANSI-совместимый.

--22
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);

--23
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);











