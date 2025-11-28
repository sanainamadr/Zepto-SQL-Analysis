CREATE DATABASE IF NOT EXISTS Zepto_SQL_p;
USE Zepto_SQL_p;

-- Data  Exploration✅ 👇

-- adding column 
select * from zepto;
SELECT COUNT(*) FROM zepto;

ALTER TABLE zepto 
ADD column serial_no int NOT NULL auto_increment;

-- NULL value 
SELECT * FROM zepto 
WHERE Category IS NULL
OR 
name IS NULL
OR 
mrp IS NULL
OR 
discountPercent IS NULL
OR 
availableQuantity IS NULL
OR 
discountedSellingPrice IS NULL
OR 
weightInGms IS NULL
OR 
outOfStock IS NULL
OR 
quantity IS NULL;

-- Diferent product Category 
SELECT distinct Category 
FROM zepto 
ORDER BY Category;

-- product in stocks VS out of stock 
SELECT outOfStock, count(serial_no)
FROM zepto 
GROUP BY outOfStock;

-- product name present multiple times 
SELECT name, COUNT(serial_no) as "Number of product"
FROM zepto 
GROUP BY name 
HAVING count(serial_no)>1
ORDER BY COUNT(serial_no) DESC;


-- Data clening ✅ 👇

-- product with price = 0
SELECT * FROM zepto 
WHERE mrp = 0 or discountedSellingPrice = 0;


SET SQL_SAFE_UPDATES =0;

UPDATE zepto 
SET mrp = mrp*100.0 , discountedSellingPrice = discountedSellingPrice*100.0 ;

select mrp, discountedSellingPrice from zepto;

-- Business Insight Queries

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT * FROM zepto ORDER BY discountPercent DESC LIMIT 10; 

-- Q2. What are the Products with High MRP but Out of Stock
 SELECT * FROM zepto WHERE mrp > 200 AND outOfStock = "TRUE";
 
-- Q3. Calculate Estimated Revenue for each category
SELECT Category, SUM(availableQuantity * discountedSellingPrice) as total_revenue 
FROM zepto 
GROUP BY Category 
ORDER BY total_revenue desc;

-- Q4. Find all products where MRP is greater than 2500 and discount is less than 10%.
SELECT * FROM zepto WHERE mrp > 2500 AND discountPercent < 10;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT Category, AVG(discountPercent) AS avg_discount FROM zepto
GROUP BY Category
ORDER BY avg_discount DESC limit 5;

-- Q6.Find the price per gram for products above 108g and sort by best value.
SELECT name, discountedSellingPrice, weightInGms, mrp/weightInGms AS pricePerGram 
from zepto 
where weightInGms > 100
ORDER BY pricePerGram;

-- Q7. Group the products into categories like Low, Medium, Bulk.
SELECT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'LOW'
     WHEN weightInGms < 5000 THEN 'Medium'
     ELSE 'Bulk'
     END AS groupByweightInGms
FROM zepto 
ORDER BY groupByweightInGms;   

-- Q8. What is the Total Inventory Weight Per Category
SELECT category,
SUM(weightInGms * availableQuantity) AS total_weight
FROM zepto
GROUP BY category
ORDER BY total_weight;

  



DESC zepto;












