use 한빛무역;

DELIMITER $$
CREATE PROCEDURE proc_if()
	BEGIN
		DECLARE x INT;
        DECLARE y INT DEFAULT 5;
        SET x = 10;
        
        IF x > y THEN
			SELECT 'x는 y보다 큽니다.' AS 결과;
		ELSE
			SELECT 'x는 y보다 작습니다.' AS 결과;
		END IF;
	END $$
DELIMITER ;

CALL proc_if();

DELIMITER $$
CREATE PROCEDURE proc_case()
	BEGIN
		DECLARE x INT DEFAULT 10;
        DECLARE y INT;
        SET y = 10 mod 2;
        
        CASE
			WHEN y = 0 THEN
				SELECT 'x는 짝수입니다.' as '결과';
			ELSE
				SELECT 'x는 홀수입니다.' as '결과'; 
		END CASE;
    END $$
DELIMITER ;

CALL proc_case();

DELIMITER $$
CREATE PROCEDURE proc_while()
	BEGIN
		DECLARE x INT default 0;
        DECLARE y INT default 0;
        
        WHILE x < 10 DO
			SET x = x + 1;
            SET y = y + x;
		END WHILE;
		SELECT x, y;
	END $$
DELIMITER ;

CALL proc_while()

DELIMITER $$
CREATE PROCEDURE proc_loop()
	BEGIN
		DECLARE x INT default 0;
        DECLARE y INT default 0;
        
        loop_sum:LOOP
			SET x = x + 1;
            SET y = x + y;
            IF x > 10 THEN
				LEAVE loop_sum;
            END IF;
            SELECT x, y;
		END LOOP;
    END $$
DELIMITER ;

CALL proc_loop();

/*예제 10-8*/
DELIMITER $$
CREATE PROCEDURE proc_도시고객정보(
	IN city VARCHAR(50)
	)
	BEGIN
		SELECT *
		FROM 고객
        WHERE 도시 = city;
        
        SELECT COUNT(*) AS 고객수
        FROM 고객
        WHERE 도시 = city;
    END $$
DELIMITER ;

/*
프로시져 호출시 오류 생기면 실행 1267오류발생 시!!!
alter table 고객 convert to char set utf8mb4 collate utf8mb4_general_ci;
alter table 주문 convert to char set uft8mb4 collate utf8mb4_general_ci;
alter table 주문세부 convert to char set uft8mb4 collate utf8mb4_general_ci;
alter table 제품 convert to char set uft8mb4 collate utf8mb4_general_ci;
*/

CALL proc_도시고객정보('부산광역시');

/*예제10 -9*/
DELIMITER $$
CREATE PROCEDURE proc_고객회사명_마일리지추가2(
	IN company VARCHAR(50),
    IN add_mileage INT
)
	BEGIN
		select 고객번호,
				고객회사명,
                마일리지 AS 변경전마일리지
		from 고객
        where 고객회사명 =  company;
        
        update 고객
        set 마일리지 = 마일리지 + add_mileage
        where 고객회사명 = company;
        
        select 고객번호,
				고객회사명,
				마일리지 as 변경후마일리지
		from 고객
        where 고객회사명 = company;
    END $$
DELIMITER ;

CALL proc_고객회사명_마일리지추가2('진영무역', 1000);

select * from 고객
where 고객회사명 = '진영무역';

/*예제 10-13*/
set global log_bin_trust_function_creators = 1;

DELIMITER $$
CREATE FUNCTION func_금액(quantity INT, price INT)
	RETURNS INT
    BEGIN
		DECLARE amount INT;
        SET amount = quantity * price;
        RETURN amount;
    END $$
DELIMITER ;

select func_금액(100, 4500);

select *
		, func_금액(주문수량, 단가) as 주문금액
from  주문세부;


