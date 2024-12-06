select 고객.고객번호,
				고객회사명
from 고객
where 고객번호 IN (select distinct 주문.고객번호
				from 주문);
                
select distinct 고객.고객번호,
				고객회사명
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
order by 1;

select 고객번호,
		고객회사명
from 고객
where exists (select *
			from 주문
			where 고객번호 = 고객.고객번호);

select 사원번호,
		이름,
        상사번호,
        (select 이름
		from 사원 as 상사
		where 상사.사원번호 = 사원.상사번호) as 상사이름
from 사원;

select 도시,
		담당자명,
        고객회사명,
        마일리지
from 고객
where (도시, 마일리지) in (select 도시, MAX(마일리지)
						from 고객
                        group by 도시);
                        
/*점검문제6-1번*/
select 부서명
from 부서
where 부서번호 = (select 부서번호
			from 사원
			where 이름 = "배재용");
		
        /*상관서브쿼리*/            
select (select 부서명
		from 부서 as d
        where d.부서번호 = e.부서번호) as 부서명
from 사원 e
where 이름 = '배재용';
		
        /*ANSI JOIN*/
select 부서명
from 부서
inner join 사원
on 부서.부서번호 = 사원.부서번호
where 이름 ='배재용';

		/*Non-ANSI SQL*/
select 부서명
from 부서, 사원
where 부서.부서번호 = 사원.부서번호
and 이름 ='배재용';


/*점검문제6-2번*/
select 제품번호,
		제품명,
        포장단위,
        단가,
        재고,
         단가*재고 as 재고금액
from 제품
where 제품번호 NOT IN (select 제품번호
					from 주문세부);

		/*상관 서브쿼리*/
select *
from 제품 as p
where NOT exists(
					select *
                    from 주문세부 as d
                    where d.제품번호 = p.제품번호
                    );

		/*외부 조인*/
select 제품.*
from 제품
left outer join 주문세부
on 제품.제품번호 = 주문세부.제품번호
where 주문세부.제품번호 IS NULL;

/*실습문제 6-1 */
select 제품명
from 제품
where 단가 = (
			select MAX(단가)
			from 제품
            );
            
/*실습문제 6-2 */
select sum(주문수량)
from 주문세부
where 제품번호 = (
				select 제품번호
				from 제품
                where 단가 = (select MAX(단가)
							from 제품
                            )
				);

/*실습문제 6-3 */
select sum(주문수량)
from 주문세부
where 제품번호 in (
				select 제품번호
				from 제품
				where 제품명 like '%아이스크림%'
                );
                
/*실습문제 6-4 */
select year(주문일) as 주문년도,
		count(주문일) as 주문건수
from 주문
where 고객번호 in (
				select 고객.고객번호
				from 고객
                where 도시 = "서울특별시"
                )
group by 주문년도;

/*================7장=================*/
insert into 부서
values('A5', '마케팅부');

insert into 제품
values(91, '연어피클소스', NULL, 5000, 40);

insert into 제품(제품번호, 제품명, 단가, 재고)
values(90, '연어핫소스', 4000, 50);

insert into 사원(사원번호, 이름, 직위, 성별, 입사일)
values('E20', '김사과', '수습사원', '남', CURDATE()),
		('E21', '박바나나', '수습사원', '여', CURDATE()),
        ('E22', '정오렌지', '수습사원', '여', CURDATE());
        
update 사원
set 이름='김레몬'
where 사원번호='E20';

update 제품
set 포장단위 = '200 ml bottles'
where 제품번호 = 91;

update 제품
set 단가 = 단가 * 1.1,
	재고 = 재고 - 10
where 제품번호 = 91;

delete from 제품
where 제품번호 = 91;

delete from 사원
order by 입사일 desc
limit 3;

select *
from 사원
where 이름 in ('김레몬','박바나나','정오렌지');

insert into 제품(제품번호, 제품명, 단가, 재고)
values(91, '연어피클핫소스', 6000, 50)
on DUPLICATE KEY UPDATE
제품명 = '연어피클핫소스', 단가=6000, 재고 =50;

/*점검문제 7-1*/
insert into 제품
values(95, '망고베리 아이스크림', '400g', 800, 30);

select * from 제품;

/*점검문제 7-2*/
insert into 제품
values(96, '눈꽃빙수맛 아이스크림', NULL, 2000, NULL);

select * from 제품;

/*점검문제 7-3*/
update 제품
set 재고 = 30
where 제품번호 = 96;

select * from 제품;


create table 고객주문요약(
고객번호 char(5) PRIMARY KEY,
고객회사명 VARCHAR(50),
주문건수 INT,
최종주문일 DATE
);

insert into 고객주문요약
	select 고객.고객번호,
			고객회사명,
            count(*),
            MAX(주문일)
	from 고객,
		주문
	where 고객.고객번호 = 주문.고객번호
	group by 고객.고객번호, 고객회사명;

select * from 고객주문요약;

update 제품
set 단가 = (
			select *
            from (
					select avg(단가)
                    from 제품
                    where 제품명 LIKE "%소스%"
					) as t
			)
where 제품번호 = 91;

select * from 제품;

update 고객,
		(
        select distinct 고객번호
        from 주문
        )as 주문고객
set 마일리지 = 마일리지 * 1.1
where 고객.고객번호 in (주문고객.고객번호);

select *
from 고객
where 고객번호 in (select distinct 고객번호
				from 주문);
                
update 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
set 마일리지 = 마일리지 + 1000
where 등급명 = 'S';

delete from 주문
where 주문번호 not in (
					select distinct 주문번호
                    from 주문세부
					);

select *
from 주문
where 주문번호 = 'H0248';

select *
from 주문세부
where 주문번호 = 'H0248';

delete 주문, 주문세부
from 주문
inner join 주문세부
on 주문.주문번호 = 주문세부.주문번호
where 주문.주문번호 = 'H0248';