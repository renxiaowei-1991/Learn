--Oracle�����ֵ�
--  �����ֵ���Oracle��Ź������ݿ��ڲ���Ϣ�ĵط�������;�������������ݿ��ڲ������к͹��������
--  ���磺һ�����ݱ�������ߡ�����ʱ�䡢������ռ䡢�û�����Ȩ�޵���Ϣ����Щ��Ϣ�������������ֵ����ҵ���
--Oracle�����ֵ����
--  Oracle�����ֵ��������ǰ׺�ͺ�׺��ɣ�ʹ��"_"���ӣ������ĺ������£�
--    dba_:�������ݿ�ʵ�������ж�����Ϣ
--    v$_:��ǰʵ���Ķ�̬��ͼ������ϵͳ�����ϵͳ�Ż�����ʹ�õ���ͼ
--    user:��¼�û��Ķ�����Ϣ
--    gv_:�ֲ�ʽ����������ʵ���Ķ�̬��ͼ������ϵͳ�����ϵͳ�Ż�ʹ�õ���ͼ
--    all_:��¼�û��Ķ�����Ϣ������Ȩ���ʵĶ�����Ϣ
--Oracle���������ֵ�
--  ��Ȼͨ��Oracle��ҵ������(OEM)�������ݿ�ȽϷ��㣬���������ڶ����˽�Oracleϵͳ���ڲ��ṹ��Ӧ��ϵͳ����֮��Ĺ�ϵ�����龡��ʹ��SQL*Plus���������ݿ�
--  Ϊ�˷����˽�Oracleϵͳ�ڲ��Ķ���ṹ�ͽ��и߲�ε����ݹ��������г���õ������ֵ估��˵��
--1�����������ֵ�
--  ���������ֵ���Ҫ���������߼��洢�ṹ������洢�ṹ�����ݱ�
--  ���⣬������һЩ�����������ݶ�����Ϣ�ı����磺dba_views��dba_triggers��dba_users��
--  ���������ֵ估˵��
--    �����ֵ�����         ˵��
--    dba_tablespace       ���ڱ�ռ����Ϣ
--    dba_ts_quotas        �����û���ռ��޶�
--    dba_free_space       ���б�ռ��е����ɷ���
--    dba_segments         �������ݿ������жεĴ洢�ռ�
--    dba_extents          ���ݿ������з�������Ϣ
--    dba_tables           ���ݿ����������ݱ������
--    dba_all_tables       ���ݿ����������ݱ������
--    dba_tab_columns      ���б���ͼ�Լ��ص���
--    dba_views            ���ݿ���������ͼ����Ϣ
--    dba_synonyms         ����ͬ��ʵ���Ϣ��ѯ
--    dba_sequences        �����û�������Ϣ
--    dba_constraints      �����û����Լ����Ϣ
--    dba_indexes          �������ݿ�����������������
--    dba_ind_columns      �����б�����ѹ����������
--    dba_triggers         �����û��Ĵ�������Ϣ
--    dba_source           �����û��洢������Ϣ
--    dba_data_files       ��ѯ�������ݿ��ļ�����Ϣ
--    dba_tab_grants/privs ��ѯ���ڶ�����Ȩ����Ϣ ���ű�ֻ��һ�Ŵ���
--    dba_objects          ���ݿ������еĶ���
--    dba_users            �������ݿ��������û�����Ϣ
--    dba_sys_privs        �û�Ȩ��
--    dual                 Ĭ�ϱ�
--    user_all_tables      �û����б�
--    all_col_comments     ע����Ϣ
--    user_col_comment     ע����Ϣ
--    all_tab_comments     ע����Ϣ
--    user_tab_comments    ע����Ϣ
--    dba_directories      ������ݱõ��뵼��·��

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

--2�����ö�̬������ͼ
--  Oracleϵͳ�ڲ��ṩ�˴����Ķ�̬������ͼ��֮����˵��"��̬"������Ϊ��Щ��ͼ����Ϣ�����ݿ������ڼ�᲻�ϵظ��¡�
--  ��̬������ͼ�� v$��Ϊ����ǰ׺����Щ��ͼ�ṩ�˹����ڴ�ʹ��̵�����������û�ֻ�ܽ���ֻ�����ʶ������޸����ǡ�
--  ���ö�̬������ͼ��˵��
--    �����ֵ�����         ˵��
--    v$database           �����������ݿ�������Ϣ
--    v$datafile           ���ݿ�ʹ�õ������ļ���Ϣ
--    v$log                �ӿ����ļ�����ȡ�й�������־�����Ϣ
--    v$logfile            �й�ʵ��������־���ļ�������λ�õ���Ϣ
--    v$archived_log       ��¼�鵵��־�ļ��Ļ�����Ϣ
--    v$archived_dest      ��¼�鵵��־�ļ���·����Ϣ
--    v$controlfile        ���������ļ��������Ϣ
--    v$instance           ��¼ʵ���Ļ�����Ϣ
--    v$system_parameter   ��ʾʵ����ǰ��Ч�Ĳ�����Ϣ
--    v$sga                ��ʾʵ����SGA���Ĵ�С
--    v$sgastat            ͳ��SGAʹ���������Ϣ

--    v$parameter          ��¼��ʼ�������ļ����������ֵ
--    v$lock               ͨ���������ݿ�Ự�����ö�������������Ϣ
--    v$session            �йػỰ����Ϣ
--    v$sql                �й�SQL������ϸ��Ϣ
--    v$sqltext            ��¼SQL���������Ϣ
--    v$bgprocess          ��ʾ��̨������Ϣ
--    v$process            ��ǰ���̵���Ϣ

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