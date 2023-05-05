
--9_1
SELECT SAL FROM EMP WHERE ENAME = 'JONES';

--JONES의 급여를 알아내어 그 급여보다 많은 레코드 출력
--9_2
SELECT * FROM EMP WHERE SAL > 2975;

--9_3
--서브쿼리로 JONES의 급여보다 높은 급여를 받는 사원 출력하기
--서브쿼리는 ()로 묶는다
--WHERE절의 비교 연산자 우측에 사용
--WHERE절의 좌항 컬럼과 우항의 컬럼명은 동일
SELECT * FROM EMP
    WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'JONES');

--9_4 서브쿼리의 결과 값이 날짜형인 경우
--DATE형도 비교 ㄱ능
--날짜 값이 적다는것은 빠른 날짜의 의미
--서브쿼리와 사용될수 있는 연산자는 비교 연산자
SELECT * FROM EMP
    WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'FORD');
    
--9_5
SELECT E.EMPNO,E.ENAME,E.JOB,E.SAL,D.DEPTNO,D.DNAME,D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 20
    AND E.SAL > (SELECT AVG(SAL) FROM EMP); --서브쿼리에서 단일값을 반환하는 다중행 함수 AVG사용
    --연산자는 단일값 끼리 비교하는 단일행 연산자
    
--9_6
SELECT * FROM EMP WHERE DEPTNO IN (20,30);
--IN연산자는 복수개의 값과 비교하는 연산자
--다중행 서브쿼리와 같이 사용 가능

--9_7
--다중행 함수 MAX를 사용하나 GROUP BY를 사용하므로 그룹별 MAX를 반환
--복수개의 값과 비교는 다중행 연산자 IN을 사용
--각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
SELECT * FROM EMP WHERE SAL IN (SELECT MAX(SAL)FROM EMP GROUP BY DEPTNO);

--9_8
SELECT MAX(SAL)
FROM EMP
GROUP BY DEPTNO;

--9_9
-- =ANY 연산자 사용하기
SELECT *
FROM EMP
WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--9_10
--SOME 연산자 사용하기
SELECT *
FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);

--9_11 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력하기
--DEPTNO30의 값들중 그 값보다 하나라도 적으면 TRUE
--최대값보다 적으면 TRUE
SELECT *
FROM EMP
WHERE SAL < ANY (SELECT SAL FROM EMP WHERE DEPTNO = 30)
ORDER BY SAL,EMPNO;

--9_12
-- 부서 번호가 30번인 사원들의 급여 출력
SELECT SAL
FROM EMP
WHERE DEPTNO = 30;

--9_13
--30번 부서 사원들의 최소 급여보다 많은 급여를 받는 사원 정보 출력하기
SELECT *
FROM EMP
WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30);

SELECT SAL FROM EMP WHERE DEPTNO = 30;

--9_14 ALL연산자 사용하여 출력
--부서번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원 출력하기
--ALL의 모든 결과보다 < 조건을 만족하려면 결과의 최소값 보다 적으면 모두 만족
SELECT *
FROM EMP
WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);

--9_15
--부서번호가 30번인 사원들의 최대 급여보다 더 많은 급여를 받는 사원 출력하기
-- ALL은 2850보다 큰 급여를 받는 사람들만 나옴
SELECT *
FROM EMP
WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);

--9_16 EXISTS 연산자는 서브쿼리에 결과 값이 하나 이상 존재하면 조건식이 모두 TRUE,존재하지 않으면 FALSE
SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

--9_17
--EXISTS 는 서브쿼리의 결과가 하나라도 있으면 TRUE
SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME FROM DEPT WHERE DEPTNO = 60);

--9_18 다중열 서브쿼리 사용하기
--서브쿼리의 결과가 2개 이상 컬럼을 가질때도 빕교 연산이 가능
--이때 메인쿼리의 비교 연산 대상에 (컬럼1,컬럼2..)사용
--이때 데이터형이 일치하고 순서도 일치
SELECT *
FROM EMP
WHERE (DEPTNO,SAL) IN (SELECT DEPTNO,MAX(SAL) FROM EMP GROUP BY DEPTNO);

--9_19 인라인 뷰
--서브쿼리를 FROM절 안에서 사용
--테이블처럼 간주하고 별칭을 주어 SELECT 절이나 WHERE절에서는 별칭으로 사용
SELECT E10.EMPNO,E10.ENAME,E10.DEPTNO,D.DNAME,D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
    (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

--9_20 WITH절을 이용하여 서브쿼리에 대한 별칭을 미리 지정
--별칭 AS (서브쿼리문)
--나머지 절에서는 별칭 이용
--FROM절에서 서브쿼리를 이용보다 깔끔
WITH
E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
D AS (SELECT * FROM DEPT)
SELECT E10.EMPNO,E10.ENAME,E10.DEPTNO,D.DNAME,D.LOC
FROM E10,D
WHERE E10.DEPTNO = D.DEPTNO;

--9_21
--SELECT절의 항목으로 서브쿼리 사용
--각각의 행에 대해 서브쿼리 실행값
SELECT EMPNO,ENAME,JOB,SAL,
    (SELECT GRADE
    FROM SALGRADE
    WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE,
    DEPTNO,
    (SELECT DNAME
    FROM DEPT
    WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
FROM EMP E; 