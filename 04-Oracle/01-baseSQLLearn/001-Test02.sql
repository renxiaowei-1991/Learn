--�û���system
--�����ֵ�
select * from user_users;
select * from dba_sys_privs;
select * from user_sys_privs;

select * from dba_users;

alter user hr account lock;
drop user oraclelearn01 cascade;
select * from dba_tablespaces;
select * from dba_data_files;

--��ռ�
drop tablespace PythonLearn01 including contents and datafiles;  --ɾ����ռ�(�������ݺ������ļ�)

create tablespace PythonLearn 
datafile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\PythonLearn01.DBF' size 50M autoextend on next 50M maxsize 1024M
;

--�û�
create user PythonLearn
identified by PythonLearn
default tablespace PythonLearn
temporary tablespace temp
--account lock/unlock
--password expire
;

drop user PythonLearn cascade;

select * from dba_users;
select * from user_users;


--Ȩ��
--��ɫ
create role LearnRole;
grant create session,create table,unlimited tablespace To LearnRole;
grant connect,resource To LearnRole;

--����ɫ��Ȩ���û�
grant LearnRole To OracleLearn;
grant LearnRole To PythonLearn with admin option; --����Ȩ�û������԰��û���Ȩ�������û�
revoke LearnRole From PythonLearn;

--�ռ�ʹ��
select * from dba_data_files;
select * from dba_free_space;

select * from user_tab_columns;
select * from user_tab_comments;
select * from user_col_comments where table_name=upper('dba_free_space');


--�û���OracleLearn
select * from user_users;
select * from user_tables;

select * from PARTITION_TEST01;
select * from PARTITION_TEST02;
select * from PARTITION_TEST03;
select * from PARTITION_TEST04;
select * from C_OVER_TABLE;
select * from LEARN01;
select * from SYS_TEMP_FBT;
select * from EMPLOYEE;
select * from A_TABLE;
select * from B_TABLE;
select * from STOCK;


select * from user_sys_privs;  --ϵͳȨ��
select * from user_role_privs; --��ɫȨ��


--��
drop table tab_learn_01;
create table tab_learn_01(
     id      int Not Null
    ,code    varchar2(20) Not Null
    ,name    varchar2(20) Not Null
    ,num     int Not Null
    ,amt     number(22,4)
    ,dt      date
    ,time    timestamp
    ,dt_date varchar2(10)
    ,type    varchar2(10)
    ,primary key(id)
) 
partition by range(dt_date)
subpartition by list(type)
(
   partition partition_start values less than('2023-07-01')
  (
     subpartition partition_start_01 values('1') tablespace oraclelearn
    ,subpartition partition_start_02 values('2') tablespace oraclelearn
  )
  ,partition partition_20230701 values less than('2023-07-02')
  (
     subpartition partition_20230701_01 values('1') tablespace oraclelearn
    ,subpartition partition_20230701_02 values('2') tablespace oraclelearn
  )
);
comment on table tab_learn_01          is '��ϰ��01';
comment on column tab_learn_01.id      is '����';
comment on column tab_learn_01.code    is '����';
comment on column tab_learn_01.name    is '����';
comment on column tab_learn_01.num     is '����';
comment on column tab_learn_01.amt     is '���';
comment on column tab_learn_01.dt      is '����';
comment on column tab_learn_01.time    is 'ʱ��';
comment on column tab_learn_01.dt_date is '���ڷ���';
comment on column tab_learn_01.type    is '���ͷ���';

--oracle�����ֶ�ֻ����ӵ����һλ�����Ҫָ��λ�ã���Ҫ�½���Ȼ���޸ı���ʵ��
alter table tab_learn_01 add product_no varchar2(10) not null;
comment on column tab_learn_01.product_no is '��Ʒ����';

alter table tab_learn_01 add partition partition_20230702 values less than('2023-07-03')(
   subpartition partition_20230702_01 values('1') tablespace oraclelearn
  ,subpartition partition_20230702_02 values('2') tablespace oraclelearn
);

alter table tab_learn_01 add partition partition_20230703 values less than('2023-07-04')(
   subpartition partition_20230703_01 values('1') tablespace oraclelearn
  ,subpartition partition_20230703_02 values('2') tablespace oraclelearn
);

alter table tab_learn_01 add partition partition_20230704 values less than('2023-07-05')(
   subpartition partition_20230704_01 values('1') tablespace oraclelearn
  ,subpartition partition_20230704_02 values('2') tablespace oraclelearn
);

alter table tab_learn_01 add partition partition_20230705 values less than('2023-07-06')(
   subpartition partition_20230705_01 values('1') tablespace oraclelearn
  ,subpartition partition_20230705_02 values('2') tablespace oraclelearn
);

alter table tab_learn_01 add partition partition_20230706 values less than('2023-07-07')(
   subpartition partition_20230706_01 values('1') tablespace oraclelearn
  ,subpartition partition_20230706_02 values('2') tablespace oraclelearn
);

alter table tab_learn_01 add partition partition_20230707 values less than('2023-07-08')(
   subpartition partition_20230707_01 values('1') tablespace oraclelearn
  ,subpartition partition_20230707_02 values('2') tablespace oraclelearn
);

select * from user_tables where table_name=upper('tab_learn_01');
select * from user_tab_columns where table_name=upper('tab_learn_01');
select * from user_tab_comments where table_name=upper('tab_learn_01');
select * from user_col_comments where table_name=upper('tab_learn_01');


--����
drop sequence seq_learn_01;
create sequence seq_learn_01
start with 1000000001  --��ʼֵ
increment by 1  --����
maxvalue 9999999999  --���ֵ
nocycle  --��ѭ��
nocache  --������
;



--���ݲ���
insert into tab_learn_01
select     seq_learn_01.nextval as id
          ,concat('AAAAAA',seq_learn_01.currval) as code
          ,concat('Name_', a1.num) as name
          ,a1.num as num
          ,round(DBMS_RANDOM.VALUE(0, 10000), 2) as amt
          ,sysdate as dt
          ,systimestamp as time
          ,to_char(sysdate, 'YYYY-MM-DD') as dt_date
          ,'1' as type
          ,'1001' as product_no
from (select ABS(MOD(DBMS_RANDOM.RANDOM, 1000000000)) as num from dual) a1
;


select * from tab_learn_01
