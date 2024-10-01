
-- 
SHOW VARIABLES LIKE 'character_%';

-- 1.整型
CREATE DATABASE IF NOT EXISTS dbtest12 CHARACTER SET 'utf8';
USE dbtest12;

CREATE TABLE IF NOT EXISTS test_int1(
f1 TINYINT,
f2 SMALLINT,
f3 MEDIUMINT,
f4 INT,
f5 BIGINT
) CHARACTER SET 'utf8';

DESC test_i`information_schema`nt1;
SELECT * FROM test_int1;

-- 2.无符号类型
CREATE TABLE test_int3(
f1 INT UNSIGNED
);

DESC test_int3;
SHOW CREATE TABLE test_int3;

INSERT INTO test_int3 VALUES (156), (0);
INSERT INTO test_int3 VALUES (257);
SELECT * FROM test_int3;

-- 3.浮点型 FLOAT DOUBLE REAL
CREATE TABLE IF NOT EXISTS test_double1 (
f1 FLOAT,
f2 FLOAT(5,2),
f3 DOUBLE,
f4 DOUBLE(5,2)
);

DESC test_double1;
-- 小数位超了，会自动四舍五入
INSERT INTO test_double1(f1,f2) VALUES (1.1, 1.2), (111,123);
INSERT INTO test_double1(f1,f2) VALUES (12345.123, 123);
INSERT INTO test_double1(f1,f2) VALUES (12.645312, 13.541451312);
SELECT * FROM test_double1;

INSERT INTO test_double1(f3, f4) VALUES (1.52, 5.2), (-5.1, -10), (-1, -12.3);
INSERT INTO test_double1(f3, f4) VALUES (12345.123, 123);
INSERT INTO test_double1(f3, f4) VALUES (12.645312, 13.541451312);
INSERT INTO test_double1(f3, f4) VALUES (999.5, 999.9944);

CREATE TABLE IF NOT EXISTS test_double2(
f1 DOUBLE
);

DESC test_double2;

INSERT INTO test_double2 VALUES (0.47), (0.44), (0.19);
SELECT * FROM test_double2;
-- 计算错误，出现精度问题
SELECT SUM(f1) FROM test_double2;

-- 介绍定点数 Decimal(M,D)
-- 4.定点类型

CREATE TABLE IF NOT EXISTS test_decimal1(
f1 DEC,
f2 NUMERIC(5, 2)
);

DESC test_decimal1;

INSERT INTO test_decimal1(f1) VALUES (123.45);

SELECT * FROM test_decimal1;;

INSERT INTO test_decimal1(f2) VALUES (999.994);

INSERT INTO test_decimal1(f2) VALUES (0.47), (0.44), (0.19);
-- 没有出现精度问题，说明比较精准
SELECT SUM(f2) FROM test_decimal1 WHERE f2 < 1;;

-- 5.位类型
CREATE TABLE IF NOT EXISTS test_bit1(
f1 BIT,
f2 BIT(5),
f3 BIT(64)
);

DESC test_bit1;

INSERT INTO test_bit1(f1) VALUES (1), (0);

SELECT * FROM test_bit1;

USE mysql;
SELECT USER,PASSWORD,HOST FROM USER;
SELECT * FROM USER;
SELECT `user`,`password`,`host` FROM USER;
*A365222F2CD96BEFA43B3CDDCCE7EADF770CDAF8;
SELECT PASSWORD('');

USE dbtest12;

SELECT * FROM test_bit1;

-- 6.日期与时间类型
CREATE TABLE IF NOT EXISTS test_year1(
f1 YEAR,
f2 YEAR(4)

);

DESC test_year1;

INSERT INTO test_year1(f2) VALUES (0);

SELECT * FROM test_year1;
TRUNCATE test_year1;
INSERT INTO test_year1(f2) VALUES ('00');

-- 00-69代表2000-2069, 70-99代表1970-1999

-- date type
CREATE TABLE IF NOT EXISTS test_date1(
f1 DATE
);

DESC test_date1;

INSERT INTO test_date1 VALUES ('2020-10-01'), ('20201002'), (20201003);

SELECT * FROM test_date1;

INSERT INTO test_date1 VALUES ('00-01-01'), ('000101'), ('69-12-31'), ('70-01-01'), ('700102'), ('991231');

INSERT INTO test_date1 VALUES (000228),(691230),(700102),(991230);

INSERT INTO test_date1 VALUES (CURDATE()), (CURRENT_DATE()), (NOW());

-- time type 
CREATE TABLE IF NOT EXISTS test_time1(
f1 TIME
);

DESC test_time1;

INSERT INTO test_time1 VALUES (CURRENT_TIME()), (NOW());

SELECT * FROM test_time1;

INSERT INTO test_time1 VALUES ('2 12:30:29'), ('12:35:29'), ('123529'), ('1240'), ('2 12:40'), ('1 05'), ('45');

INSERT INTO test_time1 VALUES ('12:40');

INSERT INTO test_time1 VALUES ('123520'), (124011), (1210);

INSERT INTO test_time1 VALUES ('34 22:59:59');

INSERT INTO test_time1 VALUES ('839:00:00');

-- 6.4 datetime type
CREATE TABLE IF NOT EXISTS test_dt1(
f1 DATETIME
);

DESC test_dt1;

