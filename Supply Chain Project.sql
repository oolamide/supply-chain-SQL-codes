SELECT *
FROM Supply_Chain
WHERE Order_Item_Discount <= 0

--Remove Unnecessary Columns in the table. (Mostly columns with overall null values)
ALTER Supply_Chain
DROP COLUMN Product_Status, Customer_Email, Customer_Password, Product_Description

--ORDER FULFILMENT
--The average time taken for orders to be shipped (real shipping days)
SELECT AVG(Days_for_shipping_real) AS Average_shipping_days
FROM Supply_Chain

--How the actual shipping time compare to the scheduled shipping time
SELECT
	AVG(Days_for_shipping_real) AS Average_actual_shipping_days,
	AVG(Days_for_shipment_scheduled) AS Average_scheduled_shipping_days
FROM Supply_Chain

--The percentage of orders are shipped late compared to the scheduled shipping time
SELECT
	 CASE
		WHEN Days_for_shipping_real > Days_for_shipment_scheduled THEN 'Shipped Late'
		ELSE 'Shipped_Promptly'
	END AS Shipping_Status,
	(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Supply_Chain)) AS percentage
FROM Supply_Chain
GROUP BY CASE
		WHEN Days_for_shipping_real > Days_for_shipment_scheduled THEN 'Shipped Late'
		ELSE 'Shipped_Promptly'
	END

--Is there a correlation between late deliveries and customer satisfaction (sales per customer)
--Create a shipping_status column
ALTER TABLE Supply_Chain
ADD shipping_status VARCHAR(20)
--Insert data into the shipping_status based on a CASE statment to identify Satisfied and Not_satisfied customers
UPDATE Supply_Chain
SET shipping_status = 
	CASE 
		WHEN Days_for_shipping_real > Days_for_shipment_scheduled THEN 'Late Deliveries'
			ELSE 'Perfect Deliveries'
		END
--Correlation between late deliveries and customer satisfaction (Customer is only satisfied if the customer sales is more than 200 and the shipping status is perfect delivery.
SELECT
	Customer_Fname,
	Sales_per_customer,
	shipping_status,
	CASE 
		WHEN Sales_per_customer > '200' AND shipping_status = 'Perfect Deliveries' THEN 'Satisfied_Customers'
		ELSE 'Not_Satisfied_Customers'
	END AS Customer_Satisfaction
	FROM Supply_Chain

--CUSTOMER SATISFACTION AND LOYALTY:
--What is the average benefit per order for each customer segment?
SELECT Customer_Segment, AVG(Benefit_per_order) Benefit
FROM Supply_Chain
GROUP BY Customer_Segment
ORDER BY Benefit DESC

--Are there any correlations between late deliveries and customer segments



--How the late delivery risk vary across different customer segments or regions
ALTER TABLE Supply_Chain
ALTER COLUMN Late_delivery_risk INT;

SELECT Customer_Segment, SUM(Late_delivery_risk) Late_Delivery_Risk
FROM Supply_Chain
GROUP BY Customer_Segment
ORDER BY Customer_Segment DESC

--INVENTORY MANAGEMENT:
--The top-selling product categories and their corresponding sales
SELECT TOP 10 Product_Category_Id, SUM(Sales) Category_Sales
FROM Supply_Chain
GROUP BY Product_Category_Id
ORDER BY Category_Sales DESC

--Is there a seasonal trend in sales for certain product categories?

--Products with consistently high profit ratios or margins?
Select TOP 10 Product_Name, Avg(Order_Item_Profit_Ratio) AVG_Profit_Ratio, COUNT(Order_Id) No_of_Orders
FROM Supply_Chain
GROUP BY Product_Name
ORDER BY AVG(Order_Item_Profit_Ratio)DESC

--SHIPPING EFFICIENCY AND COST ANALYSIS
--What is the average shipping time for each shipping mode?
SELECT AVG(Days_for_shipping_real) avg_shipping_days, Shipping_Mode
FROM Supply_Chain
GROUP BY Shipping_Mode

--Difference in shipping costs between different shipping modes?

--Regions with delivery delays?
SELECT DISTINCT Order_Region, Delivery_Status
FROM Supply_Chain
WHERE Delivery_Status = 'Late delivery'

--OPERATIONAL EFFICIENCY
--Distribution of orders by department and category?
SELECT Department_Name, Category_Name, COUNT(Order_Id) Orders
FROM Supply_Chain
GROUP BY Category_Name,Department_Name
Order BY Orders DESC

--Departments or categories with higher late delivery risks?
SELECT DISTINCT Department_Name, Category_Name, Late_delivery_risk
FROM Supply_Chain
WHERE Late_delivery_risk = '1'

--Correlation between order status and department efficiency

--GEOGRAPHIC ANALYSIS
--Top markets in terms of sales revenue?
SELECT Market, Sum(Sales) Revenue
FROM Supply_Chain
GROUP BY Market
ORDER BY Revenue DESC

--Geographic regions with lower sales but higher shipping costs?

--Distribution of orders across different regions and countries?
SELECT Order_Region, Order_Country, Count(Order_Id) Orders
FROM Supply_Chain
GROUP BY Order_Region, Order_Country
ORDER BY Orders DESC

--RISK MANAGEMENT
--Product categories or departments with consistently high late delivery risks?
SELECT 
	Category_Name,
	Department_Name,
	COUNT(Late_delivery_risk) Late_Delivery_Risk
FROM Supply_Chain
WHERE Late_delivery_risk ='1'
GROUP BY Category_Name, Department_Name
ORDER BY Late_Delivery_Risk DESC

--Correlation between late deliveries and order profitability
SELECT Order_Profit_Per_Order, Late_delivery_risk
FROM Supply_Chain
WHERE Late_delivery_risk ='1'

--Late delivery risk impact on customer retention and future sales?


SELECT *
FROM Supply_Chain
ORDER BY shipping_date_DateOrders DESC
	CASE
		WHEN(


SELECT Shipping_Mode, COUNT(Shipping_Status) Shipping_Status
FROM Supply_Chain
GROUP BY Shipping_Mode
ORDER BY Shipping_Status DESC

UPDATE Supply_Chain
SET shipping_status = 'Timely Deliveries'
WHERE shipping_status = 'Perfect Deliveries'

SELECT AVG(days_for_shipping_real) Average_days, shipping_mode
FROM Supply_chain
GROUP BY shipping_mode

SELECT DISTINCT Market, shipping_status
FROM Supply_Chain
WHERE shipping_status = 'Late Deliveries'

UPDATE Supply_Chain
ADD Column AS 

