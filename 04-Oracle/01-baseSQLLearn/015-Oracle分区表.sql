--分区表&分区索引
  Oracle对于分区表方式其实就是将表分段存储，一般普通表格是一个段存储，而分区表会分成多个段。
  所以查找数据过程都是先定位，根据查询条件定位分区范围，即数据在哪个分区或哪几个分区内部，然后在分区内部去查找数据。
  一个分区一般保证四十多万条数据就比较正常了。
  
  但是分区表并非乱建立，而其维护性也相对较为复杂一点，而索引的创建也有讲究。
  
1、分区类型
1) range分区方式(范围分区)
  也是常用的分区方式，其通过某字段或几个字段的组合的值，从小到大，按照指定的范围说明进行分区。
  在Insert数据的时候就会存储到指定的分区中。
2) list分区方式(列表分区)
  一般是在range基础上做的二级分区较多，是一种列举方式进行分区。
  一般将某些地区、状态或指定规则的编码等进行划分。
3) hash分区方式
  没有固定的规则，由Oracle管理，只需要将值Insert进去，Oracle会自动根据一套Hash算法去划分分区。
  只需要告诉Oracle要分几个区即可。
  
注意：
  1、分区可以进行两两组合，Oracle 11g以前两两组合都必须以range作为一级分区的开头，Oracle目前最多支持2级分区。
  2、分区，需要先创建，再插入数据

  
2、分区练习
/*
 *分区操作
 *经过测试确认
 *  范围分区中如果是两个值，插入数据的时候只需要有一个值小于分区范围即可
 *  如果插入一个值，插入的数据中该字段必须小于一个分区的范围
 */

--子分区表测试01
--  创建子分区表指定表空间的时候只能在子分区后面指定(因为子分区才是实际存在的分区)
Create Table Partition_Test01(
     Table_Name Varchar2(30)
    ,Data_Date Varchar2(10)
    ,Busi_Type Varchar2(2)
    ,Pk_Run Varchar2(20)
) Partition By Range(Data_Date,Busi_Type)
SubPartition By List(Pk_Run)
(
  Partition test_20220101_1 Values Less Than('2022-01-01','2')
  (
    SubPartition test_20220101_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
  ),
  Partition test_20220102_1 Values Less Than('2022-01-02','2')
  (
    SubPartition test_20220102_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
  )
);

Insert Into Partition_Test01 Values('partition_test','2021-12-31','1','1001A210000000001EFL');
Insert Into Partition_Test01 Values('partition_test','2021-12-31','2','1001A210000000001EFL');
Insert Into Partition_Test01 Values('partition_test','2022-01-01','2','1001A210000000001EFL');

--新增表分区
Alter Table Partition_Test01 
Add Partition test_20220103_1 Values Less Than('2022-01-03','2')
(
   SubPartition test_20220103_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
);
--这条数据查不到 test_20220102_1 分区中，需要新增分区
Insert Into Partition_Test01 Values('partition_test','2022-01-02','2','1001A210000000001EFL');

--分区表查询-按照分区查询(partition(分区名(不能用引号括起来)))
select * from Partition_Test01 partition(TEST_20220102_1)

--分区表数据字典
select * from dba_tab_partitions where table_name =upper('Partition_Test01')
select * from dba_tab_subpartitions where table_name =upper('Partition_Test01')

--子分区表测试02
Create Table Partition_Test02(
     Table_Name Varchar2(30)
    ,Data_Date Varchar2(10)
    ,Busi_Type Varchar2(2)
    ,Pk_Run Varchar2(20)
) Partition By Range(Data_Date)
SubPartition By List(Pk_Run)
(
  Partition test_20220101_1 Values Less Than('2022-01-01')
  (
    SubPartition test_20220101_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
  ),
  Partition test_20220102_1 Values Less Than('2022-01-02')
  (
    SubPartition test_20220102_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
  )
)
;
Insert Into Partition_Test02 Values('Partition_Test02','2021-12-31','1','1001A210000000001EFL');
Insert Into Partition_Test02 Values('Partition_Test02','2021-12-31','2','1001A210000000001EFL');
Insert Into Partition_Test02 Values('Partition_Test02','2022-01-01','3','1001A210000000001EFL');

--分区操作
--  建表的时候，表字段后面紧跟分区说明，
--  分区说明完成后创建初始化分区，
--  初始化分区需要用一个括号括起来，
--  括号里面写分区的创建，
--  每一个分区用逗号隔开。

--添加分区和子分区
Alter Table partition_test01
Add Partition test_20220104_1 Values Less Than('2022-01-04','4')
(
  SubPartition test_20220104_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
 ,SubPartition test_20220104_1_2 Values('1001A210000000001SFS') TableSpace OracleLearn
);

