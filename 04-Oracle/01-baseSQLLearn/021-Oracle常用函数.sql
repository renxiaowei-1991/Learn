--001-�������
--  �������һ������
select dbms_random.random from dual;
--  �������һ��0-1֮���С��
select dbms_random.value from dual;

--  �������һ��0-100֮���������
select ABS(mod(dbms_random.random, 100)) from dual;
--  �������һ��0-100֮���С��
select dbms_random.value(0,100) from dual;
