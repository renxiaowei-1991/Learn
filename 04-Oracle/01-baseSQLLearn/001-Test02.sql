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

drop user PythonLearn cascade;  --ɾ���û�������ɾ��

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



--����
drop sequence seq_learn_01;
create sequence seq_learn_01
start with 1000000001  --��ʼֵ
increment by 1  --����
maxvalue 9999999999  --���ֵ
nocycle  --��ѭ��
nocache  --������
;


--������
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



--��Ʒά��
create table tab_learn_02(
     id      int not null
    ,product_no   varchar2(10) not null
    ,product_name varchar2(100) not null
    ,product_type varchar2(10) not null
    ,craete_date  varchar2(19) not null
    ,update_date  varchar2(19) default to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')  --�̶�ֵ��not null����ͬʱ����
    ,yn_flag      varchar2(2)  default '1'  --�̶�ֵ��not null����ͬʱ����
    ,primary key(id)
);



--���ݲ���:�����ָ���������Ǿ��ǰ�˳��ȫ���ֶβ���
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

--���ݲ��룺���ָ�����������ǰ�ָ��˳��ָ���ֶΣ����ֻ���ȫ���ֶβ���(���Ե����ֶ�˳��)
insert into tab_learn_01(
           id
          ,code
          ,name
          ,num
          ,amt
          ,dt
          ,time
          ,product_no
          ,dt_date
          ,type
)
select     seq_learn_01.nextval as id
          ,concat('AAAAAA',seq_learn_01.currval) as code
          ,concat('Name_', a1.num) as name
          ,a1.num as num
          ,round(DBMS_RANDOM.VALUE(0, 10000), 2) as amt
          ,sysdate as dt
          ,systimestamp as time
          ,'1001' as product_no
          ,to_char(sysdate, 'YYYY-MM-DD') as dt_date
          ,'1' as type
from (select ABS(MOD(DBMS_RANDOM.RANDOM, 1000000000)) as num from dual) a1
;
commit;

select * from tab_learn_01


--���ݸ���
update tab_learn_01 a1 set a1.product_no = '1002'
where a1.product_no = '1001'
;
commit;


--����&���ݻָ�
--  ��������
delete from tab_learn_01 where product_no = '1002';
commit;

select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;
--��ѯʲôʱ��㱻ɾ�������ݻ�����
select * from tab_learn_01 as of timestamp to_timestamp('2023-07-05 12:05:00','YYYY-MM-DD HH24:MI:SS');
--flashbackʹ��ǰ��Ҫ������Ǩ��
alter table tab_learn_01 enable row movement; 
--�������ݻָ���ָ��ʱ����״̬
flashback table tab_learn_01 to timestamp to_timestamp('2023-07-05 12:05:00','YYYY-MM-DD HH24:MI:SS');
--�ر���Ǩ��
alter table tab_learn_01 disable row movement;

--  ������
drop table tab_learn_01;
commit;

select * from tab_learn_01;
select * from dba_recyclebin where original_name = upper('tab_learn_01') order by droptime desc ;
select * from dba_col_comments where table_name = upper('dba_recyclebin');
select * from dba_objects where object_name = 'BIN$0uHr8DW0SsuacBXxnYjq7A==$0'
--�ָ�����Ҫ������Ǩ��
flashback table tab_learn_01 to before drop;



--ʱ���ʽʹ��
select date'2023-07-05' from dual;
select to_date('2023-07-05', 'YYYY-MM-DD') from dual;
select to_date('2023-07-05 12:48:00', 'YYYY-MM-DD HH24:MI:SS') from dual;
select to_timestamp('2023-07-05', 'YYYY-MM-DD') from dual;
select to_timestamp('2023-07-05', 'YYYY-MM-DD HH24:MI:SS') from dual;
select to_timestamp('2023-07-05 12:48:00', 'YYYY-MM-DD HH24:MI:SS') from dual;
select to_timestamp('2023-07-05 12:48:00.123456', 'YYYY-MM-DD HH24:MI:SS.FF6') from dual;
select to_timestamp('2023-07-05 12:48:00.123456789', 'YYYY-MM-DD HH24:MI:SS.FF9') from dual;

select to_char(to_timestamp('2023-07-05 12:48:00.123456', 'YYYY-MM-DD HH24:MI:SS.FF6'), 'YYYY-MM-DD') from dual;

select to_char(to_date('2023-07-05', 'YYYY-MM-DD')+1, 'YYYY-MM-DD') from dual;

--��ĩ
select last_day(to_date('2023-07-05', 'YYYY-MM-DD')) from dual;
--add_months(date_add/date_sub������)
select add_months(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;
--��һ�����ڼ�:���ָ�ʽ������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 2) from dual;  --��һ������һ
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 3) from dual;  --��һ�����ڶ�
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 4) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 5) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 6) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 7) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'SUNDAY'   ) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'MONDAY'   ) from dual;  --��һ������һ
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'TUESDAY'  ) from dual;  --��һ�����ڶ�
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'WEDNESDAY') from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'THURSDAY' ) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'FRIDAY'   ) from dual;  --��һ��������
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'SATURDAY' ) from dual;  --��һ��������



--��ͼ
create or replace view v_tab_learn_01
as
select id,code,name,product_no,dt_date,type
from tab_learn_01
where dt_date='2023-07-05'
;


--��ͼ���б���ָ��
create or replace view v_tab_learn_02(
    col1,col2,col3,col4,col5,col6
)
as
select id,code,name,product_no,dt_date,type
from tab_learn_01
where dt_date='2023-07-05'
;

select * from v_tab_learn_01;
select * from v_tab_learn_02;




--����
create or replace function self_date_add(in_date date, num int)
return date
--ʵ��date_add����
is
  out_date date;
begin
  out_date := in_date + num;
  return out_date;
end;

create or replace function self_date_sub(in_date date, num int)
return date
--ʵ��date_sub����
is
  out_date date;
begin
  out_date := in_date - num;
  return out_date;
end;


select self_date_add(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;
select self_date_sub(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;


--�α�



--�洢����
