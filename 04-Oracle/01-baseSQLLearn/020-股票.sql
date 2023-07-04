--股票交易表
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
Comment On Table Stock                        Is '股票交易表';
Comment On Column Stock.id                    Is '主键';
Comment On Column Stock.stock_no              Is '股票编号';
Comment On Column Stock.stock_nm              Is '股票名称';
Comment On Column Stock.trans_time            Is '交易时间';
Comment On Column Stock.trans_val             Is '交易价格';
Comment On Column Stock.trans_num             Is '交易量';
Comment On Column Stock.change_range          Is '涨跌幅';
Comment On Column Stock.change_dir            Is '涨跌类型 1涨;2跌;3平';
Comment On Column Stock.trans_type            Is '交易类型 1实际;2虚拟;3初始化';
Comment On Column Stock.real_stock_num        Is '实际股票数量';
Comment On Column Stock.real_stock_amt        Is '实际股票金额';
Comment On Column Stock.real_stock_amt_sum    Is '实际股票总金额';
Comment On Column Stock.real_account_amt      Is '实账户金额';
Comment On Column Stock.virtual_stock_num     Is '虚拟股票数量';
Comment On Column Stock.virtual_stock_amt     Is '虚拟股票金额';
Comment On Column Stock.virtual_stock_amt_sum Is '虚拟股票总金额';
Comment On Column Stock.virtual_account_amt   Is '虚拟账户金额';
Comment On Column Stock.dt                    Is '数据日期';

--Drop Sequence Seq_Stock;
Create Sequence Seq_Stock
Increment By 1
Start With 100001
MaxValue 999999
NoCyCle
Nocache
;

