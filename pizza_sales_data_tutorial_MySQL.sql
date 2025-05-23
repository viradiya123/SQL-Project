use  pizza_db;

SELECT *  FROM pizza_sales
limit 20;

#total revenue
select sum(total_price) AS Total_Revenue from pizza_sales;

#Average order value
select sum(total_price) / count(distinct(order_id)) as  Avg_Order_Value from pizza_sales;

#total pizza sold ;
select sum(quantity) as Total_Pizza_Sold from pizza_sales;

#total order place
select count(distinct(order_id)) as Total_order from pizza_sales;

#Average Pizzas sold per order 
select round(sum(quantity) / count(distinct(order_id)),2) as Avg_Soldqty_PO from  pizza_sales;

#Total order place on days  based
select dayname(order_date) as order_day , count(distinct( order_id)) as Total_orders
from pizza_sales
group by order_day;

#hourly trend for total order 
SELECT 
  HOUR(STR_TO_DATE(order_time, '%H:%i:%s')) AS day_hours,
  COUNT(DISTINCT order_id) AS total_order
FROM pizza_sales
GROUP BY day_hours
ORDER BY total_order desc;

#Monthly Trend based toatl order
select monthname(order_date) as Month_name , Count(distinct( order_id)) as Total_Order 
from Pizza_sales
Group by Month_name
order by Total_Order desc;

#percentage of sales by category 
select pizza_category , round(sum(total_price),2) as ctg_Total_sales, round (sum(total_price) * 100 / (select sum(total_price) from pizza_sales),2) as ctg_distribution_per
from pizza_Sales
group by pizza_category
order by ctg_distribution_per desc;

# percentag of order by pizza size 
select  pizza_size , round(sum(total_price),2) as Total_sell , 
        round(sum(Total_price)*100 / (select sum(total_price) from pizza_Sales) ,2) size_sell_pct
from pizza_sales
group by pizza_size ;

# top 5 seller based on Sold:
select pizza_name , sum(quantity) as sold_pizza_qty
from pizza_sales
group by  pizza_name  
order by sold_pizza_qty desc 
limit 5 ;

#worst 5 pizza
select pizza_name , sum(quantity) as pizza_sold_qty
from pizza_sales
group by pizza_name
order by pizza_sold_qty 
limit 5;

