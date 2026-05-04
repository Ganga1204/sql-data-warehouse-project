\# Data Catalog — SQL Data Warehouse



Last updated: May 2026

Owner: Ganga (github.com/Ganga1204)



\---



\## Overview



This warehouse processes 195,469 records from ERP and CRM source systems

through a Medallion Architecture into 3 analytical tables.



\---



\## dim\_customers

\*\*Layer:\*\* Gold / dbt mart  

\*\*Type:\*\* Dimension table  

\*\*Grain:\*\* One row per unique customer  

\*\*Deduplication:\*\* ROW\_NUMBER() on lifetime\_revenue descending  



| Column | Type | Description | Example |

|--------|------|-------------|---------|

| customer\_id | INT | Unique customer identifier | 21768 |

| first\_name | VARCHAR | Customer first name | Cole |

| last\_name | VARCHAR | Customer last name | Watson |

| gender | VARCHAR | Normalized: male/female/n/a | male |

| marital\_status | VARCHAR | Normalized: single/married | single |

| customer\_since | DATE | Account creation date | 2026-01-05 |

| total\_orders | INT | Lifetime order count | 12 |

| lifetime\_revenue | DECIMAL | Total USD revenue | 45230.00 |

| avg\_order\_value | DECIMAL | Average order size | 3769.17 |

| first\_order\_date | DATE | Date of first purchase | 2010-12-29 |

| last\_order\_date | DATE | Date of most recent purchase | 2014-01-28 |

| avg\_fulfillment\_days | FLOAT | Average days order to ship | 7.3 |

| customer\_segment | VARCHAR | RFM segment | High Value |



\*\*Segmentation Logic:\*\*

\- High Value: lifetime\_revenue >= 5000

\- Mid Value: lifetime\_revenue >= 1000

\- Low Value: lifetime\_revenue < 1000



\---



\## fct\_sales

\*\*Layer:\*\* Gold / dbt mart  

\*\*Type:\*\* Fact table  

\*\*Grain:\*\* One row per order transaction  

\*\*Materialization:\*\* Incremental (merge on order\_number)  



| Column | Type | Description | Example |

|--------|------|-------------|---------|

| order\_number | VARCHAR | Unique order identifier | SO43697 |

| order\_date | DATE | Date order was placed | 2010-12-29 |

| customer\_id | INT | FK → dim\_customers | 21768 |

| customer\_name | VARCHAR | First + last name | Cole Watson |

| product\_key | VARCHAR | Product identifier | BK-R93R-62 |

| quantity | INT | Units ordered | 1 |

| sales\_amount | INT | Revenue in USD | 3578 |

| fulfillment\_days | INT | Days from order to ship | 9 |

| order\_year | INT | Extracted year | 2010 |

| order\_month | INT | Extracted month number | 12 |

| order\_month\_name | VARCHAR | Month name | December |

| order\_quarter | VARCHAR | Quarter | Q4 |



\---



\## mart\_product\_performance

\*\*Layer:\*\* Gold / dbt mart  

\*\*Type:\*\* Aggregate table  

\*\*Grain:\*\* One row per product  



| Column | Type | Description | Example |

|--------|------|-------------|---------|

| product\_key | VARCHAR | Product identifier | BK-R93R-62 |

| total\_orders | INT | Distinct order count | 342 |

| total\_units\_sold | INT | Sum of quantity | 342 |

| total\_revenue | INT | Sum of sales\_amount | 1234567 |

| avg\_order\_revenue | FLOAT | Average revenue per order | 3610.43 |

| first\_sale\_date | DATE | Earliest sale date | 2010-12-29 |

| last\_sale\_date | DATE | Most recent sale | 2014-01-28 |

| revenue\_rank | INT | 1 = highest revenue product | 1 |



\---



\## Source Tables (Bronze Layer)



| Table | Source System | Records | Description |

|-------|---------------|---------|-------------|

| bronze.crm\_cust\_info | CRM | \~18,000 | Customer master data |

| bronze.crm\_prd\_info | CRM | \~500 | Product catalog |

| bronze.crm\_sales\_details | CRM | \~60,000 | Order transactions |

| bronze.erp\_cust\_az12 | ERP | \~18,000 | ERP customer reference |

| bronze.erp\_loc\_a101 | ERP | \~600 | Location reference |

| bronze.erp\_px\_cat\_g1v2 | ERP | \~40 | Product categories |



\---



\## Data Quality Rules



| Rule | Table | Column | Test |

|------|-------|--------|------|

| No null customer IDs | dim\_customers | customer\_id | not\_null |

| Unique customers | dim\_customers | customer\_id | unique |

| Valid segments only | dim\_customers | customer\_segment | accepted\_values |

| No null orders | fct\_sales | order\_number | not\_null |

