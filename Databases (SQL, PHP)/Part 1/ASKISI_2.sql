DROP DATABASE IF EXISTS new_personnel;
CREATE DATABASE new_personnel;
USE new_personnel;
CREATE TABLE DEPT(
	DEPTNO INT(2) NOT NULL,
	DNAME VARCHAR(14),
	LOC VARCHAR(14));
CREATE TABLE EMP(
	EMPNO INT(4) NOT NULL,
	ENAME VARCHAR(10),
	JOB VARCHAR(25),
	HIREDATE DATE,
	MGR INT(4),
	SAL FLOAT(7,2),
	COMM FLOAT(7,2),
	DEPTNO INT(2));
INSERT INTO DEPT VALUES
	(10,'ACCOUNTING','ATHENS'),
	(20,'SALES','LONDON'),
	(30,'RESEARCH','ATHENS'),
	(40,'PAYROLL','LONDON');
INSERT INTO EMP VALUES
	(10,'CODD','ANALYST','1989/01/01',15,3000,0,10),
	(15,'ELMASRI','ANALYST','1995/05/02',15,1200,150,10),
	(20,'NAVATHE','SALESMAN','1977/07/07',20,2000,0,20),
	(30,'DATE','PROGRAMMER','2004/05/04',15,1800,200,10);

/*
ΑΠΟΤΕΛΕΣΜΑΤΑ:

mysql> show tables;
+-------------------------+
| Tables_in_new_personnel |
+-------------------------+
| dept                    |
| emp                     |
+-------------------------+
2 rows in set (0.01 sec)

mysql> describe dept;
+--------+-------------+------+-----+---------+-------+
| Field  | Type        | Null | Key | Default | Extra |
+--------+-------------+------+-----+---------+-------+
| DEPTNO | int         | NO   |     | NULL    |       |
| DNAME  | varchar(14) | YES  |     | NULL    |       |
| LOC    | varchar(14) | YES  |     | NULL    |       |
+--------+-------------+------+-----+---------+-------+
3 rows in set (0.01 sec)

mysql> describe emp;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| EMPNO    | int         | NO   |     | NULL    |       |
| ENAME    | varchar(10) | YES  |     | NULL    |       |
| JOB      | varchar(25) | YES  |     | NULL    |       |
| HIREDATE | date        | YES  |     | NULL    |       |
| MGR      | int         | YES  |     | NULL    |       |
| SAL      | float(7,2)  | YES  |     | NULL    |       |
| COMM     | float(7,2)  | YES  |     | NULL    |       |
| DEPTNO   | int         | YES  |     | NULL    |       |
+----------+-------------+------+-----+---------+-------+
8 rows in set (0.01 sec)

mysql> select * from dept;
+--------+------------+--------+
| DEPTNO | DNAME      | LOC    |
+--------+------------+--------+
|     10 | ACCOUNTING | ATHENS |
|     20 | SALES      | LONDON |
|     30 | RESEARCH   | ATHENS |
|     40 | PAYROLL    | LONDON |
+--------+------------+--------+
4 rows in set (0.01 sec)

mysql> select * from emp;
+-------+---------+------------+------------+------+---------+--------+--------+
| EMPNO | ENAME   | JOB        | HIREDATE   | MGR  | SAL     | COMM   | DEPTNO |
+-------+---------+------------+------------+------+---------+--------+--------+
|    10 | CODD    | ANALYST    | 1989-01-01 |   15 | 3000.00 |   0.00 |     10 |
|    15 | ELMASRI | ANALYST    | 1995-05-02 |   15 | 1200.00 | 150.00 |     10 |
|    20 | NAVATHE | SALESMAN   | 1977-07-07 |   20 | 2000.00 |   0.00 |     20 |
|    30 | DATE    | PROGRAMMER | 2004-05-04 |   15 | 1800.00 | 200.00 |     10 |
+-------+---------+------------+------------+------+---------+--------+--------+
4 rows in set (0.00 sec)

*/