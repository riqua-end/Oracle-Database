
--6_1 Upper,LOWER,INITCAP 함수 사용하기
SELECT ENAME, UPPER(ENAME),LOWER(ENAME),INITCAP(ENAME) FROM EMP;

--6_2 UPPER 함수로 문자열 비교하기 (사원 이름이 SCOTT인 데이터 찾기
SELECT * FROM EMP WHERE UPPER(ENAME) = UPPER('ford');

--6_3 사원 이름에 SCOTT 단어를 포함한 데이터 찾기
SELECT * FROM EMP WHERE UPPER(ENAME) LIKE UPPER ('%ford%');

--6_4 LENGTH 함수 , 선택한 열의 문자열 길이 구하기
SELECT ENAME , LENGTH(ENAME) FROM EMP;

--6_5 WHERE 절에서 LENGTH 함수 이용하기
SELECT ENAME, LENGTH(ENAME) FROM EMP WHERE LENGTH(ENAME) >= 5;

--6_6 LENGTH 함수와 LENGTHB함수 비교하기
--dual에서는 SELECT의 문장이 제목으로 표시되고 그 결과 컬럼으로 표시
SELECT LENGTH('한글'),LENGTHB('한글') FROM DUAL;

--6_7 두번째 인자는 시작 위치(1부터 시작),세번째 인자는 개수
--세번째 없을 시는 2번째 시작 위치
-- SUBSTR(문자열 데이터,시작 위치,추출 길이)
SELECT JOB ,SUBSTR(JOB,1,2),SUBSTR(JOB,3,2),SUBSTR(JOB,5) FROM EMP;

--6_8 음수가 붙으면 역으로 함 (마지막이 -1 앞이 -2,-3..)
SELECT JOB, SUBSTR(JOB,-LENGTH(JOB)),
    SUBSTR(JOB,-LENGTH(JOB),2),
    SUBSTR(JOB,-3) FROM EMP;
    
--6_9
--INSTR([대상 문자열 데이터],[위치를 찾으려는 문자],[찾을 위치],[찾으려는 문자가 몇번째인지])
SELECT INSTR('HELLO,ORACLE!','L') AS INSTR_1,
        INSTR('HELLO,ORACLE!','L',5) AS INSTR_2,
        INSTR('HELLO,ORACLE!','L',2,2) AS INSTR_3 FROM DUAL;

--6_10 INSTR함수로 사원 이름에 문자 S가 있는 행 구하기
SELECT * FROM EMP WHERE INSTR(ENAME,'S') > 0;

--6_11
SELECT * FROM EMP WHERE ENAME LIKE '%S%';

--6_12 REPLACE 함수로 문자열 안에 있는 특정 문자 바꾸기
--DUAL사용시는 SELECT에서 사용한 값이 제목줄이고 그 값이 컬럼의 값이 되어 표시됨
SELECT '010-1234-5678' AS REPLACE_BEFORE,
    REPLACE('010-1234-5678','-',' ') AS REPLACE_1,
    REPLACE('010-1234-5678','-') AS REPLACE_2
    FROM DUAL;
    
--6_13 LPAD,RPAD 함수
SELECT 'ORACLE',
    LPAD('ORACLE',10,'#') AS LPAD_1,
    RPAD('ORACLE',10,'*') AS RPAD_1,
    LPAD('ORACLE',10) AS LPAD_2,
    RPAD('ORACLE',10) AS RPAD_2
FROM DUAL;

--6_14 개인정보 뒷자리 *로 표시하기
SELECT
    RPAD('971225-',14,'*') AS RPAD_JMNO,
    RPAD('010-1234-',13,'*') AS RPAD_PHONE
FROM DUAL;

--6_15 CONCAT 함수 두 열 사이에 콜론 넣고 연결하기
SELECT CONCAT(EMPNO,ENAME),
    CONCAT(EMPNO,CONCAT(':',ENAME)) --파라메터로 함수 사용 가능
FROM EMP WHERE ENAME = 'FORD';

--6_16 특정 문자를 지우는 TRIM,LTRIM,RTRIM
-- || 는 결합연산자 CONCAT이랑 같은 문자열 데이터를 연결
SELECT '[' || TRIM (' _ _ORACLE_ _ ') || ']' AS TRIM,
        '[' || TRIM(LEADING FROM ' _ _ORACLE_ _ ') || ']' AS TRIM_LEADING,
        '[' || TRIM(TRAILING FROM ' _ _ORACLE_ _ ') || ']' AS TRIM_TRAILING,
        '[' || TRIM(BOTH FROM ' _ _ORACLE_ _ ') || ']' AS TRIM_BOTH
    FROM DUAL;
    
--6_17
SELECT '[' || TRIM ('_' FROM '_ _ORACLE_ _') || ']' AS TRIM,
        '[' || TRIM (LEADING '_' FROM '_ _ORACLE_ _') || ']' AS TRIM_LEADING,
        '[' || TRIM (TRAILING '_' FROM '_ _ORACLE_ _') || ']' AS TRIM_TRAILING,
        '[' || TRIM (BOTH '_' FROM '_ _ORACLE_ _') || ']' AS TRIM_BOTH
    FROM DUAL;
    
--6_18 LTRIM,RTRIM
SELECT '[' || TRIM (' _ORACLE_ ') || ']' AS TRIM,
        '[' || LTRIM(' _ORACLE_ ') || ']' AS LTRIM,
        '[' || LTRIM('<_ORACLE_>' ,'_<') || ']' AS LTRIM_2,
        '[' || RTRIM(' _ORACLE_ ') || ']' AS RTRIM,
        '[' || RTRIM('<_ORACLE_>','>_') || ']' AS RTRIM_2
    FROM DUAL;
    
--6_19
SELECT ROUND(1234.5678) AS ROUND,
        ROUND(1234.5678,0) AS ROUND_0,
        ROUND(1234.5678,1) AS ROUND_1,
        ROUND(1234.5678,2) AS ROUND_2,
        ROUND(1234.5678,-1) AS ROUND_MINUS1,
        ROUND(1234.5678,-2) AS ROUND_MINUS2
    FROM DUAL;

--6_20
SELECT TRUNC(1234.5678) AS TRUNC,
        TRUNC(1234.5678, 0) AS TRUNC_0,
        TRUNC(1234.5678, 1) AS TRUNC_1,
        TRUNC(1234.5678, 2) AS TRUNC_2,
        TRUNC(1234.5678,-1) AS TRUNC_MINUS1,
        TRUNC(1234.5678,-2) AS TRUNC_MINUS2
    FROM DUAL;

--6_21
SELECT CEIL (3.14),
        FLOOR (3.14),
        CEIL (-3.14),
        FLOOR (-3.14)
    FROM DUAL;

--6_22
SELECT MOD(15,6),
        MOD(10,2),
        MOD(11,2)
    FROM DUAL;
    
--6_23 SYSDATE 함수를 사용하여 날짜 출력하기
SELECT SYSDATE AS NOW,
        SYSDATE-1 AS YESTERDAY,
        SYSDATE+1 AS TOMORROW
    FROM DUAL;

--6_24 ADD_MONTHS 함수 특정 날짜에 지정한 개월수 이후의 날짜 데이터를 반환
SELECT SYSDATE,
    ADD_MONTHS(SYSDATE,3)
    FROM DUAL;

--6_25
SELECT EMPNO,ENAME,HIREDATE,
    ADD_MONTHS(HIREDATE,120) AS WORK10YEAR
    FROM EMP;

--6_26
SELECT EMPNO,ENAME,HIREDATE,SYSDATE
    FROM EMP WHERE ADD_MONTHS(HIREDATE,500) > SYSDATE;
    
--6_27
SELECT EMPNO,ENAME,HIREDATE,SYSDATE,
        MONTHS_BETWEEN(HIREDATE,SYSDATE) AS MONTHS1,
        MONTHS_BETWEEN(SYSDATE,HIREDATE) AS MONTHS2,
        TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)) AS MONTH3
    FROM EMP;
    
