1�����ݿ���ʵ���Ĺ�ϵ
���ݿ�(Database)���������ϵͳ�ļ�����̵ļ��ϡ�(���ݿ��Ǵ����ϴ洢�������ļ�����)
ʵ��(instance)��һ��Oracle��̨����/�߳��Լ�һ�������ڴ�������Щ�ڴ���ͬһ������������е�ͳһ�߳�/����������(ʵ������һ�����̺͹����ڴ�)
ʵ�������ݿ�֮��Ĺ�ϵ�ǣ����ݿ�����ɶ��ʵ��װ�غʹ򿪣���ʵ���������κ�ʱ���װ�غʹ�һ�����ݿ⡣

2��Oralce���ݿ����������ļ�����
��ʵ����ص��ļ��������ļ�(parameter file)�������ļ�(trace file)�������ļ�(alert file)
�������ݿ���ļ��������ļ�(data file)����ʱ�ļ�(temp file)�������ļ�(control file)��������־�ļ�(redo log file)�������ļ�(password file)
Oracle 10g�����ļ����޸ĸ����ļ�(change tracking file)��������־�ļ�(flashback log file)
���������ļ���ת���ļ�(DMP file)�����ݱ��ļ�(Data Pumn file)��ƽ���ļ�(flat file)

3��Oracle���ݿ⹹��(��ռ�(tablespace)����(segment)������(extent)����(block)�Ĺ�ϵ)
��ռ�(tablespace)����Oracle�е�һ���߼��洢������λ�ڴ洢�����ϵ�Ķ��㣬����           һ�����������ļ�
��(segment)��ռ�ô洢�ռ������Ϊ��������������ع��εȣ�����һ�������������
����(extent)�����ļ���һ���߼�����������Ŀռ䣻�����ɿ����
��(block)����Oracle����С�Ŀռ���䵥λ�������С�������Ŀ����ʱ�������ʹ洢�ڿ��У�Oracle�г����Ŀ��С��2K��4K��8K��16K(����ܳ���32K)
����֮��Ĺ�ϵ�����ݿ���һ��������ռ���ɣ���ռ���һ�����������ļ���ɣ���ռ�����Σ�����һ������������ɣ��������������Ŀ����

