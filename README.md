# HR Data Analysis 2000-2015
Analysis of HR Data from 2000-2015 to determine key HR metrics, using MySQL and Power BI 

![FINAL_HR Data Analysis](https://github.com/JosanQui/HR-Data-Analysis-2000-2015/assets/173809528/7dfdc038-b910-4c9a-aab9-06a4bd826c5c)


## Data Source

+	CSV source file contains 22,214 employee records between 2000-2015, with employees working across 7 US states (Illinois, Indiana, Kentucky, Michigan, Ohio, Pennsylvania, Wisconsin)
+	Source file has required fields for analysis such as dates, gender, race, department, job title and location, etc.
+	Original source file credited to Irene Nafula (https://www.youtube.com/@herdataproject)

## Points of Interest

1.	Average length of employment for employees (job tenure)
2.	Turnover rate for each department (attrition)
3.	Employees working at headquarters vs remote locations
4.	Gender breakdown of employees in the company
5.	Gender distribution across age groups/departments
6.	Age distribution of employees in the company
7.	Employee distribution across locations (state)
8.	Race/ethnicity breakdown of employees in the company
9.	Net change in company's employee headcount over time (retention)

## Steps Taken

1.	Import CSV into MySQL Workbench for cleaning and transformation 
    +	Column name and type clean up
    +	Date transformations 
    +	Verification of query results
2.	Loading into Power BI for visualization
    +	Connecting SQL Server into Power BI
    +	Dates/Types and null value transformations
    +	Adding calculated columns, measures and date table
    +	Creation and formatting of final dashboard

## Summary of Findings

1.	Based on source file, the average job tenure for the company is around 7 years. 
2.	Auditing department shows the highest turnover rate (at 17.3%), followed by Legal (at 13.5%) which may be attributed to the low headcount vs. these departments’ employee departures. That said, turnover rate across the other departments are close to an average of around 11%.
3.	Around 75% of employees are working at the Headquarters (16,715), the rest in remote locations.
4.	In terms of gender, most employees are Males (11,288), followed by Females (10,321) and very minimally are Non-Confirming (605). This trend of Males as a leading gender is followed across age groups and departments.
5.	There is a close distribution of employees between the ages of 25-54, with age group 35-44 slightly leading at 6,055 employees, followed closely by ages 25-34 (5,999) and ages 45-54 (5,987).
6.	Majority of employees come from Ohio (18,025), followed by Pennsylvania as distant second (1,115).  
7.	Majority of the employees are of White ethnicity (6,328), and for the least part by American Indian/Alaskan Native (1,327), as well as Native Hawaiian/Pacific Islanders (1,229).
8.	Except for the fluctuation between 2000-2003, employee retention has been on an increasing trend from 2004 (82%) until 2020 (97%).

## Project Takeaways

+	Date transformations have proven to be complicated esp. since dates in source files are either in ‘%-%’ and ‘%/%’ format
+	It helps to verify and tally the total number of employees vs. currently employed vs. non-employed in each date transformation query to ensure you are on the right track
