--��Ʊ���ױ�
--Drop Table Stock;
Create Table Stock(
     id                    Int          Not Null
    ,stock_no              Varchar(6)   Not Null
    ,stock_nm              Varchar(30)  Not Null
    ,trans_time            Varchar(20)  Not Null
    ,trans_val             Number(22,2) Not Null
    ,trans_num             Int          Not Null
    ,change_range          Number(22,2)
    ,change_dir            Varchar(2)   Not Null
    ,trans_type            Varchar(2)   Not Null
    ,real_stock_num        Int          Not Null
    ,real_stock_amt        Number(22,2) Not Null
    ,real_stock_amt_sum    Int          Not Null
    ,real_account_amt      Number(22,2) Not Null
    ,virtual_stock_num     Int          Not Null
    ,virtual_stock_amt     Number(22,2) Not Null
    ,virtual_stock_amt_sum Int          Not Null
    ,virtual_account_amt   Number(22,2) Not Null
    ,dt                    Varchar(10)  Not Null
    ,Primary Key (id)
) TableSpace OracleLearn;
Comment On Table Stock                        Is '��Ʊ���ױ�';
Comment On Column Stock.id                    Is '����';
Comment On Column Stock.stock_no              Is '��Ʊ���';
Comment On Column Stock.stock_nm              Is '��Ʊ����';
Comment On Column Stock.trans_time            Is '����ʱ��';
Comment On Column Stock.trans_val             Is '���׼۸�';
Comment On Column Stock.trans_num             Is '������';
Comment On Column Stock.change_range          Is '�ǵ���';
Comment On Column Stock.change_dir            Is '�ǵ����� 1��;2��;3ƽ';
Comment On Column Stock.trans_type            Is '�������� 1ʵ��;2����;3��ʼ��';
Comment On Column Stock.real_stock_num        Is 'ʵ�ʹ�Ʊ����';
Comment On Column Stock.real_stock_amt        Is 'ʵ�ʹ�Ʊ���';
Comment On Column Stock.real_stock_amt_sum    Is 'ʵ�ʹ�Ʊ�ܽ��';
Comment On Column Stock.real_account_amt      Is 'ʵ�˻����';
Comment On Column Stock.virtual_stock_num     Is '�����Ʊ����';
Comment On Column Stock.virtual_stock_amt     Is '�����Ʊ���';
Comment On Column Stock.virtual_stock_amt_sum Is '�����Ʊ�ܽ��';
Comment On Column Stock.virtual_account_amt   Is '�����˻����';
Comment On Column Stock.dt                    Is '��������';

--Drop Sequence Seq_Stock;
Create Sequence Seq_Stock
Increment By 1
Start With 100001
MaxValue 999999
NoCyCle
Nocache
;

