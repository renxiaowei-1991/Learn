-- Grant、Revoke
-- DCL自动提交事务 https://blog.csdn.net/weixin_40379712/article/details/121967501

用户的权限来自系统权限和对象权限
下边有使用示例，做对应替换就可以执行

一、系统权限
1、3个索引权限
Grant CREATE ANY INDEX to User_Name；//创建索引
Grant ALTER ANY INDEX to User_Name；//更改索引
Grant DROP ANY INDEX to User_Name；//删除索引

2、5个存储过程权限
CREATE      PROCEDURE	
CREATE  ANY PROCEDURE	
ALTER   ANY PROCEDURE
EXECUTE ANY PROCEDURE 	 
DROP    ANY PROCEDURE	 

3、4个角色权限
CREATE    ROLE	
ALTER ANY ROLE	
DROP  ANY ROLE	
GRANT ANY ROLE

4、5个序列权限
CREATE     SEQUENCE 	
CREATE ANY SEQUENCE	
ALTER  ANY SEQUENCE
SELECT ANY SEQUENCE	
DROP   ANY SEQUENCE	 

5、登录数据库权限
CREATE SESSION

6、表空间权限
CREATE    TABLESPACE	
ALTER     TABLESPACE	
DROP      TABLESPACE
MANAGE    TABLESPACE
UNLIMITED TABLESPACE	 

7、类型权限
CREATE      TYPE	
CREATE  ANY TYPE	
ALTER   ANY TYPE 
DROP    ANY TYPE	
EXECUTE ANY TYPE	
UNDER   ANY TYPE

8、视图权限
CREATE        VIEW	
CREATE    ANY VIEW	
DROP      ANY VIEW
UNDER     ANY VIEW	
FLASHBACK ANY TABLE	
MERGE     ANY VIEW

9、表权限
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

10、触发器
CREATE     TRIGGER	
CREATE ANY TRIGGER	
ALTER  ANY TRIGGER
DROP   ANY TRIGGER	
ADMINISTER DATABASE TRIGGER	

11、备份数据库
EXP_FULL_DATABASE	
IMP_FULL_DATABASE

二、对象权限
1、具体表的操作权限：
grant select,delete,insert,update on user1.t_hr to user2;
grant all on user1.t_hr to user2;

2、具体存储过程执行权限
grant execute on procedure1 to user1

3、表空间
alter user user1 default tablespace app;

4、限制修改的列
grant update(wage,bonus) on teachers to user1

5、完整权限赋予
grant connect,resource,dba to user;

6、收回权限
revoke insert on departments from user1

三、其它方面
1、角色有哪些权限
select * from role_sys_privs where role='xujin';

2、用户有哪些权限
select * from dba_role_privs where grantee=upper('用户名')
With admin option 

3、用户sh拥有角色dw_manager的权限；可对角色分配用户；可删除角色
GRANT dw_manager
TO sh
WITH ADMIN OPTION;
With Grant option；

4、指定WITH GRANT OPTION以允许被授予者将对象特权授予其他用户和角色。
GRANT READ ON DIRECTORY bfile_dir TO hr
WITH GRANT OPTION;

5、系统角色的权限
select * from dba_sys_privs where grantee='角色名称'

四、通过角色管理权限
1、创建角色
Create Role Manager;

2、给角色赋权
Grant Create Table To Manager;

3、把角色权限赋给用户
Grant Manager To OracleLearn;

4、角色查询
select * from dba_role_privs where grantee='ORACLELEARN';
select * from user_role_privs;
select * from role_sys_privs where role='MANAGER';