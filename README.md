# About the Project

This project was started in the summer of 2021 with the goal of creating a database of financial data for publicly traded companies to help systematized and enhanced investment decision-making. The system is using algorithm developed around value-investing principles and examines rates of improvement for various metrics.

After 7 months of development 2 ETLs tools were developed to easily extract data from online databases, a robust Dev database was developed, and the project has a clear path forward. 

# High-level Metrics

Currently the database comprise data for around 200 companies. Data includes quarterly data for financials ( Cash Flow statements, Income statements, Balance Sheet). And daily pricing info( High/Low, Open/Close, Volume).

# Team Dynamic

Roles	                          Name	            Email
Product Owner - Data Engineer	  Kevin Corcoran	  kevin.corcoran@hotmail.com

# Contents

- Pre-requisite
-	Tools & Technologies
-	How to run the project
-	Database Structure
-	Future work
-	Things to consider
-	Discussions

## Pre-requisite:

-	Python [v 3.7 or greater] : https://www.python.org/downloads/
-	Sublime Text [current build] : https://www.sublimetext.com
-	pgAdmin 4 [v 5.7 ] : https://www.pgadmin.org/download/
-	Set QUICKFS_SYS_VAR environment variable
-	Subscribe to QuickFS https://quickfs.net/home

## Tools & Technologies

-	Python3 and PostgreSQL (language)

## How to run the project

1.	Complete pre-requisites
2.	Run Python tools to obtain .csv outputs
    -	quickfs_financials_to_csv.py
    -	yfinance_pricing.py
3.	Create tables and Views.
4.	Import .csv output to SQL

## Database Structure**

This ERD depicts the current database model.
Blue cells : tables.
Pink : materialized views
Green : views
 

-	Level 1 – Base Level
  -	This level contains tables for the raw Financials and Pricing data. “DATA”.”DATA_QUATERLY_MASTER_STAGING” to be used for Financials data refresh. 
  
-	Level 2 – Lower-Level Views
  -	This level structures the data from each dataset. Pricing data is summed up by month then quarter, then joined to Financials data in “ANALYTICS”.”        vQUARTERLY_MASTER_TTM_MATERIALIZED” . Data is then aggregated as follow:
    -	Year 1 : current quarter + its 3 most recent quarters
    -	Year 2 : current quarter 1 year ago + its 3 most recent quarters
    -	Year 3 …..
    
-	Level 3 – Mid-level Views
  - This level segregates various variables for analysis.

-	Level 4 – Top-level Views
  -	This level is used for data interpretation.

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
