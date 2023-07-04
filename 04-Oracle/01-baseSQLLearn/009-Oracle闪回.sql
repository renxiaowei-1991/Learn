--闪回
--https://blog.csdn.net/wmjCode/article/details/122111876
    Oracle使用FlashBack(闪回)恢复误删除的数据或误删除的表
    
1、执行Drop Table TableName语句
    Drop后的表被放在回收站(User_recyclebin)里，而不是直接删除掉。这样，回收站里的表信息就可以被恢复，或彻底清除。
    通过查询回收站(user_recyclebin)获取被删除的表信息。

2、恢复表
    FlashBack Table <user_recyclebin.object_name or user_recyclebin.original_name> to before drop [rename to <new_table_name>];
    将回收站里的表恢复为原名称或指定新名称，表中数据不会丢失。
    
3、彻底删除表
    Drop Table <table_name> pruge;
    
4、清空回收站
    清除指定表
        Purge Table <table_name>;
    清除当前用户的回收站
        Purge recyclebin;
    清除所有用户的回收站
        Purge dba_recyclebin;
    不放入回收站，直接删除表
        Drop Table TableName Purge;
        
--闪回具体操作
1、闪回查询
--没有被删除的表，想要把数据恢复到某一个时间点之前的状态，可以通过下面的语句查询，找到想要恢复的状态的时间点(多次尝试)。
select * from Learn01 as of timestamp to_timestamp('2022-05-16 13:30:00','YYYY-MM-DD HH24:MI:SS');
--被删除的表直接查回收站
select * from dba_recyclebin;

2、开启行迁移
Alter Table Learn01 enable row movement;

3、恢复
--恢复数据到某一个时间点之前的状态
FlashBack Table Learn01 to TimeStamp to_timestamp('2022-05-16 13:30:00','YYYY-MM-DD HH24:MI:SS')
--被删除的表直接恢复到被删除之前
FlashBack Table Learn01 to Before Drop;  --恢复到被Drop之前

4、关闭行迁移
Alter Table Learn01 disable row movement;