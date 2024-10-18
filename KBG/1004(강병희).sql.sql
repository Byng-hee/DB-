select count(*),
		count(고객번호),
        count(도시),
        count(지역)
from 고객;

select sum(마일리지),
		AVG(마일리지),
        MIN(마일리지),
        max(마일리지)
from 고객;

select 도시,
		count(*) as 고객수,
		avg(마일리지) as 평균마일리지
from 고객
group by 도시;

select 담당자직위,
		도시,
		count(*) as 고객수,
		avg(마일리지) as 평균마일리지
from 고객
group by 담당자직위, 도시
order by 1, 2;

select 도시,
		count(*) as 고객수,
		avg(마일리지) as 평균마일리지
from 고객
group by 도시
HAVING count(*) >= 10;

SELECT 도시,
       SUM(마일리지) AS 마일리지
FROM 고객
WHERE 고객번호 LIKE 'T%'
GROUP BY 도시
HAVING SUM(마일리지) >= 1000;

/*점검문제 1번*/
select count(도시),
		count(distinct 도시)
from 고객;

/*점검문제 2번*/
select year(주문일) as 주문년도,
		count(*) as 주문건수
from 주문
group by year(주문일);

/*점검문제 4번*/
select month(주문일) 주문월,
		count(*) as 주문건수
from  주문
where datediff(요청일, 발송일) < 0
group by 주문월
order by 주문월;

/*점검문제 3번*/
select year(주문일) as 주문년도,
		quarter(주문일) as 분기,
        count(*) as 주문건수
from 주문
group by 주문년도, 분기
with rollup;

/*점검문제 5번*/
select 제품명,
		sum(재고) as 재고합
from 제품
/*where 제품명 LIKE '%아이스크림'
where instr(제품명, '아이스크림') > 0*/
where substring_index(제품명, ' ', -1) = '아이스크림'
group by 제품명;

/*점검문제 6번*/
select /*case when 마일리지>=50000 then 'vip고객'
			else '일반고객'
		end 고객구분,*/
        if(마일리지>=50000, 'vip고객', '일반고객')  as 고객구분,
		count(고객번호) as 고객수,
		avg(마일리지) as 평균마일리지
from 고객
group by 고객구분;

/*실습문제1번*/
select 제품번호, 
		SUM(주문수량) as 주문수량합,
        SUM(단가 * 주문수량) as 주문금액합
from 주문세부
group by 제품번호;

/*실습문제2번*/
select 주문번호, 
		group_concat(제품번호) as 제품번호목록,
        SUM(단가 * 주문수량) as 주문금액합
from 주문세부
group by 주문번호;

/*실습문제3번*/
select 고객번호, 
		count(*) as 주문건수
from 주문
where year(주문일) = 2021
group by 고객번호
ORDER BY 주문건수 DESC
LIMIT 3;

/*실습문제4번*/
select 직위, 
		count(*) as 사원수,
        group_concat(이름)  as 사원이름
from 사원
group by 직위