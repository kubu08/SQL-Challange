# SQL-Challange
Question Source:Real SQL Queries  50 Challenges: Practice for Reporting and Analysis


Brian Cohen, Neil Pepi, Neerja  Mishra


SQL Challange Solutions by Post-Gre SQL


Data source: Use AdventureWorks DB:  https://drive.google.com/file/d/1vyz2_lobwmAGl4cJ7jTdERgxBoFeGxyf/view?usp=sharing


Used PG Admin development platform 




Q1 :
An executive requests data concerning fiscal quarter sales by salesperson. She’d
like to see comparisons from the fiscal quarters of 2008 to the same fiscal
quarters of 2007.
For example, suppose sales for salesperson X totaled $1,000 during Fiscal Year
2008, Fiscal Quarter 2. If sales for salesperson X totaled $900 in Fiscal Year
2007, Fiscal Quarter 2, this reflects about 11.1% growth between the two periods
for salesperson X.
Notes:
For Adventure Works, the fiscal year spans July through June
Tax and freight will not be considered with revenue
Dates are based on OrderDate
Disregard online orders
Your output should include the following columns, corresponding to all sales
people:
LastName
SalesPersonID
Fiscal year
Fiscal quarter
Fiscal quarter sales
Sales during the same fiscal quarter of the previous fiscal year
Change in revenue between the two periods
Percent change in revenue between the two periods


Q2 :
A marketing manager devised the “2/22” promotion, in which orders subtotaling at
least $2,000 ship for $0.22. The strategy assumes that freight losses will be offset
by gains from higher value orders. According to the marketing manager, orders
between $1,700 and $2,000 will likely boost to $2,000 as customers feel
compelled to take advantage of bargain freight pricing.
You are asked to test the 2/22 promotion for hypothetical profitability based on the
marketing manager’s assumption about customer behavior. Examine orders
shipped to California during fiscal year 2008 for net gains or losses under the
promotion.
PART I
Create a table that includes the following columns:
SalesOrderID
Ship to state (California)
OrderDate
Historical order subtotal (prior to any changes as a result of the
promotion)
Historical freight (prior to any changes as a result of the promotion)
Potential promotional effect. Indicate one of three hypothetical scenarios
related to the order:
Increase order to $2,000 and pay $0.22 freight
No order change and pay $0.22 freight
No order change and pay historical freight
Potential order gain
Potential freight loss
Potential promotional net gain/loss
Notes:
For Adventure Works, the fiscal year spans July through June
Tax should not be considered
PART II
Aggregate data from Part I by PotentialPromotionalEffect. Include the following:
PotentialPromotionalEffect
Potential order gains
Potential freight losses
Overall net gain/loss


Q3 :
Ten million dollars of revenue is a common benchmark for Adventure Works. For
each fiscal year (2012 and 2013), find the first dates when the cumulative running
revenue total hit $10 million.
Notes:
For Adventure Works, the fiscal year spans July through June
Do not consider tax and freight with revenue
Your output should include the following columns:
Fiscal year (2012 or 2013)
Order date in which $10 million was reached or exceeded
Order number within the fiscal year in which $10 million was reached or
exceeded. Note, this is a count of orders. For example, if the $10 million
goal was reached on the 50th order, then the appropriate value to report
is 50.
Running total revenue in which $10 million was reached or exceeded


Q4 :
Tuesday’s are “upsell” days for sales people at Adventure Works. Management
wants to compare sales from Tuesday to other days of the week to see if the
initiative is working. Help monitor the upsell initiative by creating a query to
calculate average revenue per order by day of week in 2012.
Include the following columns with your output:
Day of week
Revenue
Orders
Revenue per order
Notes:
Dates based on OrderDate
Tax and freight should not be considered
Exclude online orders


Q5:
Adventure Works will feature one product for the cover of its print catalog. Help
select a list of products for consideration.
Your list should contain products which meet all of the following conditions:
Finished goods (not products utilized to make other products)
List price at least $1,500
At least 150 in inventory
Currently available for sale
Your output should contain the following columns:
ProductID
ProductName
Color
ListPrice
Inventory quantity

Q6:
An Adventure Works executive asks for a list of all salespeople representing the
Northwest, Southwest, and Canadian sales territories, along with their 2012
revenue. You ask about the purpose of the information. “I’m assembling a ‘special
team,’ the executive responds. “I’ll tell you more soon.”
Create a list of sales people with revenue as requested. Do not consider tax and
freight.
