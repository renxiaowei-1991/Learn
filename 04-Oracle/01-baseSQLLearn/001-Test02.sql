--用户：system
--数据字典
select * from user_users;
select * from dba_sys_privs;
select * from user_sys_privs;

select * from dba_users;

alter user hr account lock;
drop user oraclelearn01 cascade;
select * from dba_tablespaces;
select * from dba_data_files;

--表空间
drop tablespace PythonLearn01 including contents and datafiles;  --删除表空间(包括内容和数据文件)

create tablespace PythonLearn 
datafile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\PythonLearn01.DBF' size 50M autoextend on next 50M maxsize 1024M
;

--用户
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


--权限
--角色
create role LearnRole;
grant create session,create table,unlimited tablespace To LearnRole;
grant connect,resource To LearnRole;

--将角色赋权给用户
grant LearnRole To OracleLearn;
grant LearnRole To PythonLearn with admin option; --被赋权用户还可以把用户赋权给其它用户
revoke LearnRole From PythonLearn;

--空间使用
select * from dba_data_files;
select * from dba_free_space;

select * from user_tab_columns;
select * from user_tab_comments;
select * from user_col_comments where table_name=upper('dba_free_space');


--用户：OracleLearn
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


select * from user_sys_privs;  --系统权限
select * from user_role_privs; --角色权限


--表
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
comment on table tab_learn_01          is '练习表01';
comment on column tab_learn_01.id      is '主键';
comment on column tab_learn_01.code    is '编码';
comment on column tab_learn_01.name    is '名字';
comment on column tab_learn_01.num     is '数量';
comment on column tab_learn_01.amt     is '金额';
comment on column tab_learn_01.dt      is '日期';
comment on column tab_learn_01.time    is '时间';
comment on column tab_learn_01.dt_date is '日期分区';
comment on column tab_learn_01.type    is '类型分区';

--oracle新增字段只能添加到最后一位。如果要指定位置，需要新建表，然后修改表名实现
alter table tab_learn_01 add product_no varchar2(10) not null;
comment on column tab_learn_01.product_no is '产品编码';

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


--序列
drop sequence seq_learn_01;
create sequence seq_learn_01
start with 1000000001  --起始值
increment by 1  --步长
maxvalue 9999999999  --最大值
nocycle  --不循环
nocache  --不缓存
;



--数据插入
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