--6_28 NEXT_DAY 는 돌아오는 요일 , LAST_DAY는 이 달의 마지막 날짜
SELECT SYSDATE,
        NEXT_DAY(SYSDATE,'월요일'),
        LAST_DAY(SYSDATE)
    FROM DUAL;
    
--6_31 
--숫자 + 숫자형 문자열은 숫자로 변경되어 연산
SELECT EMPNO,ENAME,EMPNO + '500'
    FROM EMP
WHERE ENAME = 'SMITH';

--6_32
--숫자 + 일반 문자열은 연산 안됨
SELECT 'ABCD' + EMPNO,EMPNO
    FROM EMP
WHERE ENAME = 'SMITH';

--6_33
--날짜를 지정한 문자열 형식으로 변환
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
    FROM DUAL;
    
--6_34
--날짜를 정해진 FORMAT의 문자열로 변환
SELECT SYSDATE,
       TO_CHAR(SYSDATE,'MM') AS MM,
       TO_CHAR(SYSDATE,'MON') AS MON,
       TO_CHAR(SYSDATE,'MONTH') AS MONTH,
       TO_CHAR(SYSDATE,'DD') AS DD,
       TO_CHAR(SYSDATE,'DY') AS DY,
       TO_CHAR(SYSDATE,'DAY') AS DAY
FROM DUAL;

--6_38
--숫자를 형식화된 문자열로 변경
SELECT SAL,
    TO_CHAR(SAL,'$999,999') AS SAL_$,
    TO_CHAR(SAL,'L999,999') AS SAL_L,
    TO_CHAR(SAL,'999,999.00') AS SAL_1,
    TO_CHAR(SAL,'000,999,999.00') AS SAL_2,
    TO_CHAR(SAL,'000999999.99') AS SAL_3,
    TO_CHAR(SAL,'999,999,00') AS SAL_4
FROM EMP;

--6_41
--숫자형 문자열이 아닌 문자열(숫자를 형식화된 문자열로 변환 한것들)을 숫자로 변환
--TO_NUMBER(문자열,형식)
SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,500','999,999')
FROM DUAL;

--6_42 to_date 함수로 문자 데이터를 날짜 데이터 변환하기
SELECT TO_DATE('2018-07-14','YYYY-MM-DD') AS TODATE1,
    TO_DATE('20180714','YYYY-MM-DD') AS TODATE2
    FROM DUAL;

--6_43
--DATE간 크기 비교 연산은 가능(늦은 날짜가 크다)
SELECT * FROM EMP WHERE HIREDATE > TO_DATE('1981/06/01','YYYY-MM-DD');

--6_45
--NVL함수에서 NULL이 아니면 원래값 반환,NULL이면 0
SELECT EMPNO,ENAME,SAL,COMM,SAL+COMM,
    NVL(COMM,0),
    SAL+NVL(COMM,0)
FROM EMP;

--6_46
SELECT EMPNO,ENAME,COMM,
    NVL2(COMM,'O','X'),
    NVL2(COMM,SAL*12+COMM,SAL*12) AS ANNSAL
FROM EMP;

--6_47 DECODE 함수를 사용하여 출력하기
--SELECT 절에는 컬럼명,함수호출,계산식 등이 올수 있음
SELECT EMPNO,ENAME,JOB,SAL,
    DECODE(JOB,
            'MANAGER',SAL*1.1,
            'SALESMAN',SAL*1.05,
            'ANALYST',SAL,
            SAL*1.03) AS UPSAL
    FROM EMP;
    
--6_48 CASE 함수를 사용하여 출력하기
--CASE ~ END문 방식
SELECT EMPNO,ENAME,JOB,SAL,
    CASE JOB
        WHEN 'MANAGER' THEN SAL*1.1
        WHEN 'SALESMAN' THEN SAL*1.05
        WHEN 'ANALYST' THEN SAL
        ELSE SAL*1.03
    END AS UPSAL
FROM EMP;

--6_49 CASE문에서 기준데이터를 정하지 않고 출력하기
SELECT EMPNO,ENAME,COMM,
    CASE
        WHEN COMM IS NULL THEN '해당 사항 없음'
        WHEN COMM = 0 THEN '수당없음'
        WHEN COMM > 0 THEN '수당 : ' || COMM
    END AS COMM_TEXT
FROM EMP;


--6_QUIZ
--Q1
SELECT EMPNO,ENAME,
    RPAD(EMPNO,2,'#') AS MASKING_EMPNO,
    RPAD(ENAME,1,'#') AS MASKING_ENAME
FROM EMP WHERE LENGTH(ENAME) = 5;