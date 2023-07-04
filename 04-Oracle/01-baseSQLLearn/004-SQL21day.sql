--SQL:结构化查询语音(Structured Query Language)
--DDL:数据定义语音(Data Definition language)
--  Create、Drop、Alter
--  DDL自动提交事务
--DML:数据操作语言(Data Manipulation Language)
--  Insert、Delete、Update、Selete
--  DML不自动提交事务
--DCL:数据控制语言(Data Control language)
--  Grant、Revoke
--  DCL自动提交事务
--TCL:事务控制语言(Transactional Control Language)
--  Commit、RollBack、Savepoint
--  TCL自动提交事务

--1、DDL:数据定义语音(Data Definition language)
--  TableSapce
--  User
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_users where username='ORACLELEARN';
select * from dba_sys_privs where grantee='ORACLELEARN';

--DDL:TableSpace
--  创建表空间  https://www.cnblogs.com/hftian/p/6993614.html
--Reuse 需要放在 Size 100M 后

Create TableSpace OracleLearn  --表空间名称
DataFile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN01.DBF'  --表空间包含的数据文件
Size 100M  --数据文件初始化大小
Reuse  --文件是否被重用
Autoextend On  --是否自动扩展
Next 50M  --下一次扩展的大小
MaxSize Unlimited,  --数据文件最大限制
'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN02.DBF'
Size 100M Reuse Autoextend On Next 50M MaxSize Unlimited  --数据文件最大限制
Extent ManageMent Local  --表空间管理:本地管理(可以不限定)
Segment Space ManageMent Auto  --段空间管理:自动
;

--DDL:TableSpace
--  修改表空间:增加文件  https://www.php.cn/oracle/488273.html
Alter TableSpace OracleLearn
Add DataFile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN03.DBF'
Size 100M Reuse AutoExtend On Next 50M MaxSize Unlimited
;

--DDL:TableSpace
--  修改表空间:删除文件
Alter TableSpace OracleLearn Drop DataFile 'E:\APP\ADMINISTRATOR\ORADATA\ORCL\ORACLELEARN03.DBF';


--DDL:TableSpace
--查看表空间使用情况
Select     Upper(Free.TableSpace_Name) As "表空间名"
          ,Data.Sum_Bytes As "表空间大小(M)"
          ,Data.Sum_Bytes - Free.Sum_Bytes As "已使用空间(M)"
          ,Free.Sum_Bytes As "空闲表空间"
          ,Free.Max_Bytes As "最快(M)"
          ,To_Char(Round((Data.Sum_Bytes - Free.Sum_Bytes)/Data.Sum_Bytes*100,2),'990.99')||'%' As "使用比"
From (Select     TableSpace_Name
                ,Round(Sum(Bytes)/1024/1024,2) As Sum_Bytes
                ,Round(Max(Bytes)/1024/1024,2) As Max_Bytes
      From Dba_Free_Space  --空闲表空间
      Group By TableSpace_Name
     ) Free
,(Select TableSpace_Name,Round(Sum(Bytes)/1024/1024,2) As Sum_Bytes
  From Dba_Data_Files  --数据库文件表
  Group By TableSpace_Name
  ) Data
Where Free.TableSpace_Name = Data.TableSpace_Name
Order By 1
;


--DDL:User
--  创建用户
Create User OracleLearn  --用户名
Identified By OracleLearn  --密码
Default TableSpace OracleLearn  --默认表空间
Quota Unlimited on OracleLearn  --默认表空间中可以使用的空间配额，无限(可以不写)
Temporary TableSpace Temp  --临时表空间
--Password Expire  --密码状态，过期。登录的时候要求用户修改
;

--管理用户
--Sys:数据库管理系统的权限，包括底层的数据库软件
--System:数据库实例的权限
--最大的区别就是，创建实例只能用Sys用户，一般情况下Dba角色的权限相当于System

--  用户授权
Grant Connect,Resource,Dba to OracleLearn;  --授权(DBA权限)
Grant Create Session to OracleLearn;  --授权(可以登录)
Grant Create Table to OracleLearn;  --授权(建表)
Grant Unlimited TableSpace to OracleLearn;  --授权(访问表空间，修改表空间)

--  撤销权限
Revoke Create Table From OracleLearn;

--  修改用户密码
Alter User OracleLearn Identified by OracleLearn;

--  删除用户
Drop User OracleLearn Cascade;  --级联删除(Cascade)

select * from dba_users;
select * from dba_sys_privs;


--DDL:Table
--  创建表
--  Create Table TableName(
--       ColName ColProperties Constraint
--  	 ...
--  ) TableSpace TableSpaceName
--  ;
--  
--  TableName:表名
--  ColName:列名
--  TableSpaceName:表空间
--注意：字段类型会自动转换成Oracle本身支持的类型
Create Table Learn01(
     id int Not Null
    ,col01 varchar(20) Not Null
    ,col02 Decimal(22,4) Not Null
    ,col03 Date Default SysDate
    ,Primary Key(id)
) TableSpace OracleLearn
;
--  添加注释
Comment On Table Learn01 Is '练习表01';
Comment On Column Learn01.id Is '主键';
Comment On Column Learn01.col01 Is '字段1';
Comment On Column Learn01.col02 Is '字段2';
Comment On Column Learn01.col03 Is '字段3';

