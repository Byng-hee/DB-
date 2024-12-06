create database 김치공장;
use 김치공장;

create table  학과(
	학과번호 CHAR(2),
    학과명 VARCHAR(20),
    학과장명 VARCHAR(20)
);

insert into 학과
values('AA','컴퓨터공학과', '배경민'),
		('BB','소프트웨어학과','김남준'),
        ('CC','디자인융합학과','박선영');

create table 학생(
	학번  CHAR(5),
    이름 VARCHAR(20),
    생일 DATE,
    연락처 varchar(20),
    학과명 VARCHAR(2)
);

insert into 학생
values('S0001','이윤주', '2020-01-30','01033334444', 'AA'),
		('S0002','이승은','2021-02-23',NULL,'AA'),
        ('S0003','백재용','2018-03-31','01077778888', 'DD');
        
CREATE TABLE 휴학생 as
	select *
    from 학생
    where 1 = 2;

create table 회원(
	아이디 varchar(20) primary key,
    회원명 varchar(20),
    키 INT,
    몸무게 INT,
    체질량지수 decimal(4,1) as (몸무게 / power(키/100, 2)) stored
);

insert into 회원(아이디, 회원명, 키, 몸무게)
values('APPLE', '김사과', 178, 70);

/*============ ALTER의 다양한 사용법 ==============*/
ALTER table 학생 ADD 성별 CHAR(1);

ALTER table 학생 MODIFY COLUMN 성별 VARCHAR(2);

ALTER table 학생 change column 연락처 휴대폰번호 varchar(20);

ALTER table 학생 DROP COLUMN 성별;

ALTER table 휴학생 RENAME 졸업생;


/*============ DROP 사용법 ==============*/
DROP table 학과, 학생;

/*============ 제약조건 ==============*/
create table 학과(
	학과번호 CHAR(2) PRIMARY KEY,
    학과명 VARCHAR(20) NOT NULL,
    학과장명 VARCHAR(20)
);

create table 학생(
	학번 CHAR(5) PRIMARY KEY,
    이름 VARCHAR(20) NOT NULL,
    생일 DATE NOT NULL,
    연락처 VARCHAR(20) UNIQUE,
    학과번호 CHAR(2),
    성별 CHAR(1) CHECK(성별 IN ('남','여')),
    등록일 DATE DEFAULT(CURDATE()),
    FOREIGN KEY(학과번호) REFERENCES 학과(학과번호)
);

create table 과목(
	과목번호 CHAR(5) PRIMARY KEY,
    과목명 VARCHAR(20) NOT NULL,
    학점 INT NOT NULL CHECK(학점 BETWEEN 2 AND 4),
    구분 VARCHAR(20) CHECK(구분 IN ('전공', '교양','일반'))
);

CREATE TABLE 수강_1(
	수강년도 CHAR(4),
    수강학기 VARCHAR(20) CHECK(수강학기 IN ("1학기", "2학기", "여름학기", "겨울학기") ),
	학번 CHAR(5) NOT NULL,
	과목번호 CHAR(5) NOT NULL,
    성적 NUMERIC(3,1) CHECK(성적 between 0 and 4.5),
    PRIMARY KEY(수강년도, 수강학기, 학번, 과목번호),
    FOREIGN KEY(학번) REFERENCES 학생(학번),
    FOREIGN KEY(과목번호) REFERENCES 과목(과목번호)
);

CREATE TABLE 수강_2(
	수강번호 INT AUTO_INCREMENT,
	수강년도 CHAR(4) NOT NULL,
    수강학기 VARCHAR(20) NOT NULL CHECK(수강학기 IN ("1학기", "2학기", "여름학기", "겨울학기") ),
	학번 CHAR(5) NOT NULL,
	과목번호 CHAR(5) NOT NULL,
    성적 NUMERIC(3,1) CHECK(성적 between 0 and 4.5),
    PRIMARY KEY(수강번호),
    FOREIGN KEY(학번) REFERENCES 학생(학번),
    FOREIGN KEY(과목번호) REFERENCES 과목(과목번호)
);

INSERT INTO 학과
VALUES('AA', '컴퓨터공학과', '배경민');
INSERT INTO 학과
VALUES('BB', '소프트웨어학과', '김남준');
INSERT INTO 학과
VALUES('CC', '디자인융합학과', '박선영');

