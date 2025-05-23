select top 20 * from pizza_sales;

--revenue_find
select sum(total_price) as Total_Revenue from pizza_sales;

--Average order value 
select sum(total_price) / count(distinct(order_id)) as avg_order_value from pizza_sales;

--Total Pizza sold
select sum(quantity) as sold_qunatity from pizza_sales;

--Order Placed
select count(distinct(order_id)) as total_order_place from pizza_sales;

--AVG Pizza Sold / Order
select 
cast(
      cast(sum(quantity) as decimal(7,2)) /cast(count(distinct(order_id))as decimal (7,2)
)as decimal(10,2))
as sold_per_order from pizza_sales;


====================chart analysis==================

--Total Orders Place on Day based
select datename(dw,order_Date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by datename(dw , order_date) 

--hourly Trends Based on Total Orders
select datename(Hour, order_time) as Hours_digit , count(distinct  order_id) as Total_Orders
from pizza_sales
group by datename(Hour , order_time ) 
order by total_orders desc

--Monthly Trends Based on Total Orders
select datename(Month, order_date) as month_name , count(distinct  order_id) as Total_Orders
from pizza_sales
group by datename(month , order_date ) 
order by total_orders desc

--Percentage of Sales  by Pizza Category and month  
select 
	pizza_category ,
	cast(sum(total_price)as decimal(10,2))as ctg_selling ,
	cast(
		sum(total_price) * 100/ (select sum(total_price) from pizza_sales where month(order_date)=1)
		as decimal(10,2)
	)as ctg_sale_distribution
from pizza_sales
where month(order_date)=1
group  by pizza_category
order by ctg_sale_distribution;

--percentage of order by pizza size , quarter
select 
	pizza_size ,
	cast(sum(total_price) as decimal(10,2))as size_selling ,
	cast(
		sum(total_price) * 100/ (select sum(total_price) from pizza_sales 
		where datepart(quarter , order_date) = 1)
		as decimal(10,2)
	)as size_sale_distribution
from pizza_sales
where datepart(quarter , order_date) = 1
group  by pizza_size
order by size_sale_distribution desc;

-- Top  5 best Pizza based on Quantity sold and Revenue
select top 5 pizza_name , sum(quantity)as sold_quantity from pizza_sales
group by pizza_name
order by sold_quantity desc;

select top 5 pizza_name , sum(total_price)as revenue_generate from pizza_sales
group by pizza_name
order by revenue_generate desc;

-- Worst 5 best Pizza based on Quantity sold and Revenue
select top 5 pizza_name , sum(quantity)as sold_quantity from pizza_sales
group by pizza_name
order by sold_quantity asc;

select top 5 pizza_name , cast(sum(total_price)as decimal(10,2) )as revenue_generate from pizza_sales
group by pizza_name
order by revenue_generate asc;



