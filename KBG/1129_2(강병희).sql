use 한빛무역;

/*예제 9-1*/
CREATE OR REPLACE VIEW view_사언
as 
select 이름,
		집전화 as 전화번호,
        입사일,
        주소
from 사원;

select *
from view_사언;

/*예제 9-2*/
create or replace view view_제품별주문수량합
as
select 제품명,
		sum(주문수량) as 주문수량합
from 제품
inner join 주문세부
on 제품.제품번호 = 주문세부.제품번호
group by 제품명;

select *
from view_제품별주문수량합;

/*예제 9-3*/
create or replace view view_사원_여
as
select 이름,
		집전화 as  전화번호,
        입사일,
        주소,
        성별
from 사원
where 성별 = '여';

select *
from view_사원_여;

/*예제 9-4*/
select *
from view_사원_여
where 전화번호 like '%88%';

/*예제 9-5*/
select *
from view_제품별주문수량합
where 주문수량합 >= 1200;

/*예제 9-7*/
DROP view view_사언;

/*예제 9-8*/
insert into view_사원_여(사원번호, 이름, 전화번호, 입사일, 주소, 성별)
values('E12', '황여름', '(02)587-4948','2023-02-10', '서울시 강남구 청담동 23-5', '여');

create or replace view view_사원_여
as
select 사원번호,
		이름,
		집전화 as  전화번호,
        입사일,
        주소,
        성별
from 사원
where 성별 = '여';

select *
from view_사원_여
where 사원번호 = 'E12';

select *
from 사원
where 사원번호 = 'E12';

/*예제 9-9*/ 
insert into view_제품별주문수량합
values('단짠 새우깡', 250);
/*오류가 발생 view 생성할 때 join사용했기 때문이다. */

/*9-10*/
insert into view_사원_여(사원번호, 이름, 입사일, 주소, 성별)
values('E13', '강겨울', '2023-02-01', '서울시 성북구 장위동 123-7', '남');

select *
from view_사원_여
where 사원번호 = 'E13';

select *
from 사원
where 사원번호 = 'E13';

create or replace view view_사원_여
as
select 사원번호,
		이름,
		집전화 as  전화번호,
        입사일,
        주소,
        성별
from 사원
where 성별 = '여'
with check option;

update view_사원_여
set 성별 = '남'
where 이름 = '황여름';