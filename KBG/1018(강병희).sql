/*점검문제 1번*/
select 제품명,
		sum(주문수량) as 주문수량합,
        sum(주문세부.단가 * 주문수량) as 주문금액합
from 제품
left join 주문세부
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

/*점검문제 3번*/
select 제품.제품명,
		sum(주문세부.주문수량) as 주문수량합
from 제품
left outer join 주문세부
on 제품.제품번호 = 주문세부.제품번호
group by 제품명;

select 제품.제품명,
		sum(주문세부.주문수량) as 주문수량합
from 주문세부
right outer join 제품
on 제품.제품번호 = 주문세부.제품번호
group by 제품명;

/*점검문제 4*/
select 고객번호,
        고객회사명,
        담당자명,
        등급명,
        마일리지
from 고객
left join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
where 등급명 = 'A';

select 고객번호,
        고객회사명,
        담당자명,
        등급명,
        마일리지
from 고객, 마일리지등급
where 등급명 = 'A' and  마일리지 between 하한마일리지 and 상한마일리지;

/*실습문제 1*/
select 등급명,
		count(고객번호) as 고객수
from 마일리지등급
inner join 고객
on 마일리지 between 하한마일리지 and 상한마일리지
group by 등급명;

/*실습문제2번*/
select *
from 고객, 주문
where 주문.주문번호 = 'H0249' AND 고객.고객번호 = 주문.고객번호;

/*실습문제3번*/
select *
from 고객, 주문
where 주문.주문일 = '2020-04-09' AND 고객.고객번호 = 주문.고객번호;

select *
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
where 주문.주문일 = '2020-04-09' AND 고객.고객번호 = 주문.고객번호;

/*실습문제4번*/
select 도시,
		sum(단가 * 주문수량 ) as 주문금액합
from 고객, 주문, 주문세부
where 고객.고객번호 = 주문.고객번호 AND 주문.주문번호 = 주문세부.주문번호
group by 도시
order by 주문금액합 desc
limit 5;

select 도시,
		sum(단가 * 주문수량 ) as 주문금액합
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
inner join 주문세부
on 주문세부.주문번호 = 주문.주문번호
where 고객.고객번호 = 주문.고객번호 AND 주문.주문번호 = 주문세부.주문번호
group by 도시
order by 주문금액합 desc
limit 5;