Select * from dba_all_tables where owner ='ORACLELEARN';
Select * from dba_tab_columns where owner ='ORACLELEARN';

--  修改表结构
--  Alter Table TableName Modify ColName ColProperties;
--  Alter Table TableName Add ColName ColProperties;
--  Alter Table TableName Drop ColName ColProperties;
Alter Table Learn01 Add col04 number(22,4) Not Null;
Alter Table Learn01 Add col05 timestamp(6) Not Null;
Alter Table Learn01 Add col06 number(22,4) Not Null;
Comment On Column Learn01.col04 Is '字段4';
Comment On Column Learn01.col05 Is '字段5';
Comment On Column Learn01.col06 Is '字段5';

--如果已经存在数据，想要将列的数据类型调小，最小不能小于现有数据的最大长度
Alter Table Learn01 Modify col02 Decimal(24,4);
Alter Table Learn01 Drop (col06);  --字段名需要用括号括起来

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

--  删除表:可以恢复
Drop table Learn01;
--  清空表:不能恢复
Truncate Table Learn01;
--  修改表
Alter Table Learn01 Rename To Learn02;

select * from dba_tables;
select * from dba_tab_columns;
select * from dba_tab_comments;


--DDL:View
--视图
--  视图是从表中抽出的逻辑上相关的数据集合(存储在数据库中的预先定义好的查询)
--  具有表的外观，可以象表一样对其进行存取，但不占据物理存储空间
--视图的特定
--  视图的存在依赖于生成视图的表
--  视图能用作数据库安全的一种形式
--  利用视图维护综合数据
--视图的有点
--  控制数据访问；简化查询；数据独立性；
--创建视图的语法
--  Create [Or Replace] [Force|NoForce] View ViewName
--  As
--  SubQuery
--  [With Check Option [Constraint constraint]]
--  [With Read Only [Constraint constraint]]
--  ;
--  
--  SubQuery:子查询，可以是复杂的select语句
--  Force:即使基表不存在，也强制创建视图。默认值(NoForce)
--  Or Replace:如果视图已经存在，则替换旧视图
--  With Check Option:表名只有子查询检索的行才能被插入、删除、更新。
--    默认情况下，在增删改 行之前并不会检查这些行是否被子查询检索。
--  With Read Only:默认可以通过视图对基表进行增删改操作，但是有很多在基表上的限制
--    (比如：基表中某列不能为空，但是该列没有出现在视图中，则不能通过视图执行Insert操作)
--    With Read Only 说明视图是只读视图，不能通过该视图进行增删改操作。
--    现实开发中，基本不通过视图对表中的数据进行增删改操作
Create Or Replace View View_Learn01
As
Select id,col01,col02,col03,col04
From Learn01
Where col01 = 'rxw'
;

--Create View 子句中各列的别名应和子查询中各列相对应
Create Or Replace NoForce View View_Learn01_01(
     id,name,weight,time,age
)
As
Select id,col01,col02,col03,col04
From Learn01
Where col01 = 'rxw'
With Read Only
;

--  删除视图
--    删除视图，由此视图导出的其他视图也将自动被删除。
--    若导出此视图的基本表被删除了，则此视图也将自动删除。
Drop View ViewName;

select * from View_Learn01_01
select * from user_views;

--DDL:Index
--索引
--  索引是对数据库表中一列或多列的值进行排序的一种结构，使用索引可快速访问数据库表中的特定信息。
--索引的特点
--  一种数据库对象
--  通过指针加速Oracle服务器的查询速度
--  通过快速定位数据的方法，减少磁盘I/O
--  索引与表相互独立
--  Oracle服务器自动使用和维护索引
--创建索引：
--  Create [Unique][Cluster] Index IndexName
--  On TableName(ColName 升/降序,......)
--  ;
--  
--  Asc:升序,Desc:降序
--  Unique:每一个索引只对应唯一的数据记录
--  Cluster:聚簇索引，是指索引项的顺序与表中记录的物理顺序一致的索引组织。
--
--建议创建索引的情况
--  列中数据值分布范围很广
--  列中包含大量空值
--  列经常在where子句或连接条件中出现
--  表经常被访问而且数据量很大，访问的数据大概占数据总量的2%到4%(操作2%-4%，就直接全表查询了)
--
--不建议创建索引的情况
--  表很小
--  列不经常作为连接条件或出现在where子句中
--  查询的数据大于2%到4%
--  表经常更新
--  加索引的列包含在表达式中
--
--创建索引：
--  自动创建：在定义primary key或unique约束后系统自动在相应的列上创建唯一性索引
--  手动创建：用户可以在其它列上创建非唯一的索引，以加速查询
Create Index Index_learn01_01 On Learn01(col01);

