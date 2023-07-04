--递归
Start With ... Connect By Prior ...
Level:递归层级


--样例数据创建
Drop Table employee;
Create Table employee(
     empno Int not null
    ,ename Varchar2(30) not null
    ,job   Varchar2(30) not null
    ,mgr   Int
    ,hiredate Date
    ,sal   Number(22,2)
    ,comm  Number(22,2)
    ,deptno Int
    ,Primary Key(empno)
) Tablespace OracleLearn;
Comment On Table employee Is '员工表';
Comment On Column employee.empno    Is '员工编号';
Comment On Column employee.ename    Is '员工名称';
Comment On Column employee.job      Is '员工岗位';
Comment On Column employee.mgr      Is '上级编号';
Comment On Column employee.hiredate Is '入职日期';
Comment On Column employee.sal      Is '薪资金额';
Comment On Column employee.comm     Is '备注金额';
Comment On Column employee.deptno   Is '部门编号';

Insert Into employee
Select 7369,'SMITH'  ,'CLERK'    ,7902,To_Date('1980-12-17','YYYY-MM-DD'), 800.00,Null,20 From dual Union All
Select 7499,'ALLEN'  ,'SALESMAN' ,7698,To_Date('1981-02-20','YYYY-MM-DD'),1600.00, 300,30 From dual Union All
Select 7521,'WARD'   ,'SALESMAN' ,7698,To_Date('1981-02-22','YYYY-MM-DD'),1250.00, 500,30 From dual Union All
Select 7566,'JOINES' ,'MANAGER'  ,7839,To_Date('1981-04-02','YYYY-MM-DD'),2975.00,Null,20 From dual Union All
Select 7654,'MARTION','SALESMAN' ,7698,To_Date('1981-09-28','YYYY-MM-DD'),1250.00,1400,30 From dual Union All
Select 7698,'BLAKE'  ,'MANAGER'  ,7839,To_Date('1981-05-01','YYYY-MM-DD'),2850.00,Null,30 From dual Union All
Select 7782,'CLARK'  ,'MANAGER'  ,7839,To_Date('1981-06-09','YYYY-MM-DD'),2450.00,Null,10 From dual Union All
Select 7788,'SCOTT'  ,'ANALYST'  ,7566,To_Date('1987-04-19','YYYY-MM-DD'),3000.00,Null,20 From dual Union All
Select 7839,'KING'   ,'PRESIDENT',Null,To_Date('1981-11-17','YYYY-MM-DD'),5000.00,Null,10 From dual Union All
Select 7844,'TURNER' ,'SALESMAN' ,7698,To_Date('1981-09-08','YYYY-MM-DD'),1500.00,   0,30 From dual Union All
Select 7876,'ADAMS'  ,'CLERK'    ,7788,To_Date('1987-05-23','YYYY-MM-DD'),1100.00,Null,20 From dual Union All
Select 7900,'JAMES'  ,'CLERK'    ,7698,To_Date('1981-12-03','YYYY-MM-DD'), 950.00,Null,30 From dual Union All
Select 7902,'FORD'   ,'ANALYST'  ,7566,To_Date('1981-12-03','YYYY-MM-DD'),3000.00,Null,20 From dual Union All
Select 7934,'MILLER' ,'CLERK'    ,7782,To_Date('1982-01-23','YYYY-MM-DD'),1300.00,Null,10 From dual
;
Commit;



--递归
--上述员工表为树形结构表
--递归语法
Start With Condition01 Connect By Prior Condition02;
--解释：
--  Condition01为开始的条件
--  Condition02为连接条件(查询下条记录的条件)(也就是说树形结构上下级数据的关联关系)
--  Connect By Prior:按顺序连接
--  Prior:用来标识根字段(根节点)
--1、样例1:(递归查询父节点)
--  查询员工7369的上级的数据(全部上级，包括自己)
--解析1：
--  当前这条记录的mgr的值是下条数据empno的值，也就是说查询的是父节点
--  Prior:表明empno=7369是子节点字段
--结果1：
--  查询该节点的父级节点以及一直递归到根节点
Select * From employee        --查询目标
Start With empno = 7369       --开始条件
Connect By Prior mgr = empno  --关联关系
;

--2、样例2:(递归查询子节点)
--  查询员工7566的下级的数据(全部下级，包括自己)
--解析2::
--  当前这条记录的empno的值是下条数据mgr的值，也就是说查询的是子节点
--  Prior:表明empno=7566是父节点字段
--结果2:
--  查询该节点的子节点一直递归到叶子节点
Select * From employee
Start With empno = 7566
Connect By Prior empno = mgr
;

--3、Level使用(递归的深度)
--  Level标识递归层级
--  注意：这里表名需要添加别名使用，否则会报错
Select t.*,Level lv From employee t
Start With empno = 7369
Connect By Prior mgr = empno
;

--4、Sys_Connect_By_Path(根据深度把需要的数据进行拼接)
--  使用'>'作为连接符，显示每一层的ename字段的连接值。
--  例如：Level=4的数据中，结果是：'>SMITH>FORD>JOINES>KING'
Select t.*,Level lv,Sys_Connect_By_Path(ename,'>')
From employee t
Start With empno = 7369
Connect By Prior mgr = empno
;

--5、查询树(从根节点查询到子节点(完整树)(不是从某一个节点开始的不完整树))
Select t.*,Level lv,Sys_Connect_By_Path(ename,'>')
From employee t
Start With empno in (Select empno From employee Where mgr is null)
--Connect By Prior empno = mgr
Connect By mgr = Prior empno  --效果与上面的语句相同
;


--6、通过递归Level(递归层级)获取连续值

--从5-100
Select Level From dual 
Where Level>=5 
Connect By Level <= 100
;

--从5-100，增量为3的数字序列
Select Level From dual 
Where Level>=5 and Mod(Level-2,3)=0
Connect By Level <= 100
;

--从2022-01-01到2022-12-31
Select To_Char(To_date('2022-01-01','YYYY-MM-DD')+Level-1,'YYYY-MM-DD') As day 
From dual
Where Level >= 1
Connect By Level <= 365
;

--通过ASCII码值，生成连续的字符
Select Level,Chr(Level)
From dual
Where Level >= 1
Connect By Level <= 127
;

--Level&RowNum 等价的使用方式
SELECT LEVEL FROM dual CONNECT BY LEVEL <= 7;
SELECT ROWNUM FROM dual CONNECT BY ROWNUM <= 7;