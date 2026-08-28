# IBM HR Analytics Employee Attrition Analysis

[![Python](https://img.shields.io/badge/Python-3.9%2B-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![Google Colab](https://img.shields.io/badge/Google%20Colab-Notebook-F9AB00?logo=googlecolab&logoColor=white)](https://colab.research.google.com/)
[![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-CC2927?logo=microsoftsqlserver&logoColor=white)](https://www.microsoft.com/sql-server)
[![License: MIT](https://img.shields.io/badge/License-MIT-2ea44f.svg)](LICENSE)

An end-to-end HR analytics project that investigates employee attrition using Python, SQL, and data visualization. The analysis identifies the employee groups and workplace conditions most associated with turnover, then translates those patterns into practical retention recommendations.

> **Project:** NTI26 Graduation Project<br>
> **Dataset:** IBM HR Analytics Employee Attrition & Performance<br>

## Table of Contents
- [Project Overview](#project-overview)
- [Dataset & Data Preparation](#dataset--data-preparation)
- [Analytical Workflow](#analytical-workflow)
  - [1. Data Cleaning](#1-data-cleaning)
  - [2. Data Exploration](#2-data-exploration)
  - [3. Exploratory & Diagnostic Analysis](#3-exploratory--diagnostic-analysis)
- [Key Findings](#key-findings)
- [Business Insights](#business-insights)
- [Recommendations](#recommendations)
- [Complete Report & Presentation](#complete-report--presentation)
- [Tech Stack](#tech-stack)
- [Folder Structure](#folder-structure)
- [Installation](#installation)
- [Usage](#usage)
- [Team Members](#team-members)
- [License](#license)

---

## Project Overview

The company has a high employee attrition rate, which drives up hiring and training costs and causes the loss of experienced workers, ultimately reducing productivity and affecting business performance. HR wants to understand **why** employees leave and identify the main factors that lead to employee attrition, so that targeted retention strategies can be developed.

This project analyzes the **IBM HR Analytics Employee Attrition & Performance** dataset to answer that question and provide data-driven recommendations to improve employee retention. The workflow moves from raw data quality checks to cleaned data, exploratory analysis, SQL validation, and stakeholder-facing findings.

### Questions addressed

- Which departments, job roles, and working conditions have the highest attrition rates?
- How are overtime, job satisfaction, work-life balance, tenure, and income related to attrition?
- Which employee segments should HR prioritize for retention initiatives?

---

## Dataset & Data Preparation

- **Source:** Kaggle — IBM HR Analytics Employee Attrition & Performance
- **Rows:** 1,470 employees
- **Columns:** 35 raw columns; 31 retained for analysis after removing zero-variance and identifier columns
- **Target variable:** `Attrition` (Yes/No)

<details>
<summary><strong>Full column dictionary</strong> (click to expand)</summary>

| Column | Description |
|---|---|
| Age | Employee's age in years. |
| Attrition | Indicates whether the employee left the company (Yes/No). |
| BusinessTravel | Frequency of business travel (Travel_Rarely, Travel_Frequently, Non-Travel). |
| DailyRate | Employee's daily salary rate. |
| Department | Department where the employee works. |
| DistanceFromHome | Distance between the employee's home and workplace (in miles). |
| Education | Employee's education level (1 = Below College, 5 = Doctor). |
| EducationField | Field of study or educational specialization. |
| EmployeeCount | Number of employees (constant value, usually 1). |
| EmployeeNumber | Unique identifier assigned to each employee. |
| EnvironmentSatisfaction | Employee's satisfaction with the work environment (1 = Low, 4 = Very High). |
| Gender | Employee's gender. |
| HourlyRate | Employee's hourly pay rate. |
| JobInvolvement | Level of involvement in the job (1 = Low, 4 = Very High). |
| JobLevel | Employee's job level within the organization. |
| JobRole | Employee's job position or role. |
| JobSatisfaction | Employee's satisfaction with their job (1 = Low, 4 = Very High). |
| MaritalStatus | Employee's marital status (Single, Married, Divorced). |
| MonthlyIncome | Employee's monthly income. |
| MonthlyRate | Monthly salary rate. |
| NumCompaniesWorked | Number of companies the employee worked for before joining the current company. |
| Over18 | Indicates whether the employee is over 18 years old (constant value). |
| OverTime | Indicates whether the employee works overtime (Yes/No). |
| PercentSalaryHike | Percentage increase in salary from the previous year. |
| PerformanceRating | Employee's performance rating (3 = Good, 4 = Excellent). |
| RelationshipSatisfaction | Employee's satisfaction with workplace relationships (1 = Low, 4 = Very High). |
| StandardHours | Standard working hours (constant value). |
| StockOptionLevel | Employee's stock option level. |
| TotalWorkingYears | Total years of professional work experience. |
| TrainingTimesLastYear | Number of training sessions attended during the last year. |
| WorkLifeBalance | Employee's work-life balance rating (1 = Bad, 4 = Best). |
| YearsAtCompany | Number of years the employee has worked at the company. |
| YearsInCurrentRole | Number of years in the current job role. |
| YearsSinceLastPromotion | Number of years since the last promotion. |
| YearsWithCurrManager | Number of years working with the current manager. |

</details>

---

## Analytical Workflow

### 1. Data Cleaning
*(`python/01_data_cleaning.ipynb`)*

- **Initial audit:** confirmed 1,470 rows × 35 columns, **0 duplicate records**, and **0 missing values** — no imputation for missingness was required.
- **Data types:** confirmed 26 numeric and 9 object/string columns, with no incorrect data types detected.
- **Column pruning:** dropped 4 uninformative columns — `EmployeeCount`, `Over18`, `StandardHours` (zero-variance / constant) and `EmployeeNumber` (ID column) — leaving 31 columns.
- **Type optimization:** cast all categorical/text columns (`Attrition`, `Department`, `JobRole`, `OverTime`, etc.) to pandas `category` dtype.
- **Output:** cleaned dataset exported to `data/cleaned_data.csv`.

### 2. Data Exploration
*(`python/01_data_cleaning.ipynb`)*

- **Statistical summary:** ages range 18–60 (mean ≈ 36.9); monthly income ranges $1,009–$19,999 (mean ≈ $6,503); total working years range 0–40.
- **Class imbalance:** the target is imbalanced ~5:1 — **83.88% retained (1,233)** vs. **16.12% attrition (237)** — a factor kept in mind when interpreting group-level rates.

### 3. Exploratory & Diagnostic Analysis
*(`python/02_data_analysis.ipynb`, mirrored in `sql/02_data_analysis.sql`)*

Each business question below was answered with a `groupby`/cross-tab in pandas and validated against an equivalent SQL query:

| # | Question |
|---|---|
| 1 | What is the attrition rate by department, job role, and overtime status? |
| 2 | What is the average monthly income by job level and attrition status? |
| 3 | Which employees combine low job satisfaction with frequent overtime? |
| 4 | Which department has the highest attrition, and how does it break down by job role? |
| 5 | How does attrition vary across tenure groups (`YearsAtCompany`)? |
| 6 | Is attrition associated with overtime status? |
| 7 | How do income, job satisfaction, and work-life balance compare between leavers and stayers? |

---

## Key Findings

The dataset contains a meaningful class imbalance, so the results below are reported as group-level attrition rates rather than counts alone.

| Metric | Result |
|---|---|
| Overall attrition rate | **16.12%** (237 of 1,470 employees) |
| Highest-attrition department | **Sales — 20.63%** (HR 19.05%, R&D 13.84%) |
| Highest-attrition job role | **Sales Representative — 39.76%** (Laboratory Technician 23.94%, Human Resources 23.08%; Manager 4.90% and Research Director 2.50% were lowest) |
| Sales dept. breakdown | Sales Representative 39.76% · Sales Executive 17.48% · Manager 5.41% |
| Overtime vs. no overtime | **30.53%** vs. **10.44%** attrition (~3x higher with overtime) |
| Low satisfaction + overtime | 35.71%–37.68% attrition (more than double the company average) |
| Attrition by tenure | 0–2 yrs: **29.82%** · 3–5 yrs: 13.82% · 6–10 yrs: 12.28% · 11–15 yrs: 6.48% · 16+ yrs: 9.42% |
| Avg. monthly income, leavers vs. stayers | **$4,787** vs. **$6,833** (roughly a 30% gap) |
| Avg. job satisfaction (1–4), leavers vs. stayers | 2.47 vs. 2.78 |
| Avg. work-life balance (1–4), leavers vs. stayers | 2.66 vs. 2.78 |
| Income by job level | Rises from about $2,700 at Level 1 to roughly $19,300 at Level 5; the leaver/stayer income gap is inconsistent across levels |

---

## Business Insights

- **Sales is the highest-risk department**, and the problem is concentrated in Sales Representatives, who leave at more than 7x the rate of Sales Managers.
- **Overtime is strongly associated with attrition** — employees who work overtime leave at roughly three times the rate of those who do not, with risk exceeding 35% among employees reporting low job satisfaction.
- **The first two years are the highest-risk tenure window** — attrition drops sharply through 11–15 years, then ticks up modestly among employees with 16+ years at the company.
- **Attrition appears multifactorial** — leavers earn less and report lower job satisfaction and slightly lower work-life balance, but the income relationship is inconsistent across job levels, so salary alone is unlikely to explain turnover.

---

## Recommendations

- Reduce excessive overtime, especially within the Sales department, and monitor workload to prevent burnout.
- Prioritize retention strategies for Sales Representatives, including a review of sales targets, workload, performance expectations, coaching, and career progression.
- Strengthen onboarding, mentoring/buddy programs, and regular check-ins during employees' first two years.
- Increase engagement and job satisfaction through recognition, career development, surveys, and one-on-one check-ins, especially for employees combining low satisfaction with overtime.
- Review compensation competitiveness for lower-income groups and investigate income equity at Job Level 3, where leavers earned more than stayers.
- Continue work-life balance initiatives and investigate the modest attrition uptick among employees with 16+ years at the company.

---

## Complete Report & Presentation

For a detailed explanation of the project methodology, analysis, findings, and recommendations, see the [complete project report](docs/pdf/report.pdf).

For a concise visual overview of the project, analysis, findings, and recommendations, see the [complete project presentation](docs/pdf/presentation.pdf).

---

## Tech Stack

- **SQL:** T-SQL business-question queries mirroring the Python analysis
- **Python:** pandas, numpy, matplotlib, seaborn (data cleaning & EDA)
- **Google Colab:** reproducible notebook-based analysis workflow
- **PDF:** complete project presentation and detailed report

---

## Folder Structure

```
NTI26_Graduation_Project
│
├── data
│   ├── cleaned_data.csv               # Cleaned dataset after preprocessing
│   └── raw_data.csv                   # Original raw dataset
│
├── dashboards                         # Dashboard workspace
│   ├── dashboard.pbix                 # Power BI dashboard file
│   └── dashboard.xlsx                 # Excel dashboard file
│
├── docs
│   ├── presentation.pdf               # Complete project presentation
│   └── report.pdf                     # Detailed project report
│
├── python
│   ├── 01_data_cleaning.ipynb         # Colab notebook for data cleaning and preprocessing
│   └── 02_data_analysis.ipynb         # Colab notebook for data analysis and visualization
│
├── sql
│   ├── 01_database.sql                # SQL script for database creation and initial setup
│   └── 02_data_analysis.sql           # SQL script for data analysis
│
├── requirements.txt                   # List of Python dependencies required for the project
├── .gitignore
├── LICENSE
└── README.md
```

## Installation

### Prerequisites

- Google account with access to Google Colab
- SQL Server (optional, for running the T-SQL scripts)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/Mohammed-3tef/NTI26_Graduation_Project
   ```

2. Navigate to the project directory:
   ```bash
   cd NTI26_Graduation_Project
   ```

3. Open the notebooks from the `python` folder in [Google Colab](https://colab.research.google.com/).

4. Install the required Python packages in a Colab cell:
   ```bash
   !pip install -r requirements.txt
   ```

---

## Usage

1. Run `python/01_data_cleaning.ipynb` in Google Colab to audit and clean `data/raw_data.csv`. The notebook writes `data/cleaned_data.csv`.
2. Run `python/02_data_analysis.ipynb` to reproduce the exploratory and diagnostic analysis.
3. Execute `sql/01_database.sql` and then `sql/02_data_analysis.sql` in SQL Server when SQL validation is required.
4. Review the findings and recommendations in this README and the generated notebook outputs.

The SQL scripts are designed for SQL Server and create the `HRAttritionDB` database and analysis objects used by the project.

---

## Team Members

| Name | GitHub Username |
|------|-----------------|
| Hla Hany | [@hlahany2005-ux](https://github.com/hlahany2005-ux) |
| Mohammed Atef | [@Mohammed-3tef](https://github.com/Mohammed-3tef) |
| Mahmoud Hassan | [@mahmoud-hassan77](https://github.com/mahmoud-hassan77) |
| Youssef Aly | [@youssefalyy99](https://github.com/youssefalyy99) |

## License

See [LICENSE](LICENSE) for the project license.