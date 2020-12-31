# SQL-Challange
SQL Challange Solutions by Post-Gre SQL
Use AdventureWorks DB

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
each fiscal year (2007 and 2008), find the first dates when the cumulative running
revenue total hit $10 million.
Notes:
For Adventure Works, the fiscal year spans July through June
Do not consider tax and freight with revenue
Your output should include the following columns:
Fiscal year (2007 or 2008)
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
calculate average revenue per order by day of week in 2008.
Include the following columns with your output:
Day of week
Revenue
Orders
Revenue per order
Notes:
Dates based on OrderDate
Tax and freight should not be considered
Exclude online orders

Q5 :
The Accounting department found instances where expired credit cards were
used with sales orders. You are asked examine all credit cards and report the
extent of such activity.
PART I
white_check_mark
eyes
raised_hands
Based on each CreditCardID, find the following:
CreditCardType
ExpirationDate
Last order date
Number of sales orders with order dates earlier than or equal to the
card’s expiration date
Number of sales orders with order dates later than the card’s expiration
date
Note:
Adventure Works stores information about a credit card’s expiration year and
expiration month. Expiration dates pertain to the last day of a card’s expiration
month. For example, if the expiration year is 2007 and the expiration month is “4”,
the card’s expiration date will be April 30, 2007.
PART II
Based on CreditCardType, summarize data returned from Part I. Your output
should include the following columns:
CreditCardType
Number of sales orders with order dates earlier than or equal to the
card’s expiration date
Number of sales orders with order dates later than the card’s
expiration date
Q6:
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

Q7:
An Adventure Works executive asks for a list of all salespeople representing the
Northwest, Southwest, and Canadian sales territories, along with their 2008
revenue. You ask about the purpose of the information. “I’m assembling a ‘special
team,’ the executive responds. “I’ll tell you more soon.”
Create a list of sales people with revenue as requested. Do not consider tax and
freight.

Q8:
The following day, after completing the previous challenge, the executive
approaches you again.
“I’m starting a new company,” he says. “That’s why I asked for the information
yesterday. I need you to recommend candidates for recruitment.
I want one salesperson from the Northwest territory, one from the Southwest
territory, and one from the Canadian territory. Which three-person combination of
sales people results in the highest revenue? Base your calculations on the 2008
revenue you previously found.
I want the best team, but we cannot exceed the salary constraints. My salary
budget for the combined roster must be less than $210,000.”
Below are the salaries you can offer to each sales person, as provided by the
executive:
Pak: $79,500
Vargas: $60,000
Campbell: $59,500
Mensa-Annan: $56,000
Ito: $68,000
Michel: $80,000
Based on 2008 revenue, find the most valuable combination of sales people
within the salary constraint.
Your output should include a single row with the following columns:
Sum of salaries of your three person team
Sum of revenue from your three person team
Territory of the first sales person
Last name of first sales person
Revenue of first sales person
Salary of first sales person
Territory of the second sales person
Last name of second sales person
Revenue of second sales person
Salary of second sales person
Territory of the third sales person
Last name of third sales person
Revenue of third sales person
Salary of third sales person

Q9:
The executive management team wants to analyze the buying behavior of
customers.
PART I
Provide the following calculations:
Percentage of sales orders containing at least one bike and at least one
accessory item
Percentage of sales orders containing at least one bike and at least two
different clothing products
PART II
Count sales orders by product type. For example, if 500 sales orders included the
product types Bikes and Clothing, with no accessories and components
purchased

Q10:
An analyst notified the Vice President of Sales that averages can be skewed by
outliers. In response, he asks to see median revenue in addition to average
revenue. He also asks you to add minimum and maximum revenue to your report.
Write a query of sales by year that includes the following columns:
Order year
Minimum sale
Maximum sale
Average sale
Median sale
Notes:
Years based on OrderDate
Tax and freight should not be considered with revenue
