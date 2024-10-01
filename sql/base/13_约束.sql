
/*

1.3
约束的分类：
单列约束 vs 多列约束

约束的作用范围：
列级约束：将此约束声明在对应字段的后面
表级约束：在表中所有字段声明完之后，声明在所有字段的后面

约束的作用：
1. not null    非空约束
2. unique      唯一性约束
3. primary key 主键约束
4. foreign key 外键约束
5. check       检查约束
6. default     默认值约束


1.4 如何添加/删除约束？

a：create table时添加约束

b：alter table时修改约束
*/

-- 如何查看表中的约束
-- SELECT * FROM information_schema.table_constraints WHERE table_name = '表名'
SELECT * FROM information_schema.table_constraints WHERE table_name = 'employees';
USE atguigudb;

CREATE DATABASE IF NOT EXISTS dbtest13 CHARACTER SET 'utf8';
USE dbtest13;
-- 1. not null 只能使用列级的约束方式
CREATE TABLE IF NOT EXISTS test_nn(
id INT NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(20) NOT NULL
);

DESC test_nn;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'test_nn';

INSERT INTO test_nn VALUES (1, 'tom', NULL);

SELECT * FROM test_nn;

-- 删除非空约束
ALTER TABLE test_nn
MODIFY email VARCHAR(20);


-- 增加非空约束（前提是当前没有为NULL的字段）
ALTER TABLE test_nn
MODIFY email VARCHAR(20) NOT NULL;

-- 2. unique 唯一性约束
-- 第一种方式添加约束
CREATE TABLE IF NOT EXISTS test2(
id INT UNIQUE, -- 列级约束
last_name VARCHAR(15),
email VARCHAR(25),
salary DECIMAL(10,2),
CONSTRAINT uk_test_email UNIQUE(email)-- 表级约束
-- CONSTRAINT uk_test_email可以删除掉,相当于没有取名字而已
);

DROP TABLE IF EXISTS test2;
DESC test2;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'test2';

INSERT INTO test2(id, last_name) VALUES (NULL, 'dfh');
-- 可以发现，unique约束的字段可以为null，并且为null的数据可以有多条
SELECT * FROM test2;

-- 第二种方式，alter table 添加unique约束
ALTER TABLE test2
MODIFY salary VARCHAR(25) UNIQUE;
DESC test2;
-- 第三种方式
ALTER TABLE test2
ADD UNIQUE KEY(last_name);
-- 或者
ALTER TABLE test2
ADD UNIQUE(last_name);
-- 或者
ALTER TABLE test2
ADD CONSTRAINT uk_test2_sa UNIQUE(salary);
-- 注意下列方式会报错，因为要用CONSTRAINT而不是CONSTRAINTS
ALTER TABLE test2
ADD CONSTRAINTS uk_test2_sa UNIQUE(salary);

-- 复合的唯一性约束（多列）
CREATE TABLE IF NOT EXISTS USER(
id INT,
NAME VARCHAR(15),
PASSWORD VARCHAR(25),
CONSTRAINT uk_user_name_pwd UNIQUE(id, NAME)
);

DESC USER;

INSERT INTO USER VALUES (2, 'Tom', '456');

SELECT * FROM USER;
SELECT * FROM information_schema.table_constraints WHERE table_name = 'user';
-- 删除唯一性约束的错误示范(下列方式行不通)
ALTER TABLE test2
MODIFY id INT;

-- 正确的方法
ALTER TABLE test2
DROP INDEX id;

ALTER TABLE USER
DROP INDEX uk_user_name_pwd;

DESC USER;

-- 3. primary key 主键约束 特征：非空且唯一，相当于not null 和 unique的组合
-- 一个表中最多有一个主键约束
-- 错误示范
CREATE TABLE IF NOT EXISTS test31(
id INT PRIMARY KEY,
last_name VARCHAR(15) PRIMARY KEY,
email VARCHAR(25),
salary DECIMAL(10,2)
);

