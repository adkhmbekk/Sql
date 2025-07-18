--1 puzzle

CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

-- 1 method
select distinct * from InputTbl

--2 method
select distinct col1, col2 from InputTbl

--2 puzzle

CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

select * from [TestMultipleZero]
where A<>0 or B<>0 or C<>0 or D<>0

--3 puzzle

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')

SELECT * 
FROM section1
WHERE id % 2 = 1;

--4 puzzle

SELECT TOP 1 * 
FROM section1 
ORDER BY id ASC;

--5 puzzle

SELECT TOP 1 * 
FROM section1 
ORDER BY id DESC;

--6 puzzle

SELECT * 
FROM section1
WHERE name LIKE 'b%';

--7 puzzle

CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

select * from ProductCodes
where Code like '%[_]%'


