-- 1o ERWTIMA
SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(*)>=1;
-- 2o ERWTIMA
SELECT DEPTNO, format(AVG(datediff(current_date,hiredate)/365),1) 'PROYPHRESIA (ETI)'
FROM EMP
GROUP BY DEPTNO;

/*
APOTELESMATA
1o ERWTIMA
+--------+-------------+
| DEPTNO | AVG(SAL)    |
+--------+-------------+
|     10 | 2000.000000 |
|     20 | 2000.000000 |
+--------+-------------+

2o ERWTIMA
+--------+-------------------+
| DEPTNO | PROYPHRESIA (ETI) |
+--------+-------------------+
|     10 | 24.2              |
|     20 | 42.9              |
+--------+-------------------+
*/