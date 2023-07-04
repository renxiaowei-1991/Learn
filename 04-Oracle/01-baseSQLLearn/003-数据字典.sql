--Oracle数据字典
--  数据字典是Oracle存放关于数据库内部信息的地方，其用途是用来描述数据库内部的运行和管理情况。
--  比如：一个数据表的所有者、创建时间、所属表空间、用户访问权限等信息，这些信息都可以在数据字典中找到。
--Oracle数据字典概述
--  Oracle数据字典的名称由前缀和后缀组成，使用"_"连接，其代表的含义如下：
--    dba_:包含数据库实例的所有对象信息
--    v$_:当前实例的动态视图，包含系统管理和系统优化等所使用的视图
--    user:记录用户的对象信息
--    gv_:分布式环境下所有实例的动态视图，包含系统管理和系统优化使用的视图
--    all_:记录用户的对象信息及被授权访问的对象信息
--Oracle常用数据字典
--  虽然通过Oracle企业管理器(OEM)操作数据库比较方便，但它不利于读者了解Oracle系统的内部结构和应用系统对象之间的关系，建议尽量使用SQL*Plus来操作数据库
--  为了方便了解Oracle系统内部的对象结构和进行高层次的数据管理，下面列出最常用的数据字典及其说明
--1、基本数据字典
--  基本数据字典主要包括描述逻辑存储结构和物理存储结构的数据表
--  另外，还包括一些描述其他数据对象信息的表，例如：dba_views、dba_triggers、dba_users等
--  基本数据字典及说明
--    数据字典名称         说明
--    dba_tablespace       关于表空间的信息
--    dba_ts_quotas        所有用户表空间限额
--    dba_free_space       所有表空间中的自由分区
--    dba_segments         描述数据库中所有段的存储空间
--    dba_extents          数据库中所有分区的信息
--    dba_tables           数据库中所有数据表的描述
--    dba_all_tables       数据库中所有数据表的描述
--    dba_tab_columns      所有表、视图以及簇的列
--    dba_views            数据库中所有视图的信息
--    dba_synonyms         关于同义词的信息查询
--    dba_sequences        所有用户序列信息
--    dba_constraints      所有用户表的约束信息
--    dba_indexes          关于数据库中所有索引的描述
--    dba_ind_columns      在所有表及簇上压缩索引的列
--    dba_triggers         所有用户的触发器信息
--    dba_source           所有用户存储过程信息
--    dba_data_files       查询关于数据库文件的信息
--    dba_tab_grants/privs 查询关于对象授权的信息 两张表只有一张存在
--    dba_objects          数据库中所有的对象
--    dba_users            关于数据库中所有用户的信息
--    dba_sys_privs        用户权限
--    dual                 默认表
--    user_all_tables      用户所有表
--    all_col_comments     注释信息
--    user_col_comment     注释信息
--    all_tab_comments     注释信息
--    user_tab_comments    注释信息
--    dba_directories      存放数据泵导入导出路径

select * from dba_tablespaces;
select * from dba_ts_quotas;
select * from dba_free_space;
select * from dba_segments;
select * from dba_extents;
select * from dba_tab_columns;
select * from dba_views;
select * from dba_synonyms;
select * from dba_sequences;
select * from dba_constraints;
select * from dba_indexes;
select * from dba_ind_columns;
select * from dba_triggers;
select * from dba_source where name='STANDARD';
select * from dba_data_files;
select * from dba_tab_privs;
select * from dba_objects;
select * from dba_users;
select * from dba_all_tables;
select * from user_all_tables;
select * from dba_directories;

--2、常用动态性能视图
--  Oracle系统内部提供了大量的动态性能视图，之所以说是"动态"，是因为这些视图的信息在数据库运行期间会不断地更新。
--  动态性能视图以 v$作为名称前缀，这些视图提供了关于内存和磁盘的运行情况，用户只能进行只读访问而不能修改它们。
--  常用动态性能视图及说明
--    数据字典名称         说明
--    v$database           描述关于数据库的相关信息
--    v$datafile           数据库使用的数据文件信息
--    v$log                从控制文件中提取有关重做日志组的信息
--    v$logfile            有关实例重置日志组文件名及其位置的信息
--    v$archived_log       记录归档日志文件的基本信息
--    v$archived_dest      记录归档日志文件的路径信息
--    v$controlfile        描述控制文件的相关信息
--    v$instance           记录实例的基本信息
--    v$system_parameter   显示实例当前有效的参数信息
--    v$sga                显示实例的SGA区的大小
--    v$sgastat            统计SGA使用情况的信息

--    v$parameter          记录初始化参数文件中所有项的值
--    v$lock               通过访问数据库会话，设置对象锁的所有信息
--    v$session            有关会话的信息
--    v$sql                有关SQL语句的详细信息
--    v$sqltext            记录SQL语句的语句信息
--    v$bgprocess          显示后台进程信息
--    v$process            当前进程的信息

select * from v$database;
select * from v$datafile;
select * from v$log;
select * from v$logfile;
select * from v$archived_log;
select * from v$controlfile;
select * from v$instance;
select * from v$system_parameter;
select * from v$sga;
select * from v$sgastat;

select * from v$parameter;
select * from v$lock;
select * from v$session;
select * from v$sql;
select * from v$sqltext;
select * from v$bgprocess;
select * from v$process;