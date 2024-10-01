
CREATE DATABASE myTest1;
SHOW CREATE DATABASE myTest1;

CREATE DATABASE myTest2 CHARACTER SET 'gbk';
SHOW CREATE DATABASE myTest2;

CREATE DATABASE IF NOT EXISTS myTest3 CHARACTER SET 'gbk';
SHOW CREATE DATABASE myTest3;

USE test;
SELECT * FROM employees;

USE atguigudb;

-- 查看数据库下所有表
SHOW TABLES;

-- 查看指定数据库下所有表
SHOW TABLES FROM test;

-- 更改数据库的字符集
SHOW CREATE DATABASE myTest2;
ALTER DATABASE myTest2 CHARACTER SET 'utf8';

SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS myTest4 CHARACTER SET 'gbk';
DROP DATABASE IF EXISTS myTest4;
DROP DATABASE myTest4;

SHOW TABLES FROM atguigudb;

-- 创建新表
CREATE TABLE IF NOT EXISTS mytable(
id INT,
lname VARCHAR(20),
age INT
) CHARACTER SET 'utf8';

SELECT * FROM mytable;
DESC mytable;
INSERT INTO mytable VALUES(100, 'jack', 18);

-- 基于现有的表创建新表（会自动导入数据）
CREATE TABLE myemp
AS
SELECT employee_id, last_name, salary
FROM employees;

SELECT * FROM myemp;

DESC myemp;

-- 3 修改表
-- 添加字段
ALTER TABLE myemp
ADD award DOUBLE(10, 2);

ALTER TABLE myemp
ADD phone VARCHAR(11) FIRST;

ALTER TABLE myemp
ADD email VARCHAR(45) AFTER last_name;

-- 修改字段的属性
-- 长度
ALTER TABLE myemp
MODIFY last_name VARCHAR(30);

SELECT * FROM myemp;
ALTER TABLE myemp
ADD test1 DATE DEFAULT NOW();
UPDATE myemp SET test1=NOW();

ALTER TABLE myemp
MODIFY test1 INT;

ALTER TABLE myemp
MODIFY test1 VARCHAR(35) DEFAULT 'aaabbbcccdddeee';

-- 添加列
ALTER TABLE myemp
ADD test2 VARCHAR(10) DEFAULT 'abcdefghij';

-- 重命名列
ALTER TABLE myemp
CHANGE test2 test3 VARCHAR(12) DEFAULT 0;

-- 删除列
ALTER TABLE myemp
DROP COLUMN award;

CREATE TABLE dtest(
id INT,
namee VARCHAR(10)
);

SELECT * FROM dtest;

DROP TABLE IF EXISTS ufyfyutl; 

DROP TABLE IF EXISTS dtest; 

CREATE TABLE ttest
AS
SELECT * FROM myemp;

SELECT * FROM ttest;
-- 清空表数据,TRUNCATE不支持回滚rollback
TRUNCATE TABLE ttest;

INSERT INTO ttest SELECT * FROM myemp;

SET autocommit = FALSE;

DELETE FROM ttest WHERE employee_id > 150 ;
ROLLBACK;
COMMIT;

-- 控制是否自动commit
SELECT autocommit FROM sys;

##################
-- 9 测试MySQL8的新特性：DDL的原子化
CREATE DATABASE testdb;

USE testdb;

CREATE TABLE test1(
id TINYINT,
age SMALLINT
);

SHOW TABLES;

DROP TABLE test1, test2;

-- 课后练习

CREATE DATABASE test01_office CHARSET 'utf8';
DESC CREATE DATABASE test01_office;

SHOW CREATE DATABASE test01_office;

CREATE TABLE dept01(
id INT(7),
`name` VARCHAR(25)
);

DESC dept01;
SHOW CREATE TABLE dept01;

-- 1
DROP DATABASE test01_office;
SHOW CREATE DATABASE test02_office;
SHOW CREATE DATABASE test03_office;
CREATE DATABASE IF NOT EXISTS test02_office CHARSET 'utf8';
CREATE DATABASE IF NOT EXISTS test03_office CHARACTER SET  'utf8';
USE test01_office;