/*
 * 添加分区
 *  注意：
 *    1、增加分区的时候必须添加子分区(如果不添加子分区，会报错:Ora-14621:cannot add subpartition when default subpartition exists)
 *    2、当添加分区，不添加子分区的时候，系统会自动建一个默认子分区，包含所有的子分区数据，这时候插入数据只需要满足整个分区即可，不需要对应子分区
 *    3、系统在默认子分区存在的情况下不能为该分区创建新的子分区，如果要创建会报错:ORA-14621
 */
 
--默认子分区
Alter Table partition_test01
Add Partition test_20220105_4 Values Less Than('2022-01-05','4')
;
select * from dba_tab_subpartitions where table_name=upper('partition_test01');

--添加子分区
--  默认分区存在，不能添加子分区。会报错
Alter Table partition_test01
Modify Partition test_20220105_4 
Add SubPartition test_20220101_4_1 Values('1001A210000000001EFL') TableSpace OracleLearn
;

--添加子分区 只能为已有分区并且该分区没有默认子分区的分区创建子分区
Alter Table partition_test01 Modify Partition test_20220104_1
Add SubPartition test_20220104_1_3 Values('1001A210000000001ABC') TableSpace OracleLearn
;
--清空子分区
Alter Table partition_test01 Truncate SubPartition test_20220104_1_3;
--删除子分区
Alter Table partition_test01 Drop SubPartition test_20220104_1_3;
--清空分区
Alter Table partition_test01 Truncate Partition test_20220104_1;
--删除分区
Alter Table partition_test01 Drop Partition test_20220104_1;
--修改分区名字
Alter Table partition_test01 Rename Partition test_20220103_1 To test_20220103_2;
--修改子分区名字
Alter Table partition_test01 Rename SubPartition test_20220103_1_1 To test_20220103_2_1;



3、range分区+list分区
Create Table partition_test03(
     id int
    ,data_dt Varchar2(10)
    ,code Varchar2(1)
    ,type Varchar2(10)
    ,name Varchar2(20)
) TableSpace OracleLearn
Partition By range(data_dt,code)
SubPartition By list(type)
(
  Partition p_20220102_1 Values Less Than('2022-01-02','2')
  (
    SubPartition p_20220102_1_1 Values('A')
   ,SubPartition p_20220102_1_2 Values('B')
  ),
  Partition p_20220102_2 Values Less Than('2022-01-02','3')
  (
    SubPartition p_20220102_2_1 Values('A')
   ,SubPartition p_20220102_2_2 Values('B')
  ),
  Partition p_20220103_1 Values Less Than('2022-01-03','2')
  (
    SubPartition p_20220103_1_1 Values('A')
   ,SubPartition p_20220103_1_2 Values('B')
  ),
  Partition p_20220103_2 Values Less Than('2022-01-03','3')
  (
    SubPartition p_20220103_2_1 Values('A')
   ,SubPartition p_20220103_2_2 Values('B')
  )
)
;

Alter Table partition_test03 Add Partition p_20220104_1 Values Less Than('2022-01-04','2');
Alter Table partition_test03 Add Partition p_20220104_2 Values Less Than('2022-01-04','3');

Alter Table partition_test03 Drop Partition p_20220104_1;
Alter Table partition_test03 Drop Partition p_20220104_2;

Alter Table partition_test03
Add Partition p_20220104_1 Values Less Than('2022-01-04','2')
(
  SubPartition p_20220104_1_1 Values('A')
 ,SubPartition p_20220104_1_2 Values('B')
);
Alter Table partition_test03
Add Partition p_20220104_2 Values Less Than('2022-01-04','3')
(
  SubPartition p_20220104_2_1 Values('A')
 ,SubPartition p_20220104_2_2 Values('B')
);

Insert Into partition_test03 Values(1,'2022-01-01','1','A','aaa');
Insert Into partition_test03 Values(2,'2022-01-01','2','A','aaa');
Insert Into partition_test03 Values(3,'2022-01-02','1','A','aaa');
Insert Into partition_test03 Values(4,'2022-01-02','2','A','aaa');

--查询各分区数据
Select * from partition_test03 Partition(p_20220102_1);
Select * from partition_test03 Partition(p_20220103_1);


4、列表分区
Create Table partition_test04(
     id int
    ,data_dt varchar2(10)
    ,name varchar2(20)
) TableSpace OracleLearn
Partition By List(data_dt)
(
  Partition p_20220101 Values('2022-01-01')
);

Alter Table partition_test04 Add Partition p_20220102 Values('2022-01-02');
Alter Table partition_test04 Add Partition p_20220103 Values('2022-01-03');

Alter Table partition_test04 Drop Partition p_20220103;

Insert Into partition_test04 Values(1,'2022-01-01','aaa');
Insert Into partition_test04 Values(2,'2022-01-02','aaa');