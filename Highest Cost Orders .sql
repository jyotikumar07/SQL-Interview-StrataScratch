
-- Highest Cost Orders


/* Find the customers with the highest daily total order cost between 2019-02-01 and 2019-05-01. 
 If a customer had more than one order on a certain day, sum the order costs on a daily basis. 
 Output each customer's first name, total cost of their items, and the date. 
 If multiple customers tie for the highest daily total on the same date, return all of them. */


-- For simplicity, you can assume that every first name in the dataset is unique. 


with total_spending as (

Select cust.first_name as name, odr.order_date as date_, sum(odr.total_order_cost) as total_cost 
from customers as cust 
right join orders as odr
on cust.id = odr.cust_id
where odr.order_date between '2019-02-01' and '2019-05-01'
Group by cust.first_name, odr.order_date

),

ranking_customers as (

Select name , date_, total_cost, 
rank() over( partition by date_  order by total_cost desc )as Rank_
from total_spending

)

select name, date_, total_cost from ranking_customers where Rank_ = 1 
order by date_ , name asc;

