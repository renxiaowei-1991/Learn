--DDL:数据定义语音(Data Definition language)
--DDL:TableSpace
--  创建表空间  https://www.cnblogs.com/hftian/p/6993614.html
select * from dba_tablespaces;

--一、语法
CREATE [UNDO]  TABLESPACE tablespace_name          
[DATAFILE datefile_spec1 [,datefile_spec2] ......   
[{MININUM EXTENT integer [k|m]   
|BLOCKSIZE integer [k]   
|logging clause | FORCE LOGGING   
|DEFAULT {data_segment_compression} storage_clause   
|[online|offline]   
|[PERMANENT|TEMPORARY]   
|extent_manager_clause   
|segment_manager_clause}] 

1、undo   
说明系统将创建一个回滚表空间。   
在9i中数据库管理员可以不必管理回滚段，只有建立了undo表空间，系统就会自动管理回滚段的分配，回收的工作。   
当然,也可以创建一般的表空间,在上面创建回滚段.不过对于用户来说,系统管理比自己管理要好很多.   
如果需要自己管理,请参见回滚段管理的命令详解.   
当没有为系统指定回滚表空间时,系统将使用system系统回滚段来进行事务管理。   

2、tablespace_name   
指出表空间的名称。   

3、datafile  datefile_spec1   
指出表空间包含什么空间文件。   
datefile_spec1是形如:[ 'filename' ] [SIZE integer [ K | M ]] [REUSE] [autoextend_clause]   
[autoextend_clause]是形如：AUTOEXTEND { OFF | ON [ NEXT integer [ K | M ] ] [maxsize_clause] }   
其中filename是数据文件的路径名，可以是相对路径，也可以是绝对路径。   
size是文件的大小,   
REUSE表示文件是否被重用.   
AUTOEXTEND表明是否自动扩展.   
OFF | ON  表示自动扩展是否被关闭.   
NEXT 表示数据文件满了以后,扩展的大小.   
maxsize_clause表示数据文件的最大大小.形如MAXSIZE { UNLIMITED | integer [ K | M ] }.   
UNLIMITED 表示无限的表空间.   
integer是数据文件的最大大小.   
       DATAFILE  'D:"oracle"oradata"IMAGEDATA01.dbf'  SIZE 2000M,   
                 'D:"oracle"oradata"IMAGEDATA02.dbf'  SIZE 2000M   

4、MININUM EXTENT integer [k|m]   
指出在表空间中范围的最小值。这个参数可以减小空间碎片，保证在表空间的范围是这个数值的整数倍。   

5、BLOCKSIZE integer [k]   
这个参数可以设定一个不标准的块的大小。如果要设置这个参数，必须设置db_block_size,   
至少一个db_nk_block_size,并且声明的integer的值必须等于db_nk_block_size.   
注意：在临时表空间不能设置这个参数。   

6、logging clause   
这个子句声明这个表空间上所有的用户对象的日志属性（缺省是logging），   
包括表，索引，分区，物化视图，物化视图上的索引，分区。   

7、FORCE LOGGING   
使用这个子句指出表空间进入强制日志模式。此时，系统将记录表空间上对象的所有改变，除了临时段的改变。   
这个参数高于对象的nologging选项。   
注意：设置这个参数数据库不行open并且出于读写模式。而且，在临时表空间和回滚表空间中不能使用这个选项。   

8、DEFAULT storage_clause   
声明缺省的存储子句。   

9、online|offline   
改变表空间的状态。online使表空间创建后立即有效.这是缺省值.   
offline使表空间创建后无效.这个值，可以从dba_tablespace中得到。   

10、PERMANENT|TEMPORARY   
指出表空间的属性，是永久表空间还是临时表空间。   
永久表空间存放的是永久对象，临时表空间存放的是session生命期中存在的临时对象。   
这个参数生成的临时表空间创建后一直都是字典管理，不能使用extent management local选项。   
如果要创建本地管理表空间，必须使用create temporary tablespace   
注意，声明了这个参数后，不能声明block size   

11、extent_management_clause   
这是最重要的子句，说明了表空间如何管理范围。一旦你声明了这个子句，只能通过移植的方式改变这些参数。   
如果希望表空间本地管理的话，声明local选项。本地管理表空间是通过位图管理的。   
autoallocate说明表空间自动分配范围，用户不能指定范围的大小。只有9.0以上的版本具有这个功能。   
uniform说明表空间的范围的固定大小，缺省是1m。   
不能将本地管理的数据库的system表空间设置成字典管理。   
oracle公司推荐使用本地管理表空间。   
如果没有设置extent_management_clause，oracle会给他设置一个默认值。   
如果初始化参数compatible小于9.0.0,那么系统创建字典管理表空间。   
如果大于9.0.0,那么按照如下设置：   
如果没有指定 default  storage_clause,oracle创建一个自动分配的本地管理表空间。   
否则，   
如果指定了mininum extent,那么oracle判断mininum extent 、initial、next是否相等,以及pctincrease是否=0.   
如果满足以上的条件，oracle创建一个本地管理表空间，extent size是initial.   
如果不满足以上条件，那么oracle将创建一个自动分配的本地管理表空间。   
如果没有指定mininum extent。initial、那么oracle判断next是否相等,以及pctincrease是否=0。   
如果满足oracle创建一个本地管理表空间并指定uniform。否则oracle将创建一个自动分配的本地管理表空间。   
注意：本地管理表空间只能存储永久对象。   
如果你声明了local,将不能声明 default  storage_clause,mininum extent、temporary.   
EXTENT MANAGEMENT LOCAL   

12、segment_management_clause   
段空间管理的方式，自动或者手动:   
SEGMENT SPACE MANAGEMENT {AUTO|MANUAL}   

select * from dba_tablespaces

--二、实例1:创建永久表空间   
可以一次创建单个表空间，也可以一次性创建多个表空间   
1.1创建单个表空间   
create tablespace ts_something   
  logging   
  datafile  '/dbf1/ts_sth.dbf'     
  size 32m    
  autoextend on    
  next 32m maxsize 2048m   
  extent management local;   

1.2创建多个表空间   
CREATE TABLESPACE TS_IMAGEDATA   
    NOLOGGING    
    DATAFILE  'D:"oracle"oradata"DATA01.dbf'  SIZE 2000M,    
              'D:"oracle"oradata"DATA02.dbf'  SIZE 2000M,    
              'D:"oracle"oradata"DATA03.dbf'  SIZE 2000M,    
              'D:"oracle"oradata"DATA04.dbf'  SIZE 2000M,    
              'D:"oracle"oradata"DATA05.dbf'  SIZE 2000M EXTENT    
    MANAGEMENT LOCAL SEGMENT    
    SPACE MANAGEMENT  AUTO;   

CREATE TABLESPACE TS_IMAGEDATA   
LOGGING   
DATAFILE  'E:"ORACLE"ORADATA"DATA_01.DBF'  SIZE 2000M REUSE    
                AUTOEXTEND ON    
                NEXT 51200K MAXSIZE 3900M,   
          'E:"ORACLE"ORADATA"XL"DATA_02.DBF'  SIZE 2000M REUSE   
                AUTOEXTEND ON    
                NEXT 51200K MAXSIZE 3900M,   
          'E:"ORACLE"ORADATA"XL"DATA_03.DBF'  SIZE 2000M REUSE   
                AUTOEXTEND ON    
                NEXT 51200K MAXSIZE 3900M,   
          'E:"ORACLE"ORADATA"XL"DATA_04.DBF'  SIZE 2000M REUSE   
                AUTOEXTEND ON    
                NEXT 51200K MAXSIZE 3900M   
EXTENT MANAGEMENT LOCAL    
SEGMENT SPACE MANAGEMENT AUTO;   
实例2:创建撤销表空间   
create undo tablespace ts_undo   
datafile  '/dbf/undo.dbf'   size 100M;   

CREATE UNDO TABLESPACE ts_undo01    
       DATAFILE  '/data/ts_undo01.dbf'     
       SIZE 50000M REUSE   
       autoextend on;



创建私用表空间：
create tablespace jf_data datafile '/opt/oracle/app/oracle/oradata/iptvbss/jfdata.dbf' size 1000M autoextend on next 500M maxsize unlimited;

create tablespace jf_index datafile '/opt/oracle/app/oracle/oradata/iptvbss/jfindex.dbf' size 1000M autoextend on next 500M maxsize unlimited;



--三、查看表空间使用情况
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

select to_char(22334.3456,'99999.99') from dual


select * from Dba_Free_Space;
select * from dba_col_comments where table_name ='DBA_FREE_SPACE';
select * from dba_tab_comments where table_name ='DBA_FREE_SPACE';