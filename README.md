# Data Wrangling and Analysis With SQL
## Table of Content
- [Project Overview](#project-overview)
- [Dataset Entity Relationship Diagram (ERD)](#dataset-entity-relationship-diagram-erd)
- [Tools](#tools)
- [Data Cleansing](#data-cleansing)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
- [Data Analysis](#data-analysis)
- [Result](#result)
- [Recommendation](#recommendation)
- [Limitation](#limitation)

## Project Overview
So, here is a dataset of the website of a company I might work for, just call it **“imaginary store”**. The data extracted from January 1, 2013 to June 1, 2018. They have some items which can be viewed and hopefully purchased by the users. 

In order to purchase an item, a visitor must first create an account be logged in and then add the item to their cart and then check out.

This data analysis project aims to provide insight into the sales, marketing, and product performance of an e-commerce company over the current year. By analyzing the various aspects of user activity and sales data, we seek to identify trends, make data-driven recommendations, and gain a deeper understanding of the company's performance. 

## Dataset Entity Relationship Diagram (ERD)
![imaginary store](https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/23474a8d-cc96-4739-97ef-06eef8c25fd0)

### Tools
- [MySQL Workbench](https://www.mysql.com/products/workbench/) - Data wrangling & analysis
- [Mode Analytics](https://mode.com/) - Data visualization from SQL query
- [Stats Chart](https://statscharts.com/) - Data visualization

### Data Cleansing
In the initial data preparation phase, we performed the following:
1. Loading the data
2. Identifying unreliable data and null
3. Filtering and formatting while analyzing the data

### Exploratory Data Analysis (EDA)
EDA involved exploring user activity data and sales data to answer key questions and ideas, such as:

1. How many users do we add each day?
2. How many orders each day? What is the trend over a period?
3. How do we can increase sales? 
4. How many times do users re-order a specific item?
5. How many times do users re-order an item from a specific category?
6. How long between orders and re-orders?

In order answering questions, we analyse:
- [Users Growth](users-growth-analysis.sql) to answer question 1
- [Rolling Orders](rolling-orders-analysis.sql) to answer question 2
- [Promo Email](promo-email-analysis.sql) to respone idea 3
- [Product Analysis](product-analysis.sql) to answer question 4, 5, & 6

## Data Analysis

### 1. Users Growth Analysis
<img width="1139" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/9e2ac325-022e-4719-a5f3-61188e3462fb">

<img width="750" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/b71b0cac-c11c-424b-8815-9eeb9c50f6b6">

### 2. Rolling Orders Analysis
<img width="1140" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/10427a05-f4db-4a7a-be55-326359dce69f">

<img width="1140" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/839ae5ac-58c4-405a-9351-8dbe9bedf238">

### 3. Promo Email Analysis
<img width="680" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/0e0098aa-f1a0-481a-8df1-3409c962e33f">

### 4. Product Analysis
<img width="600" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/3cc5f479-1073-42e6-9483-03220dc80c1a">

<img width="500" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/f118bdee-f91e-4f4d-8879-84e2ca3bc262">

### Result
1. Today, we have acquired 96 users. However, 3 users have been deleted and 2 users have been merged. So, we have 91 net-added users today. This number is 6.19% lower than yesterday.
2. Today, we have 4 orders with 11 items ordered, we are in the trench but still stable in 7 days of rolling orders.
3. We have 146 users who recently viewed an item this year and have not placed an order yet. 
4. Users order the device storage unit 1,1 times on average. People tend to look for another product for second items.
5. Users order apparatus 2,4 times on average. Whenever people order apparatus, they tend to buy multiple items from that category.
6. Times between order and reorder vary from 0 to 197 days. The majority of our users' behavior is reordering in less than 1 month, there also in 1-3 months, the others reorder for 3 to 7 months.

### Recommendation
1. Invest in sales and marketing during the peak of users added to increase revenue.
2. We are in a safe sales position as long as rolling orders are still stable. Instead of worrying about the local trench, we should increase marketing during peak sales season to increase rolling orders.
3. We should email people a picture of what they looked at most recently! Probably it will be a reason for them to come back to our site and place an order.
4. We should increase product diversity to increase revenue.
5. While people are in the middle of ordering apparatus, we will recommend other apparatus to them. This might cause they are not to order it in second time on a different date but they might potentially add it to their order.
6. We can recommend the other product in the same category as the last items they ordered.

### Limitation
This data wrangling and analysis project is totally conducted in SQL which is poor in visualizations except for exporting the file and then visualizing in Tableau, Power BI, etc. Therefore we only provide data visualization in a separate way not in one dashboard.
