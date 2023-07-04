--DDL:���ݶ�������(Data Definition language)
--DDL:TableSpace
--  ������ռ�  https://www.cnblogs.com/hftian/p/6993614.html
select * from dba_tablespaces;

--һ���﷨
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

1��undo   
˵��ϵͳ������һ���ع���ռ䡣   
��9i�����ݿ����Ա���Բ��ع���ع��Σ�ֻ�н�����undo��ռ䣬ϵͳ�ͻ��Զ�����ع��εķ��䣬���յĹ�����   
��Ȼ,Ҳ���Դ���һ��ı�ռ�,�����洴���ع���.���������û���˵,ϵͳ������Լ�����Ҫ�úܶ�.   
�����Ҫ�Լ�����,��μ��ع��ι�����������.   
��û��Ϊϵͳָ���ع���ռ�ʱ,ϵͳ��ʹ��systemϵͳ�ع����������������   

2��tablespace_name   
ָ����ռ�����ơ�   

3��datafile  datefile_spec1   
ָ����ռ����ʲô�ռ��ļ���   
datefile_spec1������:[ 'filename' ] [SIZE integer [ K | M ]] [REUSE] [autoextend_clause]   
[autoextend_clause]�����磺AUTOEXTEND { OFF | ON [ NEXT integer [ K | M ] ] [maxsize_clause] }   
����filename�������ļ���·���������������·����Ҳ�����Ǿ���·����   
size���ļ��Ĵ�С,   
REUSE��ʾ�ļ��Ƿ�����.   
AUTOEXTEND�����Ƿ��Զ���չ.   
OFF | ON  ��ʾ�Զ���չ�Ƿ񱻹ر�.   
NEXT ��ʾ�����ļ������Ժ�,��չ�Ĵ�С.   
maxsize_clause��ʾ�����ļ�������С.����MAXSIZE { UNLIMITED | integer [ K | M ] }.   
UNLIMITED ��ʾ���޵ı�ռ�.   
integer�������ļ�������С.   
       DATAFILE  'D:"oracle"oradata"IMAGEDATA01.dbf'  SIZE 2000M,   
                 'D:"oracle"oradata"IMAGEDATA02.dbf'  SIZE 2000M   

4��MININUM EXTENT integer [k|m]   
ָ���ڱ�ռ��з�Χ����Сֵ������������Լ�С�ռ���Ƭ����֤�ڱ�ռ�ķ�Χ�������ֵ����������   

5��BLOCKSIZE integer [k]   
������������趨һ������׼�Ŀ�Ĵ�С�����Ҫ���������������������db_block_size,   
����һ��db_nk_block_size,����������integer��ֵ�������db_nk_block_size.   
ע�⣺����ʱ��ռ䲻���������������   

6��logging clause   
����Ӿ����������ռ������е��û��������־���ԣ�ȱʡ��logging����   
�������������������ﻯ��ͼ���ﻯ��ͼ�ϵ�������������   

7��FORCE LOGGING   
ʹ������Ӿ�ָ����ռ����ǿ����־ģʽ����ʱ��ϵͳ����¼��ռ��϶�������иı䣬������ʱ�εĸı䡣   
����������ڶ����nologgingѡ�   
ע�⣺��������������ݿⲻ��open���ҳ��ڶ�дģʽ�����ң�����ʱ��ռ�ͻع���ռ��в���ʹ�����ѡ�   

8��DEFAULT storage_clause   
����ȱʡ�Ĵ洢�Ӿ䡣   

9��online|offline   
�ı��ռ��״̬��onlineʹ��ռ䴴����������Ч.����ȱʡֵ.   
offlineʹ��ռ䴴������Ч.���ֵ�����Դ�dba_tablespace�еõ���   

10��PERMANENT|TEMPORARY   
ָ����ռ�����ԣ������ñ�ռ仹����ʱ��ռ䡣   
���ñ�ռ��ŵ������ö�����ʱ��ռ��ŵ���session�������д��ڵ���ʱ����   
����������ɵ���ʱ��ռ䴴����һֱ�����ֵ��������ʹ��extent management localѡ�   
���Ҫ�������ع����ռ䣬����ʹ��create temporary tablespace   
ע�⣬��������������󣬲�������block size   

