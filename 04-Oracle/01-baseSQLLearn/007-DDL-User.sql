--DDL:User
--  创建用户  https://blog.csdn.net/jtwmy_lb/article/details/85257715

--用户属性
用户能访问数据库前必须要有获得相应授权的账号，oracle中创建一个用户并为其分配密码很简单，但是在创建用户的同时其实还可以指定很多该用户的属性,另外还有用户的特权授予。
以便用户去执行相应的操作。当创建了一个的同时也创建了一个通的shema,shema与用户是一一对应的关系。shema是数据库对象的逻辑容器。
在创建用户的过程中可以指定的用户属性有：
1、认证方式
2、认证密码
3、默认的永久表空间，临时表空间
4、表空间配额
5、用户账号状态(locked or unlocked)
6、密码状态(expired or not)
语法格式：
create user username
identified by password;
你可以创建仅供运用程序使用的账户，用于运用程序连接数据库，没人可以使用该账户登录到数据库。

--预置账户
oracle会根据你创建数据库时候的配置自动的创建预置账户：
所有的数据库都包括管理账户：
sys 默认密码：chang_on_install
system 默认密码：manager
sysman 默认密码: chang_on_install
dbsnmp 默认密码：dbsnmp
其实并不是所有的数据库都包括，你若在使用dbca创建数据库的是，不勾选
confiure enterprise manager
sysman与dbsnmp就不会有了。
如果安装的时候要求安装了sample schema，还会多出一些预置账户其中常用的有：
hr 默认密码：hr
scott 默认密码：TIGER

所有的数据都包含有内部账户(internal accounts),这些自动创建的用户，使得特别的oracle特性或者组件拥有他们自己的schema。为保证这些账户被未经授权的使用，这些账户是lock的，密码设置为expire。

--创建用户
create user oracleusr //用户名：oracleuser
2 identified by oracle //登陆验证密码：oracle （密码是大小写敏感的）
3 default tablespace users //用户的默认表空间：users
4 quota 10m on users //默认表空间中可以使用的空间配额：10MB
5 temporary tablespace temp //用户使用的临时表空间
6 password expire; //密码状态，过期。登陆的时候要求用户修改。

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
     
参数说明
user_name - 要创建的数据库帐户的名称。
PROFILE profile_name - 可选的。要分配给用户帐户的配置文件的名称是限制分配给用户帐户的数据库资源的数量。如果省略此选项，则会将DEFAULT配置文件分配给用户。
PASSWORD EXPIRE - 可选的。 如果设置了此选项，则过期了以后必须重置密码，然后用户才能登录到Oracle数据库。
ACCOUNT LOCK - 可选的。它禁用对用户帐户的访问。
ACCOUNT UNLOCK - 可选的。 它可以访问用户帐户


用户创建过程中的注意事项：
1、对temporary tablespace不能指定配额。
2、如果没有为用户指定默认表空间，将使用system表空间，强烈建议指定默认表空间。
3、默认表空间不能是undo tablespace或者temporary tablespace。
4、如果没有为用户指定默认表空间，临时表空间，用户将使用system表空作为默认表空间与临时表空，强烈避免出现此种状况。

可以查询数据字典dba_users查询用户的信息
下面查询上面创建的用户的部分信息。
SQL> select username,user_id,account_status,default_tablespace,temporary_tablespace
2 from dba_users
3 where username=‘ORACLEUSR’;

注：dba_users中的password列已经在oracle11gR2中弃用了，取而代之的是authentication_type列。

修改用户的密码：
语法格式：
alter user user_name identified by new_password;

SQL> alter user system identified by oracle11g;
User altered
SQL> alter user oracleusr identified by oracle11g;
User altered
要注意了，oracle中给用户修改密码的时候是不需要，输入旧密码的。这是一个安全隐患。
任何用户可以给自己修改密码，但是要修改别人的密码需要取得相应的权限。