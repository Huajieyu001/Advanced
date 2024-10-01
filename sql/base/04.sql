-- 有空格的别名必须要加双引号

SELECT salary, salary * 12 "coun Yea" FROM employees;

SELECT * FROM employees;

-- DISTINCT去重
SELECT DISTINCT department_id FROM employees;

-- select salary, distinct department_id from employees;

SELECT DISTINCT department_id,salary FROM employees;

-- use null
SELECT (1 + IFNULL(commission_pct,0)) * 12 AS reward FROM employees;

SELECT * FROM `order`;

-- 查询常数
SELECT 'asg', 46561565, department_id, salary FROM employees;

-- “描述”：显示表结构
DESCRIBE employees;

--
SELECT * FROM employees WHERE last_name<=>'king' AND employee_id >= 100;

SELECT 100+1, 100-1, 100*1.1, 100/5, 100 DIV 2, 105 % 10 , 105 MOD 10;

SELECT '50'+100;
-- sql 中，加号只表达加法，不表达连接字符串，下列结果为10
SELECT 'asgdfh' + 10;
-- null参与的运算结果都为null
SELECT 100+NULL;

SELECT 0='a'; -- 字符串存在隐式转换，如果转换不成功，则默认为0
-- <=>  是安全等于的意思，commission_pct=NULL 不会返回结果，因为该式结果为null，而commission_pct<=>NULL会返回当commission_pct是null
-- 时候的数据
SELECT last_name,commission_pct FROM employees WHERE commission_pct<=>NULL;

SELECT 0 = NULL,NULL <=> NULL;

SELECT last_name,commission_pct FROM employees WHERE commission_pct IS NULL;

SELECT last_name,commission_pct FROM employees WHERE commission_pct is not NULL;

### 安全等于，搭配Not,可以实现is not null 的效果
select last_name,commission_pct FROM employees WHERE not commission_pct<=>NULL;

-- ---------------------------------------------------------------
select least(162,6415,1564,6485,978,615,9748,615,465) as l from dual;
SELECT LEAST('g','a','c','n','b'),greatest('g','a','c','n','b')  ;

select least('aab','aaab','aa'),greatest('aab','aaab','aa');

-- 查询工资在6000-8000的员工 between and 是包含边界值的
select * from employees where salary between 6000 and 8000;
-- 等价于
select * from employees where salary >= 6000 && salary <= 8000;
SELECT * FROM employees WHERE salary >= 6000 and salary <= 8000;

-- 查询工资不在6000-8000的员工
SELECT * FROM employees WHERE salary < 6000 or salary > 8000;
SELECT * FROM employees WHERE salary < 6000 || salary > 8000;
SELECT * FROM employees WHERE not salary BETWEEN 6000 AND 8000;

-- in     not in
select * from employees where employee_id in (100,101,102,103,105,110);
SELECT * FROM employees WHERE employee_id not IN (100,101,102,103,105,110);

-- like ### %代表0-n个字符  _代表一个字符
select * from employees where first_name like '%Da%';
-- 以B开头
SELECT * FROM employees WHERE first_name LIKE 'B%';
-- 以a结尾
SELECT * FROM employees WHERE first_name LIKE '%a';
-- 第二个字符为a
SELECT * FROM employees WHERE first_name LIKE '_a%';
-- 第二个字符为下划线且第三个字符为e
select * from employees where first_name like '__e%'; -- 错误写法
SELECT * FROM employees WHERE first_name LIKE '_\_e%'; -- 正确写法，使用\这个转义字符进行转义
SELECT * FROM employees WHERE first_name LIKE '_*_e%' escape '*'; -- 正确写法，自定义转义字符*进行转义,可以替换成其他字符

select 'xanadu' regexp 'a.a';
SELECT 'xanadu' REGEXP 'na';
SELECT 'xanadu' REGEXP '[sjx]';

-- xor 异或：两边的真假值不一致时，才为true
select 1=3 xor 1=1;
-- ^ 异或
select 7 ^ 3;
-- ~ 取反
select 10 & ~ 1;
select 16>>2;
SELECT 3<<2;

