--003-Oracle�����ֵ�
--Oracle�����ֵ�
select * from dba_tablespaces;
select * from dba_free_space;
select * from dba_tables where tablespace_name='ORACLELEARN';
select * from employee;
select * from dba_all_tables where tablespace_name='ORACLELEARN';
select * from dba_tab_columns where owner='ORACLELEARN' and table_name='EMPLOYEE' order by column_id;
select * from dba_views where owner='ORACLELEARN';
select * from VIEW_LEARN01;
select * from dba_sequences where sequence_owner='ORACLELEARN';
select * from dba_constraints where owner='ORACLELEARN';
select * from dba_indexes where owner='ORACLELEARN';
select * from dba_ind_columns where index_owner='ORACLELEARN';
select * from dba_triggers where owner='ORACLELEARN';
select *from dba_source where name='STANDARD';
select * from dba_data_files order by tablespace_name,file_name;
select * from dba_tab_privs where owner='ORACLELEARN';
select * from dba_objects where owner='ORACLELEARN' and object_type like '%PARTITION%';
select * from dba_users;
select * from dba_sys_privs where grantee='ORACLELEARN';
select 1 from dual;
select * from user_all_tables;
select * from all_col_comments where owner='ORACLELEARN';
select * from user_col_comments;
select * from all_tab_comments where owner='ORACLELEARN';
select * from user_tab_comments;
select * from dba_directories;

--Oracle���ö�̬������ͼ
select * from v$database;
select * from v$datafile;
select * from v$log;
select * from v$logfile;
select * from v$controlfile;
select * from v$instance;
select * from v$system_parameter;
select * from v$lock;
select * from v$session;
select * from v$sql;
select * from v$sqltext;


--004-SQL21day
--1��DDL�����ݶ�������
--  TableSpace
select * from dba_tablespaces;
select * from dba_data_files;


--DDL:TableSpace
--  ������ռ�
Create TableSpace OracleLearn01
DataFile 
 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN03.DBF' Size 100M Autoextend On Next 50M Maxsize Unlimited
,'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN04.DBF' Size 100M Autoextend On Next 50M Maxsize Unlimited
Extent Management Local  --��ռ����:���ع���
;

--��չ��ռ��ļ�
Alter TableSpace OracleLearn01
Add DataFile 
'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN05.DBF' Size 100M Autoextend On Next 50M Maxsize Unlimited
;

--ɾ����ռ��ļ�
Alter TableSpace OracleLearn01
Drop DataFile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN05.DBF'
;

--DDL TableSpace
--  ��ռ�ʹ�����
select     Upper(free.TableSpace_name) As "��ռ�"
          ,Data.sum_types As "��ռ��С(M)"
          ,Data.sum_types - Free.sum_types As "��ʹ�ÿռ�(M)"
          ,Free.sum_types As "���б�ռ�"
          ,To_Char(Round((Data.sum_types - Free.sum_types)/data.sum_types*100,2),'990.99')||'%' As "ʹ�ñ�"
from (select     TableSpace_Name
                ,Round(Sum(Bytes)/1024/1024,2) As Sum_Types
                ,Round(Max(Bytes)/1024/1024,2) as Max_Types
      from Dba_Free_Space 
      group by TableSpace_Name
     ) free
,(select TableSpace_name,Round(sum(Bytes)/1024/1024,2) As Sum_Types
  from dba_data_files 
  group by TableSpace_name
 ) data
where free.TableSpace_name = data.TableSpace_name


--DDL:User
select * from dba_users where username='ORACLELEARN01';
select * from dba_sys_privs where grantee='ORACLELEARN01';

--  �����û�
Create User OracleLearn01
Identified by OracleLearn01
Default TableSpace OracleLearn01
Temporary TableSpace Temp
;

--  �û���Ȩ
Grant Connect,Resource,Dba to OracleLearn01;
Grant Create Session to OracleLearn01;
Grant Create Table to OracleLearn01;
Grant Unlimited TableSpace to OracleLearn01;

--  ����Ȩ��
Revoke Create Table From OracleLearn01;

--  �޸��û�����
Alter User OracleLearn01 Identified by OracleLearn01;

--  ɾ���û�
Drop User OracleLearn01 Cascade;

--DDL:Table
select * from dba_all_tables where owner='ORACLELEARN01';
select * from dba_tab_columns where owner='ORACLELEARN01';

Create Table Learn02(
     id int Not Null
    ,Col01 Varchar(20) Not Null
    ,Col02 Decimal(22,4) Not Null
    ,Col03 Date Default SysDate
    ,Primary Key(id)
) TableSpace OracleLearn01
;
Comment On Table Learn02 Is '��ϰ��02';
Comment On Column Learn02.id Is '����';
Comment On Column Learn02.Col01 Is '�ֶ�1';
Comment On Column Learn02.Col02 Is '�ֶ�2';
Comment On Column Learn02.Col03 Is '�ֶ�3';

Alter Table Learn02 Add Col04 number(22,4) Not Null;
Alter Table Learn02 Add Col05 timestamp(6) Not Null;
Alter Table Learn02 Add Col06 number(22,4) Not Null;
Comment On Column Learn02.Col04 Is '�ֶ�4';
Comment On Column Learn02.Col05 Is '�ֶ�5';
Comment On Column Learn02.Col06 Is '�ֶ�6';

Alter Table Learn02 Modify col02 Decimal(24,4);
Alter Table Learn02 Drop (col06);

Truncate Table Learn02;
Insert Into Learn02 Values(100001,'rxw',150.22,SysDate,30.80,SysDate);
Insert Into Learn02
Values(100002
      ,'rxw'
      ,150.22
      ,to_date('2023-04-23 21:01:19','YYYY-MM-DD HH24:MI:SS')
      ,30.80
      ,to_timestamp('2023-04-23 21:01:19.123456','YYYY-MM-DD HH24:MI:SS.FF6')
      );
Insert Into Learn02 Values(100003,'rxw',150.22,SysDate,30.80,Systimestamp);
Commit;

select * from Learn02;

Drop Table Learn02;  --���Իָ�
Truncate Table Learn02;  --��ձ����ɻָ�
Alter Table Learn02 Rename To Learn03;

select * from dba_tables where owner='ORACLELEARN01';
select * from dba_tab_columns where owner='ORACLELEARN01';
select * from dba_tab_comments where owner='ORACLELEARN01';
select * from dba_col_comments where owner='ORACLELEARN01';

--DDL:View
Create Or Replace View View_Learn02
As
Select * From Learn02
Where Col01='rxw'
;

Create Or Replace View View_Learn03(
     id,Name,Weight,Time,Age,DateA
) 
AS
select id,Col01,Col02,Col03,Col04,Col05
from learn02
;

select * from View_Learn02;
select * from View_Learn03;

Drop View View_Learn02;

select * from user_views;


--DDL:View
Create Index Index_Learn_02 On Learn02(Col01);
Create Index Index_Learn_03 On Learn02(Upper(Col01));
Create Index Index_Learn_04 On Learn02(Lower(Col01));

select * from Learn02 where upper(Col01)='RXW';

Drop Index Index_Learn_04;

select * from dba_indexes where owner='ORACLELEARN01';
select * from dba_ind_columns where index_owner='ORACLELEARN01';