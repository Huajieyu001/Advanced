
#1 
-- 查看所有系统变量（全局变量）
SHOW GLOBAL VARIABLES;

-- 查看所有会话变量（局部变量）
SHOW SESSION VARIABLES;
SHOW VARIABLES;

-- 可以用like
SHOW GLOBAL VARIABLES LIKE 'auto%';

#2 用户定义变量 vs 局部变量
SET @m1 = 1;
SET @m2 := 2;
SET @sum = @m1 + @m2;

SELECT @m1, @m2, @sum;

SET @m1 = 3;


-- prepara
CREATE DATABASE IF NOT EXISTS dbtest16 CHARACTER SET 'utf8';
USE dbtest16;

CREATE TABLE employees
AS
SELECT *
FROM atguigudb.employees;

CREATE TABLE departments
AS
SELECT *
FROM atguigudb.departments;

-- 设置变量和赋值

SELECT @count := COUNT(*) FROM employees;
SELECT @count;

SELECT AVG(salary) INTO @avg_sal FROM employees;
SELECT @avg_sal;

CREATE TABLE IF NOT EXISTS test(
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(25),
item INT
);


DELIMITER $
CREATE PROCEDURE test_var()
BEGIN
	DECLARE a INT DEFAULT 0;
	DECLARE b INT ;
	DECLARE empname VARCHAR(25); 
	SET a = 1;
	SET b := 2;
	SELECT last_name INTO empname FROM employees WHERE employee_id = 101;
	SELECT a, b, empname;
END $
DELIMITER ;

CALL test_var();

DELIMITER $
CREATE PROCEDURE test_set()
BEGIN
	DECLARE lname VARCHAR(25);
	DECLARE sal DOUBLE;
	SELECT emp.last_name, emp.salary INTO lname, sal
	FROM employees emp
	WHERE employee_id = 102;
	SELECT lname, sal;
END $
DELIMITER ;

CALL test_set();

-- example2
SET @v1 = 10;
SET @v2 := 20;
SET @vsum = @v1 + @v2;
SELECT @v1, @v2, @vsum;

DELIMITER $
CREATE PROCEDURE adds()
BEGIN
	DECLARE a INT;
	DECLARE b INT;
	DECLARE c INT;
	SET a = 5;
	SET b := 15;
	SET c = a + b;
	SELECT a, b, c;
END $
DELIMITER ;

CALL adds();

DESC employees;

DELIMITER $
CREATE PROCEDURE diff_sal(IN emp_id INT, OUT sub DOUBLE(8, 2))
BEGIN
	DECLARE emp_sal DOUBLE(8,2);
	DECLARE mar_sal DOUBLE(8,2); 
	SELECT emp.salary, mar.salary INTO emp_sal, mar_sal
	FROM employees emp INNER JOIN employees mar
	ON emp.manager_id = mar.employee_id
	WHERE emp.employee_id = emp_id;
	SET sub = emp_sal - mar_sal;
END $
DELIMITER ;

SET @emp_id = 101;
CALL diff_sal(@emp_id, @resSub);
SELECT @resSub;



#2. 定义条件和处理程序

DELIMITER $
CREATE PROCEDURE updataEmp()
BEGIN
	SET @x = 1;
	UPDATE employees SET email = NULL WHERE last_name = 'Abel';
	SET @x = 2;
	UPDATE employees SET email = '5500@qq' WHERE last_name = 'Abel';
	SET @x = 3;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS updataEmp;

CALL updataEmp();

SELECT @x;

-- 定义错误名称
-- 使用MySQL_error_code定义
DECLARE Field_not_be_null CONDITION FOR 1048;
DECLARE command_not_allowed CONDITION FOR 1148;

-- 使用sqlstate_value定义
DECLARE Field_not_be_null CONDITION FOR SQLSTATE '23000';
DECLARE command_not_allowed CONDITION FOR SQLSTATE '42000';
--
捕获错误并且处理的格式
DECLARE {CONTINUE/EXIT/UNDO} HANDLER FOR '错误标识' '执行语句'
-- 捕获错误的六种方法
-- 0.1 通过sqlstate
DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @info = 'Exception1';
-- 0.2 通过MySQL_error_code
DECLARE CONTINUE HANDLER FOR 1048 SET @info = 'Exception2';
-- 0.3 通过自定义名称
DECLARE Field_not_be_null CONDITION FOR 1048;
DECLARE CONTINUE HANDLER FOR Field_not_be_null SET @info = 'Exception3';

