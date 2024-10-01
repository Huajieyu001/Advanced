
-- 查询比Abel的工资高的人
-- 使用自连接
SELECT emp2.*
FROM employees emp1, employees emp2
WHERE emp1.last_name='Abel' AND emp2.salary > emp1.salary;

-- 使用子查询
SELECT * 
FROM employees 
WHERE salary > (
	SELECT salary 
	FROM employees 
	WHERE last_name='Abel');
	
	
SELECT 890*3, 870*3, 840*3;

SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
	SELECT job_id FROM employees WHERE employee_id = '141'
)
AND salary > (
	SELECT salary FROM employees WHERE employee_id = '143'
);

--

SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary) FROM employees
);

SELECT employee_id, manager_id, department_id
FROM employees emp1
WHERE emp1.manager_id IN (
	SELECT emp2.manager_id
	FROM employees emp2
	WHERE emp2.employee_id = 141
)
AND emp1.department_id IN (
	SELECT emp3.department_id
	FROM employees emp3
	WHERE emp3.employee_id = 141
)
AND employee_id <> 141;

SELECT employee_id, manager_id, department_id
FROM employees emp1
WHERE (manager_id,department_id) IN (
	SELECT manager_id,department_id
	FROM employees 
	WHERE employee_id = 141
)
AND employee_id <> 141;

SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);

SELECT employee_id, last_name, (CASE department_id
	WHEN (
	SELECT department_id
	FROM departments
	WHERE location_id = 1800
	)
	THEN 'Canada'
	ELSE 'USA'
	END) AS location
	FROM employees
;

-- 子查询的空值问题
SELECT last_name, job_id
FROM employees
WHERE job_id <=> (
	SELECT job_id,last_name
	FROM employees
	ORDER BY last_name
	WHERE last_name = 'Haas'
);

-- 非法使用子查询
SELECT employee_id, last_name
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
	GROUP BY department_id
);

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ANY (
	SELECT salary
	FROM employees
	WHERE job_id = 'IT_PROG'
);

SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
	SELECT AVG(salary) AS avgSalary
	FROM employees
	GROUP BY department_id
	ORDER BY avgSalary
	LIMIT 1);

SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
		SELECT MIN(avg_sal) min_avg
		FROM(
				SELECT AVG(salary) avg_sal, department_id
				FROM employees
				GROUP BY department_id
				) AS avg_Salary)
;

SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= ALL(
		SELECT AVG(salary)
		FROM employees
		GROUP BY department_id);

-- 空值问题
SELECT last_name
FROM employees
WHERE employee_id NOT IN (SELECT manager_id FROM employees);
-- 可改写为↓
SELECT last_name
FROM employees
WHERE employee_id NOT IN (SELECT IFNULL(manager_id,'') FROM employees);
-- 或者写为↓
SELECT last_name
FROM employees
WHERE employee_id NOT IN (SELECT manager_id FROM employees WHERE manager_id IS NOT NULL);

SELECT * FROM employees;

-- 6
SELECT emp1.last_name, emp1.salary, emp1.department_id
FROM employees emp1
WHERE salary >= (
	SELECT AVG(emp2.salary)
	FROM employees emp2
	GROUP BY emp2.department_id
	HAVING emp2.department_id = emp1.department_id OR (emp2.department_id IS NULL AND emp1.department_id IS NULL)
);

SELECT emp1.last_name, emp1.salary, emp1.department_id
FROM employees emp1
WHERE salary > (
	SELECT AVG(emp2.salary)
	FROM employees emp2
	WHERE emp2.department_id = emp1.department_id OR (emp2.department_id IS NULL AND emp1.department_id IS NULL));

SELECT emp2.last_name, emp2.salary, emp2.department_id
FROM (
	SELECT department_id, AVG(salary) avgS
	FROM employees
	GROUP BY department_id
) emp1, employees emp2
WHERE emp2.salary > emp1.avgS AND emp2.department_id = emp1.department_id;

-- 查询员工的id,salary,安装department_name排序
SELECT DISTINCT emp.employee_id, emp.salary, emp.department_id,dept.department_name
FROM (
	SELECT department_id, department_name
	FROM departments
) dept RIGHT OUTER JOIN employees emp
-- where emp.department_id = dept.department_id 
USING(department_id)
ORDER BY dept.department_name;
-- method2
SELECT emp.employee_id,emp.salary, emp.department_id
FROM employees emp
ORDER BY (
	SELECT department_name
	FROM departments dept
	WHERE emp.department_id = dept.department_id
);

SELECT department_id, department_name
	FROM departments
	ORDER BY department_name ASC;
	
	
SELECT employee_id, last_name, job_id
FROM employees emp
WHERE (		SELECT COUNT(*)
		FROM job_history jobh
		WHERE emp.employee_id = jobh.employee_id AND emp.
	
	) >= 2;

SELECT * FROM job_history;
SELECT manager_id FROM employees GROUP BY manager_id;

-- exists 和 not exists
SELECT m.employee_id, m.last_name, m.job_id, m.department_id
FROM employees m
WHERE EXISTS (
	SELECT *
	FROM employees e
	WHERE e.manager_id = m.employee_id
);

-- 不用exists的办法
SELECT DISTINCT mar.employee_id, mar.last_name, mar.job_id, mar.department_id
FROM employees emp LEFT OUTER JOIN employees mar
ON emp.manager_id = mar.employee_id
WHERE emp.manager_id IS NOT NULL;

SELECT DISTINCT mar.employee_id, mar.last_name, mar.job_id, mar.department_id
FROM employees emp INNER JOIN employees mar
ON emp.manager_id = mar.employee_id;

SELECT DISTINCT mar.employee_id, mar.last_name, mar.job_id, mar.department_id
FROM employees mar
WHERE mar.employee_id IN (
	SELECT emp.manager_id
	FROM employees emp
);

--
SELECT department_id, department_name
FROM departments dept
WHERE NOT EXISTS (
	SELECT *
	FROM employees emp
	WHERE dept.department_id = emp.department_id
);

SELECT department_id, department_name
FROM departments dept
WHERE department_id NOT IN (
	SELECT department_id
	FROM employees
	WHERE department_id IS NOT NULL
);

-- 09 课后练习
-- 1
SELECT last_name, salary
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	WHERE last_name = 'Zlotkey'
)
AND last_name <> 'Zlotkey';

-- 2
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
)
ORDER BY salary  ASC;

-- 3
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL (
	SELECT salary
	FROM employees
	WHERE job_id = 'SA_MAN'
);

-- 4
SELECT employee_id, last_name, department_id
FROM employees e1
WHERE department_id IN (
	SELECT department_id
	FROM employees e2
	WHERE last_name LIKE '%u%'
);

--
SELECT *
FROM employees
WHERE last_name LIKE '%u%';
--

SELECT last_name FROM employees WHERE department_id = 100 AND last_name LIKE '%u%';

-- 5
SELECT employee_id
FROM employees
WHERE department_id IN (
	SELECT department_id
	FROM departments
	WHERE location_id = '1700'
);

-- 6
SELECT last_name, salary
FROM employees
WHERE manager_id IN (
	SELECT employ ee_id
	FROM employees
	WHERE last_name = 'King'
);

-- 7
SELECT last_name, salary
FROM employees
WHERE salary <= ALL (
	SELECT salary
	FROM employees
);

-- 8
SELECT *
FROM departments
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) LIMIT 1
);
-- 8
SELECT dept.*
FROM departments dept INNER JOIN employees emp
ON dept.department_id = emp.department_id
GROUP BY department_id
ORDER BY AVG(salary) ASC LIMIT 1;
-- 8
SELECT dept.*
FROM departments dept
WHERE department_id = (
	SELECT department_id
	FROM employees emp
	GROUP BY department_id
	HAVING AVG(salary) = (
				SELECT MIN(avg_return.avg_sal)
				FROM (
					SELECT AVG(emp2.salary) AS avg_sal
					FROM employees emp2
					GROUP BY department_id
				) AS avg_return
			)
);
-- 8
SELECT dept.*
FROM departments dept
WHERE department_id = (
	SELECT department_id
	FROM employees emp
	GROUP BY department_id
	HAVING AVG(salary) <= ALL (
				SELECT AVG(emp2.salary)
				FROM employees emp2
				GROUP BY department_id
			)
);

-- 9
SELECT dept.*, AVG(emp.salary) AS avg_sal
FROM departments dept INNER JOIN employees emp
USING(department_id)
GROUP BY department_id
ORDER BY avg_sal ASC LIMIT 1;

-- 10
SELECT jobs.*
FROM jobs INNER JOIN employees emp
USING (job_id)
GROUP BY job_id
ORDER BY AVG(emp.salary) DESC LIMIT 1;
-- 10
SELECT jobs.*
FROM jobs
WHERE job_id = (
	SELECT job_id
	FROM employees emp
	GROUP BY job_id
	ORDER BY AVG(salary) DESC LIMIT 1
);
-- 10
SELECT jobs.*
FROM jobs NATURAL JOIN employees emp
GROUP BY job_id
HAVING AVG(emp.salary) >= ALL (
	SELECT AVG(salary)
	FROM employees
	GROUP BY job_id
);

--
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id;

SELECT * FROM employees;
--

-- 11 如果department_id是NULL，也能检索出来,需要加条件筛选
SELECT dept.*, AVG(emp.salary) AS detail
FROM departments dept RIGHT OUTER JOIN employees emp
USING(department_id)
WHERE department_id IS NOT NULL -- 过滤掉NULL的数据
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary)
	FROM employees
) ;
-- 11 如果department_id是NULL，不能检索出来
SELECT *
FROM departments
WHERE department_id IN (
	SELECT emp1.department_id
	FROM employees emp1
	GROUP BY emp1.department_id
	HAVING AVG(emp1.salary) > (
			SELECT AVG(emp2.salary)
			FROM employees emp2
	)
);
-- 11
SELECT department_id
FROM employees
GROUP BY department_id
HAVING AVG(salary) > (
	SELECT AVG(salary) FROM employees
);

