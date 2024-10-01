
-- 升序
SELECT * FROM employees ORDER BY salary;
SELECT * FROM employees ORDER BY salary ASC;
-- 降序
SELECT * FROM employees ORDER BY salary DESC;

-- 通过别名排序
SELECT salary, -1 * salary AS substract FROM employees ORDER BY substract DESC;

-- 二级排序
SELECT employee_id, salary, department_id FROM employees ORDER BY department_id DESC, salary ASC;

-- 分页
SELECT * FROM employees ORDER BY employee_id LIMIT 0,20;

-- 显示第n页
SELECT * FROM employees ORDER BY employee_id LIMIT 20 * (n + 1),20;
SELECT * FROM employees ORDER BY employee_id LIMIT (SELECT 20*(0)), 20;


SELECT * FROM employees WHERE employee_id > 119 ORDER BY employee_id LIMIT 0,20;
SELECT * FROM employees WHERE employee_id > 119 LIMIT 0,20 ORDER BY employee_id; -- Error 必须要把limit放在排序后面

-- 显示第32,33条数据
SELECT * FROM employees LIMIT 32,2;
-- 显示第32,33条数据
SELECT * FROM employees LIMIT 2 OFFSET 32; -- MySQL8.0新特性（自己测试发现5.7也可以跑


-- test
SELECT first_name, last_name, department_id, 12 * salary AS yearSalary 
FROM employees 
ORDER BY yearSalary DESC, 
`first_name` ASC, last_name ASC;


SELECT first_name, last_name, salary 
FROM employees 
WHERE salary NOT BETWEEN 8000 AND 17000 
ORDER BY salary DESC LIMIT 20, 20;


SELECT *
FROM employees
WHERE email LIKE '%e%'
-- WHERE email regexp '[e]'  -- 或者用这一行，正则表达式
ORDER BY LENGTH(email) DESC, department_id ASC;

/*
SELECT ..., ..., ...
FROM ...
WHERE ... AND ... OR ... NOT ... IS ...
ORDER BY ... ASC, ... DESC
LIMIT ..., ...;






*/