--数据泵 expdp&impdp
1、数据泵介绍
  数据泵(expdp&impdp)是Oracle 10G时引入的新技术，兼容了之前的数据导出导入工具(exp&imp)大部分功能，并进一步完善。
  数据泵相关命令需要在数据库服务端执行。
  
  数据泵属于逻辑迁移，可跨操作系统版本、跨数据库版本。
  高版本兼容低版本，高版本向低版本导数据，导出时需添加低版本的版本号。
  
2、环境
操作系统版本+数据库版本+数据库字符集
Windows10+Oracle11.2.0.1.0+AMERICAN_AMERICA.ZHS16GBK

注意：
  导数据之间的数据库字符集必须一致，否则可能出现乱码。
  

--查询数据库版本
select * from v$version;
--查询字符集
select userenv('language') from dual;
  

3、导出导入目录创建
--数据库文件目录查询
select * from dba_directories;
select * from dba_sys_privs where grantee = upper('OracleLearn');

1) 创建导出目录
Create Directory expdp_dir as 'E:\08-Oracle\dataFile\expdp';
Drop Directory expdp_dir;  --删除目录
2) 创建导入目录
Create Directory impdp_dir as 'E:\08-Oracle\dataFile\impdp';
Drop Directory expdp_dir;  --删除目录
3) 授权导数据用户(只是适用于导本用户下的对象，导出其它用户对象需有dba权限)
Grant read,write On Directory expdp_dir To OracleLearn;
Grant read,write On Directory impdp_dir To OracleLearn;
Grant exp_full_database,imp_full_database to OracleLearn;



4、按表导出导入
导出语法：
  expdp dbuser/password@localhost:1521/orcl tables=tablename dumpfile=expdp.dmp directory=data_dir logfile=expdp.log
含义：
  expdp [用户名]/[密码]@[IP]:[端口]/[服务名]
  tables=[表名]
  dumpfile=[导出数据库文件]
  directory=[导出数据库文件存放目录，需要先创建好目录对象]
  logfile=[日志文件文件名]

导出样例：
  expdp OracleLearn/OracleLearn@localhost:1521/orcl dumpfile=expdp_test_01.dmp directory=expdp_dir tables=Partition_Test01 logfile=expdp_test_01.log
  --密码可以不直接输入
  expdp OracleLearn@localhost:1521/orcl dumpfile=expdp_test_01.dmp directory=expdp_dir tables=Partition_Test01 logfile=expdp_test_01.log
  --可以只要用户名和密码
  expdp OracleLearn/OracleLearn dumpfile=expdp_test_01.dmp directory=expdp_dir tables=Partition_Test01 logfile=expdp_test_01.log


导入语法：
  impdp dbuser/password@localhost:1521/orcl remap_schema=srcuser:touser table_exists_action=replace directory=impdp_dir dumpfile=expdp_test_01.dmp logfile=impdp_test_01.dmp.log
含义：
  impdp [用户名]/[密码]@[IP]:[端口]/[服务名]
  remap_schemas=[源用户名1]:[目标用户名2]
  table_exists_action=[如果存在，执行的动作 replace|替换]
  dumpfile=[导入数据库文件]
  directory=[导入数据库文件存放目录，需要先创建好目录对象]
  logfile=[日志文件文件名]

导入样例：
  impdp OracleLearn/OracleLearn@localhost:1521/orcl remap_schema=OracleLearn:OracleLearn table_exists_action=replace directory=impdp_dir dumpfile=expdp_test_01.dmp logfile=impdp_test_01.log 
 
 
 

5、按用户导出导入
导出语法：
  expdp dbuser/password@localhost:1521/orcl schemas=dbuser dumpfile=expdp.dmp directory=data_dir logfile=expdp.log
含义：
  expdp [用户名]/[密码]@[IP]:[端口]/[服务名]
  schemas=[用户名]
  dumpfile=[导出数据库文件]
  directory=[导出数据库文件存放目录，需要先创建好目录对象]
  logfile=[日志文件文件名]

导出样例：
  expdp OracleLearn/OracleLearn@localhost:1521/orcl dumpfile=expdp_test_02.dmp directory=expdp_dir schemas=OracleLearn logfile=expdp_test_02.log
  
  
导入语法：
  impdp dbuser/password@localhost:1521/orcl remap_schema=srcuser:touser remap_tablespace=srctablespace:totablespace table_exists_action=replace directory=impdp_dir dumpfile=expdp_test_01.dmp logfile=impdp_test_01.dmp.log
含义：
  impdp [用户名]/[密码]@[IP]:[端口]/[服务名]
  remap_schemas=[源用户名1]:[目标用户名2]
  remap_tablespace=[源表空间1]:[目标表空间2]
  dumpfile=[导入数据库文件]
  directory=[导入数据库文件存放目录，需要先创建好目录对象]
  logfile=[日志文件文件名]

导入样例：
  impdp OracleLearn/OracleLearn@localhost:1521/orcl remap_schema=OracleLearn:OracleLearn remap_tablespace=OracleLearn:OracleLearn directory=impdp_dir dumpfile=expdp_test_02.dmp logfile=impdp_test_02.log 
  impdp OracleLearn/OracleLearn@localhost:1521/orcl directory=impdp_dir dumpfile=expdp_test_02.dmp logfile=impdp_test_02.log 
 


6、只导表结构
  导出语句中添加connect_metadata_only 参数即可
  

7、高版本向低版本数据库导数据
  导出语句中添加 version=11.2.0.1.0 参数即可(低版本数据库的版本号)


8、分区表数据泵
--数据实例查看分区表学习样例
expdp OracleLearn/OracleLearn Directory=expdp_dir dumpfile=Partition_Test01.dmp logfile=Partition_Test01.log tables=Partition_Test01:TEST_20220101_1,Partition_Test01:TEST_20220102_1
impdp OracleLearn/OracleLearn Directory=impdp_dir dumpfile=Partition_Test01.dmp logfile=Partition_Test01.log table_exists_action=replace

select * from dba_tab_subpartitions where table_name=upper('Partition_Test01')