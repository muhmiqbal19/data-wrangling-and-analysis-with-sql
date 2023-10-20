# Data Wrangling and Analysis With SQL

## Project Overview
So, here is a dataset of the website of a company I might work for, just call it **“imaginary store”**. They have some items which can be viewed and hopefully purchased by the users. 

In order to purchase an item, a visitor must first create an account be logged in and then add the item to their cart and then check out.

This data analysis project aims to provide insight into the sales, marketing, and product performance of an e-commerce company over the current year. By analyzing the various aspects of user activity and sales data, we seek to identify trends, make data-driven recommendations, and gain a deeper understanding of the company's performance. 

## Dataset Entity Relationship Diagram (ERD)
![imaginary store](https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/23474a8d-cc96-4739-97ef-06eef8c25fd0)

### Tools
- [MySQL Workbench](https://www.mysql.com/products/workbench/) - Data wrangling & analysis
- [Mode Analytics](https://mode.com/) - Data visualization from SQL query

### Data Cleansing
In the initial data preparation phase, we performed the following:
1. Loading the data
2. Identifying unreliable data and null
3. Filtering and formatting while analyzing the data

### Exploratory Data Analysis (EDA)
EDA involved exploring user activity data and sales data to answer key questions and ideas, such as:

1. How many users do we add each day?
2. How many orders each day? What is the trend over a period?
3. We should email people a picture of what they looked at most recently!
4. How many times do users re-order a specific item?
5. How many times do users re-order an item from a specific category?
6. How long between orders and re-orders?

In order answering questions, we analyse:
- [Users Growth](users-growth.sql) to answer question 1
- [Rolling Orders](rolling-orders.sql) to answer question 2
- [Promo Email](promo-email.sql) to respone idea 3
- [Product Analysis](product-analysis.sql) to answer question 4, 5, & 6

## Data Analysis

### 1. Users Growth Analysis
<img width="818" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/608def66-8d13-4313-a0d8-25326e0b2a7a">

<img width="730" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/002e8abb-f4c1-4f43-842a-0bfe638f26d9">

### 2. Rolling Orders Analysis
<img width="837" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/d7766bf3-6ad7-44df-a7fe-765531e31e8f">

### 3. Promo Email Analysis
<img width="488" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/1ff31b4a-c5a3-41d1-8e50-9feb0e028e2d">

### 4. Product Analysis
<img width="600" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/3cc5f479-1073-42e6-9483-03220dc80c1a">


<img width="1137" alt="image" src="https://github.com/muhmiqbal19/data-wrangling-and-analysis-with-sql/assets/132751713/cb51b352-a91b-4a4e-8c5a-1a85f503b09f">


### Result


### Recommendation
