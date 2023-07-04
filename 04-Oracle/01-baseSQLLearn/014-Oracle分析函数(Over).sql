--分析函数
--聚合函数+开窗函数=分析函数

Sum():聚合函数
WMSYS.WM_CONCAT():聚合函数(列转行)
Row_Number():聚合函数
...
Over():开窗函数


1、分析函数
  聚合函数+开窗函数=分析函数
  分析函数是聚合函数和开窗函数的组合

  用于计算基于组的某种聚合值，它和聚合函数的不同之处是对于每个组返回多行，而聚合函数对于每个组只返回一行

2、开窗函数
  开窗函数指定了分析函数工作的数据窗口的大小，这个数据窗口大小可能会随着行的变化而变化。
  开窗函数包含三个分析子句
    分组(partition by)
    排序(order by )
    窗口(rows)
  语法：
    over(partition by xxx order by yyy rows between zzz)

  窗口大小相关词
    preceding:前面的
    following:之后的
    unbounded:无边界
    

--样例数据
create table c_over_table(
     name varchar2(100)
    ,class varchar2(10)
    ,grade int
) tablespace oraclelearn;
insert into c_over_table values('a01','01',80);
insert into c_over_table values('a02','01',78);
insert into c_over_table values('a03','01',95);
insert into c_over_table values('a04','02',74);
insert into c_over_table values('a05','02',92);
insert into c_over_table values('a06','03',99);
insert into c_over_table values('a07','03',99);
insert into c_over_table values('a08','03',45);
insert into c_over_table values('a09','03',55);
insert into c_over_table values('a10','03',78);
    
2.1 开窗函数用法
  range:表示数据范围按照取值范围处理
  rows:表示数据范围按照行范围处理

1) over()
  默认的开窗函数，不分区，不排序。相当于直接对全部进行前面的聚合函数操作。然后把聚合结果放到每一行。
  e.g: 
    select a.*,sum(grade) over() as rank from c_over_table a;
2) over(order by null)
  等价于over()
3) over(order by salary)
  默认的排序窗口函数，数据窗口是按salary排序以后，等于等于salary的数据部分
  等价于：
    over(order by salary range unbounded preceding)  --前无边界，后为本身
    over(order by salary rows unbounded preceding)
  e.g:
    select a.*,sum(grade) over(order by grade) as rank from c_over_table a;
    select a.*,sum(grade) over(order by grade range unbounded preceding) as rank from c_over_table a;
    select a.*,sum(grade) over(order by grade rows unbounded preceding) as rank from c_over_table a;
4) over(order by salary range between 5 preceding and 5 following) 
  range:表示数据范围按照取值范围处理
  数据窗口是  salary - 5 <= salary <= salary + 5
  e.g:
    select a.*,sum(grade) over(order by grade range between 5 preceding and 5 following) as rank from c_over_table a;
    
    select a.*,sum(lv) over(order by lv range between 5 preceding and 5 following) as aa 
    from (select level lv from dual where level >= 1 connect by level <=10) a
5) over(order by salary rows between 2 preceding and 4 following)
  rows:表示数据范围按照行范围处理
  数据窗口是，排序以后，本行之前两行到本行之后四行
  (本行、本行之前一行、本行之后4行)
  e.g:
    select a.*,sum(grade) over(order by grade rows between 1 preceding and 2 following) as rank from c_over_table a;
6) over(order by salary range between unbounded preceding and unbounded following)
  按取值范围，前无边界，后无边界
  e.g:
    select a.*,sum(grade) over(order by grade range between unbounded preceding and unbounded following) as rank from c_over_table a;
7) over(order by salary rows between unbounded preceding and unbounded following)
  按行范围，前无边界，后无边界
  e.g:
    select a.*,sum(grade) over(order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    
3、常用分析函数：
注意：
  1、分析函数的所有开窗函数中，只要有order by ...,都遵循上述的。默认开窗函数排序规则(over(order by salary))
  2、排序开窗函数row_number()、rank()、dense_rank()，不需要配合rows()、range()使用
  
分类：
  排序开窗函数
  聚合开窗函数

row_number() over(partition by ... order by ...)
  分区，排序，获取行，不进行并列排序(例如：没有两个第1名)
  e.g:
    --select a.*,row_number() over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,row_number() over(partition by class order by grade) as rank from c_over_table a;
rank() over(partition by ... order by ...)
  分区，排序，获取排名，并列排序，但是跳跃排序(例如，有两个第一名，但是没有第二名)
  e.g:
    --select a.*,rank() over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,rank() over(partition by class order by grade) as rank from c_over_table a;
dense_rank() over(partition by ... order by ...)
  分区，排序，获取排名，并列排序，非跳跃排序(例如，有两个第一名，但是还会有第二名)
  e.g:
    --select a.*,dense_rank() over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,dense_rank() over(partition by class order by grade) as rank from c_over_table a;
count() over(partition by ... order by ...)
  分区，排序，获取排序统计个数
  e.g:
    select a.*,count(*) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,count(*) over(partition by class order by grade) as rank from c_over_table a;
max() over(partition by ... order by ...)
  分区，排序，获取排序最大值
  e.g:
    select a.*,max(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,max(grade) over(partition by class order by grade) as rank from c_over_table a;
min() over(partition by ... order by ...)
  分区，排序，获取排序最小值
  e.g:
    select a.*,min(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,min(grade) over(partition by class order by grade) as rank from c_over_table a;
sum() over(partition by ... order by ...)
  分区，排序，获取排序汇总数
  e.g:
    select a.*,sum(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,sum(grade) over(partition by class order by grade) as rank from c_over_table a;
avg() over(partition by ... order by ...)
  分区，排序，获取排序平均数
  e.g:
    select a.*,avg(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,avg(grade) over(partition by class order by grade) as rank from c_over_table a;
first_value() over(partition by ... order by ...) 
  分区，排序，获取指定列的第一行
  e.g:
    select a.*,first_value(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,first_value(grade) over(partition by class order by grade) as rank from c_over_table a;
last_value() over(partition by ... order by ...)
  分区，排序，获取指定列的最后一行
  e.g:
    select a.*,last_value(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,last_value(grade) over(partition by class order by grade) as rank from c_over_table a;
lag() over(partition by ... order by ...)
  lag()偏移分析函数，分区，排序，获取排序后的当前值的上num个值
  语法：
    lag(field,num,defaultvalue)
    解释：
      field:获取前后值的字段
      num:获取前面第num个值
      defaultvalue:如果第num个值没有数据，则取这个默认值
  e.g:
    select a.*,lag(name,1,'Null') over(partition by class order by grade) as rank from c_over_table a;
lead() over(partition by ... order by ...)
  lead()偏移分析函数，分区，排序，获取排序后的当前值的下num个值
  语法：
    lead(field,num,defaultvalue)
    解释：
      field:获取前后值的字段
      num:获取后面第num个值
      defaultvalue:如果第num个值没有数据，则取这个默认值
  e.g:
    select a.*,lead(name,1,'Null') over(partition by class order by grade) as rank from c_over_table a;