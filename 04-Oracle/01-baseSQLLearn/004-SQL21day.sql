--SQL:�ṹ����ѯ����(Structured Query Language)
--DDL:���ݶ�������(Data Definition language)
--  Create��Drop��Alter
--  DDL�Զ��ύ����
--DML:���ݲ�������(Data Manipulation Language)
--  Insert��Delete��Update��Selete
--  DML���Զ��ύ����
--DCL:���ݿ�������(Data Control language)
--  Grant��Revoke
--  DCL�Զ��ύ����
--TCL:�����������(Transactional Control Language)
--  Commit��RollBack��Savepoint
--  TCL�Զ��ύ����

--1��DDL:���ݶ�������(Data Definition language)
--  TableSapce
--  User
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_users where username='ORACLELEARN';
select * from dba_sys_privs where grantee='ORACLELEARN';

--DDL:TableSpace
--  ������ռ�  https://www.cnblogs.com/hftian/p/6993614.html
--Reuse ��Ҫ���� Size 100M ��

Create TableSpace OracleLearn  --��ռ�����
DataFile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN01.DBF'  --��ռ�����������ļ�
Size 100M  --�����ļ���ʼ����С
Reuse  --�ļ��Ƿ�����
Autoextend On  --�Ƿ��Զ���չ
Next 50M  --��һ����չ�Ĵ�С
MaxSize Unlimited,  --�����ļ��������
'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN02.DBF'
Size 100M Reuse Autoextend On Next 50M MaxSize Unlimited  --�����ļ��������
Extent ManageMent Local  --��ռ����:���ع���(���Բ��޶�)
Segment Space ManageMent Auto  --�οռ����:�Զ�
;

--DDL:TableSpace
--  �޸ı�ռ�:�����ļ�  https://www.php.cn/oracle/488273.html
Alter TableSpace OracleLearn
Add DataFile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN03.DBF'
Size 100M Reuse AutoExtend On Next 50M MaxSize Unlimited
;

--DDL:TableSpace
--  �޸ı�ռ�:ɾ���ļ�
Alter TableSpace OracleLearn Drop DataFile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN03.DBF';


--DDL:TableSpace
--�鿴��ռ�ʹ�����
Select     Upper(Free.TableSpace_Name) As "��ռ���"
          ,Data.Sum_Bytes As "��ռ��С(M)"
          ,Data.Sum_Bytes - Free.Sum_Bytes As "��ʹ�ÿռ�(M)"
          ,Free.Sum_Bytes As "���б�ռ�"
          ,Free.Max_Bytes As "���(M)"
          ,To_Char(Round((Data.Sum_Bytes - Free.Sum_Bytes)/Data.Sum_Bytes*100,2),'990.99')||'%' As "ʹ�ñ�"
From (Select     TableSpace_Name
                ,Round(Sum(Bytes)/1024/1024,2) As Sum_Bytes
                ,Round(Max(Bytes)/1024/1024,2) As Max_Bytes
      From Dba_Free_Space  --���б�ռ�
      Group By TableSpace_Name
     ) Free
,(Select TableSpace_Name,Round(Sum(Bytes)/1024/1024,2) As Sum_Bytes
  From Dba_Data_Files  --���ݿ��ļ���
  Group By TableSpace_Name
  ) Data
Where Free.TableSpace_Name = Data.TableSpace_Name
Order By 1
;


--DDL:User
--  �����û�
Create User OracleLearn  --�û���
Identified By OracleLearn  --����
Default TableSpace OracleLearn  --Ĭ�ϱ�ռ�
Quota Unlimited on OracleLearn  --Ĭ�ϱ�ռ��п���ʹ�õĿռ�������(���Բ�д)
Temporary TableSpace Temp  --��ʱ��ռ�
--Password Expire  --����״̬�����ڡ���¼��ʱ��Ҫ���û��޸�
;

--�����û�
--Sys:���ݿ����ϵͳ��Ȩ�ޣ������ײ�����ݿ����
--System:���ݿ�ʵ����Ȩ��
--����������ǣ�����ʵ��ֻ����Sys�û���һ�������Dba��ɫ��Ȩ���൱��System

--  �û���Ȩ
Grant Connect,Resource,Dba to OracleLearn;  --��Ȩ(DBAȨ��)
Grant Create Session to OracleLearn;  --��Ȩ(���Ե�¼)
Grant Create Table to OracleLearn;  --��Ȩ(����)
Grant Unlimited TableSpace to OracleLearn;  --��Ȩ(���ʱ�ռ䣬�޸ı�ռ�)

--  ����Ȩ��
Revoke Create Table From OracleLearn;

--  �޸��û�����
Alter User OracleLearn Identified by OracleLearn;

--  ɾ���û�
Drop User OracleLearn Cascade;  --����ɾ��(Cascade)

select * from dba_users;
select * from dba_sys_privs;


--DDL:Table
--  ������
--  Create Table TableName(
--       ColName ColProperties Constraint
--  	 ...
--  ) TableSpace TableSpaceName
--  ;
--  
--  TableName:����
--  ColName:����
--  TableSpaceName:��ռ�
--ע�⣺�ֶ����ͻ��Զ�ת����Oracle����֧�ֵ�����
Create Table Learn01(
     id int Not Null
    ,col01 varchar(20) Not Null
    ,col02 Decimal(22,4) Not Null
    ,col03 Date Default SysDate
    ,Primary Key(id)
) TableSpace OracleLearn
;
--  ���ע��
Comment On Table Learn01 Is '��ϰ��01';
Comment On Column Learn01.id Is '����';
Comment On Column Learn01.col01 Is '�ֶ�1';
Comment On Column Learn01.col02 Is '�ֶ�2';
Comment On Column Learn01.col03 Is '�ֶ�3';

Select * from dba_all_tables where owner ='ORACLELEARN';
Select * from dba_tab_columns where owner ='ORACLELEARN';

--  �޸ı�ṹ
--  Alter Table TableName Modify ColName ColProperties;
--  Alter Table TableName Add ColName ColProperties;
--  Alter Table TableName Drop ColName ColProperties;
Alter Table Learn01 Add col04 number(22,4) Not Null;
Alter Table Learn01 Add col05 timestamp(6) Not Null;
Alter Table Learn01 Add col06 number(22,4) Not Null;
Comment On Column Learn01.col04 Is '�ֶ�4';
Comment On Column Learn01.col05 Is '�ֶ�5';
Comment On Column Learn01.col06 Is '�ֶ�5';

--����Ѿ��������ݣ���Ҫ���е��������͵�С����С����С���������ݵ���󳤶�
Alter Table Learn01 Modify col02 Decimal(24,4);
Alter Table Learn01 Drop (col06);  --�ֶ�����Ҫ������������

Truncate Table Learn01;
Insert Into Learn01 values(100001,'rxw',150.22,sysdate,30.80,sysdate);
Insert Into Learn01
values(100003
       ,'rxw'
       ,150.22
       ,to_date('2022-05-16 11:35:00','YYYY-MM-DD HH24:MI:SS')
       ,30.80
       ,to_timestamp('2022-05-16 11:35:00.123456','YYYY-MM-DD HH24:MI:SS.FF6')
       );
Insert Into Learn01 values(100004,'rxw',150.22,sysdate,30.80,systimestamp);

--  ɾ����:���Իָ�
Drop table Learn01;
--  ��ձ�:���ָܻ�
Truncate Table Learn01;
--  �޸ı�
Alter Table Learn01 Rename To Learn02;

select * from dba_tables;
select * from dba_tab_columns;
select * from dba_tab_comments;


