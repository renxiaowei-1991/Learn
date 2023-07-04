--�ݹ�
Start With ... Connect By Prior ...
Level:�ݹ�㼶


--�������ݴ���
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
Comment On Table employee Is 'Ա����';
Comment On Column employee.empno    Is 'Ա�����';
Comment On Column employee.ename    Is 'Ա������';
Comment On Column employee.job      Is 'Ա����λ';
Comment On Column employee.mgr      Is '�ϼ����';
Comment On Column employee.hiredate Is '��ְ����';
Comment On Column employee.sal      Is 'н�ʽ��';
Comment On Column employee.comm     Is '��ע���';
Comment On Column employee.deptno   Is '���ű��';

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



--�ݹ�
--����Ա����Ϊ���νṹ��
--�ݹ��﷨
Start With Condition01 Connect By Prior Condition02;
--���ͣ�
--  Condition01Ϊ��ʼ������
--  Condition02Ϊ��������(��ѯ������¼������)(Ҳ����˵���νṹ���¼����ݵĹ�����ϵ)
--  Connect By Prior:��˳������
--  Prior:������ʶ���ֶ�(���ڵ�)
--1������1:(�ݹ��ѯ���ڵ�)
--  ��ѯԱ��7369���ϼ�������(ȫ���ϼ��������Լ�)
--����1��
--  ��ǰ������¼��mgr��ֵ����������empno��ֵ��Ҳ����˵��ѯ���Ǹ��ڵ�
--  Prior:����empno=7369���ӽڵ��ֶ�
--���1��
--  ��ѯ�ýڵ�ĸ����ڵ��Լ�һֱ�ݹ鵽���ڵ�
Select * From employee        --��ѯĿ��
Start With empno = 7369       --��ʼ����
Connect By Prior mgr = empno  --������ϵ
;

--2������2:(�ݹ��ѯ�ӽڵ�)
--  ��ѯԱ��7566���¼�������(ȫ���¼��������Լ�)
--����2::
--  ��ǰ������¼��empno��ֵ����������mgr��ֵ��Ҳ����˵��ѯ�����ӽڵ�
--  Prior:����empno=7566�Ǹ��ڵ��ֶ�
--���2:
--  ��ѯ�ýڵ���ӽڵ�һֱ�ݹ鵽Ҷ�ӽڵ�
Select * From employee
Start With empno = 7566
Connect By Prior empno = mgr
;

--3��Levelʹ��(�ݹ�����)
--  Level��ʶ�ݹ�㼶
--  ע�⣺���������Ҫ��ӱ���ʹ�ã�����ᱨ��
Select t.*,Level lv From employee t
Start With empno = 7369
Connect By Prior mgr = empno
;

--4��Sys_Connect_By_Path(������Ȱ���Ҫ�����ݽ���ƴ��)
--  ʹ��'>'��Ϊ���ӷ�����ʾÿһ���ename�ֶε�����ֵ��
--  ���磺Level=4�������У�����ǣ�'>SMITH>FORD>JOINES>KING'
Select t.*,Level lv,Sys_Connect_By_Path(ename,'>')
From employee t
Start With empno = 7369
Connect By Prior mgr = empno
;

--5����ѯ��(�Ӹ��ڵ��ѯ���ӽڵ�(������)(���Ǵ�ĳһ���ڵ㿪ʼ�Ĳ�������))
Select t.*,Level lv,Sys_Connect_By_Path(ename,'>')
From employee t
Start With empno in (Select empno From employee Where mgr is null)
--Connect By Prior empno = mgr
Connect By mgr = Prior empno  --Ч��������������ͬ
;


--6��ͨ���ݹ�Level(�ݹ�㼶)��ȡ����ֵ

--��5-100
Select Level From dual 
Where Level>=5 
Connect By Level <= 100
;

--��5-100������Ϊ3����������
Select Level From dual 
Where Level>=5 and Mod(Level-2,3)=0
Connect By Level <= 100
;

--��2022-01-01��2022-12-31
Select To_Char(To_date('2022-01-01','YYYY-MM-DD')+Level-1,'YYYY-MM-DD') As day 
From dual
Where Level >= 1
Connect By Level <= 365
;

--ͨ��ASCII��ֵ�������������ַ�
Select Level,Chr(Level)
From dual
Where Level >= 1
Connect By Level <= 127
;

--Level&RowNum �ȼ۵�ʹ�÷�ʽ
SELECT LEVEL FROM dual CONNECT BY LEVEL <= 7;
SELECT ROWNUM FROM dual CONNECT BY ROWNUM <= 7;