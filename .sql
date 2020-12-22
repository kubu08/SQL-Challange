SELECT soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Year_2013,
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Quarter_2013,
SUM(soh.subtotal) as Total_2013
INTO Part_2013
FROM sales.salesorderheader soh
WHERE EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval))='2013'
GROUP BY soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)),
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval))

SELECT soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Year_2012,
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval)) AS Fiscal_Quarter_2012,
SUM(soh.subtotal) as Total_2012
INTO Part_2012
FROM sales.salesorderheader soh
WHERE EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval))='2012'
GROUP BY soh.salespersonid, EXTRACT(YEAR FROM soh.orderdate::timestamp+cast('6 months' as interval)),
EXTRACT(QUARTER FROM soh.orderdate::timestamp+cast('6 months' as interval))

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