--DDL:View
--��ͼ
--  ��ͼ�Ǵӱ��г�����߼�����ص����ݼ���(�洢�����ݿ��е�Ԥ�ȶ���õĲ�ѯ)
--  ���б����ۣ��������һ��������д�ȡ������ռ������洢�ռ�
--��ͼ���ض�
--  ��ͼ�Ĵ���������������ͼ�ı�
--  ��ͼ���������ݿⰲȫ��һ����ʽ
--  ������ͼά���ۺ�����
--��ͼ���е�
--  �������ݷ��ʣ��򻯲�ѯ�����ݶ����ԣ�
--������ͼ���﷨
--  Create [Or Replace] [Force|NoForce] View ViewName
--  As
--  SubQuery
--  [With Check Option [Constraint constraint]]
--  [With Read Only [Constraint constraint]]
--  ;
--  
--  SubQuery:�Ӳ�ѯ�������Ǹ��ӵ�select���
--  Force:��ʹ�������ڣ�Ҳǿ�ƴ�����ͼ��Ĭ��ֵ(NoForce)
--  Or Replace:�����ͼ�Ѿ����ڣ����滻����ͼ
--  With Check Option:����ֻ���Ӳ�ѯ�������в��ܱ����롢ɾ�������¡�
--    Ĭ������£�����ɾ�� ��֮ǰ����������Щ���Ƿ��Ӳ�ѯ������
--  With Read Only:Ĭ�Ͽ���ͨ����ͼ�Ի��������ɾ�Ĳ����������кܶ��ڻ����ϵ�����
--    (���磺������ĳ�в���Ϊ�գ����Ǹ���û�г�������ͼ�У�����ͨ����ͼִ��Insert����)
--    With Read Only ˵����ͼ��ֻ����ͼ������ͨ������ͼ������ɾ�Ĳ�����
--    ��ʵ�����У�������ͨ����ͼ�Ա��е����ݽ�����ɾ�Ĳ���
Create Or Replace View View_Learn01
As
Select id,col01,col02,col03,col04
From Learn01
Where col01 = 'rxw'
;

--Create View �Ӿ��и��еı���Ӧ���Ӳ�ѯ�и������Ӧ
Create Or Replace NoForce View View_Learn01_01(
     id,name,weight,time,age
)
As
Select id,col01,col02,col03,col04
From Learn01
Where col01 = 'rxw'
With Read Only
;

--  ɾ����ͼ
--    ɾ����ͼ���ɴ���ͼ������������ͼҲ���Զ���ɾ����
--    ����������ͼ�Ļ�����ɾ���ˣ������ͼҲ���Զ�ɾ����
Drop View ViewName;

select * from View_Learn01_01
select * from user_views;

--DDL:Index
--����
--  �����Ƕ����ݿ����һ�л���е�ֵ���������һ�ֽṹ��ʹ�������ɿ��ٷ������ݿ���е��ض���Ϣ��
--�������ص�
--  һ�����ݿ����
--  ͨ��ָ�����Oracle�������Ĳ�ѯ�ٶ�
--  ͨ�����ٶ�λ���ݵķ��������ٴ���I/O
--  ��������໥����
--  Oracle�������Զ�ʹ�ú�ά������
--����������
--  Create [Unique][Cluster] Index IndexName
--  On TableName(ColName ��/����,......)
--  ;
--  
--  Asc:����,Desc:����
--  Unique:ÿһ������ֻ��ӦΨһ�����ݼ�¼
--  Cluster:�۴���������ָ�������˳������м�¼������˳��һ�µ�������֯��
--
--���鴴�����������
--  ��������ֵ�ֲ���Χ�ܹ�
--  ���а���������ֵ
--  �о�����where�Ӿ�����������г���
--  ���������ʶ����������ܴ󣬷��ʵ����ݴ��ռ����������2%��4%(����2%-4%����ֱ��ȫ���ѯ��)
--
--�����鴴�����������
--  ���С
--  �в�������Ϊ���������������where�Ӿ���
--  ��ѯ�����ݴ���2%��4%
--  ��������
--  ���������а����ڱ��ʽ��
--
--����������
--  �Զ��������ڶ���primary key��uniqueԼ����ϵͳ�Զ�����Ӧ�����ϴ���Ψһ������
--  �ֶ��������û��������������ϴ�����Ψһ���������Լ��ٲ�ѯ
Create Index Index_learn01_01 On Learn01(col01);

