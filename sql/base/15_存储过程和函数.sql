
CREATE DATABASE IF NOT EXISTS dbtest15 CHARACTER SET 'utf8';

USE dbtest15;

CREATE TABLE departments
AS
SELECT *
FROM atguigudb.departments;

DELIMITER $
CREATE PROCEDURE select_all_data()
BEGIN
	SELECT * FROM employees;
END $
DELIMITER ;

CALL select_all_data();

DELIMITER $
CREATE PROCEDURE avg_employee_salary()
BEGIN
	SELECT AVG(salary) FROM employees;
END $
DELIMITER ;

CALL avg_employee_salary;

DELIMITER //
CREATE PROCEDURE show_max_salary()
BEGIN
	SELECT MAX(salary) FROM employees;
END //
DELIMITER ;

CALL show_max_salary();
-- 使用OUT
DELIMITER $
CREATE PROCEDURE show_min_salary(OUT ms DOUBLE)
BEGIN
	SELECT MIN(salary) INTO ms
	FROM employees;
END $
DELIMITER ;
-- 调用
CALL show_min_salary(@ms);
-- 查看变量值
SELECT @ms;

DROP PROCEDURE show_min_salary;

-- 使用IN
DELIMITER $
CREATE PROCEDURE show_someone_salary(IN empname VARCHAR(25))
BEGIN
	SELECT salary
	FROM employees
	WHERE last_name = empname;
END $
DELIMITER ;

DROP PROCEDURE IF EXISTS show_someone_salary;

DESC employees;

SELECT * FROM employees;
-- 传参调用方式1
CALL show_someone_salary('King');
-- 传参调用方式2 更灵活
SET @empname = 'Abel';
CALL show_someone_salary(@empname);

-- 6.
DELIMITER $
CREATE PROCEDURE show_someone_salary2(IN empname VARCHAR(25), OUT empsalary DOUBLE)
BEGIN
	SELECT salary INTO empsalary
	FROM employees
	WHERE last_name = empname;
END $
DELIMITER ;

ALTER PROCEDURE show_someone_salary2
SQL SECURITY INVOKER
COMMENT '查询某人工资';

CALL show_someone_salary2('Chen', @empsaalry);
SELECT @empsaalry;

-- 7.
DELIMITER $
CREATE PROCEDURE show_mar_name(INOUT empname VARCHAR(25))
BEGIN
	SELECT mar.last_name
	FROM employees emp INNER JOIN employees mar
	ON emp.manager_id = mar.employee_id
	WHERE emp.last_name = empname;
END $
DELIMITER ;

SET @empname = 'Abel';
CALL show_mar_name(@empname);
SELECT @empname;

DELIMITER $
CREATE FUNCTION email_by_name()
RETURNS VARCHAR(25)
	DETERMINISTIC
	CONTAINS SQL
	READS SQL DATA
BEGIN
	RETURN (SELECT email FROM employees WHERE last_name = 'Abel');
END $
DELIMITER ;

SELECT email_by_name();
	
DESC employees;

DELIMITER $
CREATE FUNCTION email_by_id(emp_id INT)
RETURNS VARCHAR(25)
	DETERMINISTIC
	CONTAINS SQL
	READS SQL DATA
BEGIN
	RETURN (SELECT email FROM employees WHERE employee_id = emp_id);
END $
DELIMITER ;

SELECT * FROM employees;
SELECT email_by_id(100);
	
	
DELIMITER $
CREATE FUNCTION count_by_dept_id(dept_id INT)
RETURNS INT
	DETERMINISTIC
	CONTAINS SQL
	READS SQL DATA
BEGIN
	RETURN 
	(SELECT COUNT(*) FROM employees WHERE department_id = dept_id);
END $
DELIMITER ;
	
SELECT COUNT(*) FROM employees WHERE department_id = 50;
SELECT count_by_dept_id(50);

-- 查看存储过程
SHOW CREATE PROCEDURE show_mar_name;

-- 查看所有存储过程
SHOW PROCEDURE STATUS;

-- 查看存储过程
SELECT * FROM information_schema.Routines WHERE routine_type = 'function';-- ROUTIN_NAME = '{myName';

