create Database Pizza_db;
use Pizza_db;
SELECT 
    *
FROM
    pizza_sales;
    
#update a date  datatype 
select * from pizza_sales limit 20 offset 1100 ;
SET SQL_SAFE_UPDATES = 0;

UPDATE pizza_sales
SET order_date = STR_TO_DATE(order_date, '%d-%m-%Y');

ALTER TABLE pizza_sales
MODIFY COLUMN order_date DATE;

savepoint change_date_type;
describe pizza_sales ;

# change time data type 
select distinct(order_time) from pizza_Sales limit 20;

update pizza_sales set order_time =  str_to_date(order_time , '%H:%i:%s') where order_time is not null; 

alter table pizza_sales
modify order_time time;