--  ���ں��������������ں�����������һ�����ڱ��ʽ������
--    �������ʽ����,����,SQL�������û��Զ���ĺ���
Create Index Index_Learn01_02
On Learn01(Upper(col01));
Create Index Index_Learn01_03
On Learn01(Lower(col01));

--��ѯ��ʱ���ߺ�������
Select * from Learn01 
where Lower(col01)='rxw';

--ɾ������
Drop Index IndexName;

select * from user_indexes;
select * from user_ind_columns;


--DDL:Sequence
--���� https://blog.csdn.net/Ezreal_XLove/article/details/112850902
--  �����Ǳ��ų�һ�еĶ���(���¼�)��ÿ��Ԫ�ز���������Ԫ��֮ǰ������������Ԫ��֮��
--  ���������ӻ������ͬ������һ�����
--�����ض�
--  �Զ��ṩΨһ����ֵ
--  �������
--  ��Ҫ�����ṩ����ֵ
--  ����Ӧ�ô���
--  ������ֵװ���ڴ������߷���Ч��
--
--��������
--  Create Sequence SequenceName
--  [Increment By num1]
--  [Start With num2]
--  [{MaxValue num3 | NoMaxValue}]
--  [{MinValue num4 | NoMinValue}]
--  [{Cycle | NoCycle}]
--  [{Cache num5 | NoCache}]
--  [Order]
--  ;
--  
--  Increment By num1:
--    ����Ϊnum1��num1�������������߸���������������������Ĭ��Ϊ1����������0(Ϊ0��ʧȥ�����е�����)
--    ��num1Ϊ����ʱ����ֵԽ��Խ��Ϊ������Խ��ԽС
--  Start With num2:
--    �������еĳ�ʼֵ����ʼֵnum2���������еĵ�һ��ֵ��Ĭ��ֵ��1
--  MaxValue num3 | NoMaxValue:
--    �������п������������ֵnum3�����趨���ֵ����Ĭ��ΪNoMaxValue��
--  MinValue num4 | NoMinValue:
--    �������п��Բ�������Сֵnum4�����趨��Сֵ����Ĭ��ΪNoMinValue��
--  Cycle | NoCycle:
--    �����������ɵ�ֵ�ﵽ���ʱ�Ƿ�ѭ����NoCycle��ʾ��ѭ�������һ��������Ҫ�ܳ�ʱ��������꣬���Կ���ʹ��ѭ�����С�
--    ��һ��ѭ����ʼֵ����User_sequence�е�last_number�ֶο��Բ鿴
--  Cache num5 | NoCache:
--    ���������Ƿ�ʹ�û��棬�������Ĵ�С��Ĭ�ϴ�СΪ20��
--  Order:
--    Orderѡ����������Ƿ�˳������Ĭ��ΪNo��
--    �ڵ�ʵ�����ݿ���û��������Ϊ����һ���ǰ������ġ�
--    �ڼ�Ⱥ�����У����绺��Cache=20��ʵ��1ȡ��1-20���洢���ڴ��У�ʵ��2������ͬһ����ʱ����ȡ21-40...�����ڶ�ʵ����ȡ��������ֵ�ͻ᲻ͬ��Order�����Ⱥ��ÿ��ʵ����Ҫ����˳��õ�����ֵ��
Create Sequence Seq_Learn01_01
Increment By 1
Start With 1000000001
MaxValue 9999999999
NoCycle
NoCache
;

--  ��ȡ����ֵ
--    SequenceName.currval:��ȡ���е�ǰֵ
--      ע�⣺�״β�ѯ���еĵ�ǰֵ��ʱ�򣬻ᱨ��ora-08002��ԭ���ǣ��״β�ѯ��ʱ���ڴ��в�û�л������е��κ�ֵ��������Ҫ�Ȳ�ѯһ�����е���һ��ֵ(��ʱ��Oracle���Զ������Ѳ�ѯ������ֵ)���ٲ�ѯ���еĵ�ǰֵ
--    SequenceName.nextval:��ȡ������һ��ֵ
select Seq_Learn01_01.currval from dual;
select Seq_Learn01_01.nextval from dual;

--  �޸�����
Alter Sequence SequenceName Increment By Num1;
Alter Sequence SequenceName MaxValue Num2;
Alter Sequence SequenceName Cache Num3;

--  ����ע��㣺
--    �����ǹ���ĵ��ã�������Ȩ�޵��û�������������
--    ������ع�ʱ����������ɾ�ĵ����ݿ��Ի��ˣ������в�����ˡ�
--    ��һ�����У����е������ֶ�ֵ���ܻ��жϡ���������ԭ������������������������У���ʹ��dual���������á�
--    NoCache�趨ʱ��ÿ���������ж���Ҫ���㣬���������ܣ�Cacheʱ��ֻ�ٻ���ʱ����һ�Σ��������ٵ���������ֵ���뽫Cacheֵ�Ӵ�ʵ�����ó������綩���š�
--    �����������ֵ��Ϊ����������һ��Ҫ����ΪNoCycle

--  ����Ӧ��
Insert Into Learn01
Values(Seq_Learn01_01.Nextval,'rxw',150.22,date'2022-05-17',30.8,to_timestamp('2022-05-17 09:38:00.123','YYYY-MM-DD HH24:MI:SS.FF3'))
;

select * from learn01
select * from user_sequences;

--  ����ɾ��
Drop Sequence SequenceName;



--2��DML:���ݲ�������(Data Manipulation Language)
--  Insert��Delete��Update��Selete

--  Insert
--    û�б�ָ�����ֶΣ����ݲ����Ϊnull
Insert Into TableName(col1,col2,...)
Values(value1,value2,...);

Insert Into TableNameTo(col1,col2,...)
Select col1,col2 
From TableNameFrom
Where Condition
;

Insert Into Learn01
Values(Seq_Learn01_01.Nextval,'rxw',150.22,date'2022-05-17',30.8,to_timestamp('2022-05-17 09:38:00.123','YYYY-MM-DD HH24:MI:SS.FF3'))
;

--  Update
Update TableName
Set ColumnName1 = Value1 [,ColumnName2 = Value2,...]
Where Condition
;

Update Learn01
Set Col03 = To_Date('2022-05-17 18:31:00','YYYY-MM-DD HH24:MI:SS')
Where Length(Replace(To_Char(col03,'YYYY-MM-DD HH24:MI:SS'),' 00:00:00',''))=10
;

--  Delete
Delete From TableName
Where Condition;


--3��DCL:���ݿ�������(Data Control language)
--  Grant��Revoke
--  DCL���ڿ��ƶ����ݿ���������Ȩ�ޣ���ʹ��Grant��Revoke�����û����û��������������ݿ�����Ȩ�ޡ�
--  ���ݿⰲȫ��
--    ϵͳ��ȫ��
--    ���ݰ�ȫ��
--  ϵͳȨ�ޣ��������ݿ��Ȩ��
--  ����Ȩ�ޣ��������ݿ�����Ȩ��
--  ������һ�����ݿ���󼯺ϣ����磺��,��ͼ,����
--
--  ���忴DCL-Grant����



--5��SQL����
--SQL������
--5.1���Ƚϲ�����
--  Exists:�Ƿ���ڷ�������������
--  ALL/ANY:һ�����ݵ�����/���е��κ�һ��
--  Between:����֮��
--5.2�����Ӳ�����
--  ���Ӳ��������ڽ�����ַ���������ֵ�ϲ���һ���ַ���
--  ||
--  Concat

--  Exists
Where Exists (
          Select employee_id
          From employee
          Where employee_id='3333'
      )
      
-- ALL/ANY
Where salary > ALL (
          Select salary
          From employee_tbl
          Where city='INDIAN'
      )
      
--  ||
Select 'Hello' || 'World' As Str From dual;
      
--  Concat
Select Concat('Hello','World') As Str From dual;
      
--  Between
--������200��300֮�䣬����200��300
Where salary Between 200 And 300
