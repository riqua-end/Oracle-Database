
--7_1
SELECT SUM(SAL)
FROM EMP;

--7_2
--다중행 함수를 사용하는 SELECT절에는 여러 행의 값을 출력하는 컬럼이나 데이터는 사용 못함
SELECT ENAME ,SUM(SAL) FROM EMP;

--7_3
--ALL이 생략되어 있음 (기본값,중복값 포함)
--컬럼 값이 NULL은 제외하고 합산
SELECT SUM(COMM) --ALL COMM
FROM EMP;

--7_4
--선택 사항 DISTINCT는 중복은 한번만 합산 ALL 또는 생략은 중복 모두 합산
SELECT SUM(DISTINCT SAL),
        SUM(ALL SAL),
        SUM(SAL)
FROM EMP;

--7_5
--COUNT 대상 열을 *로 하면 NULL이 포함된 컬럼이 있더라도 COUNT 기본값 ALL로 처리
SELECT COUNT(*)
FROM EMP;

--7_6
--WHERE절로 조건을 줌
--30번 부서에서 근무하는 직원수 구하기
SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;

--7_7
--선택 사항 DISTINCT,ALL,생략 사용
SELECT COUNT(DISTINCT SAL),COUNT(ALL SAL),COUNT(SAL)
FROM EMP;

--7_8
--COMM컬럼에 NULL이 있는 행은 COUNT에서 제외
--단 *일시는 NULL도 카운트
SELECT COUNT(COMM)
FROM EMP;

--7_9
--조건절인 WHERE절에서 IS NOT NULL함수로 NULL아닌것만 선택하도록 제한
SELECT COUNT(COMM)
FROM EMP
WHERE COMM IS NOT NULL;

--7_10 10번 부서의 최대 급여
SELECT MAX(SAL)
FROM EMP
WHERE DEPTNO = 10;

--7_11 10번 부서의 최소 급여
SELECT MIN(SAL)
FROM EMP
WHERE DEPTNO = 10;

--7_12 부서번호가 20번인 사원의 입사일 중 제일 최근인 사람 구하기
SELECT MAX(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

--7_13 부서번호가 20번인 사원의 입사일 중 제일 오래된 사람 구하기
SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

--7_14 부서번호가 30번인 사원들의 평균 급여 구하기
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = 30;

--7_15
--DISTINCT 로 중복을 제거한 급여 열의 평균 구하기
SELECT AVG(DISTINCT SAL)
FROM EMP
WHERE DEPTNO = 30;

--7_16 집합 연산자 UNION ALL을 사용하여 DEPTNO별로 결합
--SELECT절에 데이터 값이 있으면 그 값을 출력
--select절에 값을 넣을시는 다중행 함수와 함께 사용
SELECT AVG(SAL),'10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION ALL
SELECT AVG(SAL),'20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION ALL
SELECT AVG(SAL),'30' AS DEPTNO FROM EMP WHERE DEPTNO = 30;

--7_17 GROUP BY를 사용해서 부서별 평균 급여 구하기
--GROUPBY에 있는 컬럼은 SELECT에서 다중행함수와 같이 사용 가능
SELECT AVG(SAL),DEPTNO
FROM EMP
GROUP BY DEPTNO;

--7_18 부서번호 및 직책별 평균 급여로 정렬하기
--GROUP BY의 값이 여러개 일시는 순서대로 그룹화 (대그룹,소그룹)
SELECT DEPTNO,JOB,AVG(SAL)
FROM EMP
GROUP BY DEPTNO,JOB
ORDER BY DEPTNO,JOB;

--7_19 GROUP BY 절 사용시 유의점
--GROUP BY절에 명시하지 않으면 SELECT절에 사용 할수 없음
SELECT ENAME,DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

--7_20
--HAVING절은 GROUPBY의 조건절임
--그룹화된 결과에 조건을 줌
--GROUP BY조건으로는 WHERE사용 안함
SELECT DEPTNO,JOB,AVG(SAL)
FROM EMP
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO,JOB;

--7_21
--WHERE 절에는 다중행 함수는 사용 못함
SELECT DEPTNO,JOB,AVG(SAL)
FROM EMP
WHERE AVG(SAL) >= 2000
GROUP BY DEPTNO,JOB
ORDER BY DEPTNO,JOB;

--7_22
SELECT DEPTNO,JOB,AVG(SAL)
FROM EMP
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) >=2000
ORDER BY DEPTNO,JOB;

--7_23
--WHERE절과 GROUP BY 절이 같이 있을시는 WHERE절이 먼저 실행되고 그 결과를 가지고
--GROUP BY절을 실행
SELECT DEPTNO,JOB,AVG(SAL)
FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO,JOB
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO,JOB;

--7_24
SELECT DEPTNO,JOB,COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL)
FROM EMP
GROUP BY DEPTNO,JOB
ORDER BY DEPTNO,JOB;

--7_25
--GROUP BY 의 값을 ROLLUP함수에 적어줌
--첫번째 GROUP BY 항목을 기준하여 각열의 그룹연산결과를 나타내는 행을 추가
--즉 표에서 소계란을 만들어 줌(소그룹 먼저 나중에 대그룹 소계를 표시)
SELECT DEPTNO,JOB,COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO,JOB);

--7_26
--CUBE는 ROLLUP과 유사하나 제 2의 그룹화 항목에 대한 연산 결과 소계란을 추가 해줌
SELECT DEPTNO,JOB,COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO,JOB)
ORDER BY DEPTNO,JOB;

--7_27
SELECT DEPTNO,JOB,COUNT(*)
FROM EMP
GROUP BY DEPTNO, ROLLUP(JOB);

--7_28
SELECT DEPTNO,JOB,COUNT(*)
FROM EMP
GROUP BY JOB, ROLLUP(DEPTNO);

--7_29
--GROUPING SETS(DEPTNO,JOB)는 GROUP BY뒤에 오며 모두 대그룹으로 처리
--대그룹 처리 항목이 아닌 다른 그룹 항목은 NULL으로 처리
SELECT DEPTNO,JOB,COUNT(*)
FROM EMP
GROUP BY GROUPING SETS(DEPTNO,JOB)
ORDER BY DEPTNO,JOB;

--7_30
--GROUPING()함수는 SELECT절에서 그룹화 된 여부를 나타냄(0은 그룹화됨,1은 안됨)
--ROLLUP이나 CUBE함수를 사용한 경우에 가능
SELECT DEPTNO,JOB,COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL),
    GROUPING(DEPTNO),GROUPING(JOB)
FROM EMP
GROUP BY CUBE(DEPTNO,JOB)
ORDER BY DEPTNO,JOB;

--7_31
SELECT DECODE(GROUPING(DEPTNO),1,'ALL_DEPT',DEPTNO) AS DEPTNO,
       DECODE(GROUPING(JOB),1,'ALL_JOB',JOB) AS JOB,
       COUNT(*),MAX(SAL),SUM(SAL),AVG(SAL)
    FROM EMP
GROUP BY CUBE(DEPTNO,JOB)
ORDER BY DEPTNO,JOB;
