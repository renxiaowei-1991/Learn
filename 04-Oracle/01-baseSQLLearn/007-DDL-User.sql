--DDL:User
--  �����û�  https://blog.csdn.net/jtwmy_lb/article/details/85257715

--�û�����
�û��ܷ������ݿ�ǰ����Ҫ�л����Ӧ��Ȩ���˺ţ�oracle�д���һ���û���Ϊ���������ܼ򵥣������ڴ����û���ͬʱ��ʵ������ָ���ܶ���û�������,���⻹���û�����Ȩ���衣
�Ա��û�ȥִ����Ӧ�Ĳ�������������һ����ͬʱҲ������һ��ͨ��shema,shema���û���һһ��Ӧ�Ĺ�ϵ��shema�����ݿ������߼�������
�ڴ����û��Ĺ����п���ָ�����û������У�
1����֤��ʽ
2����֤����
3��Ĭ�ϵ����ñ�ռ䣬��ʱ��ռ�
4����ռ����
5���û��˺�״̬(locked or unlocked)
6������״̬(expired or not)
�﷨��ʽ��
create user username
identified by password;
����Դ����������ó���ʹ�õ��˻����������ó����������ݿ⣬û�˿���ʹ�ø��˻���¼�����ݿ⡣

--Ԥ���˻�
oracle������㴴�����ݿ�ʱ��������Զ��Ĵ���Ԥ���˻���
���е����ݿⶼ���������˻���
sys Ĭ�����룺chang_on_install
system Ĭ�����룺manager
sysman Ĭ������: chang_on_install
dbsnmp Ĭ�����룺dbsnmp
��ʵ���������е����ݿⶼ������������ʹ��dbca�������ݿ���ǣ�����ѡ
confiure enterprise manager
sysman��dbsnmp�Ͳ������ˡ�
�����װ��ʱ��Ҫ��װ��sample schema��������һЩԤ���˻����г��õ��У�
hr Ĭ�����룺hr
scott Ĭ�����룺TIGER

���е����ݶ��������ڲ��˻�(internal accounts),��Щ�Զ��������û���ʹ���ر��oracle���Ի������ӵ�������Լ���schema��Ϊ��֤��Щ�˻���δ����Ȩ��ʹ�ã���Щ�˻���lock�ģ���������Ϊexpire��

--�����û�
create user oracleusr //�û�����oracleuser
2 identified by oracle //��½��֤���룺oracle �������Ǵ�Сд���еģ�
3 default tablespace users //�û���Ĭ�ϱ�ռ䣺users
4 quota 10m on users //Ĭ�ϱ�ռ��п���ʹ�õĿռ���10MB
5 temporary tablespace temp //�û�ʹ�õ���ʱ��ռ�
6 password expire; //����״̬�����ڡ���½��ʱ��Ҫ���û��޸ġ�

CREATE USER user_name 
  IDENTIFIED { BY password
             | EXTERNALLY [ AS 'certificate_DN' ]
             | GLOBALLY [ AS '[ directory_DN ]' ]
             }
  [ DEFAULT TABLESPACE tablespace
  | TEMPORARY TABLESPACE
       { tablespace | tablespace_group }
  | QUOTA integer [ K | M | G | T | P | E ]
        | UNLIMITED }
        ON tablespace
    [ QUOTA integer [ K | M | G | T | P | E ]
        | UNLIMITED }
            ON tablespace
    ]
  | PROFILE profile_name
  | PASSWORD EXPIRE
  | ACCOUNT { LOCK | UNLOCK }
     [ DEFAULT TABLESPACE tablespace
     | TEMPORARY TABLESPACE
         { tablespace | tablespace_group }
     | QUOTA integer [ K | M | G | T | P | E ]
           | UNLIMITED }
           ON tablespace
       [ QUOTA integer [ K | M | G | T | P | E ]
           | UNLIMITED }
           ON tablespace
        ]
     | PROFILE profile
     | PASSWORD EXPIRE
     | ACCOUNT { LOCK | UNLOCK } ]
     ] ;
     
����˵��
user_name - Ҫ���������ݿ��ʻ������ơ�
PROFILE profile_name - ��ѡ�ġ�Ҫ������û��ʻ��������ļ������������Ʒ�����û��ʻ������ݿ���Դ�����������ʡ�Դ�ѡ���ὫDEFAULT�����ļ�������û���
PASSWORD EXPIRE - ��ѡ�ġ� ��������˴�ѡ���������Ժ�����������룬Ȼ���û����ܵ�¼��Oracle���ݿ⡣
ACCOUNT LOCK - ��ѡ�ġ������ö��û��ʻ��ķ��ʡ�
ACCOUNT UNLOCK - ��ѡ�ġ� �����Է����û��ʻ�


�û����������е�ע�����
1����temporary tablespace����ָ����
2�����û��Ϊ�û�ָ��Ĭ�ϱ�ռ䣬��ʹ��system��ռ䣬ǿ�ҽ���ָ��Ĭ�ϱ�ռ䡣
3��Ĭ�ϱ�ռ䲻����undo tablespace����temporary tablespace��
4�����û��Ϊ�û�ָ��Ĭ�ϱ�ռ䣬��ʱ��ռ䣬�û���ʹ��system�����ΪĬ�ϱ�ռ�����ʱ��գ�ǿ�ұ�����ִ���״����

���Բ�ѯ�����ֵ�dba_users��ѯ�û�����Ϣ
�����ѯ���洴�����û��Ĳ�����Ϣ��
SQL> select username,user_id,account_status,default_tablespace,temporary_tablespace
2 from dba_users
3 where username=��ORACLEUSR��;

ע��dba_users�е�password���Ѿ���oracle11gR2�������ˣ�ȡ����֮����authentication_type�С�

�޸��û������룺
�﷨��ʽ��
alter user user_name identified by new_password;

SQL> alter user system identified by oracle11g;
User altered
SQL> alter user oracleusr identified by oracle11g;
User altered
Ҫע���ˣ�oracle�и��û��޸������ʱ���ǲ���Ҫ�����������ġ�����һ����ȫ������
�κ��û����Ը��Լ��޸����룬����Ҫ�޸ı��˵�������Ҫȡ����Ӧ��Ȩ�ޡ