--  基于函数的索引：基于函数的索引是一个基于表达式的索引
--    索引表达式由列,常量,SQL函数和用户自定义的函数
Create Index Index_Learn01_02
On Learn01(Upper(col01));
Create Index Index_Learn01_03
On Learn01(Lower(col01));

--查询的时候走函数索引
Select * from Learn01 
where Lower(col01)='rxw';

--删除索引
Drop Index IndexName;

select * from user_indexes;
select * from user_ind_columns;


--DDL:Sequence
--序列 https://blog.csdn.net/Ezreal_XLove/article/details/112850902
--  序列是被排成一列的对象(或事件)；每个元素不是在其他元素之前，就是在其他元素之后。
--  是有序增加或减少相同步长的一组序号
--序列特定
--  自动提供唯一的数值
--  共享对象
--  主要用于提供主键值
--  代替应用代码
--  将序列值装入内存可以提高访问效率
--
--创建序列
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
--    步长为num1，num1可以是正数或者负数，但都必须是整数，默认为1，不可以是0(为0就失去了序列的意义)
--    当num1为正数时序列值越来越大，为负数是越来越小
--  Start With num2:
--    定义序列的初始值或起始值num2，这是序列的第一个值，默认值是1
--  MaxValue num3 | NoMaxValue:
--    定义序列可以生产的最大值num3。不设定最大值，则默认为NoMaxValue。
--  MinValue num4 | NoMinValue:
--    定义序列可以产生的最小值num4。不设定最小值，则默认为NoMinValue。
--  Cycle | NoCycle:
--    定义序列生成的值达到最大时是否循环，NoCycle表示不循环，如果一个序列需要很长时间才能用完，可以考虑使用循环序列。
--    下一个循环开始值，在User_sequence中的last_number字段可以查看
--  Cache num5 | NoCache:
--    定义序列是否使用缓存，及缓存块的大小，默认大小为20。
--  Order:
--    Order选项，定义序列是否按顺序发生，默认为No。
--    在单实例数据库中没有区别，因为序列一定是按序发生的。
--    在集群环境中，假如缓存Cache=20，实例1取了1-20，存储到内存中；实例2再引用同一序列时，会取21-40...这样在多实例中取到的序列值就会不同，Order定义后集群的每个实例都要按照顺序得到序列值。
Create Sequence Seq_Learn01_01
Increment By 1
Start With 1000000001
MaxValue 9999999999
NoCycle
NoCache
;

--  获取序列值
--    SequenceName.currval:获取序列当前值
--      注意：首次查询序列的当前值的时候，会报错ora-08002。原因是：首次查询的时候，内存中并没有缓存序列的任何值，所以需要先查询一下序列的下一个值(此时，Oracle会自动缓存已查询的序列值)，再查询序列的当前值
--    SequenceName.nextval:获取序列下一个值
select Seq_Learn01_01.currval from dual;
select Seq_Learn01_01.nextval from dual;

--  修改序列
Alter Sequence SequenceName Increment By Num1;
Alter Sequence SequenceName MaxValue Num2;
Alter Sequence SequenceName Cache Num3;

--  序列注意点：
--    序列是共享的调用，有引用权限的用户都可以引用它
--    当事务回滚时，事务中增删改的数据可以回退，但序列不会回退。
--    在一个表中，序列递增的字段值可能会中断、不连续，原因是其它对象引用了这个序列，即使是dual虚拟表的引用。
--    NoCache设定时，每次引用序列都需要计算，会消耗性能；Cache时，只再缓存时计算一次；如果想快速的生成序列值，请将Cache值加大，实际引用场景，如订单号。
--    如果想用序列值作为主键，序列一定要定义为NoCycle

--  序列应用
Insert Into Learn01
Values(Seq_Learn01_01.Nextval,'rxw',150.22,date'2022-05-17',30.8,to_timestamp('2022-05-17 09:38:00.123','YYYY-MM-DD HH24:MI:SS.FF3'))
;

select * from learn01
select * from user_sequences;

--  序列删除
Drop Sequence SequenceName;



--2、DML:数据操作语言(Data Manipulation Language)
--  Insert、Delete、Update、Selete

--  Insert
--    没有被指定的字段，数据插入后为null
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


--3、DCL:数据控制语言(Data Control language)
--  Grant、Revoke
--  DCL用于控制对数据库对象操作的权限，它使用Grant和Revoke语句对用户或用户组授予或回收数据库对象的权限。
--  数据库安全性
--    系统安全性
--    数据安全性
--  系统权限：对于数据库的权限
--  对象权限：操作数据库对象的权限
--  方案：一组数据库对象集合，例如：表,视图,序列
--
--  具体看DCL-Grant部分



--5、SQL基础
--SQL操作符
--5.1、比较操作符
--  Exists:是否存在符合条件的数据
--  ALL/ANY:一组数据的所有/其中的任何一个
--  Between:两者之间
--5.2、连接操作符
--  连接操作符用于将多个字符串或数据值合并成一个字符串
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
--工资在200到300之间，包括200和300
Where salary Between 200 And 300
