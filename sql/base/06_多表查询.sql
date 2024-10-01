SELECT * FROM locations;
-- 查询员工名为‘Abel’的人在哪个城市工作
SELECT locations.city FROM locations WHERE
(SELECT location_id FROM departments WHERE 
(SELECT department_id FROM employees WHERE last_name = 'Abel') = departments.department_id) = locations.location_id;

DESC employees;
DESC departments;

-- 下式查询出现错误，是因为department_id是不明确的，不确定来自哪个表，此时加上表名即可成功查询
SELECT employee_id, department_name, department_id
FROM employees, departments
WHERE employees.`department_id` = departments.`department_id`;

-- 修改后的sql语句成功执行。（出现的字段存在于多个表时，需要指明该字段来自哪个表）
-- 其他没有歧义的字段是不是就不用指定了呢？是的，但是从sql优化的角度来看，建议每个字段都指明所属的表
-- 不指名字段所属表时，会在from的表里查找符合的字段，而指明表的话，只会从已指明的表里查找该字段，效率更高（优化）
SELECT employee_id, department_name, departments.department_id
FROM employees, departments
WHERE employees.`department_id` = departments.`department_id`;

-- 起别名，看起来更简洁
SELECT emp.employee_id, dept.department_name, dept.department_id
FROM employees emp, departments dept
WHERE emp.`department_id` = dept.`department_id`;

-- 起了别名就必须用，不能再使用原名，不然会报错，如下
-- 原理：FROM 后面执行之后，表名被别名覆盖，然后执行WHERE的时候，发现找不到原来的表，所以报错
SELECT emp.employee_id, departments.department_name, departments.department_id
FROM employees emp, departments dept
WHERE emp.`department_id` = departments.`department_id`;

-- 等值连接：用等号
SELECT emp.employee_id, emp.department_id, dept.location_id, loc.city
FROM employees emp, departments dept, locations loc
WHERE emp.last_name = 'Abel' && emp.department_id=dept.department_id && dept.location_id=loc.location_id;
-- 非等值连接：不用等号
SELECT emp.last_name, emp.salary, job.grade_level
FROM employees emp, job_grades job
WHERE emp.salary BETWEEN job.lowest_sal AND job.highest_sal;
-- 自连接：自身不同的字段存在关联,比如员工表，某员工的领导也是公司的员工。同属一个员工表
SELECT emp.employee_id, emp.manager_id, emp.last_name AS collegue, emp2.last_name AS leader
FROM employees emp, employees emp2
WHERE emp.employee_id = emp2.manager_id;
-- 非自连接：不和自身字段关联的连接就是非自连接

-- 内连接: 只包含两个或者多个表中的共同部分
SELECT emp.last_name, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id  = dept.department_id;
-- SQL99
SELECT emp.last_name, dept.department_name
FROM employees emp INNER JOIN departments dept
ON emp.department_id = dept.department_id;
-- SQL99 默认是内连接，可以不写inner
SELECT emp.last_name, dept.department_name
FROM employees emp JOIN departments dept
ON emp.department_id = dept.department_id;

-- 外连接：除了包含内连接的内容外，还包含了左表或者右表中的所有数据（非共同部分）
-- SQL92 MySQL不支持，报错
SELECT emp.last_name, dept.department_name
FROM employees emp, departments dept
WHERE emp.department_id (+) = dept.department_id;
-- SQL99 左外连接
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id;
-- SQL99 右外连接
SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT OUTER JOIN departments dept
ON emp.department_id = dept.department_id;
-- 写了left或right，说明肯定是外连接了，outer这个词可以省略不写，如下
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT JOIN departments dept
ON emp.department_id = dept.department_id;
-- 满外连接 MySQL不支持full join写法，Oracle支持
SELECT emp.last_name, dept.department_name
FROM employees emp FULL JOIN departments dept
ON emp.department_id = dept.department_id;
-- 
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT JOIN departments dept
ON emp.department_id = dept.department_id
WHERE dept.department_id IS NULL;

SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT JOIN departments dept
ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL;

SELECT emp.last_name, dept.department_name
FROM employees emp LEFT JOIN departments dept
ON emp.department_id = dept.department_id
WHERE (emp.department_id IS NULL) OR (dept.department_id IS NULL);
-- 满外连接 ~A并~B 17条
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT JOIN departments dept
ON emp.department_id = dept.department_id
WHERE dept.department_id IS NULL UNION ALL
SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT JOIN departments dept
ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL;
-- 满外连接 A并B 123条
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT JOIN departments dept
ON emp.department_id = dept.department_id
UNION ALL
SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT JOIN departments dept
ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL;

