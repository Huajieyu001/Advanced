
CREATE DATABASE IF NOT EXISTS dbtest14 CHARACTER SET 'utf8';

USE dbtest14;

-- 复制过来的只是数据，key并没有被复制过来
CREATE TABLE emps AS SELECT * FROM atguigudb.`employees`;
CREATE TABLE depts AS SELECT * FROM atguigudb.`departments`;


DESC emps;


CREATE VIEW vu_emp1
AS
SELECT employee_id, last_name, salary
FROM emps;

SELECT * FROM vu_emp1;

-- 确定视图中字段名的方式一
CREATE VIEW vu_emp2
AS
SELECT employee_id eid, last_name lname, salary
FROM emps
WHERE salary > 8000;

SELECT * FROM vu_emp2;

-- 确定视图中字段名的方式二
CREATE VIEW vu_emp3(emp_id, lname, monthly_sal)
AS
SELECT employee_id, last_name lname, salary
FROM emps
WHERE salary > 8000;

SELECT * FROM vu_emp3;

CREATE VIEW vu_emp_svgsal(dept_id, avg_sal)
AS
SELECT department_id, AVG(salary)
FROM emps
WHERE department_id IS NOT NULL
GROUP BY department_id;

SELECT * FROM vu_emp_svgsal;

CREATE VIEW vu_emp_dept(emp_id, dept_id, dept_name)
AS
SELECT e.employee_id, e.department_id, d.department_name
FROM emps e INNER JOIN depts d
ON e.department_id = d.department_id;

SELECT * FROM vu_emp_dept;

CREATE VIEW vu_emp_dept2
AS
SELECT CONCAT(e.last_name,'(',d.department_name,')') format_item
FROM emps e INNER JOIN depts d
ON e.department_id = d.department_id;

SELECT * FROM vu_emp_dept2;

-- 基于视图去创建视图
CREATE VIEW vu_emp4
AS
SELECT employee_id, last_name
FROM vu_emp1;

SELECT * FROM vu_emp4;
-- 1
SHOW TABLES;
-- 2
DESC vu_emp4;
-- 3
SHOW TABLE STATUS LIKE 'vu_emp%';
-- 4
SHOW CREATE VIEW vu_emp1;

-- 修改视图
SELECT * FROM vu_emp1;
SELECT * FROM emps;

-- 修改视图或基表的数据时，会互相影响
UPDATE vu_emp1 SET salary = 20000 WHERE employee_id = 101;

UPDATE emps SET salary = 17000 WHERE employee_id = 101;

SELECT * FROM vu_emp_svgsal;
-- 更新失败的场景：在视图修改有基表中不存在的字段
UPDATE vu_emp_svgsal SET avg_sal = 10000 WHERE dept_id = 10;

-- 修改视图
-- 方式一
CREATE OR REPLACE VIEW vu_emp1
AS 
SELECT employee_id, last_name, salary, email
FROM emps;

SELECT * FROM emps;
SELECT * FROM vu_emp1;

-- 方式二
ALTER VIEW vu_emp1
AS
SELECT employee_id, last_name, salary, email, hire_date
FROM emps;

SELECT * FROM vu_emp1;

-- 删除视图（和删除表一样）

DROP VIEW IF EXISTS vu_emp1;

-- 课后练习
CREATE OR REPLACE VIEW employee_vu
AS
SELECT last_name, employee_id, department_id
FROM atguigudb.employees
WHERE department_id = '80';

DESC employee_vu;

SELECT * FROM employee_vu;

CREATE VIEW OR REPLACE employee_vu2
AS
SELECT last_name, employee_id, department_id
FROM atguigudb.employees
WHERE department_id = '80';;

SELECT * FROM employee_vu2;

CREATE OR REPLACE VIEW emp_v1
AS
SELECT last_name, salary, email
FROM emps
WHERE phone_number LIKE '011%' AND email LIKE '%e%';

SELECT * FROM emp_v1;
SELECT * FROM emps;

INSERT INTO emp_v1 VALUES ('WenXhenHao', 8000, 'Huajieyu');

UPDATE emp_v1
SET salary = salary + 1000;

DELETE FROM emp_v1 WHERE last_name = 'Olsen';

-- q6
CREATE OR REPLACE VIEW emp_v2
AS
SELECT department_id, MAX(salary)
FROM emps
GROUP BY department_id
HAVING MAX(salary) > 12000;

SELECT * FROM emp_v2;

DROP VIEW IF EXISTS emp_v1;
DROP VIEW IF EXISTS emp_v2;






