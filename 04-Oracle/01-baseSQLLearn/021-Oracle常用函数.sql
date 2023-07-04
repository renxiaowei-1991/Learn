--001-随机函数
--  随机产生一个整数
select dbms_random.random from dual;
--  随机产生一个0-1之间的小数
select dbms_random.value from dual;

--  随机产生一个0-100之间的正整数
select ABS(mod(dbms_random.random, 100)) from dual;
--  随机产生一个0-100之间的小数
select dbms_random.value(0,100) from dual;
