--������&��������
  Oracle���ڷ�����ʽ��ʵ���ǽ���ֶδ洢��һ����ͨ�����һ���δ洢�����������ֳɶ���Ρ�
  ���Բ������ݹ��̶����ȶ�λ�����ݲ�ѯ������λ������Χ�����������ĸ��������ļ��������ڲ���Ȼ���ڷ����ڲ�ȥ�������ݡ�
  һ������һ�㱣֤��ʮ���������ݾͱȽ������ˡ�
  
  ���Ƿ��������ҽ���������ά����Ҳ��Խ�Ϊ����һ�㣬�������Ĵ���Ҳ�н�����
  
1����������
1) range������ʽ(��Χ����)
  Ҳ�ǳ��õķ�����ʽ����ͨ��ĳ�ֶλ򼸸��ֶε���ϵ�ֵ����С���󣬰���ָ���ķ�Χ˵�����з�����
  ��Insert���ݵ�ʱ��ͻ�洢��ָ���ķ����С�
2) list������ʽ(�б����)
  һ������range���������Ķ��������϶࣬��һ���оٷ�ʽ���з�����
  һ�㽫ĳЩ������״̬��ָ������ı���Ƚ��л��֡�
3) hash������ʽ
  û�й̶��Ĺ�����Oracle����ֻ��Ҫ��ֵInsert��ȥ��Oracle���Զ�����һ��Hash�㷨ȥ���ַ�����
  ֻ��Ҫ����OracleҪ�ּ��������ɡ�
  
ע�⣺
  1���������Խ���������ϣ�Oracle 11g��ǰ������϶�������range��Ϊһ�������Ŀ�ͷ��OracleĿǰ���֧��2��������
  2����������Ҫ�ȴ������ٲ�������

  
2��������ϰ
/*
 *��������
 *��������ȷ��
 *  ��Χ���������������ֵ���������ݵ�ʱ��ֻ��Ҫ��һ��ֵС�ڷ�����Χ����
 *  �������һ��ֵ������������и��ֶα���С��һ�������ķ�Χ
 */

--�ӷ��������01
--  �����ӷ�����ָ����ռ��ʱ��ֻ�����ӷ�������ָ��(��Ϊ�ӷ�������ʵ�ʴ��ڵķ���)
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

--���������
Alter Table Partition_Test01 
Add Partition test_20220103_1 Values Less Than('2022-01-03','2')
(
   SubPartition test_20220103_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
);
--�������ݲ鲻�� test_20220102_1 �����У���Ҫ��������
Insert Into Partition_Test01 Values('partition_test','2022-01-02','2','1001A210000000001EFL');

--�������ѯ-���շ�����ѯ(partition(������(����������������)))
select * from Partition_Test01 partition(TEST_20220102_1)

--�����������ֵ�
select * from dba_tab_partitions where table_name =upper('Partition_Test01')
select * from dba_tab_subpartitions where table_name =upper('Partition_Test01')

--�ӷ��������02
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

--��������
--  �����ʱ�򣬱��ֶκ����������˵����
--  ����˵����ɺ󴴽���ʼ��������
--  ��ʼ��������Ҫ��һ��������������
--  ��������д�����Ĵ�����
--  ÿһ�������ö��Ÿ�����

--��ӷ������ӷ���
Alter Table partition_test01
Add Partition test_20220104_1 Values Less Than('2022-01-04','4')
(
  SubPartition test_20220104_1_1 Values('1001A210000000001EFL') TableSpace OracleLearn
 ,SubPartition test_20220104_1_2 Values('1001A210000000001SFS') TableSpace OracleLearn
);

/*
 * ��ӷ���
 *  ע�⣺
 *    1�����ӷ�����ʱ���������ӷ���(���������ӷ������ᱨ��:Ora-14621:cannot add subpartition when default subpartition exists)
 *    2������ӷ�����������ӷ�����ʱ��ϵͳ���Զ���һ��Ĭ���ӷ������������е��ӷ������ݣ���ʱ���������ֻ��Ҫ���������������ɣ�����Ҫ��Ӧ�ӷ���
 *    3��ϵͳ��Ĭ���ӷ������ڵ�����²���Ϊ�÷��������µ��ӷ��������Ҫ�����ᱨ��:ORA-14621
 */
 
--Ĭ���ӷ���
Alter Table partition_test01
Add Partition test_20220105_4 Values Less Than('2022-01-05','4')
;
select * from dba_tab_subpartitions where table_name=upper('partition_test01');

--����ӷ���
--  Ĭ�Ϸ������ڣ���������ӷ������ᱨ��
Alter Table partition_test01
Modify Partition test_20220105_4 
Add SubPartition test_20220101_4_1 Values('1001A210000000001EFL') TableSpace OracleLearn
;

--����ӷ��� ֻ��Ϊ���з������Ҹ÷���û��Ĭ���ӷ����ķ��������ӷ���
Alter Table partition_test01 Modify Partition test_20220104_1
Add SubPartition test_20220104_1_3 Values('1001A210000000001ABC') TableSpace OracleLearn
;
--����ӷ���
Alter Table partition_test01 Truncate SubPartition test_20220104_1_3;
--ɾ���ӷ���
Alter Table partition_test01 Drop SubPartition test_20220104_1_3;
--��շ���
Alter Table partition_test01 Truncate Partition test_20220104_1;
--ɾ������
Alter Table partition_test01 Drop Partition test_20220104_1;
--�޸ķ�������
Alter Table partition_test01 Rename Partition test_20220103_1 To test_20220103_2;
--�޸��ӷ�������
Alter Table partition_test01 Rename SubPartition test_20220103_1_1 To test_20220103_2_1;



3��range����+list����
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

--��ѯ����������
Select * from partition_test03 Partition(p_20220102_1);
Select * from partition_test03 Partition(p_20220103_1);


4���б����
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