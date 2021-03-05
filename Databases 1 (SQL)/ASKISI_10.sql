-- PERSONNEL CREATOR
DROP DATABASE IF EXISTS personnel;
CREATE DATABASE personnel;
USE personnel;
CREATE TABLE DEPT(
	DEPTNO INT(2) NOT NULL,
	DNAME VARCHAR(15),
	PRIMARY KEY(DEPTNO));
CREATE TABLE JOB(
	JOBNO INT(3) NOT NULL,
	JOB VARCHAR(15),
	SAL FLOAT(7,2),
	PRIMARY KEY(JOBNO));
CREATE TABLE EMP(
	EMPNO INT(4) NOT NULL,
	ENAME VARCHAR(10),
	JOBCODE INT(3),
	DEPTNO INT(2),
	PRIMARY KEY(EMPNO),
	FOREIGN KEY(JOBCODE) REFERENCES JOB(JOBNO),
	FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO));
INSERT INTO DEPT VALUES
	(10, 'ACCOUNTING'),
	(20, 'SALES'),
	(30, 'PERSONNEL');
INSERT INTO JOB VALUES
	(100, 'DBA', 2500),
	(200, 'ANALYST', 2000);
INSERT INTO EMP VALUES
	(1000, 'SMITH', 100, 10),
	(2000, 'TOM', 200, 10),
	(300, 'JIM', 100, 20),
	(400, 'BOB', 200, 20);

-- 1o ERWTIMA
SELECT * FROM EMP,JOB,DEPT
WHERE EMP.JOBCODE = JOB.JOBNO
AND   EMP.DEPTNO  = DEPT.DEPTNO
ORDER BY JOB.JOB, EMP.ENAME;
-- 2o ERWTIMA
SELECT * FROM EMP,JOB,DEPT
WHERE EMP.JOBCODE = JOB.JOBNO
AND   EMP.DEPTNO  = DEPT.DEPTNO
AND DEPT.DNAME IN('ACCOUNTING','SALES')
ORDER BY JOB.JOB, EMP.ENAME;
-- 3o ERWTIMA
SELECT DNAME,COUNT(*) 'EMP_SUM' FROM DEPT,EMP
WHERE EMP.DEPTNO = DEPT.DEPTNO
GROUP BY EMP.DEPTNO
HAVING COUNT(*) >= 2;
-- 4o ERWTIMA
SELECT ENAME, DNAME, SAL FROM EMP,DEPT,JOB
WHERE EMP.DEPTNO = DEPT.DEPTNO AND EMP.JOBCODE = JOB.JOBNO
AND ( (substr(ENAME,2,1)='O') OR JOB.JOB='ANALYST' );
-- 5o ERWTIMA
SELECT ENAME FROM EMP,JOB
WHERE EMP.JOBCODE = JOB.JOBNO
AND ENAME != 'SMITH'
AND SAL = (
    SELECT SAL FROM EMP,JOB 
    WHERE EMP.JOBCODE = JOB.JOBNO
    AND ENAME = 'SMITH');
    
/*
APOTELESMATA
1o ERWTIMA
+-------+-------+---------+--------+-------+---------+---------+--------+------------+
| EMPNO | ENAME | JOBCODE | DEPTNO | JOBNO | JOB     | SAL     | DEPTNO | DNAME      |
+-------+-------+---------+--------+-------+---------+---------+--------+------------+
|   400 | BOB   |     200 |     20 |   200 | ANALYST | 2000.00 |     20 | SALES      |
|  2000 | TOM   |     200 |     10 |   200 | ANALYST | 2000.00 |     10 | ACCOUNTING |
|   300 | JIM   |     100 |     20 |   100 | DBA     | 2500.00 |     20 | SALES      |
|  1000 | SMITH |     100 |     10 |   100 | DBA     | 2500.00 |     10 | ACCOUNTING |
+-------+-------+---------+--------+-------+---------+---------+--------+------------+

2o ERWTIMA
+-------+-------+---------+--------+-------+---------+---------+--------+------------+
| EMPNO | ENAME | JOBCODE | DEPTNO | JOBNO | JOB     | SAL     | DEPTNO | DNAME      |
+-------+-------+---------+--------+-------+---------+---------+--------+------------+
|   400 | BOB   |     200 |     20 |   200 | ANALYST | 2000.00 |     20 | SALES      |
|  2000 | TOM   |     200 |     10 |   200 | ANALYST | 2000.00 |     10 | ACCOUNTING |
|   300 | JIM   |     100 |     20 |   100 | DBA     | 2500.00 |     20 | SALES      |
|  1000 | SMITH |     100 |     10 |   100 | DBA     | 2500.00 |     10 | ACCOUNTING |
+-------+-------+---------+--------+-------+---------+---------+--------+------------+

3o ERWTIMA
+------------+---------+
| DNAME      | EMP_SUM |
+------------+---------+
| ACCOUNTING |       2 |
| SALES      |       2 |
+------------+---------+

4o ERWTIMA
+-------+------------+---------+
| ENAME | DNAME      | SAL     |
+-------+------------+---------+
| TOM   | ACCOUNTING | 2000.00 |
| BOB   | SALES      | 2000.00 |
+-------+------------+---------+

5o ERWTIMA
+-------+
| ENAME |
+-------+
| JIM   |
+-------+
*/