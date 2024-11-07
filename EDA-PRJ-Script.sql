-- Q.1]Create  create database supermarket and perform EDA 

use superstore;
select * from table_superstore;

-- 1. Display the first 5 rows from the dataset.
select * from table_superstore limit 5;
-- 2. Display the last 5 rows from the dataset.
select * from table_superstore order by 'Invoice ID' desc limit 5 ;
-- 3. Display random 5 rows from the dataset.
select * from table_superstore order by rand() limit 5;
-- 4. Display count, min, max, avg, and std values for a column(gross income) in the dataset.
select count(`gross income`), min(`gross income`), round(max(`gross income`),1), round(avg(`gross income`),1), round(std(`gross income`),1) from table_superstore ;
-- 5. Find the number of missing values.
select count(*) from table_superstore where branch is null; 
select count(*) from table_superstore where `Invoice Id` is null ;
# as our data is cleaned so no null values present there.
-- 6. Count the number of occurrences of each city.
select city, count(city) from table_superstore group by city ;
-- 7. Find the most frequently used payment method.
select payment,count(*) from table_superstore group by payment order by count(*) desc ;
-- 8. Does The Cost of Goods Sold Affect The Ratings That The Customers Provide?
select cogs,Rating from table_superstore ;
#wont affect 
-- 9. Find the most profitable branch as per gross income.
select branch,round(sum(`gross income`),2)sum_gross_income from table_superstore group by branch order by sum_gross_income desc;
-- 10. Find the most used payment method city-wise.
#select payment,city,count(payment) from table_superstore group by payment,city ;
select city,
sum(case when payment= "cash" then 1 else 0 end)Cash,
sum(case when payment="Ewallet" then 1 else 0 end)Ewallet,
sum(case when payment="Credit Card" then 1 else 0 end)CreditCard
from table_superstore group by city ;
-- 11. Find the product line purchased in the highest quantity.
select `product line`,sum(quantity)total_quantity from table_superstore group by `product line` order by total_quantity desc ;
-- 12. Display the daily sales by day of the week.
UPDATE table_superstore 
SET date = CASE 
    WHEN date LIKE '%/%/%' THEN STR_TO_DATE(date, '%m/%d/%Y')  
    WHEN date LIKE '%-%-%' THEN STR_TO_DATE(date, '%Y-%m-%d')  
    ELSE NULL  
END 
WHERE date IS NOT NULL;  

SET SQL_SAFE_UPDATES = 1;
select dayname(date),dayofweek(date),round(sum(Total),2) from table_superstore group by dayname(date),dayofweek(date);

-- 13. Find the month with the highest sales.
select monthname(date) name ,round(sum(total),2)total from table_superstore  group by name order by total desc;
-- 14. Find the time at which sales are highest.
select hour(Time)Time,round(sum(Total),2)Total from table_superstore group by Time order by Total desc;
-- 15. Which gender spends more on average?  
select gender,round(avg(`Total`),2)Total from  table_superstore group by gender;





