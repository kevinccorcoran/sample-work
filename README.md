# About the Project

This project was started in the summer of 2021 with the goal of creating a database of financial data for publicly traded companies to systematize and enhance investment decision-making. The logic was developed around value-investing principles and measurements of rates of improvement for various metrics, and studies the relationship between them. 

After 7 months of development 2 ETLs tools were developed to extract big data from online databases for easy data refresh, and a robust Dev database was developed. Although more data engineering and data analytics is needed, the project has a clear path forward. 

Note: this GitHub repository contains the 2 ETLs tools, some of the SQL views and tables, and project documemts to showcase some of the work acomplished. Not all the project files are included. Additional information can be provided. .

# High-level Metrics

Currently the DEv database comprise data for around 200 companies. Data includes quarterly data for financials ( Cash Flow statements, Income statements, Balance Sheet). And daily pricing info( High/Low, Open/Close, Volume).

# Team Dynamic

1. Product Owner/Data Engineer
   - Kevin Corcoran
   - kevin.corcoran@hotmail.com

# Contents

- Pre-requisite
-	Tools & Technologies
-	How to run the project
-	Database Schema
-	Future work
-	Things to consider
-	Discussions

## Pre-requisite:

-	Python [v 3.7 or greater]: https://www.python.org/downloads/
-	Sublime Text [current build] : https://www.sublimetext.com
-	pgAdmin 4 [v 5.7 ]: https://www.pgadmin.org/download/
-	Set QUICKFS_SYS_VAR environment variable
-	Subscribe to QuickFS https://quickfs.net/home
-	Open Office Draw: https://www.openoffice.org/fr/Telecharger/

## Tools & Technologies

-	Python3 and PostgreSQL (language)

## How to run the project

1.	Go through pre-requisites
2.	Review ERD (/sample-work/Documents/ERD_dev_v3.odg)
3.	Run Python tools to obtain .csv outputs (/sample-work/ETL Tools/).
    -	quickfs_financials_to_csv.py
    -	yfinance_pricing.py
4.	Create SQL Tables and Views as follow (/sample-work/SQL/)
    1. Data
    2. Financials
    3. Historical
    4. Analytics
6.	Import .csv output to SQL.

## GitHub Content

- /sample-work/ETL Tools/

## Database Schema

This ERD depicts the current database schema for the Dev database. Schema will change. 
- Blue cells : tables.
- Pink : materialized views
- Green : views

![image](https://i.postimg.cc/hPNGgY47/ERD-dev-v3.png)

-	Level 1 – Base Level
    - This level contains tables for the raw Financials and Pricing data. “DATA”.”DATA_QUATERLY_MASTER_STAGING” to be used for Financials data refresh. 
  
-	Level 2 – Lower-Level Views
    - This level structures the data from each dataset. Pricing data is summed up by month then quarter, then joined to Financials data in “ANALYTICS”.”        vQUARTERLY_MASTER_TTM_MATERIALIZED” . Data is then aggregated as follow:
      - Year 1 : current quarter + its 3 most recent quarters
      - Year 2 : current quarter 1 year ago + its 3 most recent quarters
      - Year 3 …..
    
-	Level 3 – Mid-level Views
    - This level segregates various variables for analysis.

-	Level 4 – Top-level Views
    - This level is used for data interpretation.

## Future work

-	Complete views in Level 3 (est. 30h)
-	Analyze data Level 4
-	Develop additional views (e.g. ROE, ect) in Level 3 (est. 12h each)
-	Rethink database structure

## Things to consider

-	In lower levels use standard Views instead of materialized
-	Automate data refresh (scheduled tasks or psycopg2)
-	Create automated test-cases 
-	Develop visual reports
-	Why does quickfs_financials_to_csv.py fails for certain companies (i.e. AAPL)

## Discussion:
