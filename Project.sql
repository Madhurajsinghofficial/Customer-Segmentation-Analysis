
CREATE DATABASE IF NOT EXISTS project;
USE project ;

-- INSPECTING DATA 

select *from data1

-- CHECKING UNIQUE VALUES

select distinct status from data1 -- Nice one to plot
select distinct year_id from data1
select distinct PRODUCTLINE from data1 -- Nice to plot
select distinct COUNTRY from data1 -- Nice to plot
select distinct DEALSIZE from data1 -- Nice to plot
select distinct TERRITORY from data1 --  Nice to plot

select distinct MONTH_ID from data1
where year_id = 2003

select distinct MONTH_ID from data1
where year_id = 2004

select distinct MONTH_ID from data1
where year_id = 2005

-- it shows that in thsi year of 2005 only 5 months the sales were made as compared to 2004, 2003 when the sales were made in the whole year



--  ANALYSIS 1 = SALES BY PRODUCT LINE 
--  Let's start by grouping sales by productline

select PRODUCTLINE, sum(sales) as Revenue
from data1
group by PRODUCTLINE
order by 2 desc

--  ANALYSIS 2 = SALES BY YEAR WHICH HAVE THE BEST SALES 

select YEAR_ID , sum(sales) as Revenue
from data1
group by YEAR_ID
order by 2 desc

--  ANALYSIS 3 = SALES BY DEALS WHICH HAVE THE BEST SALES 

select DEALSIZE , sum(sales) as Revenue
from data1
group by DEALSIZE
order by 2 desc

--  What was the best month for sales in a specific year? How much was earned that month?

SELECT MONTH_ID , sum(sales) as Revenue, count(ORDERNUMBER) as Frequency
from data1
where YEAR_ID = 2003   -- change year to see the rest
group by  MONTH_ID
order by 2 desc

SELECT MONTH_ID , sum(sales) as Revenue, count(ORDERNUMBER) as Frequency
from data1
where YEAR_ID = 2004   -- change year to see the rest
group by  MONTH_ID
order by 2 desc

SELECT MONTH_ID , sum(sales) as Revenue, count(ORDERNUMBER) as Frequency
from data1
where YEAR_ID = 2005   -- change year to see the rest
group by  MONTH_ID
order by 2 desc

--  November seems to be the month, what product do they sell in November, Classic I believe

select  MONTH_ID, PRODUCTLINE, sum(sales) Revenue, count(ORDERNUMBER)
from data1
where YEAR_ID = 2004 and MONTH_ID = 11 -- change year to see the rest
group by  MONTH_ID, PRODUCTLINE
order by 3 desc 

-- Who is our best customer (this could be best answered with RFM)

CREATE TABLE rfm (
    CUSTOMERNAME VARCHAR(255),
    MonetaryValue DECIMAL(18, 2),
    AvgMonetaryValue DECIMAL(18, 2),
    Frequency INT,
    last_order_date DATE,
    max_order_date DATE,
    Recency INT,
    rfm_recency INT,
    rfm_frequency INT,
    rfm_monetary INT,
    rfm_cell INT,
    rfm_cell_string VARCHAR(255)
);



-- What products are most often sold together? 
--  select * from [dbo].[sales_data_sample] where ORDERNUMBER =  10411


SELECT 
    OrderNumber, 
    GROUP_CONCAT(PRODUCTCODE) AS ProductCodes
FROM data1
WHERE ORDERNUMBER IN (
    SELECT ORDERNUMBER
    FROM (
        SELECT ORDERNUMBER, COUNT(*) AS rn
        FROM data1
        WHERE STATUS = 'Shipped'
        GROUP BY ORDERNUMBER
    ) m
    WHERE rn = 3
)
GROUP BY OrderNumber
ORDER BY ProductCodes DESC;


--  EXTRAs----
-- What city has the highest number of sales in a specific country

select city, sum(sales) Revenue
from data1
where country = 'UK'
group by city
order by 2 desc



--  What is the best product in United States?

select country, YEAR_ID, PRODUCTLINE, sum(sales) Revenue
from data1
where country = 'USA'
group by  country, YEAR_ID, PRODUCTLINE
order by 4 desc


