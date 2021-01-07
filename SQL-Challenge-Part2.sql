--For explanatory reasons, I added the name of variables and some function names in parentheses that I used for calculating the requested parts
--For the first 3 questions' answers, please see the other file.
	

--Q4
--Tuesday’s are “upsell” days for sales people at Adventure Works. 
--Management wants to compare sales from Tuesday to other days of the week to see if the initiative is working. 
--Help monitor the upsell initiative by creating a query to calculate 
--average revenue( SUM(soh.subtotal) 
--per order (SUM(soh.subtotal)/Count(*) by day of week in 2012. 
--Include the following columns with your output: Day of week Revenue Orders Revenue per order (to_char(soh.orderdate, 'Day'))
--Notes: Dates based on OrderDate Tax and freight should not be considered Exclude online orders

QUESTION 4
SELECT to_char(soh.orderdate, 'Day') AS DAY, SUM(soh.subtotal) AS Revenue, COUNT(*) AS Orders, 
SUM(soh.subtotal)/Count(*) AS Revenue_Per_Order
FROM Sales.SalesOrderHeader soh
WHERE EXTRACT(YEAR FROM soh.orderdate)='2012' AND soh.onlineorderflag = '0'
GROUP BY to_char(soh.orderdate, 'Day')
ORDER BY Orders DESC



QUESTION 5
--Adventure Works will feature one product for the cover of its print catalog. Help select a list of products for consideration.
-- Your list should contain products which meet all of the following conditions:  
--List price at least $1,500 At least 150 in inventory Currently available for sale Your output should contain the following columns: 
--ProductID ProductName Color ListPrice Inventory quantity

SELECT pop.productid, pop.name, pop.color, pop.listprice, SUM(prop.quantity) 
FROM production.product pop
INNER JOIN production.productinventory prop
ON pop.productid=prop.productid
WHERE pop.listprice>=150
AND prop.quantity>=150
GROUP BY pop.productid 
ORDER BY pop.listprice DESC
LIMIT 5

--QUESTION 6
-- An Adventure Works executive asks for a list of all salespeople (soh.salespersonid) representing the Northwest, Southwest, and Canadian sales territories(sst.name),
-- along with their 2012 revenue ((soh.subtotal)). 
--You ask about the purpose of the information. “I’m assembling a ‘special team,’ the executive responds. “I’ll tell you more soon.” Create a list of sales people with revenue as requested. 
--Do not consider tax and freight.

QUESTION 6
SELECT soh.salespersonid, SUM(soh.subtotal), pp.lastname, sst.name
from sales.salesorderheader soh
INNER JOIN sales.salesterritoryhistory sth
ON soh.salespersonid= sth.businessentityid
INNER JOIN sales.salesterritory sst
ON sst.territoryid=sth.territoryid
INNER JOIN person.person pp
ON sth.businessentityid=pp.businessentityid
WHERE EXTRACT(YEAR FROM soh.orderdate)= '2012'
AND name='Northwest' OR name='Southwest' OR name='Canada'
GROUP BY(soh.salespersonid, pp.lastname, sst.name)
ORDER BY SUM(soh.subtotal) DESC


