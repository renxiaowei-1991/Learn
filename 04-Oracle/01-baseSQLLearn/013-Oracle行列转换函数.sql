--Oracle行列转换函数
行转列
列转行


--一、固定行列转换

--样例数据准备
Create Table a_table(
     c_year  Varchar2(10) not null
    ,c_month Varchar2(10) not null
    ,c_qty   Int not null
) TableSpace OracleLearn
;
Comment On Table a_table Is '测试表a';
Comment On Column a_table.c_year Is '年份';
Comment On Column a_table.c_month Is '月份';
Comment On Column a_table.c_qty Is '数量';

Insert Into a_table
Select '2016年' as c_year,'1月' as c_month,100 as c_qty From dual Union All
Select '2016年' as c_year,'2月' as c_month,101 as c_qty From dual Union All
Select '2016年' as c_year,'3月' as c_month,102 as c_qty From dual Union All
Select '2016年' as c_year,'4月' as c_month,103 as c_qty From dual Union All
Select '2017年' as c_year,'1月' as c_month,201 as c_qty From dual Union All
Select '2017年' as c_year,'2月' as c_month,202 as c_qty From dual Union All
Select '2017年' as c_year,'3月' as c_month,203 as c_qty From dual Union All
Select '2017年' as c_year,'4月' as c_month,204 as c_qty From dual Union All
Select '2018年' as c_year,'1月' as c_month,302 as c_qty From dual Union All
Select '2018年' as c_year,'2月' as c_month,303 as c_qty From dual Union All
Select '2018年' as c_year,'3月' as c_month,304 as c_qty From dual Union All
Select '2018年' as c_year,'4月' as c_month,305 as c_qty From dual Union All
Select '2019年' as c_year,'1月' as c_month,403 as c_qty From dual Union All
Select '2019年' as c_year,'2月' as c_month,404 as c_qty From dual Union All
Select '2019年' as c_year,'3月' as c_month,405 as c_qty From dual Union All
Select '2019年' as c_year,'4月' as c_month,406 as c_qty From dual
;
Commit;


Create Table b_table(
     t_year      Varchar2(10) not null
    ,one_month   Int not null
    ,two_month   Int not null
    ,three_month Int not null
    ,four_month  Int not null
) TableSpace OracleLearn
;
Comment On Table b_table Is '测试表b';
Comment On Column b_table.t_year Is '年份';
Comment On Column b_table.one_month Is '一月';
Comment On Column b_table.two_month Is '二月';
Comment On Column b_table.three_month Is '三月';
Comment On Column b_table.four_month Is '四月';

Insert Into b_table
Select '2016年' as t_year,100 as one_month,101 as two_month,102 as three_month,103 as four_month From dual Union All
Select '2017年' as t_year,201 as one_month,202 as two_month,203 as three_month,204 as four_month From dual Union All
Select '2018年' as t_year,302 as one_month,303 as two_month,304 as three_month,305 as four_month From dual Union All
Select '2019年' as t_year,403 as one_month,404 as two_month,405 as three_month,406 as four_month From dual
;
Commit;


select * from a_table;
select * from b_table;

--1.1 行转列，将a_table表的行转列
--1.1.1 Decode实现
select     c_year
          ,Sum(Decode(c_month,'1月',c_qty,0)) as one_month
          ,Sum(Decode(c_month,'2月',c_qty,0)) as two_month
          ,Sum(Decode(c_month,'3月',c_qty,0)) as three_month
          ,Sum(Decode(c_month,'4月',c_qty,0)) as four_month
from a_table
group by c_year
order by c_year
;

--1.1.2 Case实现
select     c_year
          ,Sum(Case when c_month='1月' then c_qty else 0 end) as one_month
          ,Sum(Case when c_month='2月' then c_qty else 0 end) as two_month
          ,Sum(Case when c_month='3月' then c_qty else 0 end) as three_month
          ,Sum(Case when c_month='4月' then c_qty else 0 end) as four_month
from a_table
group by c_year
order by c_year
;

--pivot函数实现
--  pivot函数语法
--    pivot(任一聚合函数 for 转列值所在的列名 in (转为列名的值))，其中in ('')中可以指定别名，in中还可以指定子查询
--注意：
--  这里将a_table表作为pivot的输入表，一般输入表只返回需要用到的列，这里因为表字段都需要，所以可以直接用a_table表作为输入表
select * from a_table
pivot(Sum(c_qty) For c_month In ('1月','2月','3月','4月'))
order by c_year
;

select * 
from (select c_year,c_month,c_qty from a_table) a
pivot(Sum(c_qty) For c_month In ('1月' as one_month,'2月' as two_month,'3月' as three_month,'4月' as four_month))
;



--1.2 列转行，将b_table表的列转为行
--1.2.1 Decode实现。对原表做笛卡尔积，一行复制成4行，然后通过Decode实现。
select     a1.t_year
          ,Decode(a2.lv,1,'1月',2,'2月',3,'3月',4,'4月') as t_month
          ,Decode(a2.lv,1,a1.one_month,2,a1.two_month,3,a1.three_month,4,a1.four_month) as t_qty
from  b_table a1
     ,(select Level lv From dual where level >=1 Connect By Level<=4) a2
order by   t_year,t_month
;

--1.2.2 Case实现。与Decode同理
select     a1.t_year
          ,case a2.lv when 1 then '1月' when 2 then '2月' when 3 then '3月' when 4 then '4月' end as t_month
          ,case a2.lv when 1 then a1.one_month when 2 then a1.two_month when 3 then a1.three_month when 4 then a1.four_month end as t_qty
from  b_table a1
     ,(select Level lv From dual where level >=1 Connect By Level<=4) a2
order by   t_year,t_month
;

--1.2.3 unpivot函数实现
--  unpivot函数语法
--    unpivot(新增值所在列的列名 For 列名转为行值后所在列名 In (转为行的列名(需要使用as将列名转换为想要在转换后字段中存储的字符串)))
select * from b_table
unpivot(t_qyt for t_month in (one_month as '1月',two_month as '2月',three_month as '3月',four_month as '4月'))
;

select * from b_table
unpivot(t_qyt for t_month in (one_month,two_month,three_month,four_month))
;


--二、不固定行列转换
--1、行转列
  利用递归Level方法+正则截取实现

--从字符串'1,2,3,4'中匹配不包含','的字符串，从第1位开始，截取第1个匹配项
SELECT regexp_substr('1,2,3,4','[^,]+',1,1,'i') FROM dual;
--从字符串'1,2,3,4'中匹配不包含','的字符串，从第1位开始，截取第2个匹配项
SELECT regexp_substr('1,2,3,4','[^,]+',1,2,'i') FROM dual;
--从字符串'1,2,3,4'中匹配不包含','的字符串，从第1位开始，截取第3个匹配项
SELECT regexp_substr('1,2,3,4','[^,]+',1,3,'i') FROM dual;
--从字符串'1,2,3,4'中匹配不包含','的字符串，从第1位开始，截取第4个匹配项
SELECT regexp_substr('1,2,3,4','[^,]+',1,4,'i') FROM dual;

--利用递归的Level连续获取子字符串，实现行转列，转列后再汇总
Select Sum(Regexp_Substr('1,2,3,4','[^,]+',1,Level))
From dual
Where Level >= 1
Connect By Level <= length('1,2,3,4')-length(replace('1,2,3,4',',',''))+1
;

2、列转行
  利用WMSYS.WM_CONCAT(追加)函数，实现一列转一行，这个函数是聚合函数，可以与开窗函数(OVER)组合成分析函数使用

函数格式：
  WMSYS.WM_CONCAT(TableName.ColumnName)
注意：
  列转行函数，分隔符默认只能为逗号，可以在转完之后用replace替换成其他的符号
  

--行转列：聚合函数
select     type
          ,WMSYS.WM_CONCAT(curr_no) as curr_no
          ,WMSYS.WM_CONCAT(curr_name) as curr_name
from (
  select '转换' as type,'96' as curr_no,'外币折美元' as curr_name from dual union all
  select '转换' as type,'97' as curr_no,'外币折本币' as curr_name from dual union all
  select '转换' as type,'99' as curr_no,'本外币汇总' as curr_name from dual union all
  select '原币' as type,'01' as curr_no,'人民币'     as curr_name from dual union all
  select '原币' as type,'13' as curr_no,'港币'       as curr_name from dual union all
  select '原币' as type,'14' as curr_no,'美元'       as curr_name from dual union all
  select '原币' as type,'27' as curr_no,'日元'       as curr_name from dual union all
  select '原币' as type,'33' as curr_no,'欧元'       as curr_name from dual
) a
group by type
;

--行转列：聚合函数+开窗函数=分析函数
select     type
          ,WMSYS.WM_CONCAT(curr_no) Over(Partition By type Order By curr_no Asc) as rank01
          ,WMSYS.WM_CONCAT(curr_name) Over(Partition By type Order By curr_no Asc) as rank02
          
from (
  select '转换' as type,'96' as curr_no,'外币折美元' as curr_name from dual union all
  select '转换' as type,'97' as curr_no,'外币折本币' as curr_name from dual union all
  select '转换' as type,'99' as curr_no,'本外币汇总' as curr_name from dual union all
  select '原币' as type,'01' as curr_no,'人民币'     as curr_name from dual union all
  select '原币' as type,'13' as curr_no,'港币'       as curr_name from dual union all
  select '原币' as type,'14' as curr_no,'美元'       as curr_name from dual union all
  select '原币' as type,'27' as curr_no,'日元'       as curr_name from dual union all
  select '原币' as type,'33' as curr_no,'欧元'       as curr_name from dual
) a