-- 列级约束
CREATE TABLE IF NOT EXISTS test32(
id INT PRIMARY KEY,
last_name VARCHAR(15),
email VARCHAR(25),
salary DECIMAL(10,2)
);

-- 表级约束
CREATE TABLE IF NOT EXISTS test33(
id INT,
last_name VARCHAR(15),
email VARCHAR(25),
salary DECIMAL(10,2),
CONSTRAINT uk_test31_pri PRIMARY KEY(id,email)
);
-- 查询约束名发现上面取的名字被重置为PRIMARY，所以可以用下面的方式创建，不需要命名约束的名称了

CREATE TABLE IF NOT EXISTS test33(
id INT,
last_name VARCHAR(15),
email VARCHAR(25),
salary DECIMAL(10,2),
PRIMARY KEY(id,email)
);

DROP TABLE IF EXISTS test33;
SELECT * FROM information_schema.table_constraints WHERE table_name = 'test33';

SELECT * FROM test33;
INSERT INTO test33 VALUES (123, 'tom', '550030810@qq.com', 7200.5);

-- 在alter table 添加主键约束
CREATE TABLE IF NOT EXISTS test35(
id INT,
last_name VARCHAR(15),
email VARCHAR(25),
salary DECIMAL(10,2)
);

DESC test34;
DESC test35;

-- 这个
ALTER TABLE test34
ADD PRIMARY KEY(id, email);
-- 或者这个
ALTER TABLE test35
MODIFY id INT PRIMARY KEY;

-- 主键约束的添加方式和unique的方式基本一致

-- 删除主键约束,也类似unique。不过这里不需要加INDEX关键字
ALTER TABLE test35
DROP PRIMARY KEY;

-- 4. 自增长列
CREATE TABLE IF NOT EXISTS test4(
id INT PRIMARY KEY AUTO_INCREMENT,
last_name VARCHAR(15)
);

DESC test4;
-- 插入主键之外的数据，主键会自动递增
INSERT INTO test4(last_name) VALUES ('tom'); 
-- 插入0或者NULL的时候，主键也会递增，并不会真的插入0和NULL
INSERT INTO test4 VALUES (0, 'zero');  
INSERT INTO test4 VALUES (NULL, 'NullValue'); 
-- 插入负数，主键值会采用当前插入的值（-5）.所以有时候主键需要设定为无符号类型（不可为负）
INSERT INTO test4 VALUES (-5, '-555');
INSERT INTO test4 VALUES (7, 'haer'); 
-- 删除一条数据，后面的不会自动递减
DELETE FROM test4 WHERE id = 7;

SELECT * FROM test4;

CREATE TABLE IF NOT EXISTS test41(
id INT,
last_name VARCHAR(15),
CONSTRAINT PRIMARY KEY(id)
);

DESC test41;

-- 使用alter 添加自增列
ALTER TABLE test41
MODIFY id INT AUTO_INCREMENT;
-- 使用alter 删除自增列
ALTER TABLE test41
MODIFY id INT;

SELECT * FROM test41;

INSERT INTO test41(last_name) VALUES ('tom');

DELETE FROM test41 WHERE id = 5;
-- 删除2条最新的数据，再插入新数据时，会直接跳过删除数据的id，中间留出了2行空白
-- 重启MySQL之后再插入，就能继续递增的插入数据了，id不会留空

-- auto_increment 会在内存中记录一个递增的值，使用delete的时候，该值没有变化。所以产生了这种现象
-- 而重启之后，服务器的内存会被清掉，此时会根据表里的自增列获取最新的值。所以不会出错

-- 但是，在MySQL8.0中，重启不会重置递增的值。8.0的自增变量时持久化的，而不是放在内存中的
-- 8.0的方式会更好一些

-- 5. foreign key 外键约束

CREATE TABLE IF NOT EXISTS dept(
dept_id INT,
dept_name VARCHAR(15)
);

ALTER TABLE dept
ADD PRIMARY KEY(dept_id);

CREATE TABLE IF NOT EXISTS emp(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(15),
department_id INT,
CONSTRAINT fk_emp_dept_id FOREIGN KEY(department_id) REFERENCES dept(dept_id)
);

SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp';

INSERT INTO dept VALUES (50, 'java');
INSERT INTO emp VALUES (1002,'rosy',NULL);

SELECT * FROM dept;
SELECT * FROM emp;
-- 发现删除失败，因为从表有数据使用的外键对应了此条数据
DELETE FROM dept WHERE dept_id = 50;

-- 使用alter添加外键
CREATE TABLE IF NOT EXISTS dept1(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS emp1(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(15),
department_id INT
-- constraint fk_emp_dept_id foreign key(department_id) references dept(dept_id)
);

DESC emp1;
DROP TABLE IF EXISTS dept1;

ALTER TABLE emp1
ADD CONSTRAINT fk_dept1_emp1_department_id FOREIGN KEY(department_id) REFERENCES dept1(dept_id);

ALTER TABLE emp1
DROP INDEX department_id;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp1';

-- 
ALTER TABLE emp1
MODIFY department_id INT;

-- 外键约束等级
CREATE TABLE IF NOT EXISTS dept2(
dept_id INT PRIMARY KEY,
dept_name VARCHAR(15)
);

CREATE TABLE IF NOT EXISTS emp2(
emp_id INT PRIMARY KEY AUTO_INCREMENT,
emp_name VARCHAR(15),
department_id INT,
CONSTRAINT fk_emp_dept_id2 FOREIGN KEY(department_id) REFERENCES dept2(dept_id) 
ON UPDATE CASCADE ON DELETE SET NULL -- 主表更新时，从表也更新。主表删除时，从表置空
);

DESC dept2;
DESC emp2;


DROP TABLE IF EXISTS emp2;

INSERT INTO dept2 VALUES (50, 'IT');
INSERT INTO emp2 VALUES (1002, 'Tom', 50);
COMMIT;
SELECT * FROM dept2;
SELECT * FROM emp2;

UPDATE dept2 SET dept_id = 60 WHERE dept_id = 50;
DELETE FROM dept2 WHERE dept_id = 60;


-- 5.1.删除外键约束（一个表中可以有多个外键，所以这里需要输入约束名称）
ALTER TABLE emp2
DROP FOREIGN KEY fk_emp_dept_id2;

SELECT * FROM information_schema.table_constraints WHERE table_name = 'emp2';
-- 5.2.查看索引名和删除索引
SHOW INDEX FROM emp2;
-- 5.3.删除索引，此时才算完全删除成功
ALTER TABLE emp2
DROP INDEX fk_emp_dept_id2;

-- 6. check约束

CREATE TABLE test13(
id INT,
last_name VARCHAR(15),
salary DECIMAL(10,2) CHECK(salary > 2000)
);

-- MySQL5.7不支持CHECK约束，写了也没用，8.0才会产生效果
INSERT INTO test13 VALUES (1001, 'John', 2000);

-- 7. Default 默认值约束
CREATE TABLE IF NOT EXISTS test7(
id INT,
last_name VARCHAR(15),
salary DECIMAL DEFAULT 2000
);

INSERT INTO test7 VALUES (1001, 'sdfga', 2500);
SELECT * FROM test7;
DESC test7;

INSERT INTO test7(id, last_name) VALUES (1001, 'sdfga');

-- 7.2 alter 添加default约束
CREATE TABLE IF NOT EXISTS test72(
id INT,
last_name VARCHAR(15),
salary DECIMAL(10,2)
);

DROP TABLE test72;

INSERT INTO test72(id, last_name) VALUES (1001, 'sdfga');
SELECT * FROM test72;

-- 添加约束后，旧数据(哪怕是NULL)不受影响，新插入的数据默认值为2000
ALTER TABLE test72
MODIFY salary DECIMAL(10,2) DEFAULT 2000;


-- 课后练习

