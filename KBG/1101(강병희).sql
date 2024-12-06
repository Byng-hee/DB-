#1
select 고객번호, 고객회사명, 담당자명, 담당자직위, 도시, 마일리지
from 고객
where 도시 Like '%광역시%' or 도시 Like '%특별시%'
order by 마일리지
limit 3;

#2
select 제품번호, 제품명, 단가, 재고, 재고*단가 as 재고금액
from 제품
order by 재고금액 desc
limit 10;


#3
select 이름, 생일, timestampdiff(YEAR, 생일, now()) as 만나이, 입사일, datediff(now(), 입사일)as 입사일수
from 사원
where datediff(생일, '1980-01-01') >= 0;

#4
select 제품번호, 제품명, 재고 , if(재고>=10, if(재고>=100,'과다재고','적정'),'재고부족') as 재고구분
from 제품
where 재고 >= 10;

#5
select year(주문일) as 주문년도,
		quarter(주문일) as 주문분기,
        count(주문일) as 주문건수
from 주문
group by 주문년도, 주문분기
with rollup;

#6
select 주문번호, group_concat(제품번호), sum(주문수량*단가) as 주문금액
from 주문세부
group by 주문번호;

#7
select 제품명, sum(주문수량) as 주문수량합
from 제품
left outer join 주문세부
on 제품.제품번호 = 주문세부.제품번호
group by 제품명
having 주문수량합 >= 1000
order by 주문수량합;

#8
select 고객.*, 주문.주문번호
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
where 주문번호 = 'H0249';

#9
select 제품명, 제품.단가, sum(주문세부.주문수량) as 주문수량합
from 제품
inner join 주문세부
on 제품.제품번호 = 주문세부.제품번호
group by 제품명, 2
order by 제품.단가 desc
limit 1;

select sum(주문수량) as 주문수량합
from 주문세부
where 제품번호 = (select 제품번호
			from 제품
            order by 단가 desc
            limit 1);

select sum(주문수량) as 주문수량합
from 주문세부
where 제품번호 = (select 제품번호
			from 제품
            where 단가 = (select Max(단가)
						from 제품
                        )
            );

#10
select year(주문일) as 주문년도, count(주문일) as 주문건수
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
where 도시 in ('서울특별시', '광주광역시')
group by 주문년도;

select year(주문일) as 주문년도, count(주문일) as 주문건수
from 주문
where 고객번호 in (select 고객번호
			from 고객
			where 도시 in ('서울특별시', '광주광역시') )
group by 주문년도;



select 고객번호,
		고객회사명,
        담당자명,
        마일리지
from 고객
where 마일리지 = (select max(마일리지)
				from 고객
                );
                
select 고객회사명, 담당자명
from 고객
where 고객번호 = (select 고객번호
				from 주문
                where 주문번호 = 'H0250'
                );
                
select 고객회사명, 담당자명
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
where 주문번호 = 'H0250';

select 담당자명,
		고객회사명,
		마일리지
from 고객
where 마일리지 > (select MIN(마일리지)
				from 고객
                where 도시 ='부산광역시');

select count(*) as 주문건수
from 주문
where 고객번호 in (select 고객번호
				from 고객
				where 도시 = '부산광역시');
                
select 담당자명,
		고객회사명,
        마일리지
from 고객
where 마일리지 > any(select 마일리지
					from 고객
                    where 도시 = '부산광역시'
                    );
                    
select 담당자명, 고객회사명, 마일리지
from 고객
where 마일리지 > all (select avg(마일리지)
					from 고객
					group by 지역);

select 고객번호,
		고객회사명
from 고객
where exists (select *
			from 주문
            where 고객번호 = 고객.고객번호);
            
select 고객번호, 고객회사명
from 고객
where 고객번호 in (select distinct 고객번호
				from 주문
				)
                
select count(*)
from 고객
where 마일리지 > any (select 마일리지
					from 고객
                    where 도시 = '부산광역시');
                    
select count(*)
from 고객
where 마일리지 > all (select 마일리지
					from 고객
                    where 도시 = '부산광역시');

select count(*)
from 고객
where 마일리지 >  (select MAX(마일리지)
					from 고객
                    where 도시 = '부산광역시');

select count(*)
from 고객
where 마일리지 > (select MIN(마일리지)
					from 고객
                    where 도시 = '부산광역시');

select 도시,
		avg(마일리지) as 평균마일리지
from 고객
group by 도시
having avg(마일리지) > (select avg(마일리지)
					from 고객
                    );
                    
select 담당자명,
		고객회사명,
        마일리지,
        고객.도시,
        도시_평균마일리지,
        도시_평균마일리지 - 마일리지 as 차이
from 고객,
	(select 도시, avg(마일리지) as 도시_평균마일리지
		from 고객
        group by 도시) as 도시별요약
where 고객.도시 = 도시별요약.도시;


/*점검문제 3*/
select 담당자명, 고객회사명, 주문건수, 최초주문일, 최종주문일
from 고객,(select 고객번호, count(*) as 주문건수,min(주문일) as 최초주문일, max(주문일) as 최종주문일
			from 주문
            group by 고객번호) as 주문요약
where 고객.고객번호 = 주문요약.고객번호;