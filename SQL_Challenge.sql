--Q1 :
--An executive requests data concerning fiscal quarter sales by salesperson. She’d like to see comparisons from the fiscal quarters of 2012 to the same fiscal
--quarters of 2013.
--Notes:
--For Adventure Works, the fiscal year spans July through June (SELF CALCULATED from soh.orderdate)
--Tax and freight will not be considered with revenue
--Dates are based on OrderDate (soh.orderdate)
--Disregard online orders
--Output includes the following columns, corresponding to all sales people:
--LastName (pp.lastname)
--SalesPersonID (soh.salespersonid)
--Fiscal year (SELF CALCULATED from soh.orderdate: )
--Fiscal quarter (SELF CALCULATED from soh.orderdate: Fiscal_Quarter_2013, Fiscal_Quarter_2012)
--Fiscal quarter sales (soh.subtotal)
--Sales during the same fiscal quarter of the previous fiscal year
--Change in revenue between the two periods, Percent change in revenue between the two periods

--Construct 2013 dataset with salesperson id, fiscal year, fiscal quarter, sales
SELECT soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Year_2013,
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Quarter_2013,
SUM(soh.subtotal) as Total_2013
INTO Part_2013
FROM sales.salesorderheader soh
WHERE EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval))='2013'

GROUP BY soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)),
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval))

----Construct 2012 dataset with same variables
SELECT soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Year_2012,
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Quarter_2012,
SUM(soh.subtotal) as Total_2012
INTO Part_2012
FROM sales.salesorderheader soh
WHERE EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval))='2012'
GROUP BY soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)),
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval))

---Compare the variables to find the revenue difference btw 2012 & 2013 at sales person level 
SELECT last.salespersonid, pp.lastname, last.Fiscal_Year_2013, last.Fiscal_Quarter_2013, last.Total_2013, 
previous.total_2012, 
(last.Total_2013-previous.Total_2012) AS Change, 
((last.Total_2013-previous.Total_2012)/previous.Total_2012)*100 AS Percentage_change
FROM Part_2013 last
INNER JOIN person.person pp 
ON pp.businessentityid=last.salespersonid 
INNER JOIN public.part_2012 previous
ON previous.salespersonid= last.salespersonid AND last.Fiscal_Quarter_2013=previous.Fiscal_Quarter_2012
GROUP BY pp.LastName, last.salespersonid, last.Fiscal_Year_2013, last.Fiscal_Quarter_2013, last.Total_2013, previous.total_2012
ORDER BY pp.LastName, last.salespersonid, Percentage_change DESC
postresql=> \o /path/to/your/text/file.txt

--Q2
--A marketing manager devised the “2/22” promotion, in which orders subtotaling at least $2,000 ship for $0.22. The strategy assumes that freight losses will be offset
--by gains from higher value orders. According to the marketing manager, orders between $1,700 and $2,000 will likely boost to $2,000 as customers feel
--compelled to take advantage of bargain freight pricing.
--You are asked to test the 2/22 promotion for hypothetical profitability based on the marketing manager’s assumption about customer behavior. 
--Examine orders shipped to California during fiscal year 2013 for net gains or losses under the promotion.
--PART I
--Create a table that includes the following columns:
--SalesOrderID (soh.salesorderid)
--Ship to state (California) (sp.name)
--OrderDate
--Historical order subtotal (prior to any changes as a result of the promotion) (soh.subtotal)
--Historical freight (prior to any changes as a result of the promotion) (soh.freight)
--Potential promotional effect. Indicate one of three hypothetical scenarios related to the order:
--Increase order to $2,000 and pay $0.22 freight
--No order change and pay $0.22 freight ,No order change and pay historical freight
--Potential order gain
--Potential freight loss
--Potential promotional net gain/loss
--Notes:
--For Adventure Works, the fiscal year spans July through June, Tax should not be considered

--Below I add the values and take the order values btw 1700 & 2000 to calculate the revenue which would come by promotion 
SELECT soh.salesorderid, soh.orderdate, sp.name AS State, soh.subtotal AS Total, soh.freight AS Freight,
               CASE 
	           WHEN soh.subtotal BETWEEN 1700 AND 2000 THEN 2000 
			   ELSE soh.subtotal 
			   END AS potential_total,
			   CASE 
--Calculate and substract the loss freight cost from the potential campaign revenue where the revenue btw 1700 & 2000
	           WHEN soh.subtotal BETWEEN 1700 AND 2000 THEN 0.22
			   ELSE freight
			   END AS potential_freight,
			   CASE 
			   WHEN soh.subtotal BETWEEN 1700 AND 2000 THEN 2000-soh.subtotal
			   ELSE 0
			   END AS Potential_OrderGain,
			   CASE 
			   WHEN soh.subtotal>=1700 THEN 0.22
			   ELSE soh.freight
			   -soh.freight
			   END AS Potential_Freightloss,
			   (CASE
			   WHEN soh.subtotal BETWEEN 1700 AND 2000 THEN 2000-soh.subtotal
			   ELSE 0
			   END
			   + CASE 
			   WHEN soh.subtotal>=1700 THEN 0.22 ELSE soh.Freight
			   END 
			   - soh.Freight) AS PromoNetGain_Loss

INTO potential_campaign_table2
FROM sales.salesorderheader soh
INNER JOIN person.businessentityaddress bea ON soh.shiptoaddressid=bea.addressid
INNER JOIN person.address ad ON bea.addressid=ad.addressid 
INNER JOIN person.stateprovince sp ON ad.stateprovinceid=sp.stateprovinceid
WHERE sp.name='California'
AND EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval))=2013

SELECT potential_total, SUM(Potential_OrderGain) AS Potential_OrderGain_Total, 
SUM(Potential_Freightloss) AS Potential_Freightloss_Total, SUM(PromoNetGain_Loss) AS PromoNetGain_Loss_Total
FROM public.potential_campaign_table2
GROUP BY potential_total 
SELECT  SUM(Potential_total)
FROM public.potential_campaign_table2

--Q3
--Ten million dollars of revenue is a common benchmark for Adventure Works. For each fiscal year (2012 and 2013), 
--find the first dates when the cumulative running revenue total hit $10 million.
--Notes:
--For Adventure Works, the fiscal year spans July through June
--Do not consider tax and freight with revenue
--Your output should include the following columns:
--Fiscal year (2012 or 2013)
--Order date in which $10 million was reached or exceeded
--Order number within the fiscal year in which $10 million was reached or exceeded. 
--Note, this is a count of orders. For example, if the $10 million goal was reached on the 50th order, then the appropriate value to report is 50.
--Running total revenue in which $10 million was reached or exceeded


SELECT EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)) as fiscal_Year,	soh.orderdate, soh.subtotal,
soh.salesorderid, sum(soh.subtotal) OVER(ORDER BY soh.orderdate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as total, 
ROW_NUMBER() OVER (ORDER BY soh.salesorderid)
INTO deneme_3
FROM sales.salesorderheader soh
WHERE EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval))=2012;
SELECT*
FROM deneme_3
WHERE total>=10000000
LIMIT 1		
