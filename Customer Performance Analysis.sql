
CREATE VIEW gold.report_customers AS

with base_query as
(
select 
f.order_number,
f.product_key,
f.order_date,
f.sales_amount,
f.quantity,
c.customer_key,
c.customer_number,
concat(c.first_name, ' ', c.last_name) FName,
datediff(year, c.birthdate, getdate()) Age
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
where order_date is not null
)
, main as 
(
select
customer_number,
customer_key,
FName,
Age,
sum(quantity) total_quantity,
count(distinct order_number) total_orders,
sum(sales_amount) total_sales,
count(distinct product_key) total_products,
max(order_date) last_ordered,
datediff(month,min(order_date),max(order_date)) lifespan
from base_query
group by
customer_number,
customer_key,
FName,
Age
)
select
customer_number,
customer_key,
FName,
Age,
case when age<20 then 'Below 20'
     when age between 20 and 29 then '20-30'
	 when age between 30 and 39 then '30-39'
	 when age between 40 and 49 then '40-49'
	 else '50 and above'
end Age_category,
case when total_sales >= 5000 and lifespan > 12 then 'VIP'
     when total_sales < 5000 and lifespan > 12 then 'Regular'
	 else 'New'	
end category,
last_ordered,
datediff(month,last_ordered,getdate()) recency,
case when total_orders = 0 then 0
else total_sales/total_orders 
end Avg_order,
total_quantity,
total_orders,
total_sales,
total_products,
case when lifespan = 0 then total_sales
     else total_sales/lifespan
end Ord_Mon,
lifespan
from main


