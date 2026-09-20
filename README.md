# sql-layoffs-data-cleaning
SQL data cleaning project using MySQL and the layoffs dataset.


## About the Project

I used MySQL to clean a layoffs dataset and prepare it for further analysis.

The main goal was to find duplicate records, fix inconsistent data, handle missing values, and make the data more usable.

## What I Did

* Created a staging table so I could work on a copy of the original data.
* Found duplicate records using `ROW_NUMBER()`.
* Removed duplicate rows.
* Removed extra spaces from company names using `TRIM()`.
* Standardized industry names such as different versions of `Crypto`.
* Cleaned country names.
* Changed the date from text format to the MySQL `DATE` format.
* Changed blank industry values to `NULL`.
* Used a self-join to fill missing industry values when the same company had the industry information in another row.
* Removed rows where both `total_laid_off` and `percentage_laid_off` were missing.
* Removed the temporary `Row_num` column after cleaning.

## SQL Concepts Used

* CREATE TABLE
* INSERT
* SELECT
* UPDATE
* DELETE
* ALTER TABLE
* JOIN
* CTE
* ROW_NUMBER()
* TRIM()
* STR_TO_DATE()
*  NULL handling
* Window functions

## Tools

* MySQL
* MySQL Workbench

## Project File

The complete SQL queries used for the cleaning process are available in:

layoffs_data_cleaning.sql
