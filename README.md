
✨ **Project Overview**
This project focused on estimating the severity of auto insurance claims by predicting which claims would exceed $1000. It was part of a hackathon where my team and I developed a predictive model combining analytical accuracy with the ability to communicate results effectively to non-technical stakeholders.

✨ **Key Notes**
- Tools used: R programming language
- Predicted whether auto insurance claims would exceed $1,000 using logistic regression as part of the ASNA 2025 Hackathon (my team placed top 15 with 88.828% accuracy)
- Cleaned and preprocessed 9,134 records by removing outliers and handling missing values before building predictive model
- Built a Generalized Linear Model (GLM) using logistic regression to classify high-risk (1) vs. low-risk (0) claims
- Identified key predictive variables (ie Vehicle Size, Income, Gender, and Customer Lifetime Value)
- Provided clear, actionable insights to help insurers flag high-risk customers, optimize pricing, and streamline claims processes
- Emphasized model interpretability to ensure understanding across both technical and non-technical stakeholders

✨ **Dataset Description**
We worked with a dataset of 9,134 records which included various customer demographics, policy features, and claim performance metrics. Key variables included Vehicle Size, Gender, Customer Lifetime Value, and more. These features provided a comprehensive look at the insurance landscape and customer behavior.

✨ **Tools & Techniques**
The analysis was conducted using the programming language R. Our key steps are data cleaning, selecting important features, and developing our model. To help answer a simple yes-or-no question (will a claim go over $1000), we used Generalized Linear Model (GLM) with logistic regression. 

✨ **Analysis & Insights**
First, we cleaned the data by removing outliers and filling in or removing missing values to ensure it was ready for analysis. Then, we tested how well our model was performing by comparing its predictions with the actual claim outcomes. We also identified the most important features that influenced high-cost claims, such as income, vehicle size, and other customer details (income, education, etc). Finally, we applied our model to a new dataset to predict which customers were likely to make large claims. If a customer had more than 50% chance of making a claim over $1,000, we labeled them as high risk (1), and if less, we labeled them as low risk (0). This binary system helped us quickly & clearly identify customers who might pose higher risk.

The model provided each customer with a risk probability, giving insurers a practical tool for identifying and addressing high-risk claims before they happen. Our accuracy score in this competition was 88.828 % placing us in the top 15. 

✨ **Business Impact**
Our model helps insurers proactively identify high-risk claims, supporting smarter pricing strategies, improved customer targeting, and more efficient claims processing. We also emphasized clear model interpretation to make results accessible for stakeholders without modeling expertise.

**Summary**
As part of the ASNA 2025 Hackathon, my team placed in the top 15 for predicting whether auto insurance claims would exceed $1,000 using R, achieving 88.83% accuracy. I cleaned and preprocessed 9,134 records by handling missing values and outliers, then built a GLM model to identify key predictors (e.g., income) to help insurers flag high-risk customers and optimize pricing
