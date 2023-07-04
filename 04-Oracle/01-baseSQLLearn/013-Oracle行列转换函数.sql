--Oracle����ת������
��ת��
��ת��


--һ���̶�����ת��

--��������׼��
Create Table a_table(
     c_year  Varchar2(10) not null
    ,c_month Varchar2(10) not null
    ,c_qty   Int not null
) TableSpace OracleLearn
;
Comment On Table a_table Is '���Ա�a';
Comment On Column a_table.c_year Is '���';
Comment On Column a_table.c_month Is '�·�';
Comment On Column a_table.c_qty Is '����';

Insert Into a_table
Select '2016��' as c_year,'1��' as c_month,100 as c_qty From dual Union All
Select '2016��' as c_year,'2��' as c_month,101 as c_qty From dual Union All
Select '2016��' as c_year,'3��' as c_month,102 as c_qty From dual Union All
Select '2016��' as c_year,'4��' as c_month,103 as c_qty From dual Union All
Select '2017��' as c_year,'1��' as c_month,201 as c_qty From dual Union All
Select '2017��' as c_year,'2��' as c_month,202 as c_qty From dual Union All
Select '2017��' as c_year,'3��' as c_month,203 as c_qty From dual Union All
Select '2017��' as c_year,'4��' as c_month,204 as c_qty From dual Union All
Select '2018��' as c_year,'1��' as c_month,302 as c_qty From dual Union All
Select '2018��' as c_year,'2��' as c_month,303 as c_qty From dual Union All
Select '2018��' as c_year,'3��' as c_month,304 as c_qty From dual Union All
Select '2018��' as c_year,'4��' as c_month,305 as c_qty From dual Union All
Select '2019��' as c_year,'1��' as c_month,403 as c_qty From dual Union All
Select '2019��' as c_year,'2��' as c_month,404 as c_qty From dual Union All
Select '2019��' as c_year,'3��' as c_month,405 as c_qty From dual Union All
Select '2019��' as c_year,'4��' as c_month,406 as c_qty From dual
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
Comment On Table b_table Is '���Ա�b';
Comment On Column b_table.t_year Is '���';
Comment On Column b_table.one_month Is 'һ��';
Comment On Column b_table.two_month Is '����';
Comment On Column b_table.three_month Is '����';
Comment On Column b_table.four_month Is '����';

Insert Into b_table
Select '2016��' as t_year,100 as one_month,101 as two_month,102 as three_month,103 as four_month From dual Union All
Select '2017��' as t_year,201 as one_month,202 as two_month,203 as three_month,204 as four_month From dual Union All
Select '2018��' as t_year,302 as one_month,303 as two_month,304 as three_month,305 as four_month From dual Union All
Select '2019��' as t_year,403 as one_month,404 as two_month,405 as three_month,406 as four_month From dual
;
Commit;


select * from a_table;
select * from b_table;

--1.1 ��ת�У���a_table�����ת��
--1.1.1 Decodeʵ��
select     c_year
          ,Sum(Decode(c_month,'1��',c_qty,0)) as one_month
          ,Sum(Decode(c_month,'2��',c_qty,0)) as two_month
          ,Sum(Decode(c_month,'3��',c_qty,0)) as three_month
          ,Sum(Decode(c_month,'4��',c_qty,0)) as four_month
from a_table
group by c_year
order by c_year
;

--1.1.2 Caseʵ��
select     c_year
          ,Sum(Case when c_month='1��' then c_qty else 0 end) as one_month
          ,Sum(Case when c_month='2��' then c_qty else 0 end) as two_month
          ,Sum(Case when c_month='3��' then c_qty else 0 end) as three_month
          ,Sum(Case when c_month='4��' then c_qty else 0 end) as four_month
from a_table
group by c_year
order by c_year
;

--pivot����ʵ��
--  pivot�����﷨
--    pivot(��һ�ۺϺ��� for ת��ֵ���ڵ����� in (תΪ������ֵ))������in ('')�п���ָ��������in�л�����ָ���Ӳ�ѯ
--ע�⣺
--  ���ｫa_table����Ϊpivot�������һ�������ֻ������Ҫ�õ����У�������Ϊ���ֶζ���Ҫ�����Կ���ֱ����a_table����Ϊ�����
select * from a_table
pivot(Sum(c_qty) For c_month In ('1��','2��','3��','4��'))
order by c_year
;

select * 
from (select c_year,c_month,c_qty from a_table) a
pivot(Sum(c_qty) For c_month In ('1��' as one_month,'2��' as two_month,'3��' as three_month,'4��' as four_month))
;



--1.2 ��ת�У���b_table�����תΪ��
--1.2.1 Decodeʵ�֡���ԭ�����ѿ�������һ�и��Ƴ�4�У�Ȼ��ͨ��Decodeʵ�֡�
select     a1.t_year
          ,Decode(a2.lv,1,'1��',2,'2��',3,'3��',4,'4��') as t_month
          ,Decode(a2.lv,1,a1.one_month,2,a1.two_month,3,a1.three_month,4,a1.four_month) as t_qty
from  b_table a1
     ,(select Level lv From dual where level >=1 Connect By Level<=4) a2
order by   t_year,t_month
;

--1.2.2 Caseʵ�֡���Decodeͬ��
select     a1.t_year
          ,case a2.lv when 1 then '1��' when 2 then '2��' when 3 then '3��' when 4 then '4��' end as t_month
          ,case a2.lv when 1 then a1.one_month when 2 then a1.two_month when 3 then a1.three_month when 4 then a1.four_month end as t_qty
from  b_table a1
     ,(select Level lv From dual where level >=1 Connect By Level<=4) a2
order by   t_year,t_month
;

--1.2.3 unpivot����ʵ��
--  unpivot�����﷨
--    unpivot(����ֵ�����е����� For ����תΪ��ֵ���������� In (תΪ�е�����(��Ҫʹ��as������ת��Ϊ��Ҫ��ת�����ֶ��д洢���ַ���)))
select * from b_table
unpivot(t_qyt for t_month in (one_month as '1��',two_month as '2��',three_month as '3��',four_month as '4��'))
;

select * from b_table
unpivot(t_qyt for t_month in (one_month,two_month,three_month,four_month))
;


--�������̶�����ת��
--1����ת��
  ���õݹ�Level����+�����ȡʵ��

--���ַ���'1,2,3,4'��ƥ�䲻����','���ַ������ӵ�1λ��ʼ����ȡ��1��ƥ����
SELECT regexp_substr('1,2,3,4','[^,]+',1,1,'i') FROM dual;
--���ַ���'1,2,3,4'��ƥ�䲻����','���ַ������ӵ�1λ��ʼ����ȡ��2��ƥ����
SELECT regexp_substr('1,2,3,4','[^,]+',1,2,'i') FROM dual;
--���ַ���'1,2,3,4'��ƥ�䲻����','���ַ������ӵ�1λ��ʼ����ȡ��3��ƥ����
SELECT regexp_substr('1,2,3,4','[^,]+',1,3,'i') FROM dual;
--���ַ���'1,2,3,4'��ƥ�䲻����','���ַ������ӵ�1λ��ʼ����ȡ��4��ƥ����
SELECT regexp_substr('1,2,3,4','[^,]+',1,4,'i') FROM dual;

--���õݹ��Level������ȡ���ַ�����ʵ����ת�У�ת�к��ٻ���
Select Sum(Regexp_Substr('1,2,3,4','[^,]+',1,Level))
From dual
Where Level >= 1
Connect By Level <= length('1,2,3,4')-length(replace('1,2,3,4',',',''))+1
;

2����ת��
  ����WMSYS.WM_CONCAT(׷��)������ʵ��һ��תһ�У���������ǾۺϺ����������뿪������(OVER)��ϳɷ�������ʹ��

������ʽ��
  WMSYS.WM_CONCAT(TableName.ColumnName)
ע�⣺
  ��ת�к������ָ���Ĭ��ֻ��Ϊ���ţ�������ת��֮����replace�滻�������ķ���
  

--��ת�У��ۺϺ���
select     type
          ,WMSYS.WM_CONCAT(curr_no) as curr_no
          ,WMSYS.WM_CONCAT(curr_name) as curr_name
from (
  select 'ת��' as type,'96' as curr_no,'�������Ԫ' as curr_name from dual union all
  select 'ת��' as type,'97' as curr_no,'����۱���' as curr_name from dual union all
  select 'ת��' as type,'99' as curr_no,'����һ���' as curr_name from dual union all
  select 'ԭ��' as type,'01' as curr_no,'�����'     as curr_name from dual union all
  select 'ԭ��' as type,'13' as curr_no,'�۱�'       as curr_name from dual union all
  select 'ԭ��' as type,'14' as curr_no,'��Ԫ'       as curr_name from dual union all
  select 'ԭ��' as type,'27' as curr_no,'��Ԫ'       as curr_name from dual union all
  select 'ԭ��' as type,'33' as curr_no,'ŷԪ'       as curr_name from dual
) a
group by type
;

--��ת�У��ۺϺ���+��������=��������
select     type
          ,WMSYS.WM_CONCAT(curr_no) Over(Partition By type Order By curr_no Asc) as rank01
          ,WMSYS.WM_CONCAT(curr_name) Over(Partition By type Order By curr_no Asc) as rank02
          
from (
  select 'ת��' as type,'96' as curr_no,'�������Ԫ' as curr_name from dual union all
  select 'ת��' as type,'97' as curr_no,'����۱���' as curr_name from dual union all
  select 'ת��' as type,'99' as curr_no,'����һ���' as curr_name from dual union all
  select 'ԭ��' as type,'01' as curr_no,'�����'     as curr_name from dual union all
  select 'ԭ��' as type,'13' as curr_no,'�۱�'       as curr_name from dual union all
  select 'ԭ��' as type,'14' as curr_no,'��Ԫ'       as curr_name from dual union all
  select 'ԭ��' as type,'27' as curr_no,'��Ԫ'       as curr_name from dual union all
  select 'ԭ��' as type,'33' as curr_no,'ŷԪ'       as curr_name from dual
) a
