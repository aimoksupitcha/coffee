start transaction;
insert into Menu values (1,"ลาเต้ ร้อน","100","50");
insert into Menu values (2,"อเมรืกาโน่ เย็น","50","60");
insert into Menu values (3,"ชาเขียว เย็น","75","55");
commit;
select * from Menu;

start transaction;
insert into Customer values (1,"0643360808","ice","member");
commit;
select * from Customer;

start transaction;
insert into orders values (1,"2023-07-25 12:34:56","50","1");
insert into orders values (2,"2023-07-26 14:12:42","60","1");
insert into orders values (3,"2023-07-27 10:30:12","55","1");
commit;
select * from orders;

start transaction;
insert into orders_detail values (1,"1","1","1");
insert into orders_detail values (2,"1","2","2");
insert into orders_detail values (3,"1","3","3");
commit;
select * from orders_detail;

use coffee;
drop procedure if exists Week5;
delimiter //
create procedure Week5()
begin
declare sql_error int default false;
declare continue handler for sqlexception set sql_error= true;
start transaction;
insert into orders values (4, "2023-08-01 12:40:51","50", 1); 
insert into orders_detail values (4, 1, 1,4);

insert into orders values (5, "2023-08-02 15:41:11","60", 1); 
insert into orders_detail values (5, 1, 2,5);

insert into orders values (6, "2023-08-03 11:12:11","55", 1);
insert into orders_detail values (6, 1,3,6);

if sql_error = false then commit; select "Success";
else rollback; select "fail";
end if;
end// 
delimiter ;
call Week5();

SELECT Customer_name, sweetness_level, sum(Orders_detail_qty) AS Count
FROM customer 
join orders using(customer_id)
join orders_detail using(Orders_id)
join menu using(Menu_id)
GROUP BY Customer_name, sweetness_level;