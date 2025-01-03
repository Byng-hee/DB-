select char_length('Hello'),
		length('HELLO'),
        char_length('안녕'),
        length('안녕');

select concat('dreams', 'come',  'true'),
		concat_ws('-', '2023', '01', '29');

select left('SQL 완전정복',3),
		right('SQL 완전정복', 4),
        SUBSTR('SQL 완전정복', 2, 5),
        SUBSTRING('SQL 완전정복', 2);
        
select substring_index('서울시 동작구 흑성로', ' ', 1),
		substring_index('서울시 동작구 흑성로', ' ', -2);

select lpad('SQL', 10, '#'),
		Rpad('SQL', 5, '*');

select length(ltrim(' SQL ')),
		length(rtrim(' SQL ')),
		length(trim(' SQL '));
        
select trim(both 'abc' from 'abcSQLabcabc'),
		trim(leading 'abc' from 'abcSQLabcabc'),
		trim(trailing 'abc' from 'abcSQLabcabc');

select field('JAVA', 'SQL', 'JAVA', 'C'),
		find_in_set('java', 'sql,java,c'),
        instr('네 인생을 살아라', '인생'),
        locate('인생', '네 인생을 살아라');
        
select elt(2, 'SQL', "JAVA", "C");

select replace('010.1234.5678', '.', '-');

select ceiling(123.56),
		floor(123.56),
		round(123.56, 1),
		truncate(123.56, 1);

select now(),
		sysdate(),
		curdate(),
        curtime();

select now(),
		datediff('2025-12-20', now()),
        datediff(now(), '2025-12-20'),
        timestampdiff(YEAR, now(), '2025-12-20'),
        timestampdiff(MONTH, now(), '2025-12-20'),
        timestampdiff(DAY, now(), '2025-12-20');

select now(),
		adddate(now(), 50),
        adddate(now(),interval 50 Day),
        adddate(now(),interval 50 Month),
        subdate(now(), interval 50 Hour);

select now(),
		last_day(now()),
        dayofyear(now()),
        monthname(now()),
        weekday(now());

select cast('1' as unsigned),
		cast(2 as char(1)),
        convert('1', unsigned),
        convert('1', char(1));

select case when 12500 * 450 > 5000000 then '초과달성'
			when 2500 * 450 > 4000000 then '달성'
            else '미달성'
		END;
        
/*점검문제 1*/
SELECT 고객회사명,
		replace(고객회사명, left(고객회사명, 2), '**') 고객회사명2,
        전화번호,
		concat(substr(전화번호,2,2),'-',substr(전화번호,5) ) 전화번호2
FROM 고객

/*점검문제2*/
SELECT 주문번호,
		제품번호,
        truncate(단가, -1),
        주문수량,
        할인율,
        truncate(주문수량*단가, 0) as 주문금액,
        truncate(주문수량*단가*할인율, 0) as 할인금액,
        truncate(주문수량*단가-주문수량*단가*할인율, 0) as 실주문금액
FROM 주문세부

/*점검문제3*/
select 이름,
		생일,
        floor(datediff(now(), 생일)/365) as 만나이,
        입사일,
        datediff(now(), 입사일) as 일사일수,
        adddate(입사일, 500) as 500일후
from 사원

/*점검문제4*/
select  담당자명,
		고객회사명,
		도시,
		case when right(도시, 3) = '특별시' then '대도시'
			when right(도시, 3) = '광역시' then '대도시'
            else '도시'
		END as 도시구분,
        마일리지,
		case when 마일리지 >= 100000 then 'VVIP고객'
			when 마일리지 >= 10000 then 'VIP고객'
            else '일반고객'
		END as마일리지구분
from 고객;

/*점검문제5*/
select 주문번호,
		고객번호,
		주문일,
        year(주문일) as 주문년도,
        quarter(주문일) as 주문분기,
        month(주문일) as 주문월,
        right(주문일, 2) as 주문일,
        weekday(주문일) as 주문요일,
		case when weekday(주문일)=0 then '월요일'
			when weekday(주문일)=1 then '화요일'
			when weekday(주문일)=2 then '수요일'
			when weekday(주문일)=3 then '목요일'
			when weekday(주문일)=4 then '금요일'
			when weekday(주문일)=5 then '토요일'
            else '일요일'
		END as 한글요일
from 주문

/*점검문제6*/
select 주문번호,
		고객번호,
		사원번호,
        주문일,
        요청일,
        발송일,
        datediff(발송일, 요청일) as 지연일수
from 주문
where datediff(발송일, 요청일) >= 7

/*실습문제1*/
select *
from 고객
where 담당자명 like '__정' or 담당자명 like '_정_' or 담당자명 like '정__'

/*실습문제2*/
select 제품번호,
		제품명,
        포장단위,
        단가,
        재고
from 제품, 주문
where quarter(주문일) = 2;

/*실습문제3*/
select 제품번호,
		제품명,
        재고,
        case when 재고 > 100 then '과다재고'
			when 재고 > 10 then '적정'
            else '재고부족'
		end as 재고구분
from 제품;

/*실습문제4*/
select 이름,
		부서번호,
        직위,
        입사일,
        datediff(now(), 입사일) as 입사일수,
        timestampdiff(month, 입사일, now()) as 입사개월수
from 사원
where now() >= adddate(입사일, interval 40 month);