--��ʼ������
--20220519��������
--�������
--Insert Into Stock
Select     Seq_Stock.nextval As id         --����
          ,'002065' As stock_no            --��Ʊ���
          ,'�������' As stock_nm          --��Ʊ����
          ,To_Char(To_Date('2022-05-19 15:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --����ʱ��
          ,5.80 As trans_val               --���׼۸�
          ,100 As trans_num                --������
          ,0.00 As change_range            --�ǵ���
          ,'3' As change_dir               --�ǵ����� 1��;2��;3ƽ
          ,'3' As trans_type               --�������� 1ʵ��;2����;3��ʼ��
          ,100 As real_stock_num           --ʵ�ʹ�Ʊ����
          ,580 As real_stock_amt           --ʵ�ʹ�Ʊ���
          ,86335 As real_stock_amt_sum     --ʵ�ʹ�Ʊ�ܽ��
          ,1129.95 As real_account_amt     --ʵ�˻����
          ,100 As virtual_stock_num        --�����Ʊ����
          ,580 As virtual_stock_amt        --�����Ʊ���
          ,86335 As virtual_stock_amt_sum  --�����Ʊ�ܽ��
          ,1129.95 As virtual_account_amt  --�����˻����
          ,'2022-05-19' As dt              --��������
From dual
;

--��������
--Insert Into Stock
Select     Seq_Stock.nextval As id         --����
          ,'601816' As stock_no            --��Ʊ���
          ,'��������' As stock_nm          --��Ʊ����
          ,To_Char(To_Date('2022-05-19 15:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --����ʱ��
          ,4.50 As trans_val               --���׼۸�
          ,100 As trans_num                --������
          ,0.00 As change_range            --�ǵ���
          ,'3' As change_dir               --�ǵ����� 1��;2��;3ƽ
          ,'3' As trans_type               --�������� 1ʵ��;2����;3��ʼ��
          ,100 As real_stock_num           --ʵ�ʹ�Ʊ����
          ,450 As real_stock_amt           --ʵ�ʹ�Ʊ���
          ,86335 As real_stock_amt_sum     --ʵ�ʹ�Ʊ�ܽ��
          ,1129.95 As real_account_amt     --ʵ�˻����
          ,100 As virtual_stock_num        --�����Ʊ����
          ,450 As virtual_stock_amt        --�����Ʊ���
          ,86335 As virtual_stock_amt_sum  --�����Ʊ�ܽ��
          ,1129.95 As virtual_account_amt  --�����˻����
          ,'2022-05-19' As dt              --��������
From dual
;

--��������
--Insert Into Stock
Select     Seq_Stock.nextval As id         --����
          ,'600588' As stock_no            --��Ʊ���
          ,'��������' As stock_nm          --��Ʊ����
          ,To_Char(To_Date('2022-05-19 15:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --����ʱ��
          ,18.15 As trans_val              --���׼۸�
          ,4700 As trans_num               --������
          ,0.00 As change_range            --�ǵ���
          ,'3' As change_dir               --�ǵ����� 1��;2��;3ƽ
          ,'3' As trans_type               --�������� 1ʵ��;2����;3��ʼ��
          ,4700 As real_stock_num          --ʵ�ʹ�Ʊ����
          ,85305 As real_stock_amt         --ʵ�ʹ�Ʊ���
          ,86335 As real_stock_amt_sum     --ʵ�ʹ�Ʊ�ܽ��
          ,1129.95 As real_account_amt     --ʵ�˻����
          ,4700 As virtual_stock_num       --�����Ʊ����
          ,85305 As virtual_stock_amt      --�����Ʊ���
          ,86335 As virtual_stock_amt_sum  --�����Ʊ�ܽ��
          ,1129.95 As virtual_account_amt  --�����˻����
          ,'2022-05-19' As dt              --��������
From dual
;
Commit;

--��������
--Date:2022-05-20 11:16:00
--Insert Into Stock
Select     Seq_Stock.nextval As id         --����
          ,'600588' As stock_no            --��Ʊ���
          ,'��������' As stock_nm          --��Ʊ����
          ,To_Char(To_Date('2022-05-20 10:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --����ʱ��
          ,19.00 As trans_val              --���׼۸�
          ,4600 As trans_num               --������
          ,4.85 As change_range            --�ǵ���
          ,'1' As change_dir               --�ǵ����� 1��;2��;3ƽ
          ,'2' As trans_type               --�������� 1ʵ��;2����;3��ʼ��
          ,4700 As real_stock_num          --ʵ�ʹ�Ʊ����
          ,89300.00 As real_stock_amt      --ʵ�ʹ�Ʊ���
          ,90341.00 As real_stock_amt_sum  --ʵ�ʹ�Ʊ�ܽ��
          ,1129.95 As real_account_amt     --ʵ�˻����
          ,100 As virtual_stock_num        --�����Ʊ����
          ,1900 As virtual_stock_amt       --�����Ʊ���
          ,2941 As virtual_stock_amt_sum   --�����Ʊ�ܽ��
          ,88529.95 As virtual_account_amt --�����˻����
          ,'2022-05-20' As dt              --��������
From dual
;
Commit;


--Date:2022-05-20 11:16:00
--Insert Into Stock
Select     Seq_Stock.nextval As id         --����
          ,'600588' As stock_no            --��Ʊ���
          ,'��������' As stock_nm          --��Ʊ����
          ,To_Char(To_Date('2022-05-20 10:35:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --����ʱ��
          ,18.36 As trans_val              --���׼۸�
          ,4800 As trans_num               --������
          ,1.16 As change_range            --�ǵ���
          ,'1' As change_dir               --�ǵ����� 1��;2��;3ƽ
          ,'2' As trans_type               --�������� 1ʵ��;2����;3��ʼ��
          ,4700 As real_stock_num          --ʵ�ʹ�Ʊ����
          ,86292 As real_stock_amt      --ʵ�ʹ�Ʊ���
          ,87322 As real_stock_amt_sum  --ʵ�ʹ�Ʊ�ܽ��
          ,1129.95 As real_account_amt     --ʵ�˻����
          ,4900 As virtual_stock_num       --�����Ʊ����
          ,89964 As virtual_stock_amt       --�����Ʊ���
          ,89964 As virtual_stock_amt_sum   --�����Ʊ�ܽ��
          ,1361.95 As virtual_account_amt --�����˻����
          ,'2022-05-20' As dt              --��������
From dual
;
Commit;


Select 4700*18.36+450+580 From dual;

select 88529.95-4800*18.16 from dual

--���ݲ�ѯ
Select * From Stock;


Select     REGEXP_SUBSTR(comm,'[^,]+',1,1 ) As id
          ,REGEXP_SUBSTR(comm,'[^,]+',1,2 ) As stock_no
          ,REGEXP_SUBSTR(comm,'[^,]+',1,3 ) As stock_nm
          ,REGEXP_SUBSTR(comm,'[^,]+',1,4 ) As trans_time
          ,REGEXP_SUBSTR(comm,'[^,]+',1,5 ) As trans_val
          ,REGEXP_SUBSTR(comm,'[^,]+',1,6 ) As trans_num
          ,REGEXP_SUBSTR(comm,'[^,]+',1,7 ) As change_range
          ,REGEXP_SUBSTR(comm,'[^,]+',1,8 ) As change_dir
          ,REGEXP_SUBSTR(comm,'[^,]+',1,9 ) As trans_type
          ,REGEXP_SUBSTR(comm,'[^,]+',1,10) As real_stock_num
          ,REGEXP_SUBSTR(comm,'[^,]+',1,11) As real_stock_amt
          ,REGEXP_SUBSTR(comm,'[^,]+',1,12) As real_stock_amt_sum
          ,REGEXP_SUBSTR(comm,'[^,]+',1,13) As real_account_amt
          ,REGEXP_SUBSTR(comm,'[^,]+',1,14) As virtual_stock_num
          ,REGEXP_SUBSTR(comm,'[^,]+',1,15) As virtual_stock_amt
          ,REGEXP_SUBSTR(comm,'[^,]+',1,16) As virtual_stock_amt_sum
          ,REGEXP_SUBSTR(comm,'[^,]+',1,17) As virtual_account_amt
          ,REGEXP_SUBSTR(comm,'[^,]+',1,18) As dt                   
From (
    Select WMSYS.WM_CONCAT(Comments) As comm
    From (
        Select a2.Column_Id,a1.Column_Name,a1.Comments
        From dba_col_comments a1
        Left Join  dba_tab_columns a2
               On  a2.Table_Name='STOCK'
              And  a1.Column_Name = a2.Column_Name
            Where  a1.Table_Name='STOCK'
        Order By   a2.Column_Id
    ) b
) a
Union All
Select * From (
    Select     To_Char(id)                    As id
              ,stock_no                       As stock_no
              ,stock_nm                       As stock_nm
              ,trans_time                     As trans_time
              ,To_Char(trans_val)             As trans_val
              ,To_Char(trans_num)             As trans_num
              ,To_Char(change_range)          As change_range
              ,change_dir                     As change_dir
              ,trans_type                     As trans_type
              ,To_Char(real_stock_num)        As real_stock_num
              ,To_Char(real_stock_amt)        As real_stock_amt
              ,To_Char(real_stock_amt_sum)    As real_stock_amt_sum
              ,To_Char(real_account_amt)      As real_account_amt
              ,To_Char(virtual_stock_num)     As virtual_stock_num
              ,To_Char(virtual_stock_amt)     As virtual_stock_amt
              ,To_Char(virtual_stock_amt_sum) As virtual_stock_amt_sum
              ,To_Char(virtual_account_amt)   As virtual_account_amt
              ,dt                             As dt                   
    From Stock
    Where stock_nm='��������'
    Order By   stock_no
              ,dt
              ,trans_time
) c
;