--初始化数据
--20220519收盘数据
--东华软件
--Insert Into Stock
Select     Seq_Stock.nextval As id         --主键
          ,'002065' As stock_no            --股票编号
          ,'东华软件' As stock_nm          --股票名称
          ,To_Char(To_Date('2022-05-19 15:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --交易时间
          ,5.80 As trans_val               --交易价格
          ,100 As trans_num                --交易量
          ,0.00 As change_range            --涨跌幅
          ,'3' As change_dir               --涨跌类型 1涨;2跌;3平
          ,'3' As trans_type               --交易类型 1实际;2虚拟;3初始化
          ,100 As real_stock_num           --实际股票数量
          ,580 As real_stock_amt           --实际股票金额
          ,86335 As real_stock_amt_sum     --实际股票总金额
          ,1129.95 As real_account_amt     --实账户金额
          ,100 As virtual_stock_num        --虚拟股票数量
          ,580 As virtual_stock_amt        --虚拟股票金额
          ,86335 As virtual_stock_amt_sum  --虚拟股票总金额
          ,1129.95 As virtual_account_amt  --虚拟账户金额
          ,'2022-05-19' As dt              --数据日期
From dual
;

--京沪高铁
--Insert Into Stock
Select     Seq_Stock.nextval As id         --主键
          ,'601816' As stock_no            --股票编号
          ,'京沪高铁' As stock_nm          --股票名称
          ,To_Char(To_Date('2022-05-19 15:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --交易时间
          ,4.50 As trans_val               --交易价格
          ,100 As trans_num                --交易量
          ,0.00 As change_range            --涨跌幅
          ,'3' As change_dir               --涨跌类型 1涨;2跌;3平
          ,'3' As trans_type               --交易类型 1实际;2虚拟;3初始化
          ,100 As real_stock_num           --实际股票数量
          ,450 As real_stock_amt           --实际股票金额
          ,86335 As real_stock_amt_sum     --实际股票总金额
          ,1129.95 As real_account_amt     --实账户金额
          ,100 As virtual_stock_num        --虚拟股票数量
          ,450 As virtual_stock_amt        --虚拟股票金额
          ,86335 As virtual_stock_amt_sum  --虚拟股票总金额
          ,1129.95 As virtual_account_amt  --虚拟账户金额
          ,'2022-05-19' As dt              --数据日期
From dual
;

--用友网络
--Insert Into Stock
Select     Seq_Stock.nextval As id         --主键
          ,'600588' As stock_no            --股票编号
          ,'用友网络' As stock_nm          --股票名称
          ,To_Char(To_Date('2022-05-19 15:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --交易时间
          ,18.15 As trans_val              --交易价格
          ,4700 As trans_num               --交易量
          ,0.00 As change_range            --涨跌幅
          ,'3' As change_dir               --涨跌类型 1涨;2跌;3平
          ,'3' As trans_type               --交易类型 1实际;2虚拟;3初始化
          ,4700 As real_stock_num          --实际股票数量
          ,85305 As real_stock_amt         --实际股票金额
          ,86335 As real_stock_amt_sum     --实际股票总金额
          ,1129.95 As real_account_amt     --实账户金额
          ,4700 As virtual_stock_num       --虚拟股票数量
          ,85305 As virtual_stock_amt      --虚拟股票金额
          ,86335 As virtual_stock_amt_sum  --虚拟股票总金额
          ,1129.95 As virtual_account_amt  --虚拟账户金额
          ,'2022-05-19' As dt              --数据日期
From dual
;
Commit;

--交易数据
--Date:2022-05-20 11:16:00
--Insert Into Stock
Select     Seq_Stock.nextval As id         --主键
          ,'600588' As stock_no            --股票编号
          ,'用友网络' As stock_nm          --股票名称
          ,To_Char(To_Date('2022-05-20 10:00:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --交易时间
          ,19.00 As trans_val              --交易价格
          ,4600 As trans_num               --交易量
          ,4.85 As change_range            --涨跌幅
          ,'1' As change_dir               --涨跌类型 1涨;2跌;3平
          ,'2' As trans_type               --交易类型 1实际;2虚拟;3初始化
          ,4700 As real_stock_num          --实际股票数量
          ,89300.00 As real_stock_amt      --实际股票金额
          ,90341.00 As real_stock_amt_sum  --实际股票总金额
          ,1129.95 As real_account_amt     --实账户金额
          ,100 As virtual_stock_num        --虚拟股票数量
          ,1900 As virtual_stock_amt       --虚拟股票金额
          ,2941 As virtual_stock_amt_sum   --虚拟股票总金额
          ,88529.95 As virtual_account_amt --虚拟账户金额
          ,'2022-05-20' As dt              --数据日期
From dual
;
Commit;


--Date:2022-05-20 11:16:00
--Insert Into Stock
Select     Seq_Stock.nextval As id         --主键
          ,'600588' As stock_no            --股票编号
          ,'用友网络' As stock_nm          --股票名称
          ,To_Char(To_Date('2022-05-20 10:35:00','YYYY-MM-DD HH24:MI:SS'),'YYYY-MM-DD HH24:MI:SS') As trans_time --交易时间
          ,18.36 As trans_val              --交易价格
          ,4800 As trans_num               --交易量
          ,1.16 As change_range            --涨跌幅
          ,'1' As change_dir               --涨跌类型 1涨;2跌;3平
          ,'2' As trans_type               --交易类型 1实际;2虚拟;3初始化
          ,4700 As real_stock_num          --实际股票数量
          ,86292 As real_stock_amt      --实际股票金额
          ,87322 As real_stock_amt_sum  --实际股票总金额
          ,1129.95 As real_account_amt     --实账户金额
          ,4900 As virtual_stock_num       --虚拟股票数量
          ,89964 As virtual_stock_amt       --虚拟股票金额
          ,89964 As virtual_stock_amt_sum   --虚拟股票总金额
          ,1361.95 As virtual_account_amt --虚拟账户金额
          ,'2022-05-20' As dt              --数据日期
From dual
;
Commit;


Select 4700*18.36+450+580 From dual;

select 88529.95-4800*18.16 from dual

--数据查询
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
    Where stock_nm='用友网络'
    Order By   stock_no
              ,dt
              ,trans_time
) c
;