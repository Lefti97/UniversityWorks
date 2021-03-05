-- ERWTIMA 1o
SELECT 
ENAME
,concat(format(SAL,0),' $') 'MISTHOS'
,ifnull(COMM,'') 'PROMITHEIA'
,concat(format((ifnull(COMM,0)/SAL)*100,2),' %') 'POSOSTO'
FROM EMP;
-- ERWTIMA 2o
SELECT 
ENAME 'EPWNYMO'
,concat(format(SAL+ifnull(COMM,0),0),' $') 'MHNIAIES APODOXES'
,concat(format(datediff(current_date,hiredate)/365,0),' ETH') 'PROYPHRESIA'
FROM EMP WHERE datediff(current_date,hiredate)/365 > 20;
-- ERWTIMA 3o
SELECT
ENAME 'EPWNYMO'
,JOB 'THESI'
,HIREDATE 'PROSLIPSI'
FROM EMP 
WHERE 
(JOB IN('ANALYST','SALESMAN'))
AND 
(convert(substring(HIREDATE,9,2),signed) <= 5);

/*
APOTELESMATA

mysql> -- ERWTIMA 1o
mysql> SELECT
    -> ENAME
    -> ,concat(format(SAL,0),' $') 'MISTHOS'
    -> ,ifnull(COMM,'') 'PROMITHEIA'
    -> ,concat(format((ifnull(COMM,0)/SAL)*100,2),' %') 'POSOSTO'
    -> FROM EMP;
+---------+---------+------------+---------+
| ENAME   | MISTHOS | PROMITHEIA | POSOSTO |
+---------+---------+------------+---------+
| CODD    | 3,000 $ |            | 0.00 %  |
| ELMASRI | 1,200 $ | 150.00     | 12.50 % |
| NAVATHE | 2,000 $ |            | 0.00 %  |
| DATE    | 1,800 $ | 200.00     | 11.11 % |
+---------+---------+------------+---------+
4 rows in set (0.00 sec)

mysql> -- ERWTIMA 2o
mysql> SELECT
    -> ENAME 'EPWNYMO'
    -> ,concat(format(SAL+ifnull(COMM,0),0),' $') 'MHNIAIES APODOXES'
    -> ,concat(format(datediff(current_date,hiredate)/365,0),' ETH') 'PROYPHRESIA'
    -> FROM EMP WHERE datediff(current_date,hiredate)/365 > 20;
+---------+-------------------+-------------+
| EPWNYMO | MHNIAIES APODOXES | PROYPHRESIA |
+---------+-------------------+-------------+
| CODD    | 3,000 $           | 31 ETH      |
| ELMASRI | 1,350 $           | 25 ETH      |
| NAVATHE | 2,000 $           | 43 ETH      |
+---------+-------------------+-------------+
3 rows in set (0.00 sec)

mysql> -- ERWTIMA 3o
mysql> SELECT
    -> ENAME 'EPWNYMO'
    -> ,JOB 'THESI'
    -> ,HIREDATE 'PROSLIPSI'
    -> FROM EMP
    -> WHERE
    -> (JOB IN('ANALYST','SALESMAN'))
    -> AND
    -> (convert(substring(HIREDATE,9,2),signed) <= 5);
+---------+---------+------------+
| EPWNYMO | THESI   | PROSLIPSI  |
+---------+---------+------------+
| CODD    | ANALYST | 1989-01-01 |
| ELMASRI | ANALYST | 1995-05-02 |
+---------+---------+------------+
2 rows in set (0.00 sec)
*/