/*****************************************************************************
* Project Name : NTI26 Graduation Project
* File Name    : 02_data_analysis.sql
* Description  : Analytical queries, business intelligence KPIs, aggregation metrics,
*                and reporting views for project insights and dashboard.
* Note         : You should run this file after running 01_database.sql to ensure 
*                the database schema and initial data are in place.
******************************************************************************/

use HRAttritionDB;
go

-- Q_Exploration
-- Understand overall attrition rate and how it varies across departments

select 
    count(*) as Total_Emps,
    sum(case when Attrition = 1 then 1 else 0 end) as Emps_Left,
    sum(case when Attrition = 0 then 1 else 0 end) as Emps_Right,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as Attrition_Rate
from Employees;
go

------------------------------------------------------------------------
-- Q3_Business Questions
-- Q1.A: What is the attrition rate by department?
select 
    Department,
    count(*) as Total_Emps,
    sum(case when Attrition = 1 then 1 else 0 end) as Emps_Left,
     
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as Attrition_Rate
from Employees
group by Department
order by Attrition_Rate desc;
go

-- Q1.B: What is the attrition rate by job role?
select 
    JobRole,
    count(*) as Total_Emps,
    sum(case when Attrition = 1 then 1 else 0 end) as Emps_Left,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as Attrition_Rate
from Employees 
group by JobRole
order by Attrition_Rate desc;
go

-- Q1.C: What is the attrition rate by overtime status?
select 
    case
        when OverTime = 1 then 'Yes'
        else 'No'
    end as OverTime_Status,
    count(*) as Total_Emps,
    sum(case when Attrition = 1 then 1 else 0 end) as Emps_Left,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as Attrition_Rate
from Employees 
group by OverTime
order by Attrition_Rate desc;
go

------------------------------------------------------------------------
--Q2: What is the average monthly income by job level and attrition status?
select 
    JobLevel,
    case
        when Attrition = 1 then 'Left'
        else 'Stayed'
    end as AttritionStatus,
    cast(avg(MonthlyIncome) as decimal(10,2)) as Avg_MonthlyIncome
from Employees
group by
    JobLevel,
    Attrition
order by
    JobLevel,
    AttritionStatus;
go

------------------------------------------------------------------------
--Q3: Which employees combine low job satisfaction with frequent overtime?
select 
    JobSatisfaction,  
    case
        when OverTime = 1 then 'Yes'
        else 'No'
    end as OverTimeStatus,
    count(*) as Total_Emps,
    sum(case when Attrition = 1 then 1 else 0 end) as Emps_left,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as AttritionRate
from Employees
where JobSatisfaction <= 2
and OverTime = 1
group by 
        JobSatisfaction,
        OverTime
order by
        JobSatisfaction;
go

------------------------------------------------------------------------
-- Q4.A: Which department has the highest attrition,
select top 1
    Department,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100
        / count(*)
        as decimal(5,2)
    ) as AttritionRate
from Employees
group by Department
order by AttritionRate desc;
go

-- Q4.B: How does it break down by job role within that department?
--       based on result that department has the highest attrition is /**SALES**/
select 
    JobRole,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as AttritionRate
from Employees
where Department = 'Sales'
group by JobRole
order by AttritionRate desc;
go

------------------------------------------------------------------------
-- Q4_Diagnostic Analytics
-- Q1: Bucket "years at company" into tenure groups and compute 
--     attrition rate per group
select 
    case
        when YearsAtCompany <= 2 then '0-2 Years'
        when YearsAtCompany <= 5 then '3-5 Years'
        when YearsAtCompany <= 10 then '6-10 Years'
        when YearsAtCompany <= 15 then '11-15 Years'
        else '16+ Years'
    end as TenureGroup,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as AttritionRate
from Employees
group by
    case
        when YearsAtCompany <= 2 then '0-2 Years'
        when YearsAtCompany <= 5 then '3-5 Years'
        when YearsAtCompany <= 10 then '6-10 Years'
        when YearsAtCompany <= 15 then '11-15 Years'
        else '16+ Years'
    end;
go

------------------------------------------------------------------------
-- Q2: Cross-tabulate overtime status against attrition, and job 
--     satisfaction score against attrition
select
    case
        when OverTime = 1 then 'Yes'
        else 'No'
    end as OverTime_Status,
    sum(case when Attrition = 1 then 1 else 0 end) as Emps_Left,
    sum(case when Attrition = 0 then 1 else 0 end) as Emps_Right
from Employees
group by OverTime;
go

------------------------------------------------------------------------
-- Q3: Compare average income, satisfaction, and work-life balance scores 
--     between employees who left vs. stayed
select 
    case
        when Attrition = 1 then 'Left'
        else 'Stayed'
    end as AttritionStatus,
    avg(MonthlyIncome) as Avg_Income,
    avg(JobSatisfaction) as Avg_Satisfaction,
    avg(WorkLifeBalance) as Avg_WorkLife_Balance
from Employees
group by Attrition;
go

------------------------------------------------------------------------
-- Q4: Drill into the highest-attrition department by job role to find the specific driver
--     from question 4 we kown the highest-attrition is 'sales' department.
select 
    JobRole,
    cast(
        sum(case when Attrition = 1 then 1 else 0 end) * 100.0
        / count(*)
        as decimal(5,2)
    ) as AttritionRate
from Employees
where Department = 'Sales'
group by JobRole
order  by AttritionRate desc;
go

--End Question