DROP DATABASE IF EXISTS personnel;
CREATE DATABASE personnel;
USE personnel;
CREATE TABLE DEPT(
	DEPTNO INT(2) NOT NULL,
	DNAME VARCHAR(14),
	LOC VARCHAR(14),
	PRIMARY KEY(DEPTNO)
);
CREATE TABLE EMP(
	EMPNO INT(4) NOT NULL, 
	ENAME VARCHAR(10), 
	JOB VARCHAR(9),
	MGR INT(4), 
	HIREDATE DATE, 
	SAL FLOAT(7,2), 
	COMM FLOAT(7,2),
	DEPTNO INT(2),
	PRIMARY KEY(EMPNO),
	FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO)
);
INSERT INTO DEPT(DEPTNO, DNAME, LOC) VALUES
	(10, 'ACCOUNTING', 'NEW YORK'),
	(20, 'RESEARCH', 'DALLAS'),
	(30, 'SALES', 'CHICAGO'),
	(40, 'BOSTON', 'OPERATIONS');
INSERT INTO EMP VALUES
	(7369, 'SMITH', 'CLERK', 7902, '1980/12/17', 800, NULL, 20),
	(7499, 'ALLEN', 'SALESMAN', 7698, '1981/02/20', 1600, 300, 30),
	(7521, 'WARD', 'SALESMAN', 7698, '2002/02/01', 1250, 500, 30),
	(7566, 'JONES', 'MANAGER', 7839, '1981/12/24', 2975, NULL, 20),
	(7654, 'MARTIN', 'SALESMAN', 7698, '1981/10/28', 1250, 1400, 30),
	(7698, 'BLAKE', 'MANAGER', 7839, '2001/05/02', 2850, NULL, 30),
	(7782, 'CLARK', 'MANAGER', 7839, '1981/11/27', 2450, NULL, 10),
	(7788, 'SCOTT', 'ANALYST', 7566, '1987/04/29', 3000, NULL, 20),
	(7839, 'KING', 'PRESIDENT', NULL, '1987/11/12', 5000, NULL, 10),
	(7844, 'TURNER', 'SALESMAN', 7698, '2007/10/19', 1500, 0, 30),
	(7876, 'ADAMS', 'CLERK', 7788, '2003/05/07', 1100, NULL, 20),
	(7900, 'JAMES', 'CLERK', 7698, '2003/12/12', 950, NULL, 30),
	(7902, 'FORD', 'ANALYST', 7566, '2003/12/19', 3000, NULL, 20),
	(7934, 'MILLER', 'CLERK', 7782, '2003/01/19', 1300, NULL, 10),
	(7999, 'BATES', 'ANALYST', 7566, '2004/01/04', 1300, NULL, NULL);
-- ERWTHMA 1: 
SELECT AVG(SAL), MIN(SAL), MAX(SAL), SUM(SAL), COUNT(SAL), COUNT(COMM), COUNT(*)
FROM EMP WHERE JOB='ANALYST';
-- ERWTHMA 2:
SELECT DISTINCT JOB, DEPTNO
FROM EMP
WHERE DEPTNO IS NOT NULL
ORDER BY DEPTNO;
-- ERWTHMA 3:
SELECT ENAME, JOB, SAL FROM EMP
WHERE (JOB IN('ANALYST','PROGRAMMER'))
AND(SAL>=1000 AND SAL<=7000);


/*
APOTELESMATA!


ERWTHMA 1:

mysql> SELECT AVG(SAL), MIN(SAL), MAX(SAL), SUM(SAL), COUNT(SAL), COUNT(COMM), COUNT(*)
    -> FROM EMP WHERE JOB='ANALYST';
+-------------+----------+----------+----------+------------+-------------+----------+
| AVG(SAL)    | MIN(SAL) | MAX(SAL) | SUM(SAL) | COUNT(SAL) | COUNT(COMM) | COUNT(*) |
+-------------+----------+----------+----------+------------+-------------+----------+
| 2433.333333 |  1300.00 |  3000.00 |  7300.00 |          3 |           0 |        3 |
+-------------+----------+----------+----------+------------+-------------+----------+
1 row in set (0.00 sec)


ERWTHMA 2:

mysql> SELECT DISTINCT JOB, DEPTNO
    -> FROM EMP
    -> WHERE DEPTNO IS NOT NULL
    -> ORDER BY DEPTNO;
+-----------+--------+
| JOB       | DEPTNO |
+-----------+--------+
| CLERK     |     10 |
| MANAGER   |     10 |
| PRESIDENT |     10 |
| ANALYST   |     20 |
| CLERK     |     20 |
| MANAGER   |     20 |
| CLERK     |     30 |
| MANAGER   |     30 |
| SALESMAN  |     30 |
+-----------+--------+
9 rows in set (0.00 sec)


ERWTHMA 3:

mysql> SELECT ENAME, JOB, SAL FROM EMP
    -> WHERE (JOB IN('ANALYST','PROGRAMMER'))
    -> AND(SAL>=1000 AND SAL<=7000);
+-------+---------+---------+
| ENAME | JOB     | SAL     |
+-------+---------+---------+
| SCOTT | ANALYST | 3000.00 |
| FORD  | ANALYST | 3000.00 |
| BATES | ANALYST | 1300.00 |
+-------+---------+---------+
3 rows in set (0.00 sec)

*/
