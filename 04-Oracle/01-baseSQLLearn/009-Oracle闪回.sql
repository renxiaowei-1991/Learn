--����
--https://blog.csdn.net/wmjCode/article/details/122111876
    Oracleʹ��FlashBack(����)�ָ���ɾ�������ݻ���ɾ���ı�
    
1��ִ��Drop Table TableName���
    Drop��ı����ڻ���վ(User_recyclebin)�������ֱ��ɾ����������������վ��ı���Ϣ�Ϳ��Ա��ָ����򳹵������
    ͨ����ѯ����վ(user_recyclebin)��ȡ��ɾ���ı���Ϣ��

2���ָ���
    FlashBack Table <user_recyclebin.object_name or user_recyclebin.original_name> to before drop [rename to <new_table_name>];
    ������վ��ı�ָ�Ϊԭ���ƻ�ָ�������ƣ��������ݲ��ᶪʧ��
    
3������ɾ����
    Drop Table <table_name> pruge;
    
4����ջ���վ
    ���ָ����
        Purge Table <table_name>;
    �����ǰ�û��Ļ���վ
        Purge recyclebin;
    ��������û��Ļ���վ
        Purge dba_recyclebin;
    ���������վ��ֱ��ɾ����
        Drop Table TableName Purge;
        
--���ؾ������
1�����ز�ѯ
--û�б�ɾ���ı���Ҫ�����ݻָ���ĳһ��ʱ���֮ǰ��״̬������ͨ�����������ѯ���ҵ���Ҫ�ָ���״̬��ʱ���(��γ���)��
select * from Learn01 as of timestamp to_timestamp('2022-05-16 13:30:00','YYYY-MM-DD HH24:MI:SS');
--��ɾ���ı�ֱ�Ӳ����վ
select * from dba_recyclebin;

2��������Ǩ��
Alter Table Learn01 enable row movement;

3���ָ�
--�ָ����ݵ�ĳһ��ʱ���֮ǰ��״̬
FlashBack Table Learn01 to TimeStamp to_timestamp('2022-05-16 13:30:00','YYYY-MM-DD HH24:MI:SS')
--��ɾ���ı�ֱ�ӻָ�����ɾ��֮ǰ
FlashBack Table Learn01 to Before Drop;  --�ָ�����Drop֮ǰ

4���ر���Ǩ��
Alter Table Learn01 disable row movement;