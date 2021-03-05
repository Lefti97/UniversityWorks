-- 1o ERWTIMA
SELECT ENAME,SAL FROM EMP
WHERE DEPTNO = 10
ORDER BY SAL;
-- 2o ERWTIMA
SELECT ENAME,JOB,SAL FROM EMP
ORDER BY JOB, SAL DESC;
-- 3o ERWTIMA
SELECT ENAME,DEPTNO FROM EMP
WHERE DEPTNO = 10
ORDER BY COMM;

/*
APOTELESMATA
1o ERWTIMA
+---------+---------+
| ENAME   | SAL     |
+---------+---------+
| ELMASRI | 1200.00 |
| DATE    | 1800.00 |
| CODD    | 3000.00 |
+---------+---------+

2o ERWTIMA
+---------+------------+---------+
| ENAME   | JOB        | SAL     |
+---------+------------+---------+
| CODD    | ANALYST    | 3000.00 |
| ELMASRI | ANALYST    | 1200.00 |
| DATE    | PROGRAMMER | 1800.00 |
| NAVATHE | SALESMAN   | 2000.00 |
+---------+------------+---------+

3o ERWTIMA
+---------+--------+
| ENAME   | DEPTNO |
+---------+--------+
| CODD    |     10 |
| ELMASRI |     10 |
| DATE    |     10 |
+---------+--------+
*/