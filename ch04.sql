DESC EMP;

DESC DEPT;
DESC salgrade;
SELECT *FROM EMP;
SELECT EMPNO,DEPTNO FROM EMP;
SELECT DEPTNO FROM EMP;

--4_6 중복 컬럼의 값은 하나만 출력
SELECT DISTINCT DEPTNO FROM EMP;
SELECT DISTINCT JOB,DEPTNO FROM EMP;
--4_7 중복 처리 하지 않고 모두 출력
SELECT ALL DEPTNO,JOB FROM EMP;

SELECT COMM FROM EMP;
SELECT ENAME,SAL,SAL*12+COMM,COMM FROM EMP;

SELECT ENAME,SAL,SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+SAL+COMM,COMM FROM EMP;

SELECT ENAME,SAL,SAL*12+COMM AS ANNSAL,COMM FROM EMP;
--SAL*12+COMM ANNSAL
--SAL*12+COMM "ANNSAL"
--SAL*12+COMM AS ANNSAL
--SAL*12+COMM AS "ANNSAL"
--주로 AS를 붙여서 많이 사용한다 그 이유는 ""는 문자열의 시작과 끝을 알리는 기호로
--이미 많이 사용중이기 때문이다.
--자바에서 예를 들면
--String sql = "SELECT ENAME,SAL,SAL*12+COMM AS "ANNSAL",COMM FROM EMP";
--AS 까지 한 문장으로 인식하기 때문

SELECT * FROM EMP ORDER BY SAL;
--EMP 테이블의 모든 열을 급여 기준으로 오름차순 정렬
SELECT * FROM EMP ORDER BY EMPNO;

SELECT * FROM EMP ORDER BY SAL DESC;
--EMP 테이블의 모든 열을 급여 기준으로 내림차순 정렬
SELECT * FROM EMP ORDER BY HIREDATE ASC;
--4_14
SELECT * FROM EMP ORDER BY DEPTNO ASC,SAL DESC;
--DEPTNO를 1차로 기준해서 ASC,2차로 SAL을 기준으로 DESC(내림 차순)
--ORDER BY 는 제일 마지막 절로 사용( 즉 결과를 구한뒤에 그 결과를 정렬)


-- QUIZ

SELECT DISTINCT JOB FROM EMP;
--JOB 열 데이터를 중복없이 출력하기

SELECT EMPNO AS EMPLOYEE_NO,
       ENAME AS EMPLOYEE_NAME,
       JOB,
       MGR AS MANAGER,
       HIREDATE,
       SAL AS SALARY,
       COMM AS COMMISSION,
       DEPTNO AS DEPARTMENT_NO FROM EMP ORDER BY DEPTNO DESC,ENAME;