-- Grant��Revoke
-- DCL�Զ��ύ���� https://blog.csdn.net/weixin_40379712/article/details/121967501

�û���Ȩ������ϵͳȨ�޺Ͷ���Ȩ��
�±���ʹ��ʾ��������Ӧ�滻�Ϳ���ִ��

һ��ϵͳȨ��
1��3������Ȩ��
Grant CREATE ANY INDEX to User_Name��//��������
Grant ALTER ANY INDEX to User_Name��//��������
Grant DROP ANY INDEX to User_Name��//ɾ������

2��5���洢����Ȩ��
CREATE      PROCEDURE	
CREATE  ANY PROCEDURE	
ALTER   ANY PROCEDURE
EXECUTE ANY PROCEDURE 	 
DROP    ANY PROCEDURE	 

3��4����ɫȨ��
CREATE    ROLE	
ALTER ANY ROLE	
DROP  ANY ROLE	
GRANT ANY ROLE

4��5������Ȩ��
CREATE     SEQUENCE 	
CREATE ANY SEQUENCE	
ALTER  ANY SEQUENCE
SELECT ANY SEQUENCE	
DROP   ANY SEQUENCE	 

5����¼���ݿ�Ȩ��
CREATE SESSION

6����ռ�Ȩ��
CREATE    TABLESPACE	
ALTER     TABLESPACE	
DROP      TABLESPACE
MANAGE    TABLESPACE
UNLIMITED TABLESPACE	 

7������Ȩ��
CREATE      TYPE	
CREATE  ANY TYPE	
ALTER   ANY TYPE 
DROP    ANY TYPE	
EXECUTE ANY TYPE	
UNDER   ANY TYPE

8����ͼȨ��
CREATE        VIEW	
CREATE    ANY VIEW	
DROP      ANY VIEW
UNDER     ANY VIEW	
FLASHBACK ANY TABLE	
MERGE     ANY VIEW

9����Ȩ��
CREATE     TABLE	
CREATE ANY TABLE	
ALTER  ANY TABLE
BACKUP ANY TABLE	
DELETE ANY TABLE	
DROP   ANY TABLE
INSERT ANY TABLE	
LOCK   ANY TABLE	
SELECT ANY TABLE
FLASHBACK ANY TABLE
UPDATE    ANY TABLE	 

10��������
CREATE     TRIGGER	
CREATE ANY TRIGGER	
ALTER  ANY TRIGGER
DROP   ANY TRIGGER	
ADMINISTER DATABASE TRIGGER	

11���������ݿ�
EXP_FULL_DATABASE	
IMP_FULL_DATABASE

��������Ȩ��
1�������Ĳ���Ȩ�ޣ�
grant select,delete,insert,update on user1.t_hr to user2;
grant all on user1.t_hr to user2;

2������洢����ִ��Ȩ��
grant execute on procedure1 to user1

3����ռ�
alter user user1 default tablespace app;

4�������޸ĵ���
grant update(wage,bonus) on teachers to user1

5������Ȩ�޸���
grant connect,resource,dba to user;

6���ջ�Ȩ��
revoke insert on departments from user1

������������
1����ɫ����ЩȨ��
select * from role_sys_privs where role='xujin';

2���û�����ЩȨ��
select * from dba_role_privs where grantee=upper('�û���')
With admin option 

3���û�shӵ�н�ɫdw_manager��Ȩ�ޣ��ɶԽ�ɫ�����û�����ɾ����ɫ
GRANT dw_manager
TO sh
WITH ADMIN OPTION;
With Grant option��

4��ָ��WITH GRANT OPTION�����������߽�������Ȩ���������û��ͽ�ɫ��
GRANT READ ON DIRECTORY bfile_dir TO hr
WITH GRANT OPTION;

5��ϵͳ��ɫ��Ȩ��
select * from dba_sys_privs where grantee='��ɫ����'

�ġ�ͨ����ɫ����Ȩ��
1��������ɫ
Create Role Manager;

2������ɫ��Ȩ
Grant Create Table To Manager;

3���ѽ�ɫȨ�޸����û�
Grant Manager To OracleLearn;

4����ɫ��ѯ
select * from dba_role_privs where grantee='ORACLELEARN';
select * from user_role_privs;
select * from role_sys_privs where role='MANAGER';