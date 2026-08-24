# NTI26_Graduation_Project

## Overview
This repository contains the data pipeline, analysis scripts, SQL queries, and documentation for the NTI26 Graduation Project.

## Folder Structure

```
NTI26_Graduation_Project
│
├── data
│   ├── cleaned_data.csv               # Cleaned dataset after preprocessing
│   └── raw_data.csv                   # Original raw dataset
│
├── dashboard
│   └── dashboard.xlsx                 # Excel dashboard summarizing key findings and visualizations
│
├── docs
│   ├── presentation.pptx              # Presentation slides for the project
│   └── documentation.pdf              # Detailed project documentation and methodology
│
├── python
│   ├── 01_data_cleaning.ipynb         # Jupyter notebook for data cleaning and preprocessing
│   └── 02_data_analysis.ipynb         # Jupyter notebook for data analysis and visualization
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
To set up the project environment, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/Mohammed-3tef/NTI26_Graduation_Project
   ```

2. Navigate to the project directory:
   ```bash
   cd NTI26_Graduation_Project
   ```

3. Install the required Python packages:
   ```bash
   pip install -r requirements.txt
   ```

4. Ensure you have a compatible SQL database set up and configured as per the SQL scripts provided in the `sql` folder.

5. Run the Jupyter notebooks in the `python` folder to perform data cleaning and analysis.

6. Open the `dashboard.xlsx` file to view the final results and visualizations.

7. Refer to the `docs` folder for additional documentation and presentation materials related to the project.
