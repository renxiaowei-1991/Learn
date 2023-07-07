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

drop user PythonLearn cascade;  --删除用户：级联删除

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



--序列
drop sequence seq_learn_01;
create sequence seq_learn_01
start with 1000000001  --起始值
increment by 1  --步长
maxvalue 9999999999  --最大值
nocycle  --不循环
nocache  --不缓存
;


--表：分区
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



--产品维表
create table tab_learn_02(
     id      int not null
    ,product_no   varchar2(10) not null
    ,product_name varchar2(100) not null
    ,product_type varchar2(10) not null
    ,craete_date  varchar2(19) not null
    ,update_date  varchar2(19) default to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')  --固定值和not null不能同时设置
    ,yn_flag      varchar2(2)  default '1'  --固定值和not null不能同时设置
    ,primary key(id)
);



--数据插入:如果不指定列名，那就是按顺序，全量字段插入
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

--数据插入：如果指定列名，就是按指定顺序，指定字段，部分或者全量字段插入(可以调整字段顺序)
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


--数据更新
update tab_learn_01 a1 set a1.product_no = '1002'
where a1.product_no = '1001'
;
commit;


--闪回&数据恢复
--  数据闪回
delete from tab_learn_01 where product_no = '1002';
commit;

select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;
--查询什么时间点被删除的数据还存在
select * from tab_learn_01 as of timestamp to_timestamp('2023-07-05 12:05:00','YYYY-MM-DD HH24:MI:SS');
--flashback使用前需要开启行迁移
alter table tab_learn_01 enable row movement; 
--将表数据恢复到指定时间点的状态
flashback table tab_learn_01 to timestamp to_timestamp('2023-07-05 12:05:00','YYYY-MM-DD HH24:MI:SS');
--关闭行迁移
alter table tab_learn_01 disable row movement;

--  表闪回
drop table tab_learn_01;
commit;

select * from tab_learn_01;
select * from dba_recyclebin where original_name = upper('tab_learn_01') order by droptime desc ;
select * from dba_col_comments where table_name = upper('dba_recyclebin');
select * from dba_objects where object_name = 'BIN$0uHr8DW0SsuacBXxnYjq7A==$0'
--恢复表不需要开启行迁移
flashback table tab_learn_01 to before drop;



--时间格式使用
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

--月末
select last_day(to_date('2023-07-05', 'YYYY-MM-DD')) from dual;
--add_months(date_add/date_sub不存在)
select add_months(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;
--下一个星期几:两种格式都可以
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;  --下一个星期日
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 2) from dual;  --下一个星期一
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 3) from dual;  --下一个星期二
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 4) from dual;  --下一个星期三
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 5) from dual;  --下一个星期四
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 6) from dual;  --下一个星期五
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 7) from dual;  --下一个星期六
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'SUNDAY'   ) from dual;  --下一个星期日
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'MONDAY'   ) from dual;  --下一个星期一
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'TUESDAY'  ) from dual;  --下一个星期二
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'WEDNESDAY') from dual;  --下一个星期三
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'THURSDAY' ) from dual;  --下一个星期四
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'FRIDAY'   ) from dual;  --下一个星期五
select next_day(to_date('2023-07-05', 'YYYY-MM-DD'), 'SATURDAY' ) from dual;  --下一个星期六



--视图
create or replace view v_tab_learn_01
as
select id,code,name,product_no,dt_date,type
from tab_learn_01
where dt_date='2023-07-05'
;


--视图：列别名指定
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




--函数
create or replace function self_date_add(in_date date, num int)
return date
--实现date_add功能
is
  out_date date;
begin
  out_date := in_date + num;
  return out_date;
end;

create or replace function self_date_sub(in_date date, num int)
return date
--实现date_sub功能
is
  out_date date;
begin
  out_date := in_date - num;
  return out_date;
end;


select self_date_add(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;
select self_date_sub(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;


--游标



--存储过程
