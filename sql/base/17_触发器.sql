CREATE DATABASE IF NOT EXISTS dbtest17 CHARACTER SET 'utf8';
USE dbtest17;
CREATE TABLE IF NOT EXISTS test_trigger(
id INT PRIMARY KEY AUTO_INCREMENT,
t_note VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS test_trigger_log(
id INT PRIMARY KEY AUTO_INCREMENT,
t_log VARCHAR(30)
);

DROP TABLE test_trigger_log
-- 创建触发器

CREATE TRIGGER before_insert_on_test_trigger
BEFORE INSERT ON test_trigger
FOR EACH ROW
INSERT INTO test_trigger_log(t_log) VALUES ('before_log...');

DROP TRIGGER before_insert_on_test_trigger

SELECT * FROM test_trigger;
SELECT * FROM test_trigger_log;

INSERT INTO test_trigger(t_note) VALUES ('Note......');

-- 2.
CREATE TRIGGER after_insert_test_trigger
AFTER INSERT ON test_trigger
FOR EACH ROW
INSERT INTO test_trigger_log(t_log) VALUES ('after_log...');

INSERT INTO test_trigger(t_note) VALUES ('test...')

SELECT * FROM test_trigger
SELECT * FROM test_trigger_log

-- 3.
CREATE TABLE IF NOT EXISTS departments
AS SELECT * FROM atguigudb.departments;

DESC employees;

-- NEW 关键字
-- SIGNAL SQLSTATE 和 SET MESSAGE_TEXT
DELIMITER $
CREATE TRIGGER salary_check_trigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
	DECLARE mar_sal DOUBLE DEFAULT 0;
	
	SELECT salary INTO mar_sal
	FROM employees WHERE employee_id = NEW.manager_id;
	
	IF mar_sal < NEW.salary THEN 
		SIGNAL SQLSTATE 'HY000' SET MESSAGE_TEXT = '工资高于领导，插入失败'; -- 自定义异常
	END IF;
END $
DELIMITER ;

DESC employees;
SELECT * FROM employees;
INSERT INTO employees VALUES (303,'Alexander','Hunold','AHUNOLD','590.423.4567','1990/1/3','IT_PROG',17001,NULL,102,60)

-- 查看触发器
-- 记得加S
-- 1.
SHOW TRIGGERS;
-- 2.
SHOW CREATE TRIGGER salary_check_trigger;
-- 3.
SELECT * FROM information_schema.triggers


-- 课后练习
CREATE TABLE emps_back
AS
SELECT employee_id, last_name, salary
FROM atguigudb.employees WHERE 1 = 2;

SELECT * FROM emps;
SELECT * FROM emps_back

CREATE TRIGGER emps_insert_trigger
AFTER INSERT ON emps
FOR EACH ROW
INSERT INTO emps_back VALUES (NEW.employee_id, NEW.last_name, NEW.salary)

DESC emps;

INSERT INTO emps VALUES (402, 'Tyre', 15000);

SELECT * FROM emps;

SELECT * FROM emps_back;

-- practice2
CREATE TABLE emps_back2
AS
SELECT * 
FROM emps
WHERE 1 = 2;

-- old的用法
CREATE TRIGGER emps_del_trigger
BEFORE DELETE ON emps
FOR EACH ROW
INSERT INTO emps_back2 VALUES (OLD.employee_id, OLD.last_name, OLD.salary);

DROP TRIGGER IF EXISTS emps_del_trigger;
SELECT * FROM emps;
SELECT * FROM emps_back2;

DELETE FROM emps WHERE salary <= 8000;