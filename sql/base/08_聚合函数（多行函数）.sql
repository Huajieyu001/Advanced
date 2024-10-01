
SELECT AVG(salary) FROM employees WHERE salary>6000;

SELECT SUM(salary) FROM employees;

SELECT MAX(salary), MIN(salary), MAX(last_name), MIN(last_name) FROM employees;

SELECT COUNT(salary), COUNT(commission_pct), COUNT('kehjnsrg') FROM employees;

SELECT AVG(commission_pct), SUM(commission_pct), SUM(commission_pct)/COUNT(commission_pct) FROM employees;

SELECT AVG(IFNULL(commission_pct, 0)) FROM employees;

-- group by 可以用于分组
-- 查询每个部门的平均工资
SELECT department_id, AVG(salary) FROM employees GROUP BY department_id;

SELECT department_id,job_id, AVG(salary), COUNT(salary) AS counter FROM employees GROUP BY department_id, job_id WITH ROLLUP;

-- HAVING
-- 查询部门中id为10,20,30,40这四个部门中最高工资大于10000的部门信息
-- 写法1，用where加having
SELECT department_id, MAX(salary)
FROM employees 
WHERE department_id IN ('10','20','30','40')
GROUP BY department_id 
HAVING MAX(salary) > 10000;
-- 写法二 用having替代where
SELECT department_id, MAX(salary)
FROM employees 
GROUP BY department_id 
HAVING department_id IN ('10','20','30','40') AND MAX(salary) > 10000;

-- 上述两种方法都可以，但是没有用到聚合函数的条件，建议放在where中，也就是方法一的形式，效率会更高

-- practice
-- 1 **
-- 2
select max(salary), min(salary), avg(salary), sum(salary)
from employees;

-- 3
select job_id, max(salary), min(salary), avg(salary), sum(salary)
from employees
group by job_id;

-- 4
select job_id, count(*) as collgues
from employees
group by job_id;

-- 5
select max(salary)-min(salary) as diffrence
from employees;

-- 6
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 6000;

-- 7
select emp.department_id, dept.department_name, dept.location_id, count(*) as collegues, avg(emp.salary) as avgSalary
from employees emp 
left outer join departments dept using(department_id) 
left outer join locations loc using(location_id)
group by department_id
order by avgSalary desc;

-- 7
SELECT dept.department_id, dept.department_name, dept.location_id, COUNT(1) AS collegues, AVG(emp.salary) AS avgSalary
FROM departments dept 
left OUTER JOIN employees emp USING(department_id) 
LEFT OUTER JOIN locations loc USING(location_id)
where emp.department_id is not null
GROUP BY department_id;
ORDER BY avgSalary DESC;
-- 7
SELECT dept.department_id, dept.department_name, dept.location_id, COUNT(emp.employee_id) AS collegues, AVG(emp.salary) AS avgSalary
FROM departments dept 
LEFT OUTER JOIN employees emp USING(department_id) 
LEFT OUTER JOIN locations loc USING(location_id)
GROUP BY department_id;
ORDER BY avgSalary DESC;

-- 7 一种错误的select方式
SELECT emp.department_id, dept.department_name, dept.location_id, COUNT(emp.employee_id) AS collegues, AVG(emp.salary) AS avgSalary
FROM departments dept 
LEFT OUTER JOIN employees emp USING(department_id) 
LEFT OUTER JOIN locations loc USING(location_id)
GROUP BY department_id;
ORDER BY avgSalary DESC;

-- 8
select job_title,department_name, min(salary)
from jobs 
join employees emp using(job_id)
join departments dept using(department_id)
group by job_title, department_name;

SELECT job_title,department_name, MIN(salary)
FROM departments dept 
LEFT OUTER JOIN employees emp USING(department_id)
LEFT OUTER JOIN jobs USING(job_id)
GROUP BY job_title, department_name;

select * from employees;
select * from jobs;
select 
from departments dept 
left outer join employees emp using(department_id)
group by department_id

;
-- 7