insert into 학생(학번, 이름, 생일, 학과번호)
values('S0001','이윤주', '2020-01-30', 'AA');
insert into 학생(학번, 이름, 생일, 학과번호)
values('S0002','이승은','2021-02-23', 'AA');
insert into 학생(학번, 이름, 생일, 학과번호)
values('S0003','백재용','2018-03-31', 'CC');

insert into 과목(과목번호, 과목명, 구분, 학점)
values('C0001', '데이터베이스실습', '전공', 3);
insert into 과목(과목번호, 과목명, 구분, 학점)
values('C0002', '데이터베이스 설계와 구축', '전공', 3);
insert into 과목(과목번호, 과목명, 구분, 학점)
values('C0003', '데이터 분석', '전공', 3);

insert into 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0001', 'C0001', 4.3);
insert into 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0001', 'C0002', 4.4);
insert into 수강_1(수강년도, 수강학기, 학번, 과목번호, 성적)
values('2023', '1학기', 'S0002', 'C0002', 4.3);

ALTER TABLE 학생 ADD CONSTRAINT CHECK(학번 LIKE 'S%');

select *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = '김치공장'
AND TABLE_NAME = '학생';

ALTER TABLE 학생 DROP CONSTRAINT 연락처;
ALTER TABLE 학생 DROP CONSTRAINT 학생_chk_1;
ALTER TABLE 학생 DROP CONSTRAINT 학생_chk_2;
ALTER TABLE 학생 ADD CHECK (학번 LIKE 'S%');

create table 수강평가(
	 평가순번 INT AUTO_INCREMENT,
     학번 CHAR(5) NOT NULL,
     과목번호 CHAR(5) NOT NULL,
     평점 INT CHECK(평점 between 0 and 5),
     과목평가 VARCHAR(500),
     평가일시 DATETIME DEFAULT(CURDATE()),
     PRIMARY KEY(평가순번),
     FOREIGN KEY(학번) REFERENCES 학생(학번),
     FOREIGN KEY(과목번호) REFERENCES 과목(과목번호) on delete cascade
);

insert into 수강평가(학번, 과목번호, 평점, 과목평가)
values('S0001','C0001',5,'SQL학습에 도움이 되었습니다.'),
		('S0001','C0003',5,'SQL 활용을 배워서 좋았습니다.'),
        ('S0002','C0003',5,'데이터 분석에 관심이 생겼습니다.'),
        ('S0003','C0003',5,'머신러닝과 시각화 부분이 유용했습니다.');

DELETE FROM 과목 WHERE 과목번호 = 'C0003';

SELECT * FROM 과목;
SELECT * FROM 수강평가;

DELETE FROM 과목 where 과목번호 = 'C0001';

create table 영화(
	영화번호 CHAR(5),
    타이틀 VARCHAR(100) NOT NULL,
    장르 VARCHAR(20) check (장르 IN ('코미디','드라마','다큐','SF','액션','역사','기타') ),
    배우 VARCHAR(100) NOT NULL,
    감독 VARCHAR(50) NOT NULL,
    제작사 VARCHAR(50) NOT NULL,
    개봉일 DATETIME,
    등록일 DATETIME DEFAULT(CURDATE()),
    PRIMARY KEY(영화번호)
);

create table 평점관리(
	번호 INT AUTO_INCREMENT PRIMARY KEY,
    평가자닉네임 VARCHAR(50) NOT NULL,
    영화번호 CHAR(5) NOT NULL,
    평점 INT NOT NULL CHECK (평점 between 1 and 5),
    평가 VARCHAR(2000) NOT NULL,
    등록일 DATETIME default(CURTIME()),
    FOREIGN KEY(영화번호) REFERENCES 영화(영화번호) 
);


use 한빛무역;
ALTER TABLE 제품 ADD CONSTRAINT CHECK( 재고 >=0);
ALTER TABLE 제품 ADD 재고금액 INT as (단가 * 재고);
ALTER TABLE 주문세부 ADD FOREIGN KEY(제품번호) REFERENCES 제품(제품번호) on delete cascade;