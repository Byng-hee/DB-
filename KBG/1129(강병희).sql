create database 사원;
use 사원;

create table Dept(
	deptno integer(2) PRIMARY KEY,
    dname varchar(14),
    loc varchar(13)
);

create table Emp(
	empno integer(4) PRIMARY KEY,
    ename varchar(10),
    job varchar(9),
    mgr integer(4),
    hiredate date,
    sal integer(7),
    comn integer(7),
    deptno integer(2),
    FOREIGN KEY(deptno) REFERENCES Dept(deptno)
);

insert into Dept
values(10, "ACCOUNTING", "NEW YORK"),
		(20, "RESHEARCH", "DALLAS"),
		(30, "SALES", "CHICAGO"),
        (40, "OPERATIONS", "BOSTON");
        
insert into Emp
values(7369, "SMITH", "CLERK", 7902, "1980-12-17", 800, NULL, 20);

insert into Emp
values(7499, "ALLEN", "SALESMAN", 7698, "1981-02-20", 1600, 300, 30),
		(7521, "WARD", "SALESMAN", 7698, "1981-02-22", 1250, 500, 30),
        (7566, "JONES", "MANAGER", 7839, "1981-04-02", 2975, NULL, 20),
        (7654, "MARTIN", "SALESMAN", 7698, "1981-09-28", 1250, 1400, 30),
        (7698, "BLAKE", "MANAGER", 7839, "1981-05-01", 2850, NULL, 30),
        (7782, "CLARK", "MANAGER", 7839, "1981-06-08", 2450, NULL, 10),
        (7788, "SCOTT", "ANALYST", 7566, "1987-04-19", 3000, NULL, 20),
        (7839, "KING", "PRESIDENT", NULL, "1981-11-17", 5000, NULL, 10),
        (7844, "TURNER", "SALESMAN", 7698, "1981-09-08", 1500, 0, 30),
        (7876, "ADAMS", "CLERK", 7788, "1987-05-23", 1100, NULL, 20),
        (7900, "JAMES", "CLERK", 7698, "1981-12-03", 950, NULL, 30),
        (7902, "FORD", "ANALYST", 7566, "1981-12-03", 3000, NULL, 20),
        (7934, "MILLER", "CLERK", 7782, "1982-01-23", 1300, NULL, 10);
        
/*1번*/
select ename as "사원이름",
		job as "사원직위"
from Emp;

/*2번*/
select ename, sal
from Emp
where deptno = 30;

/*3번*/
select empno, ename, sal,0.1*sal as "증가액", 1.1*sal as "인상된 급여"
from Emp
order by 1;

/*4번*/
select ename, deptno
from Emp
where ename like "S%";

/*5번*/
select ceiling(MAX(sal)) as MAX,
		ceiling(MIN(sal)) as MIN,
        ceiling(SUM(sal)) as SUM,
        ceiling(AVG(sal)) as AVG
from Emp;

/*6번*/
select job as "업무",
		count(*) as "업무별 사원수"
from Emp
group by job;

/*7번*/
select Max(sal)-Min(sal) as "최대 최소 급여 차액"
from Emp;

/*8번*/
select count(*) as "구성원 수",
		SUM(sal) as "급여 합계",
        AVG(sal) as "급여 평균"
from Emp
where deptno= 30;

/*9번*/
select job,
		avg(sal)
from Emp
where job != "SALESMAN"
group by job
having avg(sal) >= 3000 
order by 2 desc;

/*10번*/
select count(*) as "직속상관이 있는 사원수"
from Emp
where mgr;

/*11번* EXEPT를 사용해서 해결 할 수도 있음/
select ename,
		sal,
        comn,
        sal+comn as "총액"
from Emp
where comn is not null
order by 3 desc;

/*12번*/
select Emp.deptno,
        Emp.job,
        count(Emp.ename)
from Emp
inner join Emp as part
on Emp.deptno = part.deptno
where Emp.job = part.job
group by Emp.deptno, Emp.job;
/*
where deptno IN (select deptno From Emp)
Group by job, deptno;
*/

/*13번*/
select Dept.dname
from Dept
left join Emp
on Dept.deptno = Emp.deptno
where Emp.deptno is NULL;

/*14번*/
select job,
		count(*)
from Emp
group by job
having count(*) >=4;

/*15번*/
select ename
from Emp
where empno between 7400 and 7600;

/*16번*/
select ename, deptno
from Emp;

/*17번*/
select Emp.ename, a.ename
from Emp
inner join Emp as a
on Emp.mgr = a.empno;

/*18번*/
select ename
from Emp
where sal > (select sal
			from Emp
			where ename= "SCOTT");
            
/*19번*/
select distinct Dept.deptno
from Emp
inner join Dept
on Emp.deptno = Dept.deptno
where Emp.ename= "SCOTT" or Dept.loc = "DALLAS";