-- 2
CREATE TABLE IF NOT EXISTS dept01(
id INT(7),
`name` VARCHAR(25)
);

SHOW CREATE TABLE dept01;

-- 3
CREATE TABLE IF NOT EXISTS dept02
AS
SELECT *
FROM atguigudb.departments;

SELECT * FROM dept02;

-- 4
CREATE TABLE IF NOT EXISTS emp01(
id INT(7),
first_name VARCHAR(25),
last_name VARCHAR(25),
dept_id INT(7)
);

-- 5
ALTER TABLE emp01
CHANGE last_name last_name VARCHAR(50);
-- or
ALTER TABLE emp01
MODIFY last_name VARCHAR(50);

DESC emp01;

-- 6
CREATE TABLE emp02
AS
SELECT *
FROM atguigudb.employees;

DROP TABLE IF EXISTS emp01;
-- 8
ALTER TABLE emp02 RENAME emp01;
-- or
RENAME TABLE emp03 TO emp01;

DESC emp01;
SELECT * FROM emp03;

-- 9
SHOW TABLES;
ALTER TABLE emp01
ADD test_column1 VARCHAR(5);

DESC dept02;
DESC emp01;

ALTER TABLE emp01
DROP COLUMN department_id;

-- 练习2
-- 1
CREATE DATABASE IF NOT EXISTS test02_market CHARACTER SET 'utf8';
USE test02_market;

CREATE TABLE IF NOT EXISTS customers(
c_cum INT,
c_name VARCHAR(50),
c_contact VARCHAR(50),
c_city VARCHAR(50),
c_birth DATE
);

-- 3
SELECT * FROM customers;
ALTER TABLE customers DROP COLUMN c_contact;
ALTER TABLE customers ADD c_contact VARCHAR(50) AFTER c_birth;

-- new 
ALTER TABLE customers_info ADD c_contact VARCHAR(10) AFTER c_gender;
ALTER TABLE customers_info MODIFY c_contact VARCHAR(50) AFTER c_birth;

-- 4
ALTER TABLE customers CHANGE c_name c_name VARCHAR(70);
ALTER TABLE customers MODIFY c_name VARCHAR(71);
DESC customers;

-- 5
ALTER TABLE customers CHANGE c_contact c_phone VARCHAR(50);
DESC customers;

-- 6
ALTER TABLE customers ADD c_gender VARCHAR(1) AFTER c_name;
SELECT * FROM customers;

-- 7
RENAME TABLE customers TO customers_info;
SELECT * FROM customers;
SELECT * FROM customers_info;
SHOW TABLES;
ALTER TABLE customers_info DROP COLUMN c_contact;

-- 8
ALTER TABLE customers_info DROP COLUMN c_city;
DESC customers_info;

-- 练习3
-- 1
CREATE DATABASE IF NOT EXISTS test03_company CHARACTER SET 'utf8';
USE test03_company;
DROP DATABASE test03_company;

-- 2
CREATE TABLE officies(
officeCode INT,
city VARCHAR(30),
address VARCHAR(50),
country VARCHAR(50),
postalCode VARCHAR(25)
);

DESC officies;

-- 3
CREATE TABLE employees(
empNum INT,
lastName VARCHAR(50),
firstName VARCHAR(50),
mobile VARCHAR(25),
`code` INT,
jobTitle VARCHAR(50),
birth DATE,
note VARCHAR(255),
sex VARCHAR(5)
);

SELECT * FROM employees;

-- 4
ALTER TABLE employees
MODIFY mobile VARCHAR(25) AFTER `code`;

-- 5
ALTER TABLE employees
CHANGE birth birthday DATE;

-- 6
DESC employees;
ALTER TABLE employees
MODIFY sex VARCHAR(1);

-- 7
ALTER TABLE employees DROP COLUMN note;

-- 8
ALTER TABLE employees ADD favoriate_activity VARCHAR(100);

-- 9
RENAME TABLE employees TO employees_info;
DESC employees_info;