11��extent_management_clause   
��������Ҫ���Ӿ䣬˵���˱�ռ���ι���Χ��һ��������������Ӿ䣬ֻ��ͨ����ֲ�ķ�ʽ�ı���Щ������   
���ϣ����ռ䱾�ع���Ļ�������localѡ����ع����ռ���ͨ��λͼ����ġ�   
autoallocate˵����ռ��Զ����䷶Χ���û�����ָ����Χ�Ĵ�С��ֻ��9.0���ϵİ汾����������ܡ�   
uniform˵����ռ�ķ�Χ�Ĺ̶���С��ȱʡ��1m��   
���ܽ����ع�������ݿ��system��ռ����ó��ֵ����   
oracle��˾�Ƽ�ʹ�ñ��ع����ռ䡣   
���û������extent_management_clause��oracle���������һ��Ĭ��ֵ��   
�����ʼ������compatibleС��9.0.0,��ôϵͳ�����ֵ�����ռ䡣   
�������9.0.0,��ô�����������ã�   
���û��ָ�� default  storage_clause,oracle����һ���Զ�����ı��ع����ռ䡣   
����   
���ָ����mininum extent,��ôoracle�ж�mininum extent ��initial��next�Ƿ����,�Լ�pctincrease�Ƿ�=0.   
����������ϵ�������oracle����һ�����ع����ռ䣬extent size��initial.   
���������������������ôoracle������һ���Զ�����ı��ع����ռ䡣   
���û��ָ��mininum extent��initial����ôoracle�ж�next�Ƿ����,�Լ�pctincrease�Ƿ�=0��   
�������oracle����һ�����ع����ռ䲢ָ��uniform������oracle������һ���Զ�����ı��ع����ռ䡣   
ע�⣺���ع����ռ�ֻ�ܴ洢���ö���   
�����������local,���������� default  storage_clause,mininum extent��temporary.   
EXTENT MANAGEMENT LOCAL   

12��segment_management_clause   
�οռ����ķ�ʽ���Զ������ֶ�:   
SEGMENT SPACE MANAGEMENT {AUTO|MANUAL}   

select * from dba_tablespaces

--����ʵ��1:�������ñ�ռ�   
����һ�δ���������ռ䣬Ҳ����һ���Դ��������ռ�   
1.1����������ռ�   
create tablespace ts_something   
  logging   
  datafile  '/dbf1/ts_sth.dbf'     
  size 32m    
  autoextend on    
  next 32m maxsize 2048m   
  extent management local;   

1.2���������ռ�   
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
ʵ��2:����������ռ�   
create undo tablespace ts_undo   
datafile  '/dbf/undo.dbf'   size 100M;   

CREATE UNDO TABLESPACE ts_undo01    
       DATAFILE  '/data/ts_undo01.dbf'     
       SIZE 50000M REUSE   
       autoextend on;



����˽�ñ�ռ䣺
create tablespace jf_data datafile '/opt/oracle/app/oracle/oradata/iptvbss/jfdata.dbf' size 1000M autoextend on next 500M maxsize unlimited;

create tablespace jf_index datafile '/opt/oracle/app/oracle/oradata/iptvbss/jfindex.dbf' size 1000M autoextend on next 500M maxsize unlimited;



--�����鿴��ռ�ʹ�����
Select     Upper(Free.TableSpace_Name) As "��ռ���"
          ,Data.Sum_Bytes As "��ռ��С(M)"
          ,Data.Sum_Bytes - Free.Sum_Bytes As "��ʹ�ÿռ�(M)"
          ,Free.Sum_Bytes As "���б�ռ�"
          ,Free.Max_Bytes As "���(M)"
          ,To_Char(Round((Data.Sum_Bytes - Free.Sum_Bytes)/Data.Sum_Bytes*100,2),'990.99')||'%' As "ʹ�ñ�"
From (Select     TableSpace_Name
                ,Round(Sum(Bytes)/1024/1024,2) As Sum_Bytes
                ,Round(Max(Bytes)/1024/1024,2) As Max_Bytes
      From Dba_Free_Space  --���б�ռ�
      Group By TableSpace_Name
     ) Free
,(Select TableSpace_Name,Round(Sum(Bytes)/1024/1024,2) As Sum_Bytes
  From Dba_Data_Files  --���ݿ��ļ���
  Group By TableSpace_Name
  ) Data
Where Free.TableSpace_Name = Data.TableSpace_Name
Order By 1
;

select to_char(22334.3456,'99999.99') from dual


select * from Dba_Free_Space;
select * from dba_col_comments where table_name ='DBA_FREE_SPACE';
select * from dba_tab_comments where table_name ='DBA_FREE_SPACE';