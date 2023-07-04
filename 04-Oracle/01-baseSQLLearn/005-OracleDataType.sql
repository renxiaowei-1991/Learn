--Oracle数据类型
--数据类型            描述
--Varchar2(size)      可变长字符数据
--Char(size)          定长字符数据
--Number(p,s)         可变长数值数据
--Date                日期型数据
--Long                可变长字符数据，最大可达到2G
--Clob                字符数据，最大可达到4G
--Raw and Long Raw    裸二进制数据
--Blob                二进制数据，最大可达到4G
--BFile               存储外部文件的二进制数据，最大可达到4G
--RowID               行地址

--Date:日期型
--https://blog.csdn.net/weixin_30855099/article/details/98714520
1、常用日期型数据类型
1.1、Date
    这是Oracle最常用的日期类型，它可以保存日期和时间，常用日期处理都可以采用这种类型。
    Date表示的日期范围可以是公元前4712年1月1日到公元9999年12月31日。
    Date类型在数据库中存储固定为7个字节，格式为：
    第1字节：世纪+100
    第2字节：年
    第3字节：月
    第4字节：日
    第5字节：小时+1
    第6字节：分+1
    第7字节：秒+1

1.2、TimeStamp(p)
    这也是Oracle常用的日期类型，它与Date的区别是不仅可以保存日期和时间，还能保存小数秒，小数位数可以指定为0-9，默认为6位，所以最高精度可以导ns(纳秒)。
    数据库内部用7或者11个字节存储，如果精度为0，则用7字节存储，与Date类型功能相同，如果精度大于0则用11字节存储。格式为：
    第1字节：世纪+100
    第2字节：年
    第3字节：月
    第4字节：日
    第5字节：小时+1
    第6字节：分+1
    第7字节：秒+1
    第8-11字节：纳秒，采用4个字节存储，内部运算类型为整型
    注意：TimeStamp日期类型如果与数值进行加减运算会自动转换为Date类型，也就是说小数秒会自动去除
    

1.3、获取Date、TimeStamp格式时间  
to_date('2022-05-16 11:35:00','YYYY-MM-DD HH24:MI:SS')
to_timestamp('2022-05-16 11:35:00.123456','YYYY-MM-DD HH24:MI:SS.FF6')

2、常见问题
2.1、如何获取当前时间
sysdate:返回当前系统日期和时间，精确到秒
systimestamp:返回当前系统日期和时间，精确到毫秒

2.2、如何进行日期运算
日期型数据可以与数值加减得到新的日期，加减数值单位为天
sysdate+1:取明天的当前时间
sysdate-1/24:取当前时间的前一个小时
select sysdate+1,sysdate-1/24,systimestamp,systimestamp+1 from dual

2.3、如何求两个日期的间隔时间
select date'2022-05-16' from dual;
select date'2022-05-16'-sysdate from dual;

2.4、日期转字符
to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')

2.5、字符转日期
to_date('2022-05-16','YYYY-MM-DD')
to_date('2022-05-16 11:35:00','YYYY-MM-DD HH24:MI:SS')
to_timestamp('2022-05-16 11:35:00.123456','YYYY-MM-DD HH24:MI:SS.FF6')

3、常用日期函数
3.1、to_char(Date,FormatStr):格式化日期成字符
to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')
to_char(date '2022-05-16','DD') --当月第几天

3.2、to_date(Char,FormatStr):将字符转换成日期
to_date('2022-05-16 11:35:00','YYYY-MM-DD HH24:MI:SS')

3.3、Trunc(Date):返回Date的日期部分，时间为0点0分0秒
select sysdate as a1,trunc(sysdate) as a2 from dual

3.4、Extract(Data From DateValue):返回Date的某一部分内容
如果DATEVALUE为DATE类型，则DATA可以是(YEAR、MONTH、DAY)
如果DATEVALUE为TIMESTAMP类型，则DATA可以是(YEAR、MONTH,DAY、HOUR、MINUTE、SECOND)
select sysdate,extract(year from sysdate) as a1,extract(year from systimestamp) as a2 from dual;

3.5、Add_months(Date,Months):在Date增加月份得到新日期
select add_months(sysdate,3) from dual;

3.6、Last_day(Date):返回日期所在月份的最后一条日期
select last_day(sysdate) as a1 from dual;

3.7、Next_Day(Date):从给定日期开始返回下一个Char指定星期的日期(也就是下一个星期几)
select next_day(date'2022-05-16','MONDAY') as a1,next_day(date'2022-05-15','MONDAY') as a2 from dual;

