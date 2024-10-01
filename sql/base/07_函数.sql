
-- 数值函数
SELECT ABS(-0.2);
SELECT SIGN(-0.2);
SELECT PI(); -- 6;
SELECT CEILING(4.4);
SELECT CEIL(4.4);
SELECT FLOOR(4.4);
SELECT LEAST(1, 2.2, 0.5, 1.8, 5, 6.4);
SELECT GREATEST(1, 2.2, 0.5, 1.8, 5, 6.4);
SELECT MOD(103, 5);
SELECT RAND() * 1000 + 100;
SELECT ROUND(4.45, 1);
SELECT TRUNCATE(0.123456789, 5);
SELECT SQRT(361.5);



-- 三角函数， 无需练习

-- 进制转换
SELECT 3 * (BIN(7));

SELECT HEX(10);

SELECT OCT(10);

SELECT CONV(111, 2, 10);

SELECT CONV(111, 8, 2);

-- 字符串函数
SELECT ASCII('a');
-- char_length是根据字符的个数来计算，length是根据字符的字节数来计算
SELECT CHAR_LENGTH('花解语'), LENGTH('花解语');

SELECT CONCAT('hello ', 'world');

SELECT CONCAT_WS('+', '1', '2', '3');
-- 3是开始位置，0是需要替换的长度，如果为0，则表示不替换，直接插入位置3
SELECT INSERT('helloworld', 3, 0, 'xxxxx');

SELECT REPLACE('hello', 'el', 'xxxxxxx');

SELECT UPPER('AaBbCc'), UCASE('AaBbCc'), LOWER('AaBbCc'), LCASE('AaBbCc');

SELECT LEFT('abcdeee', 3);
SELECT RIGHT('abcdeee', 3);

SELECT LPAD('abcde', 10, '*');
SELECT RPAD('abcde', 10, '*');

SELECT CONCAT(LTRIM('  a b c  '),'x'), CONCAT(RTRIM('  a b c  '), 'x'), CONCAT(TRIM('  a b c  '), 'x');
SELECT TRIM(' ' FROM '  a b c  '), TRIM('a' FROM 'aabccddeffaaa');

SELECT REPEAT('abc', 3), CONCAT(REPEAT(' ', 3),'x'), CONCAT(SPACE(3), 'x');

SELECT STRCMP('a', 'b'), STRCMP('ccccb', 'cccca');

SELECT SUBSTR('abcabcabc', 2, 2);

SELECT LOCATE('aaa', 'idfkhgbdkfaaa');

SELECT ELT(3, 'aaa', 'baaaa', 'aaac', 'aad');

SELECT FIELD('aaa', 'baaac', 'aaa',  'earghfdgaaafgnbfbn');

SELECT FIND_IN_SET('aaa', 'baaac,ccc,aaa,earghfdgaaafgnbfbn');

SELECT REVERSE('aabbccddeeff');

SELECT NULLIF('aaa', 'bbb'), NULLIF('aaa', 'aaa');

-- 日期函数

SELECT CURDATE(), CURTIME(), NOW(), UTC_DATE(), UTC_TIME();

SELECT UNIX_TIMESTAMP(), UNIX_TIMESTAMP('2023-12-10'), FROM_UNIXTIME(UNIX_TIMESTAMP('2023-12-10'));

SELECT YEAR(NOW()), MONTH(NOW()), DAY(NOW()), HOUR(NOW()), MINUTE(NOW()), SECOND(NOW());

SELECT MONTHNAME(NOW()), DAYNAME(NOW()), WEEKDAY(NOW()), WEEKDAY('20231213'), QUARTER(NOW()),WEEK(NOW()), WEEKOFYEAR(NOW()), DAYOFYEAR(NOW()), DAYOFMONTH(NOW()), DAYOFWEEK(NOW());

SELECT EXTRACT(YEAR FROM NOW()) AS yy,EXTRACT(MONTH FROM NOW()) AS MM,EXTRACT(DAY FROM NOW()) AS dd,
EXTRACT(HOUR FROM NOW()) AS hh,EXTRACT(MINUTE FROM NOW()) AS mm,EXTRACT(SECOND FROM NOW()) AS ss;

SELECT TIME_TO_SEC(NOW())/3600; -- today

SELECT SEC_TO_TIME(TIME_TO_SEC(NOW())), SEC_TO_TIME(36030);

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 10 HOUR), DATE_ADD(NOW(), INTERVAL 10 DAY), DATE_ADD(NOW(), INTERVAL '10_2' DAY_HOUR);
--           等同于现在加'00:05:00'                           等同于现在加'05:30:00' 等同于现在加'05:30:00'
SELECT NOW(), ADDTIME(NOW(), 500), ADDTIME(NOW(), '0:05:00'), ADDTIME(NOW(), '5:30'), ADDTIME(NOW(), 53000);
-- 2024-02-29减去现在的日期， 2024-02-29减去现在的时间                       公元100000天       今天是公元x天    这个月最后一天
SELECT DATEDIFF('2024-02-29', NOW()), TIMEDIFF('2024-02-10 00:00:00', NOW()), FROM_DAYS(100000), TO_DAYS(NOW()), LAST_DAY(NOW());
-- 2000年的第200天                             12进制
SELECT MAKEDATE(2000, 200), MAKETIME(8,30,24), PERIOD_ADD(1000000000, 12), PERIOD_ADD(1000000000, 13), PERIOD_ADD(1000000000, '13:30:24');

