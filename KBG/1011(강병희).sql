select 부서.부서번호,
		부서명,
        이름,
        사원.부서번호
from 부서,
	사원
where 이름 = '배재용';

select 부서.부서번호,
		부서명,
        이름,
        사원.부서번호
from 사원
cross join 부서
where 이름 = '배재용';

select 사원번호,
		직위,
        사원.부서번호,
        부서명
from 사원
inner join 부서
on 사원.부서번호 = 부서.부서번호
where 이름 = '이소미';

select 사원번호,
		직위,
        사원.부서번호,
        부서명
from 사원,부서
where 사원.부서번호 = 부서.부서번호
and 이름 = '이소미';

select 고객.고객번호,
		담당자명,
        고객회사명,
        count(*) as 주문건수
from 고객, 주문
where 고객.고객번호 = 주문.고객번호
group by 고객.고객번호,
			담당자명,
            고객회사명
order by count(*) desc;

/*점검문제 1번*/
select 제품명,
		sum(주문수량) as 주문수량합,
        sum(주문세부.단가 * 주문수량) as 주문금액합
from 제품, 주문세부
where 제품.제품번호 = 주문세부.제품번호
group by 제품명
order by 제품명;

select 제품명,
		sum(주문수량) as 주문수량합,
        sum(주문세부.단가 * 주문수량) as 주문금액합
from 제품
join 주문세부
on 제품.제품번호 = 주문세부.제품번호
group by 제품명;

/*점검문제 2번*/
select year(주문일) as 주문년도,
		제품명,
		sum(주문수량) as 주문수량합
from 주문, 제품, 주문세부
where 주문.주문번호 = 주문세부.주문번호 AND 주문세부.제품번호 = 제품.제품번호 
AND 제품명 LIKE '%아이스크림%'
group by 주문년도, 제품명;

select year(주문일) as 주문년도,
		제품명,
		sum(주문수량) as 주문수량합
from 주문
inner join 주문세부
on 주문.주문번호 = 주문세부.주문번호
inner join 제품
on 주문세부.제품번호 = 제품.제품번호
where 제품명 LIKE '%아이스크림%'
group by 주문년도, 제품명;

/*실습문제2번*/
select *
from 고객, 주문
where 주문.주문번호 = 'H0249' AND 고객.고객번호 = 주문.고객번호;

/*실습문제3번*/
select *
from 고객, 주문
where 주문.주문일 = '2020-04-09' AND 고객.고객번호 = 주문.고객번호;

/*실습문제4번*/
select 도시,
		sum(단가 * 주문수량 ) as 주문금액합
from 고객, 주문, 주문세부
where 고객.고객번호 = 주문.고객번호 AND 주문.주문번호 = 주문세부.주문번호
group by 도시
order by 주문금액합 desc
limit 5;