-- 0.4 使用SQLWARNINGS，以01开头
DECLARE EXIT HANDLER FOR SQLWARNING SET 'Exception4';
-- 0.5 使用NOT FOUND，以02开头
DECLARE EXIT HANDLER FOR NOT FOUND SET 'Exception5';
-- 0.6 使用SQLEXCEPTION， 是0.5和0.6之外的情况
DECLARE EXIT HANDLER FOR SQLEXCEPTION SET 'Exception6'; 
-- 定义处理程序

DELIMITER $
CREATE PROCEDURE updataEmp()
BEGIN
	DECLARE CONTINUE HANDLER FOR 1048 SET @info = 'not found';
	SET @x = 1;
	UPDATE employees SET email = NULL WHERE last_name = 'Abel';
	SET @x = 2;
	UPDATE employees SET email = '5500@qq' WHERE last_name = 'Abel';
	SET @x = 3;
END $
DELIMITER ;

CALL updataEmp();

SELECT @x, @info;
SELECT * FROM employees;

-- 3. IF语句，流程控制+
DELIMITER $
CREATE PROCEDURE test_if()
BEGIN
	DECLARE stu_name VARCHAR(15);
	IF stu_name IS NULL
		THEN SELECT 'stu_name is null';
	END IF;
END $
DELIMITER ;

CALL test_if();

DELIMITER $
CREATE PROCEDURE test_if2()
BEGIN
	DECLARE stu_name VARCHAR(15);
	IF stu_name IS NULL
		THEN SELECT 'stu_name is null';
	ELSE
		SELECT 'stu_name is not null';
	END IF;
END $
DELIMITER ;

CALL test_if2();

DELIMITER $
CREATE PROCEDURE test_if3()
BEGIN
	DECLARE stu_name VARCHAR(15) DEFAULT 'abc';
	IF stu_name IS NULL
		THEN SELECT 'stu_name is null';
	ELSE
		SELECT 'stu_name is not null';
	END IF;
END $
DELIMITER ;

CALL test_if3();

DELIMITER $
CREATE PROCEDURE test_if4(IN age INT)
BEGIN
	IF age > 50
		THEN SELECT '老年' AS '阶段';
	ELSEIF age > 30
		THEN SELECT '中年' AS '阶段';
	ELSEIF age >= 18
		THEN SELECT '青年' AS '阶段';
	ELSEIF age >= 6
		THEN SELECT '少年' AS '阶段';
	ELSE
		SELECT '幼年' AS '阶段';
	END IF;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS test_if4;

CALL test_if4(51);
CALL test_if4(31);
CALL test_if4(18);
CALL test_if4(7);
CALL test_if4(5);

-- 
DELIMITER $
CREATE PROCEDURE up_sal(IN emp_id INT)
BEGIN
	DECLARE flag INT DEFAULT 0;
	IF DATEDIFF(NOW(), (SELECT hire_date FROM employees WHERE employee_id = emp_id AND salary < 8000)) > 365*5
		THEN UPDATE employees SET salary = salary + 500 WHERE employee_id = emp_id;
	END IF;
END $
DELIMITER ;

SELECT DATEDIFF('2022-01-01', NOW());

SELECT * FROM  employees WHERE salary < 8000;

CALL up_sal(104);

-- case
-- example 1
DELIMITER $
CREATE PROCEDURE test_case(IN age INT)
BEGIN
	CASE age
		WHEN 1 THEN SELECT 'A' AS 'item';
		WHEN 2 THEN SELECT 'B' AS 'item';
		WHEN 3 THEN SELECT 'C' AS 'item';
		WHEN 4 THEN SELECT 'D' AS 'item';
		WHEN 5 THEN SELECT 'E' AS 'item';
	END CASE;
END $
DELIMITER ;

CALL test_case(1);
CALL test_case(2);
CALL test_case(3);
CALL test_case(4);
CALL test_case(5);

-- example 2
DELIMITER $
CREATE PROCEDURE test_case1(IN age INT)
BEGIN
	CASE
		WHEN age > 50 THEN SELECT '老年' AS 'item';
		WHEN age > 30 THEN SELECT '中年' AS 'item';
		WHEN age > 17 THEN SELECT '青年' AS 'item';
		WHEN age > 05 THEN SELECT '少年' AS 'item';
		ELSE SELECT '幼年' AS 'item';
	END CASE;
END $
DELIMITER ;

CALL test_case1(51);
CALL test_case1(31);
CALL test_case1(18);
CALL test_case1(6);
CALL test_case1(5);

