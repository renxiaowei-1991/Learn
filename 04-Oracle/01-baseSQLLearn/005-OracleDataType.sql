--Oracle��������
--��������            ����
--Varchar2(size)      �ɱ䳤�ַ�����
--Char(size)          �����ַ�����
--Number(p,s)         �ɱ䳤��ֵ����
--Date                ����������
--Long                �ɱ䳤�ַ����ݣ����ɴﵽ2G
--Clob                �ַ����ݣ����ɴﵽ4G
--Raw and Long Raw    �����������
--Blob                ���������ݣ����ɴﵽ4G
--BFile               �洢�ⲿ�ļ��Ķ��������ݣ����ɴﵽ4G
--RowID               �е�ַ

--Date:������
--https://blog.csdn.net/weixin_30855099/article/details/98714520
1��������������������
1.1��Date
    ����Oracle��õ��������ͣ������Ա������ں�ʱ�䣬�������ڴ������Բ����������͡�
    Date��ʾ�����ڷ�Χ�����ǹ�Ԫǰ4712��1��1�յ���Ԫ9999��12��31�ա�
    Date���������ݿ��д洢�̶�Ϊ7���ֽڣ���ʽΪ��
    ��1�ֽڣ�����+100
    ��2�ֽڣ���
    ��3�ֽڣ���
    ��4�ֽڣ���
    ��5�ֽڣ�Сʱ+1
    ��6�ֽڣ���+1
    ��7�ֽڣ���+1

1.2��TimeStamp(p)
    ��Ҳ��Oracle���õ��������ͣ�����Date�������ǲ������Ա������ں�ʱ�䣬���ܱ���С���룬С��λ������ָ��Ϊ0-9��Ĭ��Ϊ6λ��������߾��ȿ��Ե�ns(����)��
    ���ݿ��ڲ���7����11���ֽڴ洢���������Ϊ0������7�ֽڴ洢����Date���͹�����ͬ��������ȴ���0����11�ֽڴ洢����ʽΪ��
    ��1�ֽڣ�����+100
    ��2�ֽڣ���
    ��3�ֽڣ���
    ��4�ֽڣ���
    ��5�ֽڣ�Сʱ+1
    ��6�ֽڣ���+1
    ��7�ֽڣ���+1
    ��8-11�ֽڣ����룬����4���ֽڴ洢���ڲ���������Ϊ����
    ע�⣺TimeStamp���������������ֵ���мӼ�������Զ�ת��ΪDate���ͣ�Ҳ����˵С������Զ�ȥ��
    

1.3����ȡDate��TimeStamp��ʽʱ��  
to_date('2022-05-16 11:35:00','YYYY-MM-DD HH24:MI:SS')
to_timestamp('2022-05-16 11:35:00.123456','YYYY-MM-DD HH24:MI:SS.FF6')

2����������
2.1����λ�ȡ��ǰʱ��
sysdate:���ص�ǰϵͳ���ں�ʱ�䣬��ȷ����
systimestamp:���ص�ǰϵͳ���ں�ʱ�䣬��ȷ������

2.2����ν�����������
���������ݿ�������ֵ�Ӽ��õ��µ����ڣ��Ӽ���ֵ��λΪ��
sysdate+1:ȡ����ĵ�ǰʱ��
sysdate-1/24:ȡ��ǰʱ���ǰһ��Сʱ
select sysdate+1,sysdate-1/24,systimestamp,systimestamp+1 from dual

2.3��������������ڵļ��ʱ��
select date'2022-05-16' from dual;
select date'2022-05-16'-sysdate from dual;

2.4������ת�ַ�
to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')

2.5���ַ�ת����
to_date('2022-05-16','YYYY-MM-DD')
to_date('2022-05-16 11:35:00','YYYY-MM-DD HH24:MI:SS')
to_timestamp('2022-05-16 11:35:00.123456','YYYY-MM-DD HH24:MI:SS.FF6')

3���������ں���
3.1��to_char(Date,FormatStr):��ʽ�����ڳ��ַ�
to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')
to_char(date '2022-05-16','DD') --���µڼ���

3.2��to_date(Char,FormatStr):���ַ�ת��������
to_date('2022-05-16 11:35:00','YYYY-MM-DD HH24:MI:SS')

3.3��Trunc(Date):����Date�����ڲ��֣�ʱ��Ϊ0��0��0��
select sysdate as a1,trunc(sysdate) as a2 from dual

3.4��Extract(Data From DateValue):����Date��ĳһ��������
���DATEVALUEΪDATE���ͣ���DATA������(YEAR��MONTH��DAY)
���DATEVALUEΪTIMESTAMP���ͣ���DATA������(YEAR��MONTH,DAY��HOUR��MINUTE��SECOND)
select sysdate,extract(year from sysdate) as a1,extract(year from systimestamp) as a2 from dual;

3.5��Add_months(Date,Months):��Date�����·ݵõ�������
select add_months(sysdate,3) from dual;

3.6��Last_day(Date):�������������·ݵ����һ������
select last_day(sysdate) as a1 from dual;

3.7��Next_Day(Date):�Ӹ������ڿ�ʼ������һ��Charָ�����ڵ�����(Ҳ������һ�����ڼ�)
select next_day(date'2022-05-16','MONDAY') as a1,next_day(date'2022-05-15','MONDAY') as a2 from dual;

