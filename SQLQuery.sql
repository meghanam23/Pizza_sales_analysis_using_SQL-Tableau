-- show the table
select * from pizza_sales

-- to get the total revenue
select sum(total_price) as total_revenue from pizza_sales

-- to get the average revenue
select sum(total_price)/count(distinct order_id) as avg_revenue from pizza_sales

-- to get total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales

--to get total orders placed
select count(distinct order_id) as total_orders from pizza_sales

-- to get average pizza per order
select cast(cast(sum(quantity) as decimal(10,2))/ cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2)) as average_pizza_p_order from pizza_sales

-- Hourly trend for total pizzas sold
select datepart(hour, order_time) as order_hour, sum(quantity) as total_pizza_sold from pizza_sales group by datepart(hour, order_time) order by datepart(hour, order_time)
  
-- Weekly trend for total orders 
select datepart(iso_week, order_date) as week_number, year(order_date) as order_year, count(distinct order_id) as total_orders from pizza_sales group by datepart(iso_week, order_date), year(order_date) order by datepart(iso_week, order_date), year(order_date)
  
--percentage of pizza sold by pizza_category
select pizza_category, sum(total_price)*100/(select sum(total_price) from pizza_sales) as percent_sold from pizza_sales group by pizza_category

--percentage of pizza sold by pizza_category by month
select pizza_category, sum(total_price)*100/(select sum(total_price) from pizza_sales where month(order_date)=1) as percent_sold from pizza_sales where month(order_date)=1 group by pizza_category

--percentage of pizza sold by pizza_size
select pizza_size,sum(total_price) as total, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales ) as decimal(10,2))  as percent_sold from pizza_sales group by pizza_size order by percent_sold desc

--percentage of pizza sold by pizza_size for quarter
select pizza_size,sum(total_price) as total, cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where datepart(quarter, order_date)=1) as decimal(10,2))  as percent_sold from pizza_sales where datepart(quarter, order_date)=1 group by pizza_size order by percent_sold desc

--best 5 pizzas by revenue
select top 5 pizza_name, sum(total_price) as total_revenue from pizza_sales group by pizza_name order by total_revenue desc 

--last 5 pizzas by revenue
select top 5 pizza_name, sum(total_price) as total_revenue from pizza_sales group by pizza_name order by total_revenue

--best 5 pizzas by quantity
select top 5 pizza_name, sum(quantity) as total_quantity from pizza_sales group by pizza_name order by total_quantity desc 

--last 5 pizzas by revenue
select top 5 pizza_name, sum(quantity) as total_quantity from pizza_sales group by pizza_name order by total_quantity 

--best 5 pizzas wrt orders
select top 5 pizza_name, count(distinct order_id) as total_orders from pizza_sales group by pizza_name order by total_orders desc

--last 5 pizzas wrt orders
select top 5 pizza_name, count(distinct order_id) as total_orders from pizza_sales group by pizza_name order by total_orders