-- 循环结构
-- LOOP

-- example 1
DELIMITER $
CREATE PROCEDURE test_loop(IN border INT)
BEGIN
	DECLARE num INT DEFAULT 1;
	loop1: LOOP 
		SET num = num + 1;
		IF num > border THEN LEAVE loop1;
		END IF;
	END LOOP loop1;
END $
DELIMITER ;

CALL test_loop(1000000);

CREATE TABLE IF NOT EXISTS table_insert(
id DECIMAL(10, 0) NOT NULL UNIQUE,
lname VARCHAR(10),
age INT(3),
salary DEC(8, 2),
email VARCHAR(25)
);

DELIMITER $
CREATE PROCEDURE test_insert(IN starter DECIMAL(10, 0), IN num INT)
BEGIN
	DECLARE counter DECIMAL(10, 0) DEFAULT 0;
	DECLARE border DECIMAL(10, 0) DEFAULT 0;
	SET counter = starter;
	SET border = starter + num;
	loop_label:LOOP
		INSERT INTO table_insert(id, lname, age, salary, email) VALUES (counter, 'Tom', 18, 6000, '@gmail');
		SET counter = counter + 1;
		IF counter >= border
			THEN LEAVE loop_label;
		END IF;
	END LOOP loop_label;
END $
DELIMITER ;

CALL test_insert(1000000100, 1000000);

SELECT * FROM table_insert;

SELECT COUNT(*) FROM employees WHERE employee_id = 100;

-- correct
DELIMITER $
CREATE PROCEDURE update_salary_loop(OUT num INT)
BEGIN
	DECLARE counter INT DEFAULT 0;
	DECLARE avg_sal INT DEFAULT 0;
	SELECT AVG(salary) INTO avg_sal FROM employees;
	label:LOOP
		IF avg_sal > 12000
			THEN LEAVE label;
		END IF;
		UPDATE employees SET salary = 1.1 * salary;
		SET counter = counter + 1;
		SELECT AVG(salary) INTO avg_sal FROM employees;
	END LOOP label;
	SET num = counter;
END $
DELIMITER ;

SELECT salary FROM employees;

SELECT AVG(salary) FROM employees;

CALL update_salary_loop(@resNum);
SELECT @resNum;


-- while
DELIMITER $
CREATE PROCEDURE test_while(IN counter INT)
BEGIN 
	DECLARE num INT DEFAULT 1;
	WHILE num <= counter DO
		SET num = num + 1;
	END WHILE ;
END $
DELIMITER ;

CALL test_while(1000000);

-- repeat
DELIMITER $
CREATE PROCEDURE test_repeat(IN num INT)
BEGIN
	DECLARE counter INT DEFAULT 0;
	REPEAT
		SET counter = counter + 1;
	UNTIL counter > num
	END REPEAT;
END $
DELIMITER ;

CALL test_repeat(1000000);

-- leave
DELIMITER $
CREATE PROCEDURE leave_begin(INOUT num INT)
begin_label:BEGIN
	IF num > 20
		THEN LEAVE begin_label;
	END IF;
	SET num = 20;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS leave_begin;
SET @num = 25;
CALL leave_begin(@num);
SELECT @num;

-- leave and while
DELIMITER $
CREATE PROCEDURE while_leave(IN num INT)
BEGIN
	DECLARE counter INT DEFAULT 0;
	while_label:WHILE TRUE DO
		IF  num > 100
			THEN LEAVE while_label;
		END IF;
		SET counter = counter + 1;
		SET num = num + 1;
	END WHILE;
	SELECT counter AS 'item';
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS while_leave;

SET @num = 50;
CALL while_leave(@num);
SELECT @num;

DELIMITER $
CREATE PROCEDURE test_iterate()
BEGIN
	DECLARE str VARCHAR(25) DEFAULT '';
	DECLARE num INT DEFAULT 0;
	while_label:WHILE num < 100 DO
		IF LENGTH(str) >= 20
			THEN LEAVE while_label;
		END IF;
		IF num / 2 = 0
			THEN ITERATE while_label;
		END IF;
		SET str = CONCAT(str, num);
		SET num = num + 1;
	END WHILE;
	SELECT str;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS test_iterate;

CALL test_iterate();

SET @str = CONCAT(NULL, 15);
SELECT @str;

select 1920 * 1080 as 1080p, 2560 * 1440 as 2k, 3840 * 2160 as 4k;