-- -------
-- SQL JOINS Test
-- 1   107
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id;
-- 2   122
SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT OUTER JOIN departments dept
ON emp.department_id = dept.department_id;
-- 3   106
SELECT emp.last_name, dept.department_name
FROM employees emp INNER JOIN departments dept
ON emp.department_id = dept.department_id;
-- 4   1
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id
WHERE dept.department_id IS NULL;
-- 5   16
SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT OUTER JOIN departments dept
ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL;
-- 6   107+16=123
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id UNION ALL
SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT OUTER JOIN departments dept
ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL;
-- 6   122+1=123  满外连接（在Oracle中只需要写FULL OUTER JOIN就可以实现下式的效果）
SELECT emp.last_name, department_name
FROM employees emp RIGHT OUTER JOIN departments dept
ON emp.department_id = dept.department_id UNION ALL
SELECT emp.last_name, department_name
FROM employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id
WHERE dept.department_id IS NULL;

-- 7   1+16=17
SELECT emp.last_name, dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id
WHERE dept.department_id IS NULL UNION ALL
SELECT emp.last_name, dept.department_name
FROM employees emp RIGHT OUTER JOIN departments dept
ON emp.department_id = dept.department_id
WHERE emp.department_id IS NULL;


-- --------------------------------------------
-- 32
SELECT emp.employee_id, emp.last_name, dept.department_id
FROM employees emp JOIN departments dept
ON emp.department_id = dept.department_id
AND emp.manager_id = dept.manager_id;
-- SQL99 新特性 自然连接：NATURAL JOIN （会自动查询两表中所有相同的字段，进行等值连接）
-- 特点：方便，但不够灵活
-- 32 效果同上式
SELECT emp.employee_id, emp.last_name, dept.department_id
FROM employees emp NATURAL JOIN departments dept;
-- SQL99 新特性 USING （选择两表中相同的字段，进行等值连接）
-- 特点：方便，并且灵活
SELECT emp.employee_id, emp.last_name, dept.department_id
FROM employees emp JOIN departments dept
USING(department_id, manager_id);


####practice bilibili P31
-- q1
SELECT emp.last_name, emp.department_id, dept.department_id
FROM employees emp LEFT OUTER JOIN departments dept
ON emp.department_id = dept.department_id;

SELECT * FROM jobs;
SELECT * FROM departments;
SELECT * FROM employees;
-- q2
SELECT emp.job_id, dept.location_id
FROM employees emp LEFT OUTER JOIN departments dept
USING (department_id)
WHERE emp.department_id = '90';
-- q3
SELECT emp.commission_pct, emp.last_name, dept.department_name, dept.location_id, loc.city
FROM employees emp LEFT OUTER JOIN departments dept 
ON emp.department_id = dept.department_id
LEFT OUTER JOIN locations loc
ON dept.location_id = loc.location_id
WHERE emp.commission_pct IS NOT NULL;
-- q4
SELECT emp.last_name, emp.job_id , dept.department_id,dept.department_name
FROM employees emp LEFT OUTER JOIN departments dept 
ON emp.department_id = dept.department_id
LEFT OUTER JOIN locations loc
ON dept.location_id = loc.location_id
WHERE loc.city = 'Toronto';
-- q5
SELECT dept.department_name, loc.street_address, emp.last_name, jobs.job_title, emp.salary
FROM employees emp 
LEFT OUTER JOIN departments dept  
USING(department_id)
LEFT OUTER JOIN locations loc
USING(location_id)
LEFT OUTER JOIN jobs
USING(job_id)
WHERE dept.department_name='Executive';
-- q6
SELECT emp1.last_name AS employee, emp1.employee_id AS Emp, emp2.last_name AS manager, emp2.employee_id AS Mgr
FROM employees emp1 LEFT OUTER JOIN employees emp2
ON emp1.manager_id = emp2.employee_id;
-- q7
SELECT DISTINCT dept.department_id, dept.department_name
FROM departments dept
WHERE dept.department_id NOT IN (
SELECT DISTINCT emp.department_id FROM employees emp WHERE emp.department_id IS NOT NULL
);
-- q7
SELECT dept.department_id, dept.department_name
FROM departments dept LEFT OUTER JOIN employees emp
ON dept.department_id = emp.department_id
WHERE emp.department_id IS NULL;
-- q8
SELECT DISTINCT loc.location_id, loc.city
FROM locations loc
WHERE loc.location_id  NOT IN (
SELECT DISTINCT dept.location_id
FROM departments dept
WHERE department_id IS NOT NULL
);
-- q8
SELECT loc.location_id, loc.city
FROM locations loc LEFT OUTER JOIN departments dept
USING (location_id)
WHERE dept.location_id IS NULL;
-- q9  39
SELECT * 
FROM employees emp*
WHERE emp.department_id IN (
SELECT dept.department_id
FROM departments dept
WHERE dept.department_name IN ('sales', 'it')
);
-- q9
SELECT emp.employee_id, emp.last_name, emp.department_id
FROM employees emp INNER JOIN departments dept
USING(department_id)
WHERE dept.department_name IN ('sales', 'it');

SELECT * FROM locations;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM jobs;

SELECT 'hello' || 'world' FROM DUAL;
SELECT 'hello' + 'world' FROM DUAL;
SELECT CONCAT('hello', 'world');
