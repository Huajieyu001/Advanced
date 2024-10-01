-- 18章

-- 窗口函数
CREATE DATABASE IF NOT EXISTS dbtest18;
USE dbtest18;

CREATE TABLE IF NOT EXISTS sales(
id INT PRIMARY KEY AUTO_INCREMENT,
city VARCHAR(15),
county VARCHAR(15),
sales_value DEC
);

INSERT INTO sales(city, county, sales_value) VALUES 
('beijing', 'haiding', 10.00), 
('beijing', 'chaoyang', 20.00), 
('sahnghai', 'huangfu', 30.00),
('shanghai', 'changning', 10.00)

SELECT * FROM sales;

-- 窗口函数
CREATE TABLE goods(
id INT PRIMARY KEY AUTO_INCREMENT,
category_id INT NOT NULL,
category VARCHAR(15),
NAME VARCHAR(15),
price DEC(8, 2),
stock INT NOT NULL,
upper_time DATE
)

DROP TABLE IF EXISTS goods;

DELIMITER $
CREATE PROCEDURE insert_goods(IN num INT)
BEGIN
	DECLARE now_count INT DEFAULT 0;
	DECLARE cate_id INT;
	DECLARE cate VARCHAR(15);
	WHILE now_count < num DO
		SET cate_id = now_count % 2;
		IF cate_id = 1 THEN SET cate = '户外精品';
		ELSE SET cate = '游戏周边';
		END IF;
		INSERT INTO goods(category_id, category, NAME, price, stock, upper_time)
			VALUES (cate_id, cate, 'Tom', 20 + RAND() * 500, 200 + RAND() * 500, NOW());
		SET now_count = now_count + 1;
	END WHILE;
END $
DELIMITER ;		
			
			
SELECT 200 + RAND() * 500;

SELECT * FROM goods;

CALL insert_goods(100);

SELECT * FROM goods;

-- example1
SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, NAME, price, stock FROM goods;
-- example2
SELECT * FROM
(SELECT ROW_NUMBER() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, NAME, price, stock FROM goods) t
WHERE row_num <= 3;
-- example3
SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, NAME, price, stock FROM goods;
/*
example1和example3很像，但有细微的差别，根据price排序，碰到price相等时，ROW_NUMBER会把两条相同的数据排成不一样
的序号，比如一个4一个5，而RANK是会把两者都当成4，下一位直接到6
*/

-- example4
SELECT DENSE_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
id, category_id, category, NAME, price, stock FROM goods;

/*
example3和example4很像，区别在于，example3的RANK是有两个4，下一位就是6了，而DENSE_RANK也有两个4，但下一位是5
举个例子，当4,5的价格相同时，三种函数的结果如下
ROW_NUMBER()  	123456789
RANK()   	123446789
DENSE_RANK()	123445678

*/




-- 分布函数
-- PERCENT_RANK查出前百分之多少
SELECT RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS row_num,
PERCENT_RANK() OVER(PARTITION BY category_id ORDER BY price DESC) AS prc,
id, category_id, category, NAME, price, stock FROM goods WHERE category_id = 1;

-- CUME_DIST 查出小于或者等于当前price的比例是多少
SELECT 
CUME_DIST() OVER(PARTITION BY category_id ORDER BY price ASC) AS cud,
id, category_id, category, NAME, price, stock FROM goods WHERE category_id = 1;

-- 查询goods数据表中前一个商品与当前商品的差值
-- LAG(price, 1)表示上一行查询到的price，1可改为n，price也可以换成其他field
SELECT id, category_id, category, NAME,
LAG(price, 1) OVER(PARTITION BY category_id ORDER BY price) AS lags,
price, stock FROM goods

-- LEAD(price, 1)表示后一行查询到的price，1可改为n，price也可以换成其他field
SELECT id, category_id, category, NAME,
LEAD(price, 1) OVER(PARTITION BY category_id ORDER BY price) AS lags,
price, stock FROM goods;

-- 首尾函数
-- 首
SELECT FIRST_VALUE(price) OVER(PARTITION BY category_id ORDER BY price) AS fvalue,
id, category_id, category, NAME, price, stock FROM goods;

SELECT LAST_VALUE(price) OVER(PARTITION BY category_id ORDER BY price) AS lvalue,
id, category_id, category, NAME, price, stock FROM goods;

-- 查询goods中排2,3的价格信息
SELECT NTH_VALUE(price, 2) OVER (PARTITION BY category_id ORDER BY price) 2th_price,
NTH_VALUE(price, 3) OVER (PARTITION BY category_id ORDER BY price) 3th_price,
id, category_id, category, NAME, price, stock FROM goods;

-- 将goods中的商品按照价格分为3组
SELECT NTILE(3) OVER (PARTITION BY category_id ORDER BY price) classic,
id, category_id, category, NAME, price, stock FROM goods;


CREATE TABLE employees
AS
SELECT * FROM atguigudb.employees;

-- 公用表表达式（CTE，Common Table Expressions）
-- 使用CTE之前，需要用子查询
SELECT * FROM departments
WHERE department_id IN (
	SELECT DISTINCT department_id FROM employees
);

-- CTE
WITH cte_emp AS (SELECT DISTINCT department_id FROM employees)
SELECT *
FROM departments d JOIN cte_emp e
USING(department_id);

-- 递归公用表表达式
SELECT * FROM employees;

WITH RECURSIVE cte
AS
(
SELECT employee_id, last_name, manager_id, 1 AS n FROM employees WHERE employee_id = 100
UNION ALL SELECT a.employee_id, a.last_name, a.manager_id, n+1 FROM employees a JOIN cte
ON a.manager_id = cte.employee_id
)
SELECT employee_id, last_name, manager_id, n FROM cte WHERE n >= 3;


-- 课后练习

CREATE TABLE IF NOT EXISTS video(
id INT UNIQUE AUTO_INCREMENT,
NAME VARCHAR(100)
);

SELECT * FROM video;

SELECT REGEXP_SUBSTR(nnn.name, '%FC2-PPV%') FROM (
SELECT NAME FROM video WHERE NAME LIKE '%FC2-PPV%'
) AS nnn

SELECT * FROM video;		
SELECT REGEXP_SUBSTR('对方过后FC2-PPV-207445地方湖广会馆', '[FC2-PPV]+-+[PPV]+-+[1-9]*([1-9])')