4�����ƽ���
����֧��ϵͳ(DSS)��Decision Support System
����������(OLTP)��On-line Transaction Processing
������������(OLAP)��On-Line Analytical ProcessingҲ��Ϊ���߷�������
ETL(Extraction-Transformation-Loading)����ȡ(Extraction)��ת��(Transformation)������(Loading)  ETL���𽫷ֲ��ġ��칹����Դ�е��������ϵ���ݡ�ƽ�������ļ��ȳ�ȡ����ʱ�м��������ϴ��ת�������ɣ������ص����ݲֿ�����ݼ����У���Ϊ�����������������ھ�Ļ����� ETL�����ݲֿ��еķǳ���Ҫ��һ����
��ϵ���ݿ����ϵͳ(RDBMS)��Relational Database Management System
����������ӷ�ʽ:nested loop(Ƕ��ѭ������)��sort merge join(����ϲ�����)��hash join(��ϣ����)
���ݲ�ѯ����(Select):���ڼ������ݿ�����
���ݶ�������(DDL)��Data Definition Language(�� create table��alter table��truncate table):���ڽ������޸ĺ�ɾ������Ϊ����(�������ύ(commit)����ִ��DDL����COMMIT����������б���ع�������DDL����ع�����ֱ���ύ(commit))
���ݲ�������(DML): Data Manipulation Language(����:insert��update��delete):���ڸı����ݿ�����
���ݿ�������(DCL): Data Control Language(����:grant��revoke):����ִ��Ȩ��������ջز���(ͬ���ݲ�������DML���Զ��ύ����)
�����������(TCL):Transactional Control Language(Commit��Rollback��Savepoint)������ά�����ݵ�һ����
Recursive Calls��Number of recursive calls generated at both the user and system level.���û���ϵͳ��ɵĵݹ��������
DB Block Gets����������ݿ���buffer������ĸ���(Number of times a CURRENT block was requested.)
Consistent(һ����) Gets�����������ڻع���Buffer�е����� (Number of times a consistent read was requested for a block.)
Physical Reads���Ӵ��̶���Buffer Cache���ݿ�����(Total number of data blocks read from disk. This number equals the value of "physical reads direct" plus all reads into buffer cache)
Sorts (disk)��Number of sort operations that required at least one disk write. Sorts that require I/O to disk are quite resource intensive. Try increasing the size of the initialization parameter SORT_AREA_SIZE.(����������Ҫ����С����д)
PCTFREE��PCTFREE��������ָ�����б��뱣������С���пռ����.֮����ҪΪ�鱣��һЩ���пռ�,����Ϊ�ڶԿ��д洢�����ݽ����޸�ʱ(UPDATE����),�п��ܻ���Ҫ����Ĵ洢�ռ�.��ʱ������д洢�ռ䲻��,�ͱ�������¿�,��ʱ�����ָ��,��������.�����ÿ���������д����ʱ��������,����һ���ֿ��ÿռ�,����20%,����Ծ���������������. ��һЩ�����Ժ�ʹ��ʱ,�������update����ʱ,�����ʹ����20%�Ŀռ�.�����һЩ���е����ݺ�����û���˻������,������ԭ����90%��Ϊ70%,��Ϊ�ѷ���PCTFREE�Ĺ涨,��ô�����INSERT�����Ļ�,��ÿ��ֿ��Ա�ʹ����,��ʵ���������ֻ��10%�Ŀռ���Ը�INSERT����ʹ��,�����������Ӧ�ñ���.�Ǿ��õ�������Ĳ���(PCTUSED)
PCTUSED��PCTUSED��������ָ��һ���ٷֱ�,�������Ѿ�ʹ�õĴ洢�ռ併�͵�����ٷֱ�֮��ʱ,�����ű����Ϊ����,��������ļ�ʹ�����Ѿ���30%�Ŀ��ÿռ�,����Ȼ������. ����ORACLEΪ�˷�ֹ����̫���������Ƭ�����������ݿ����ܼ���ֹ�˷ѿռ���������������ʵ͵�һ���ṩ��רҵ�û�ʹ�õĲ�����   
    ��һ����д��pctused��ָ����ֵʱ���磺80%���������ͱ����Ϊ���ã��������ٳ����д���ݣ���Ϊ�պ��޸Ĵ˿��ڵ�ĳ����¼����Ҫ���������������ṩ����
    ��һ������Ϊ�޸ļ�ɾ����¼��ʹ��ռ���ʽ��͵�pctfree��ָ����ֵʱ���磺20%���� �������ֵ�������鱻���Ϊ���ã������ӵļ�¼�Ϳ��Գ��������д����
    ��������ǳ�רҵ��һ��Ҫ��ǳ���Ϥ���̵������˽��Լ����ݿ��Ӧ���ص�ſ��Ե��������ҵ����˲���һ��Ҫ���о��飬���鲻�Ǻ�ȷ����Ҫ�����������Ϊ���󽵵����ݿ�Ч�ʵ�
INITRANS������ȷ��Ϊ��������Ԥ����������ݿ�ͷ���Ŀռ䡣����Ԥ������ಢ��������Ҫ�漰ĳ����ʱ����Ϊ��ص���������Ԥ�������Ŀռ䣬�Ա��⶯̬����ÿռ�Ŀ�����
MAXTRANS���������Ʋ���ʹ��ĳ�����ݿ�������������������Ԥ����������������з���ĳ��С��ʱ���򵱴�����ʱ��Ӧ���øñ����������Ԥ�������Ŀ�ռ䣬�ϸߵ�MAXTRANS ����ֵ��������������з��ʸñ�INITRANS��MAXTRANS ���������ÿ�����Ӧ��һЩ����ֱ�Ϊ2��5��
