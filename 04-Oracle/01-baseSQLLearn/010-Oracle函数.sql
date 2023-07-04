--����
1��������������
���к��������к���������ת���������ݹ麯������������
 
2�����к���
Scalar�����Ĳ�������ĳ����һ��ֵ�������ػ�������ֵ��һ����һ��ֵ��
��Ҫ�ĵ��к������ַ����������ֺ��������ں�����ת��������ͨ�ú���
  
3.1�����к���-�ַ�����
��Сд���ƺ���
  Lower:תСд
  upper:ת��д
  InItcap:����ĸת��д

�ַ����ƺ���
  Concat:�ַ�������(�ȼ���||)
  Substr:�ַ�����ȡ
  Length:��ȡ�ַ�������(LengthB)
  Instr:��ȡ���ַ������ַ����еĿ�ʼλ��
    Instr(Str,SubStr,I,J)
      Str:���������ַ���
      SubStr:ϣ���������ַ���
      I:������ʼ��λ��
      J:���ֵڼ��ε�λ��
  Lpad:��ָ���ַ�����߲����ַ������ȵ�ָ��λ��
    Lpad(Str,Len,Char)
  Rpad:�Ҳ���
  Trim:ȥ�����ߵ�ָ���ַ������ַ�
  Ltrim:ȥ����ߵ�ָ���ַ������ַ�
  Rtrim:ȥ���ұߵ�ָ���ַ������ַ�
  Replace:�滻�ַ���
  
select Instr('abcdabcdab','a',2,2) as position from dual;
select Lpad('abcd',10,'*') from dual;
select Ltrim('aabcd','a') from dual;

3.2����������-���ֺ���
ABS:����ֵ
Round(c,num):��������
Floor(num):����ȡ��
Ceil(num):����ȡ��
Trunc:����ָ���ľ��Ƚ�ȡһ����
Mod(x,y):ȡ��

select Round(123.456,2) As num From dual;
select Floor(123.456) As num From dual;
select Ceil(123.456) As num From dual;
select Trunc(123.456,2) As num From dual;
select Mod(666666,100) As num From dual;

3.3�����к���-���ں���
Add_months:�Ӽ��·�
Last_day:���ر��µ����һ��
Next_day:ָ�����ڵ���һ������(������һ��������)
Months_between:������������֮�������
Sysdate:�����õ�ϵͳ�ĵ�ǰ����(date)
SysTimestamp:�����õ�ϵͳ�ĵ�ǰ����(timestamp)

select to_char(Add_months(to_date('2022-05-17','YYYY-MM-DD'),2),'YYYY-MM-DD') from dual;
select to_char(last_day(to_date('2022-05-17','YYYY-MM-DD')),'YYYY-MM-DD') from dual;
select to_char(next_day(to_date('2022-05-17','YYYY-MM-DD'),'FRIDAY'),'YYYY-MM-DD') from dual;
--select to_char(next_day(to_date('2022-05-17','YYYY-MM-DD'),'������'),'YYYY-MM-DD') from dual;
select months_between(to_date('2022-05-16','YYYY-MM-DD'),to_date('2022-05-17','YYYY-MM-DD')) from dual;
select sysdate,systimestamp from dual;

3.4�����к���-ת������(��������ת��)
���ԡ�����
  
����ת��
Character->(To_Date)->Date->(To_Char)->Character
Character->(To_Number)->Number->(To_Char)->Character
Character->(ASCII)->ASCII��->(Chr)Character
  
To_Date(Str,'format'):�ַ���ת����
To_Number(Str):�ַ���ת����
To_Char():��ֵת�ַ���&����ת�ַ���
ASCII():�ַ�תASCII��ֵ
Chr():ASCII��ֵת�ַ�

select To_Date('2022-05-17','YYYY-MM-DD') from dual;
select To_Number('2022') from dual;
select To_Char(2022),To_Char(Sysdate,'YYYY-MM-DD'),to_char(334.3456,'990.99'),to_char(33334.3456,'990.99') from dual;
select ASCII('A') from dual;
select CHR(65) from dual;

3.5�����к���-ͨ�ú���
��Щ�����������κ��������ͣ�ͬʱҲ�����ڿ�ֵ

NVL(expr1,expr2):�����һ�����ʽΪ�գ����صڶ������ʽ��ֵ�����򷵻ص�һ�����ʽ��ֵ
Coalesce(expr1,expr2,...,exprn):���ص�һ���ǿձ��ʽ��ֵ
NULLIF(expr1,expr2):�Ƚ��������ʽ��ֵ�������ȷ���null�����򷵻ص�һ�����ʽ��ֵ

select nvl(null,1) from dual;
select Coalesce(null,1,null,2) from dual;
select nullif(1,2),nullif(1,1) from dual;

3.6�����к���-Decode������Case���ʽ
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

Decode������Case���ʽ�ļ�д��
  ���壺�ֶ�col���߱��ʽexpr����search1�Ƚϣ������ȣ�����result1�������search2�Ƚϣ������ȣ�����result2��...�������searchn�Ƚϣ������ȣ�����resultn�����򷵻�default��
Decode(col | expr
      ,search1,result1
      [,search2,result2]
      ...
      [,searchn,resultn]
      [,default]
      )
      
select decode('aa','bb',1,'cc',2,'aa',3,4) from dual;
�ȼ���
select case 'aa' when 'bb' then 1 
                 when 'cc' then 2 
                 when 'aa' then 3 
                 else 4 
       end 
from dual;


4�����к���
���к����Ĳ�������һϵ�е�ֵ��������һ����һ��ֵ��

�﷨��
  Select [Column,]Group_Function(Column),...
  From TableName
  [Where Condition]
  [Group By Column]
  [Having Group_Condition]
  [Order By Column]
  ;

��Ҫ�Ķ��к�����
  Count:ͳ������
    Count[(*)|(Distinct|All ColumnName)]
  Sum:���
    Sum([Distinct] ColumnName)
  Max:���ֵ
    Max([Distinct] ColumnName)
  Min:��Сֵ
    Min([Distinct] ColumnName)
  Avg:ƽ��ֵ
    Avg([Distinct] ColumnName)

select count(*),count(col01),count(distinct col01),count(all col01) from learn01;
select sum(col02),sum(distinct col02) from learn01;
select Max(col02),Max(distinct col02) from learn01;
select Min(col02),Min(distinct col02) from learn01;
select Avg(col02),Avg(distinct col02) from learn01;

ע�⣺
  ���к������Կ���
  ���к����ķ���ֵ����������������where�У�Ӧ����having��
  
ʾ����
  select col01,sum(col02) as col02,sum(distinct col02) as col03
  from learn01
  where col01 is not null
  group by col01
  having sum(col02) > 1
  order by col01
  ;
  
ʾ��:ɾ�������ظ�����
  Delete From Learn01 Where RowId Not In (
    Select Min(RowID) From Learn01
    Group by id
  );
  
5������ת������
��ת�С���ת��


6�����к���-�ݹ�(Connect By)
Start With ... Connect By Prior ...
Level:�ݹ�㼶

���ڲ�ѯ���νṹ�ı�����
������������ֵ


7�����к���-��������
... Over(Partition By ... Order By ...)
�����ݽ��з������
�ȷ��飬Ȼ������ݰ�����в���