SELECT * FROM information_schema.Routines WHERE routine_type = 'procedure';


-- 课后练习

-- 0
CREATE DATABASE IF NOT EXISTS test15_pro_func CHARACTER SET 'utf8';
USE test15_pro_func;

CREATE TABLE IF NOT EXISTS admin(
id INT PRIMARY KEY AUTO_INCREMENT,
user_name VARCHAR(25) NOT NULL,
pwd VARCHAR(25) NOT NULL
);

SELECT * FROM admin;

-- 1.
DELIMITER $
CREATE PROCEDURE insert_user(IN usr_name VARCHAR(25), IN usr_pwd VARCHAR(25))
BEGIN
	INSERT INTO admin(user_name, pwd) VALUES (usr_name, usr_pwd);
END $
DELIMITER ;

SET @usr_name = 'tom', @usr_pwd = '12345678';
CALL insert_user(@usr_name, @usr_pwd);

SELECT * FROM admin;

-- 2.
-- prepare
CREATE TABLE beauty(
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(15) NOT NULL,
phone VARCHAR(15) UNIQUE,
birth DATE
);

SELECT * FROM beauty;
INSERT INTO beauty(NAME, phone, birth) VALUES ('bea', '1122334455', '2001-01-01');

-- start
DELIMITER $
CREATE PROCEDURE get_phone(IN iid INT, OUT oname VARCHAR(25),OUT ophone VARCHAR(25))
BEGIN
	SELECT NAME, phone INTO oname, ophone FROM beauty WHERE id = iid;
END $
DELIMITER ;	
	
DROP PROCEDURE get_phone;

SELECT NAME, phone FROM beauty WHERE id = 1;

SET @id = 1;
CALL get_phone(@id, @oname, @ophone);
SELECT @oname, @ophone;

-- 3.
DELIMITER $
CREATE PROCEDURE date_diff(IN date1 DATE, IN date2 DATE, OUT res INT)
BEGIN
	SELECT DATEDIFF(date1, date2) INTO res;
END $
DELIMITER ;

SHOW PROCEDURE STATUS;

CALL date_diff('2024-01-01', '2023-01-10', @res);
SELECT @res;

DELIMITER $
CREATE PROCEDURE date_formatt(IN date1 DATE, OUT resDate VARCHAR(25))
BEGIN
	SELECT DATE_FORMAT(date1, '%Y年%m月%d日');
END $
DELIMITER ;

DROP PROCEDURE date_formatt;

CALL date_formatt('20240101', @resDate);
SELECT @resDate;
	
SELECT 460.28 * 30 * 12;

-- 6.
DELIMITER $
CREATE PROCEDURE double_num(INOUT n1 INT, INOUT n2 INT)
BEGIN 
	SELECT n1 * 2, n2 * 2 INTO n1, n2;
END $
DELIMITER ;

SET @n1 = 10, @n2 = 6;
CALL double_num(@n1, @n2);
SELECT @n1, @n2;

-- incorrect
SHOW PROCEDURE STATUS LIKE 'double_num';
-- correct
SHOW PROCEDURE STATUS LIKE 'double_num';

-- 储存函数课后练习
CREATE TABLE emp
AS
SELECT *
FROM atguigudb.employees;

CREATE TABLE dept
AS
SELECT *
FROM atguigudb.departments;

-- 1.
DELIMITER $
CREATE FUNCTION get_count()
RETURNS INT
	DETERMINISTIC
	CONTAINS SQL
	READS SQL DATA
BEGIN
	RETURN (SELECT COUNT(*) FROM emp);
END $
DELIMITER ;

DELETE FROM emp WHERE employee_id = 105;

SELECT get_count();

-- 2.
DELIMITER $
CREATE FUNCTION ename_salary(ename VARCHAR(25))
RETURNS DOUBLE
	DETERMINISTIC
	CONTAINS SQL
	READS SQL DATA
BEGIN
	RETURN (SELECT salary FROM emp WHERE last_name = ename LIMIT 0, 1);
END $
DELIMITER ;

DROP FUNCTION IF EXISTS ename_salary;

SELECT DISTINCT ename_salary('King');

-- 16 test
SELECT @m1, @m2, @sum;