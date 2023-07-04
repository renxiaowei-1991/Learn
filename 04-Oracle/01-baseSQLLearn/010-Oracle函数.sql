--函数
1、函数基本类型
单行函数、多行函数、行列转换函数、递归函数、分析函数
 
2、单行函数
Scalar函数的操作面向某个单一的值，并返回基于输入值的一个单一的值。
主要的单行函数：字符函数、数字函数、日期函数、转换函数、通用函数
  
3.1、单行函数-字符函数
大小写控制函数
  Lower:转小写
  upper:转大写
  InItcap:首字母转大写

字符控制函数
  Concat:字符串连接(等价于||)
  Substr:字符串截取
  Length:获取字符串长度(LengthB)
  Instr:获取子字符串在字符串中的开始位置
    Instr(Str,SubStr,I,J)
      Str:被搜索的字符串
      SubStr:希望搜索的字符串
      I:搜索开始的位置
      J:出现第几次的位置
  Lpad:用指定字符从左边补齐字符串长度到指定位数
    Lpad(Str,Len,Char)
  Rpad:右补齐
  Trim:去除两边的指定字符串或字符
  Ltrim:去除左边的指定字符串或字符
  Rtrim:去除右边的指定字符串或字符
  Replace:替换字符串
  
select Instr('abcdabcdab','a',2,2) as position from dual;
select Lpad('abcd',10,'*') from dual;
select Ltrim('aabcd','a') from dual;

3.2、单行行数-数字函数
ABS:绝对值
Round(c,num):四舍五入
Floor(num):向下取整
Ceil(num):向上取整
Trunc:按照指定的精度截取一个数
Mod(x,y):取余

select Round(123.456,2) As num From dual;
select Floor(123.456) As num From dual;
select Ceil(123.456) As num From dual;
select Trunc(123.456,2) As num From dual;
select Mod(666666,100) As num From dual;

3.3、单行函数-日期函数
Add_months:加减月份
Last_day:返回本月的最后一天
Next_day:指定日期的下一个日期(例如下一个星期五)
Months_between:返回两个日期之间的月数
Sysdate:用来得到系统的当前日期(date)
SysTimestamp:用来得到系统的当前日期(timestamp)

select to_char(Add_months(to_date('2022-05-17','YYYY-MM-DD'),2),'YYYY-MM-DD') from dual;
select to_char(last_day(to_date('2022-05-17','YYYY-MM-DD')),'YYYY-MM-DD') from dual;
select to_char(next_day(to_date('2022-05-17','YYYY-MM-DD'),'FRIDAY'),'YYYY-MM-DD') from dual;
--select to_char(next_day(to_date('2022-05-17','YYYY-MM-DD'),'星期五'),'YYYY-MM-DD') from dual;
select months_between(to_date('2022-05-16','YYYY-MM-DD'),to_date('2022-05-17','YYYY-MM-DD')) from dual;
select sysdate,systimestamp from dual;

3.4、单行函数-转换函数(数据类型转换)
隐性、显性
  
显性转换
Character->(To_Date)->Date->(To_Char)->Character
Character->(To_Number)->Number->(To_Char)->Character
Character->(ASCII)->ASCII码->(Chr)Character
  
To_Date(Str,'format'):字符串转日期
To_Number(Str):字符串转数字
To_Char():数值转字符串&日期转字符串
ASCII():字符转ASCII码值
Chr():ASCII码值转字符

select To_Date('2022-05-17','YYYY-MM-DD') from dual;
select To_Number('2022') from dual;
select To_Char(2022),To_Char(Sysdate,'YYYY-MM-DD'),to_char(334.3456,'990.99'),to_char(33334.3456,'990.99') from dual;
select ASCII('A') from dual;
select CHR(65) from dual;

3.5、单行函数-通用函数
这些函数适用于任何数据类型，同时也适用于空值

NVL(expr1,expr2):如果第一个表达式为空，返回第二个表达式的值，否则返回第一个表达式的值
Coalesce(expr1,expr2,...,exprn):返回第一个非空表达式的值
NULLIF(expr1,expr2):比较两个表达式的值，如果想等返回null，否则返回第一个表达式的值

select nvl(null,1) from dual;
select Coalesce(null,1,null,2) from dual;
select nullif(1,2),nullif(1,1) from dual;

3.6、单行函数-Decode函数、Case表达式
Case expr When comparison_expr1 Then return_expr1
          [When comparison_expr2 Then return_expr2]
          ...
          [When comparison_exprn Then return_exprn]
          [Else else_expr]
End

Case When comparison_expr1 Then return_expr1
     [When comparison_expr2 Then return_expr2]
     ...
     [When comparison_exprn Then return_exprn]
     [Else else_expr]
End

Decode函数是Case表达式的简写。
  含义：字段col或者表达式expr，和search1比较，如果相等，返回result1；否则和search2比较，如果相等，返回result2；...；否则和searchn比较，如果相等，返回resultn；否则返回default。
Decode(col | expr
      ,search1,result1
      [,search2,result2]
      ...
      [,searchn,resultn]
      [,default]
      )
      
select decode('aa','bb',1,'cc',2,'aa',3,4) from dual;
等价于
select case 'aa' when 'bb' then 1 
                 when 'cc' then 2 
                 when 'aa' then 3 
                 else 4 
       end 
from dual;


4、多行函数
多行函数的操作面向一系列的值，并返回一个单一的值。

语法：
  Select [Column,]Group_Function(Column),...
  From TableName
  [Where Condition]
  [Group By Column]
  [Having Group_Condition]
  [Order By Column]
  ;

主要的多行函数：
  Count:统计行数
    Count[(*)|(Distinct|All ColumnName)]
  Sum:求和
    Sum([Distinct] ColumnName)
  Max:最大值
    Max([Distinct] ColumnName)
  Min:最小值
    Min([Distinct] ColumnName)
  Avg:平均值
    Avg([Distinct] ColumnName)

select count(*),count(col01),count(distinct col01),count(all col01) from learn01;
select sum(col02),sum(distinct col02) from learn01;
select Max(col02),Max(distinct col02) from learn01;
select Min(col02),Min(distinct col02) from learn01;
select Avg(col02),Avg(distinct col02) from learn01;

注意：
  多行函数忽略控制
  多行函数的返回值加限制条件不能在where中，应该在having中
  
示例：
  select col01,sum(col02) as col02,sum(distinct col02) as col03
  from learn01
  where col01 is not null
  group by col01
  having sum(col02) > 1
  order by col01
  ;
  
示例:删除表中重复数据
  Delete From Learn01 Where RowId Not In (
    Select Min(RowID) From Learn01
    Group by id
  );
  
5、行列转换函数
行转列、列转行


6、多行函数-递归(Connect By)
Start With ... Connect By Prior ...
Level:递归层级

用于查询树形结构的表数据
生成连续的数值


7、多行函数-分析函数
... Over(Partition By ... Order By ...)
对数据进行分组操作
先分组，然后对数据按组进行操作