-- 12
SELECT mar.*
FROM employees mar
WHERE employee_id IN (
	SELECT DISTINCT manager_id
	FROM employees
	-- null过滤加与不加皆可，IN
	-- where manager_id is not null
);
-- 12
SELECT DISTINCT mar.*
FROM employees mar RIGHT OUTER JOIN employees emp
ON mar.employee_id = emp.manager_id
WHERE emp.manager_id IS NOT NULL;
-- 12
SELECT DISTINCT mar.*
FROM employees mar JOIN employees emp
ON mar.employee_id = emp.manager_id;
-- 12
SELECT mar.*
FROM employees mar
WHERE EXISTS(
	SELECT *
	FROM employees emp
	WHERE emp.manager_id = mar.employee_id
);

-- 13
SELECT salary
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC LIMIT 1
)
ORDER BY salary LIMIT 1;
-- 13
SELECT DISTINCT salary
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	GROUP BY department_id
	ORDER BY AVG(salary) DESC LIMIT 1
)
AND salary <= ALL(
	SELECT salary
	FROM employees
	WHERE department_id = (
		SELECT department_id
		FROM employees
		GROUP BY department_id
		HAVING AVG(salary) >= ALL (SELECT AVG(salary) avg_sal
			FROM employees
			GROUP BY department_id)
));
-- new 13
SELECT MIN(salary)
FROM (
	SELECT *
	FROM employees
	WHERE department_id = (
		SELECT department_id
		FROM employees
		GROUP BY department_id
		ORDER BY MAX(salary) ASC LIMIT 0,1
	)
) newT;
-- new 13
SELECT MIN(salary)
FROM employees
GROUP BY department_id
HAVING MAX(salary) <= ALL(
	SELECT MAX(salary)
	FROM employees
	GROUP BY department_id
);
-- new 13
SELECT MIN(salary)
FROM employees emp, (
			SELECT department_id, MAX(salary) max_sal
			FROM employees
			GROUP BY department_id
			ORDER BY max_sal ASC
			LIMIT 1
) newT
WHERE emp.department_id = newT.department_id;


-- 
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM employees;
--
-- 14
SELECT emp.last_name, dept.department_name, emp.email, emp.salary
FROM employees emp INNER JOIN departments dept
USING(department_id)
WHERE employee_id IN (
	SELECT DISTINCT manager_id
	FROM employees
	WHERE department_id = (
		SELECT department_id
		FROM employees
		GROUP BY department_id
		ORDER BY AVG(salary) DESC LIMIT 1
	)
);
-- 14
SELECT last_name, department_id, email, salary;

-- 15 x
SELECT DISTINCT department_id
FROM departments dept LEFT OUTER JOIN employees emp 
USING (department_id)
INNER JOIN jobs USING(job_id)
WHERE department_id NOT IN(
	SELECT DISTINCT department_id
	FROM employees emp
	WHERE job_id = 'ST_CLERK'
)
ORDER BY department_id;
-- 15 √
SELECT department_id
FROM departments dept
WHERE NOT EXISTS (
	SELECT *
	FROM employees emp
	WHERE dept.department_id = emp.department_id AND emp.job_id = 'ST_CLERK'
);


-- 16
SELECT last_name
FROM employees
WHERE manager_id IS NULL;

-- 17
SELECT employee_id, last_name, hire_date, salary
FROM employees
WHERE manager_id = (
	SELECT employee_id
	FROM employees
	WHERE last_name = 'De haan'
);
-- 17
SELECT employee_id, last_name, hire_date, salary
FROM employees emp
WHERE EXISTS (
	SELECT employee_id
	FROM employees mar
	WHERE last_name = 'De haan' AND emp.manager_id = mar.employee_id
);
-- 17
SELECT emp.employee_id, emp.last_name, emp.hire_date, emp.salary
FROM employees emp INNER JOIN employees mar
ON emp.manager_id =  mar.employee_id
WHERE mar.last_name = 'De Haan';

-- 18
SELECT lef.employee_id, lef.last_name, lef.salary, lef.department_id, rig.avg_sal
FROM (SELECT employee_id, last_name, salary, department_id
FROM employees emp
WHERE salary > (
	SELECT AVG(salary)
	FROM employees dep
	WHERE emp.department_id = dep.department_id
	GROUP BY department_id
)) lef INNER JOIN (
		SELECT department_id, AVG(salary) AS avg_sal
		FROM employees
		GROUP BY department_id
) rig
USING(department_id);

-- 19
SELECT department_name
FROM departments dept INNER JOIN (
	SELECT department_id, COUNT(*) AS numbers
	FROM employees
	GROUP BY department_id
	HAVING numbers > 5
) newT
USING(department_id);

--
SELECT * FROM countries;
SELECT * FROM regions;
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM regions;
-- 20
SELECT country_id
FROM countries cou INNER JOIN (
	SELECT country_id, COUNT(department_id) AS numbers_dep
	FROM departments dept INNER JOIN locations loc USING(location_id)
	GROUP BY country_id
	HAVING numbers_dep >= 2
) newT
USING(country_id);

--
SELECT department_id
FROM departments
GROUP BY department_id
--
