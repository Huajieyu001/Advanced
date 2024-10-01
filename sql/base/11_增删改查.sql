
USE atguigudb;

CREATE TABLE IF NOT EXISTS emp1(
id INT,
`name` VARCHAR(15),
hire_date DATE,
salary DOUBLE(10,2)
);

DESC emp1;

SELECT * FROM emp1;

-- 一条一条添加
INSERT INTO emp1 VALUES(1, 'tom', '2000-06-10', 3400);

INSERT INTO emp1(id, hire_date, salary, `name`) VALUES (2, '2000-01-01', 5000, 'jack');

INSERT INTO emp1(id) VALUES (3);

-- 同时添加多条记录
INSERT INTO emp1 (id, `name`) VALUES (4, 'edfh'), (5, 'dfhe'), (6, 'dfh');

-- 使用select插入数据
INSERT INTO emp1(id, NAME, hire_date, salary) SELECT employee_id, last_name, hire_date, salary
FROM employees WHERE department_id IN ('60', '70');

SELECT * FROM emp1;

-- 计算列
CREATE TABLE IF NOT EXISTS test1(
a INT,
b INT,
c INT GENERATED ALWAYS AS (a + b) VIRTUAL
);

DESC test1;

INSERT INTO test1(a,b) VALUES(10, 20);

SELECT * FROM test1;

INSERT INTO test1(a,b) 
VALUES
(11, 520),
(11, 2745),
(11, 7),
(11, 756);

CREATE DATABASE IF NOT EXISTS test01_library CHARACTER SET 'utf8';
USE test01_library;

CREATE TABLE IF NOT EXISTS books(
id INT,
`name`  VARCHAR(50),
`authors` VARCHAR(100),
price FLOAT,
pubdate YEAR,
note VARCHAR(100),
num INT
);

DESC books;

INSERT INTO books VALUES (100, 'Life is a book', 'Tom', 24.8, 1998, 'This is a homourous book', 65);
SELECT * FROM books;

INSERT INTO books(id,`name`,`authors`,price,pubdate,note,num) VALUES (456, 'Life is a book', 'Tom', 29.8, 2012, 'This is a homourous book', 35);

SELECT * FROM books;
SELECT LENGTH(REPLACE(`name`, ' ', '')) FROM books;

SELECT REPLACE('sdah', 'a', 'b');

-- 课后练习
CREATE DATABASE IF NOT EXISTS dbtest11 CHARACTER SET 'utf8';

USE dbtest11;
CREATE TABLE IF NOT EXISTS my_employees(
id INT(10),
first_name VARCHAR(10),
last_name VARCHAR(10),
userid VARCHAR(10),
salary DOUBLE(10,2)
) CHARACTER SET 'utf8';

DESC my_employees;

CREATE TABLE IF NOT EXISTS users(
id INT,
userid VARCHAR(10),
department_id INT
) CHARACTER SET 'utf8';

DESC users;

INSERT INTO my_employees
VALUES
(1,'Patel','Ralph','Rpatel',895),
(2,'Dancs','Betty','Bdancs',860),
(3,'Biri','Ben','Bbiri',1100),
(4,'Newman','Chad','Cnewman',750),
(5,'Ropeburn','Audrey','Aropebur',1550);

INSERT INTO users
VALUES
(1,'Rpatel',10),
(1,'Bdancs',10),
(1,'Bbiri',20),
(1,'Cnewman',30),
(1,'Aropebur',40);;

-- 第二种插入方式
INSERT INTO users
SELECT 1,'Rpatel',10 UNION ALL
SELECT 1,'Bdancs',10 UNION ALL
SELECT 1,'Bbiri',20 UNION ALL
SELECT 1,'Cnewman',30 UNION ALL
SELECT 1,'Aropebur',40;

SELECT * FROM my_employees;
SELECT * FROM users;

UPDATE my_employees SET last_name = 'drelxer' WHERE id = '3';

UPDATE my_employees SET salary = 1000 WHERE salary < 900;

DELETE FROM my_employees WHERE userid = 'Bbiri';
DELETE FROM users WHERE userid = 'Bbiri';
-- new method ×
DELETE FROM my_employees emp, users usr WHERE emp.userid = 'Bbiri' OR usr.userid = 'Bbiri';
-- new method √
DELETE emp, usr FROM my_employees emp JOIN users usr USING(userid) WHERE emp.userid = 'Bbiri';


TRUNCATE TABLE users;
TRUNCATE TABLE my_employees;

-- 练习2

CREATE TABLE IF NOT EXISTS pet(
`name` VARCHAR(20),
`owner` VARCHAR(20),
 species VARCHAR(20),
 sec CHAR(1),
 birth YEAR,
 death YEAR
) CHARACTER SET 'utf8';

SELECT * FROM pet;

INSERT INTO pet
SELECT 'Fluffy', 'harold', 'Cat', 'f', 2003, 2010 UNION ALL
SELECT 'Claws', 'gwen', 'Cat', 'm', 2004, NULL UNION ALL
SELECT 'Buffy', '', 'Dog', 'f', 2009, NULL UNION ALL
SELECT 'Fang', 'benny', 'Dog', 'm', 2000, NULL UNION ALL
SELECT 'bowser', 'diane', 'Dog', 'm', 2003, 2009 UNION ALL
SELECT 'Chirpy', '', 'Dog', 'f', 2008, NULL UNION ALL;

INSERT INTO pet VALUES
('Fluffy', 'harold', 'Cat', 'f', 2003, 2010),
('Claws', 'gwen', 'Cat', 'm', 2004, NULL),
('Buffy', '', 'Dog', 'f', 2009, NULL),
('Fang', 'benny', 'Dog', 'm', 2000, NULL),
('bowser', 'diane', 'Dog', 'm', 2003, 2009),
('Chirpy', '', 'Dog', 'f', 2008, NULL);

SELECT * FROM pet;
-- 4
ALTER TABLE pet
ADD owner_birth DATE;

ROLLBACK;
SELECT 
-- 5
UPDATE pet SET `owner` = 'kevin' WHERE `name` = 'Claws' AND species = 'Cat';

-- 6
UPDATE pet SET `owner` = 'duck' WHERE death IS NULL OR death = '' AND species = 'Dog';

-- 7
UPDATE pet SET `species` = 'Bird' WHERE `name` = 'Chirpy';
UPDATE pet SET `owner` = NULL WHERE `name` = 'Chirpy';
SELECT `name` FROM pet WHERE `owner` IS NULL;

-- 8
SELECT `name`, `owner`, death FROM pet WHERE species = 'Cat' AND death IS NOT NULL;

-- 9
SELECT * FROM pet;
DELETE FROM pet WHERE death IS NOT NULL AND species = 'Dog';