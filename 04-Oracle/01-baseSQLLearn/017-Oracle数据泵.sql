--���ݱ� expdp&impdp
1�����ݱý���
  ���ݱ�(expdp&impdp)��Oracle 10Gʱ������¼�����������֮ǰ�����ݵ������빤��(exp&imp)�󲿷ֹ��ܣ�����һ�����ơ�
  ���ݱ����������Ҫ�����ݿ�����ִ�С�
  
  ���ݱ������߼�Ǩ�ƣ��ɿ����ϵͳ�汾�������ݿ�汾��
  �߰汾���ݵͰ汾���߰汾��Ͱ汾�����ݣ�����ʱ����ӵͰ汾�İ汾�š�
  
2������
����ϵͳ�汾+���ݿ�汾+���ݿ��ַ���
Windows10+Oracle11.2.0.1.0+AMERICAN_AMERICA.ZHS16GBK

ע�⣺
  ������֮������ݿ��ַ�������һ�£�������ܳ������롣
  

--��ѯ���ݿ�汾
select * from v$version;
--��ѯ�ַ���
select userenv('language') from dual;
  

3����������Ŀ¼����
--���ݿ��ļ�Ŀ¼��ѯ
select * from dba_directories;
select * from dba_sys_privs where grantee = upper('OracleLearn');

1) ��������Ŀ¼
Create Directory expdp_dir as 'E:\08-Oracle\dataFile\expdp';
Drop Directory expdp_dir;  --ɾ��Ŀ¼
2) ��������Ŀ¼
Create Directory impdp_dir as 'E:\08-Oracle\dataFile\impdp';
Drop Directory expdp_dir;  --ɾ��Ŀ¼
3) ��Ȩ�������û�(ֻ�������ڵ����û��µĶ��󣬵��������û���������dbaȨ��)
Grant read,write On Directory expdp_dir To OracleLearn;
Grant read,write On Directory impdp_dir To OracleLearn;
Grant exp_full_database,imp_full_database to OracleLearn;



4������������
�����﷨��
  expdp dbuser/password@localhost:1521/orcl tables=tablename dumpfile=expdp.dmp directory=data_dir logfile=expdp.log
���壺
  expdp [�û���]/[����]@[IP]:[�˿�]/[������]
  tables=[����]
  dumpfile=[�������ݿ��ļ�]
  directory=[�������ݿ��ļ����Ŀ¼����Ҫ�ȴ�����Ŀ¼����]
  logfile=[��־�ļ��ļ���]

����������
  expdp OracleLearn/OracleLearn@localhost:1521/orcl dumpfile=expdp_test_01.dmp directory=expdp_dir tables=Partition_Test01 logfile=expdp_test_01.log
  --������Բ�ֱ������
  expdp OracleLearn@localhost:1521/orcl dumpfile=expdp_test_01.dmp directory=expdp_dir tables=Partition_Test01 logfile=expdp_test_01.log
  --����ֻҪ�û���������
  expdp OracleLearn/OracleLearn dumpfile=expdp_test_01.dmp directory=expdp_dir tables=Partition_Test01 logfile=expdp_test_01.log


�����﷨��
  impdp dbuser/password@localhost:1521/orcl remap_schema=srcuser:touser table_exists_action=replace directory=impdp_dir dumpfile=expdp_test_01.dmp logfile=impdp_test_01.dmp.log
���壺
  impdp [�û���]/[����]@[IP]:[�˿�]/[������]
  remap_schemas=[Դ�û���1]:[Ŀ���û���2]
  table_exists_action=[������ڣ�ִ�еĶ��� replace|�滻]
  dumpfile=[�������ݿ��ļ�]
  directory=[�������ݿ��ļ����Ŀ¼����Ҫ�ȴ�����Ŀ¼����]
  logfile=[��־�ļ��ļ���]

����������
  impdp OracleLearn/OracleLearn@localhost:1521/orcl remap_schema=OracleLearn:OracleLearn table_exists_action=replace directory=impdp_dir dumpfile=expdp_test_01.dmp logfile=impdp_test_01.log 
 
 
 

5�����û���������
�����﷨��
  expdp dbuser/password@localhost:1521/orcl schemas=dbuser dumpfile=expdp.dmp directory=data_dir logfile=expdp.log
���壺
  expdp [�û���]/[����]@[IP]:[�˿�]/[������]
  schemas=[�û���]
  dumpfile=[�������ݿ��ļ�]
  directory=[�������ݿ��ļ����Ŀ¼����Ҫ�ȴ�����Ŀ¼����]
  logfile=[��־�ļ��ļ���]

����������
  expdp OracleLearn/OracleLearn@localhost:1521/orcl dumpfile=expdp_test_02.dmp directory=expdp_dir schemas=OracleLearn logfile=expdp_test_02.log
  
  
�����﷨��
  impdp dbuser/password@localhost:1521/orcl remap_schema=srcuser:touser remap_tablespace=srctablespace:totablespace table_exists_action=replace directory=impdp_dir dumpfile=expdp_test_01.dmp logfile=impdp_test_01.dmp.log
���壺
  impdp [�û���]/[����]@[IP]:[�˿�]/[������]
  remap_schemas=[Դ�û���1]:[Ŀ���û���2]
  remap_tablespace=[Դ��ռ�1]:[Ŀ���ռ�2]
  dumpfile=[�������ݿ��ļ�]
  directory=[�������ݿ��ļ����Ŀ¼����Ҫ�ȴ�����Ŀ¼����]
  logfile=[��־�ļ��ļ���]

����������
  impdp OracleLearn/OracleLearn@localhost:1521/orcl remap_schema=OracleLearn:OracleLearn remap_tablespace=OracleLearn:OracleLearn directory=impdp_dir dumpfile=expdp_test_02.dmp logfile=impdp_test_02.log 
  impdp OracleLearn/OracleLearn@localhost:1521/orcl directory=impdp_dir dumpfile=expdp_test_02.dmp logfile=impdp_test_02.log 
 


6��ֻ����ṹ
  ������������connect_metadata_only ��������
  

7���߰汾��Ͱ汾���ݿ⵼����
  ������������ version=11.2.0.1.0 ��������(�Ͱ汾���ݿ�İ汾��)


8�����������ݱ�
--����ʵ���鿴������ѧϰ����
expdp OracleLearn/OracleLearn Directory=expdp_dir dumpfile=Partition_Test01.dmp logfile=Partition_Test01.log tables=Partition_Test01:TEST_20220101_1,Partition_Test01:TEST_20220102_1
impdp OracleLearn/OracleLearn Directory=impdp_dir dumpfile=Partition_Test01.dmp logfile=Partition_Test01.log table_exists_action=replace

select * from dba_tab_subpartitions where table_name=upper('Partition_Test01')