INSERT INTO test_dt1 VALUES (NOW()), (CONCAT(CURRENT_DATE(),' ', CURRENT_TIME()));

SELECT * FROM test_dt1;

INSERT INTO test_dt1 VALUES ('691231235959'),(700101000000);

INSERT INTO test_dt1 VALUES (19991231235958);

INSERT INTO test_dt1 VALUES ('2024-02-29 23:59:59');


-- timestamp type
CREATE TABLE IF NOT EXISTS test_ts1(
ts TIMESTAMP
);

DESC test_ts1;

INSERT INTO test_ts1 VALUES  ('1999-01-01 03:04:50'), ('19990101030405'), ('990101030405'), ('99-01-01 03:04:05');

SELECT * FROM test_ts1;

INSERT INTO test_ts1 VALUES  ('1999@10@24@23@59@#29');

INSERT INTO test_ts1 VALUES  ('2038-01-19 03:15:07');

CREATE TABLE IF NOT EXISTS temp_time(
d1 DATETIME,
d2 TIMESTAMP
);

INSERT INTO temp_time VALUES (NOW(), NOW());

SELECT * FROM temp_time;

SET time_zone = '+08:00';


-- 7.字符串类型
-- char type
CREATE TABLE IF NOT EXISTS test_char1(
c1 CHAR,
c2 CHAR(5)
);

DESC test_char1;

INSERT INTO test_char1(c1) VALUES ('a'), (1), ('');

INSERT INTO test_char1(c1) VALUES ('文');

SELECT * FROM test_char1;

INSERT INTO test_char1(c2) VALUES ('1234');

INSERT INTO test_char1(c2) VALUES ('文');

SELECT CONCAT(c2, '555') FROM test_char1; 

-- varchar type
CREATE TABLE IF NOT EXISTS test_varchar1(
v1 VARCHAR(1),
v2 VARCHAR(5),
v3 VARCHAR(20000)
);

SELECT * FROM test_varchar1;
INSERT INTO test_varchar1(V1) VALUES ('a'), (1), ('');

INSERT INTO test_varchar1(V1) VALUES ('文1');

INSERT INTO test_varchar1(v2) VALUES ('1234');

INSERT INTO test_varchar1(v2) VALUES ('     ');

SELECT CONCAT(v2, '***') FROM test_varchar1;

-- text type
CREATE TABLE IF NOT EXISTS test_text(
tx TEXT
);

INSERT INTO test_text VALUES ('1'), (''), (' '), ('123   ');
INSERT INTO test_text VALUES ('比花花解语1');

SELECT * FROM test_text;

SELECT CONCAT(tx, '|') FROM test_text;

SELECT CHAR_LENGTH(tx) FROM test_text;

-- 8.enum type
CREATE TABLE test_enum(
season ENUM('Spring','Summer','Autumn','Winter','Unknown')
);


DESC test_enum;

SELECT * FROM test_enum;

INSERT INTO test_enum VALUES ('123');
INSERT INTO test_enum VALUES ('Spring');
-- 输入数字，会插入对应下标的枚举选项
INSERT INTO test_enum VALUES (1), ('3'), (5);

INSERT INTO test_enum VALUES (NULL);
INSERT INTO test_enum VALUES ('');

-- 9. set type
CREATE TABLE test_set(
s SET('January','February', 'March', 'April', 'May', 'June', 
'July', 'August', 'September', 'October', 'November', 'December')
);

DESC test_set;

SELECT * FROM test_set;

INSERT INTO test_set VALUES ('January'), ('july');

INSERT INTO test_set VALUES ('June,July,December,January');

INSERT INTO test_set VALUES ('June,July,July,July');
INSERT INTO test_set VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);

-- 10.二进制字符串

-- Binary and varBinary

CREATE TABLE IF NOT EXISTS test_bin1(
f1 BINARY,
f2 BINARY(3),
#f3 varbinary,
f4 VARBINARY(10)
);

DESC test_bin1;

INSERT INTO test_bin1(f1,f2) VALUES ('a', 'abc');

INSERT INTO test_bin1(f2,f4) VALUES ('ab', 'ab');

SELECT * FROM test_bin1;
-- f2的长度都是3
SELECT LENGTH(f2), LENGTH(f4) FROM test_bin1;

CREATE TABLE IF NOT EXISTS test_blob(
id INT,
img MEDIUMBLOB
);

DESC test_blob;

SELECT * FROM test_blob;

INSERT INTO test_blob(id) VALUES (1001);

-- 12.Json
CREATE TABLE IF NOT EXISTS test_json(
js JSON
);

DESC test_json;

INSERT INTO test_json VALUES ('{"name":"Tom", "age":18, "address":{"province":"jiangsu", "city":"wuxi"}}');

SELECT * FROM test_json;

SELECT js -> '$.name' AS `name`, js -> '$.address.city' AS city FROM test_json;



-- 总结


1. TINYINT SMALLINT MEDIUMINT INT BIGINT  
2. UNSIGNED
3. FLOAT DOUBLE DECIMAL 
5. BIT
6. DATE TIME YEAR DATETIME TIMESTAMP
7. CHAR VARCHAR TINYTEXT TEXT MEDIUMTEXT LONGTEXT
8. ENUM
9. SET
10. BINARY VARBINARY
11. TINYBLOB BLOB MEDIUMBLOB LONGBLOB
12. JSON