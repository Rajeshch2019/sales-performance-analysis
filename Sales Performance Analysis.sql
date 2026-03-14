---- TOP 3  PRODUCTS SALES BY REGION----
SELECT *
FROM 
		( 
		SELECT 
				Region,
				Product_Name,
				sum(sales) as Total_Sales,
				ROW_NUMBER()over (partition by Region order by sum(sales) Desc) as Row_Num
				FROM	
				Data_sales
				group by region, Product_Name
				)t
	where Row_Num <= 3

---- Rank customers by sales -----
SELECT Top 10
Customer_Name,
Sum(Sales) as Total_Sales,
Rank()over(Order by sum(Sales)desc) as Sales_Rank
From Data_Sales
group by Customer_Name

----- Monthly Sales by Growth ----
SELECT
	Year(Order_date) as Year,
	Month(order_date) as MOnth,
	Sum(Sales) as Total_Sales,
	lag(sum(Sales))over(Partition  by Year(Order_date) order by Month(Order_Date)) as Previous_Month
	From Data_Sales
	group by  Year(Order_Date) ,MOnth(Order_Date)

------ Best Category by Region------
Select *
	from(
	   select 
            Region,
			Category,
			sum(Sales) as Total_Sales,
			Rank()over( Partition by Region order by sum(sales)desc) as Rank_Number
			From Data_Sales
			group by Category , Region
			)t
	where Rank_Number =1 

	---Running Total of Sales 
SELECT
		Year(Order_date) as Year,
		Month(Order_Date) as Month,
		Sum(Sales) as Total_Sales,
		Sum(Sum(sales))over(PARTITION  by Year(Order_Date) order by Month(Order_Date)) as Running_Total
From Data_Sales
Group by Year(Order_Date), Month(Order_Date)

