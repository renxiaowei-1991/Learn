--����
create or replace function self_date_add(in_date date, num int)
return date
--ʵ��date_add����
is
  out_date date;
begin
  out_date := in_date + num;
  return out_date;
end;

create or replace function self_date_sub(in_date date, num int)
return date
--ʵ��date_sub����
is
  out_date date;
begin
  out_date := in_date - num;
  return out_date;
end;


select self_date_add(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;
select self_date_sub(to_date('2023-07-05', 'YYYY-MM-DD'), 1) from dual;