-- 3.7日期的格式化和解析
SELECT DATE_FORMAT(NOW(), '%Y*%M*%D'), DATE_FORMAT(NOW(), '%y %m %d'), DATE_FORMAT(NOW(), '%Y %b %e'), DATE_FORMAT('2023-12-11', '%Y %c %e');
GET_FORMAT();

SELECT TIME_FORMAT(CURTIME(), '%H %i %s'), TIME_FORMAT(CURTIME(), '%h %i %s'), TIME_FORMAT('05:05:05', '%k %i %s'), TIME_FORMAT('05:05:05', '%l %i %s');

-- 解析：格式化的逆过程
SELECT DATE_FORMAT(NOW(), '%Y %M %D %H %i %s - %W %w %T %r') FROM DUAL;
SELECT STR_TO_DATE('2023 December 11th 22 16 14 - Monday 1 22:16:14 10:16:14 PM', '%Y %M %D %H %i %s - %W %w %T %r');

SELECT GET_FORMAT(DATE, 'USA'), DATE_FORMAT(NOW(), GET_FORMAT(DATE, 'USA'));

-- P36 流程控制函数

SELECT IF('0' = '00', 'yes', 'no'), IFNULL(NULL, 'notNull');
-- case会返回第一个满足的值
SELECT CASE
	WHEN 1 > 0
	 THEN '1>0'
	WHEN 2 > 0
	 THEN '2>0'
	WHEN 1 > 2
	 THEN '1>2'
	WHEN 1>-1
	 THEN '1>-1'
	END;
-- case会返回第一个满足的值	
SELECT CASE 59
	WHEN 1
	THEN '1'
	WHEN 2
	THEN '2'
	WHEN 3
	THEN '3'
	WHEN 4
	THEN '4'
	WHEN 5
	THEN '5'
	WHEN 6
	THEN '6'
	WHEN 7
	THEN '7'
	WHEN 8
	THEN '8'
	ELSE 'Other'
	END;

-- 加密与解密函数
-- password() 8.0out
SELECT PASSWORD('ptbws+0509'), MD5('ptbws+0509'), SHA('ptbws+0509'), LENGTH(PASSWORD('ptbws+0509')), LENGTH(MD5('ptbws+0509')), LENGTH(SHA('ptbws+0509'));

SELECT SHA(MD5('ptbws+0509'));
-- 8.0out
SELECT ENCODE('xanadu', '123456789'), DECODE(ENCODE('xanadu', '123456789'), '12345678'), DECODE(ENCODE('xanadu', '123456789'), '12345679');

SELECT VERSION(), CONNECTION_ID(), DATABASE(), SCHEMA(), USER(),
 CURRENT_USER(), SYSTEM_USER(), SESSION_USER();
 
SELECT CHARSET('的實力法國海軍幾點看法');

SELECT COLLATION('hiujasdg');

-- 
-- practice 第七章 单行函数的练习
-- 1
SELECT NOW(), CURDATE(), CURTIME(), CONCAT(CURDATE(), ' ',  CURTIME());
SELECT SYSDATE(), CURRENT_TIMESTAMP(), LOCALTIME() , LOCALTIMESTAMP();
-- 2
SELECT employee_id, last_name, salary, salary*1.2 AS newSalary FROM employees;
-- 3
SELECT CONCAT(first_name, ' ', last_name), LENGTH(CONCAT(first_name,last_name)) AS last_len FROM employees ORDER BY first_name;
-- 4
SELECT ;
-- 5
SELECT DATE_FORMAT(NOW(),'%Y')-DATE_FORMAT(hire_date, '%Y') AS work_year,
	DATEDIFF(DATE_FORMAT(NOW(),'%Y-%m-%d'),hire_date) AS work_date
	FROM employees ORDER BY work_year;
	
-- 6
SELECT last_name, hire_date, department_id FROM employees WHERE DATE_FORMAT(hire_date, '%Y') >= 1997 AND department_id IN ('80', '90', '110') AND commission_pct IS NOT NULL;
-- 7
SELECT last_name, hire_date, DATEDIFF(NOW(), hire_date) AS checc FROM employees WHERE DATEDIFF(NOW(), hire_date) > 10000 ORDER BY checc;
-- 8
-- select 
-- 9
SELECT CASE job_id
	WHEN 'AD_PRES'  THEN 'A'
	WHEN 'ST_MAN'   THEN 'B'
	WHEN 'IT_PROG'  THEN 'C'
	WHEN 'SA_REP'   THEN 'D'
	WHEN 'ST_CLERK' THEN 'E'
	ELSE 'Z'
	END
	AS grade
	FROM employees;



SELECT * FROM jobs;
SELECT * FROM employees WHERE commission_pct IS NOT NULL;