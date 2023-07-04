--��������
--�ۺϺ���+��������=��������

Sum():�ۺϺ���
WMSYS.WM_CONCAT():�ۺϺ���(��ת��)
Row_Number():�ۺϺ���
...
Over():��������


1����������
  �ۺϺ���+��������=��������
  ���������ǾۺϺ����Ϳ������������

  ���ڼ���������ĳ�־ۺ�ֵ�����;ۺϺ����Ĳ�֮ͬ���Ƕ���ÿ���鷵�ض��У����ۺϺ�������ÿ����ֻ����һ��

2����������
  ��������ָ���˷����������������ݴ��ڵĴ�С��������ݴ��ڴ�С���ܻ������еı仯���仯��
  ���������������������Ӿ�
    ����(partition by)
    ����(order by )
    ����(rows)
  �﷨��
    over(partition by xxx order by yyy rows between zzz)

  ���ڴ�С��ش�
    preceding:ǰ���
    following:֮���
    unbounded:�ޱ߽�
    

--��������
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
    
2.1 ���������÷�
  range:��ʾ���ݷ�Χ����ȡֵ��Χ����
  rows:��ʾ���ݷ�Χ�����з�Χ����

1) over()
  Ĭ�ϵĿ������������������������൱��ֱ�Ӷ�ȫ������ǰ��ľۺϺ���������Ȼ��ѾۺϽ���ŵ�ÿһ�С�
  e.g: 
    select a.*,sum(grade) over() as rank from c_over_table a;
2) over(order by null)
  �ȼ���over()
3) over(order by salary)
  Ĭ�ϵ����򴰿ں��������ݴ����ǰ�salary�����Ժ󣬵��ڵ���salary�����ݲ���
  �ȼ��ڣ�
    over(order by salary range unbounded preceding)  --ǰ�ޱ߽磬��Ϊ����
    over(order by salary rows unbounded preceding)
  e.g:
    select a.*,sum(grade) over(order by grade) as rank from c_over_table a;
    select a.*,sum(grade) over(order by grade range unbounded preceding) as rank from c_over_table a;
    select a.*,sum(grade) over(order by grade rows unbounded preceding) as rank from c_over_table a;
4) over(order by salary range between 5 preceding and 5 following) 
  range:��ʾ���ݷ�Χ����ȡֵ��Χ����
  ���ݴ�����  salary - 5 <= salary <= salary + 5
  e.g:
    select a.*,sum(grade) over(order by grade range between 5 preceding and 5 following) as rank from c_over_table a;
    
    select a.*,sum(lv) over(order by lv range between 5 preceding and 5 following) as aa 
    from (select level lv from dual where level >= 1 connect by level <=10) a
5) over(order by salary rows between 2 preceding and 4 following)
  rows:��ʾ���ݷ�Χ�����з�Χ����
  ���ݴ����ǣ������Ժ󣬱���֮ǰ���е�����֮������
  (���С�����֮ǰһ�С�����֮��4��)
  e.g:
    select a.*,sum(grade) over(order by grade rows between 1 preceding and 2 following) as rank from c_over_table a;
6) over(order by salary range between unbounded preceding and unbounded following)
  ��ȡֵ��Χ��ǰ�ޱ߽磬���ޱ߽�
  e.g:
    select a.*,sum(grade) over(order by grade range between unbounded preceding and unbounded following) as rank from c_over_table a;
7) over(order by salary rows between unbounded preceding and unbounded following)
  ���з�Χ��ǰ�ޱ߽磬���ޱ߽�
  e.g:
    select a.*,sum(grade) over(order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    
3�����÷���������
ע�⣺
  1���������������п��������У�ֻҪ��order by ...,����ѭ�����ġ�Ĭ�Ͽ��������������(over(order by salary))
  2�����򿪴�����row_number()��rank()��dense_rank()������Ҫ���rows()��range()ʹ��
  
���ࣺ
  ���򿪴�����
  �ۺϿ�������

row_number() over(partition by ... order by ...)
  ���������򣬻�ȡ�У������в�������(���磺û��������1��)
  e.g:
    --select a.*,row_number() over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,row_number() over(partition by class order by grade) as rank from c_over_table a;
rank() over(partition by ... order by ...)
  ���������򣬻�ȡ�������������򣬵�����Ծ����(���磬��������һ��������û�еڶ���)
  e.g:
    --select a.*,rank() over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,rank() over(partition by class order by grade) as rank from c_over_table a;
dense_rank() over(partition by ... order by ...)
  ���������򣬻�ȡ�������������򣬷���Ծ����(���磬��������һ�������ǻ����еڶ���)
  e.g:
    --select a.*,dense_rank() over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,dense_rank() over(partition by class order by grade) as rank from c_over_table a;
count() over(partition by ... order by ...)
  ���������򣬻�ȡ����ͳ�Ƹ���
  e.g:
    select a.*,count(*) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,count(*) over(partition by class order by grade) as rank from c_over_table a;
max() over(partition by ... order by ...)
  ���������򣬻�ȡ�������ֵ
  e.g:
    select a.*,max(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,max(grade) over(partition by class order by grade) as rank from c_over_table a;
min() over(partition by ... order by ...)
  ���������򣬻�ȡ������Сֵ
  e.g:
    select a.*,min(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,min(grade) over(partition by class order by grade) as rank from c_over_table a;
sum() over(partition by ... order by ...)
  ���������򣬻�ȡ���������
  e.g:
    select a.*,sum(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,sum(grade) over(partition by class order by grade) as rank from c_over_table a;
avg() over(partition by ... order by ...)
  ���������򣬻�ȡ����ƽ����
  e.g:
    select a.*,avg(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,avg(grade) over(partition by class order by grade) as rank from c_over_table a;
first_value() over(partition by ... order by ...) 
  ���������򣬻�ȡָ���еĵ�һ��
  e.g:
    select a.*,first_value(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,first_value(grade) over(partition by class order by grade) as rank from c_over_table a;
last_value() over(partition by ... order by ...)
  ���������򣬻�ȡָ���е����һ��
  e.g:
    select a.*,last_value(grade) over(partition by class order by grade rows between unbounded preceding and unbounded following) as rank from c_over_table a;
    select a.*,last_value(grade) over(partition by class order by grade) as rank from c_over_table a;
lag() over(partition by ... order by ...)
  lag()ƫ�Ʒ������������������򣬻�ȡ�����ĵ�ǰֵ����num��ֵ
  �﷨��
    lag(field,num,defaultvalue)
    ���ͣ�
      field:��ȡǰ��ֵ���ֶ�
      num:��ȡǰ���num��ֵ
      defaultvalue:�����num��ֵû�����ݣ���ȡ���Ĭ��ֵ
  e.g:
    select a.*,lag(name,1,'Null') over(partition by class order by grade) as rank from c_over_table a;
lead() over(partition by ... order by ...)
  lead()ƫ�Ʒ������������������򣬻�ȡ�����ĵ�ǰֵ����num��ֵ
  �﷨��
    lead(field,num,defaultvalue)
    ���ͣ�
      field:��ȡǰ��ֵ���ֶ�
      num:��ȡ�����num��ֵ
      defaultvalue:�����num��ֵû�����ݣ���ȡ���Ĭ��ֵ
  e.g:
    select a.*,lead(name,1,'Null') over(partition by class order by grade) as rank from c_over_table a;