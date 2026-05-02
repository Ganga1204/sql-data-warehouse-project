# Data-Warehouse-project
Building a modern data warehouse with SQL Server, including ETL processes, data modeling and analytics.
# Modern Data Warehouse using Medallion Architecture

## Overview
This project implements a modern data warehouse using the Medallion Architecture to consolidate sales data from ERP and CRM systems and enable analytical reporting.

## Architecture
Bronze Layer → Raw data ingestion  
Silver Layer → Data cleaning and transformation  
Gold Layer → Business-ready analytical data model

## Tech Stack
SQL Server
SQL
Medallion Architecture
Data Modeling

## Data Sources
ERP and CRM datasets provided as CSV files.

10 CSV files  
15 tables  
195,469 records

## Key Features
- Data ingestion pipeline for ERP and CRM systems
- Data quality checks and cleansing
- Analytical data model for reporting
- Documented schema and pipeline architecture

## Project Workflow
1. Import CSV files into Bronze layer
2. Clean and standardize data in Silver layer
3. Build analytical tables in Gold layer
4. Enable business analytics queries

## Example Analytical Queries
- Customer segmentation
- Product performance analysis
- Sales trends over time

## Documentation
Project planning and documentation maintained using Notion and Draw.io.



# Modern Data Warehouse — Medallion Architecture + dbt + Metabase

[![dbt](https://img.shields.io/badge/dbt-1.11-orange)](https://www.getdbt.com/)
[![SQL Server](https://img.shields.io/badge/SQL_Server-2022-blue)](https://www.microsoft.com/sql-server)
[![Metabase](https://img.shields.io/badge/Metabase-Dashboard-509EE3)](https://www.metabase.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A production-grade data warehouse built on SQL Server using the Medallion
Architecture (Bronze → Silver → Gold), with dbt for transformations and
lineage, and Metabase for business analytics dashboards.

**Scale:** 10 source files · 15 tables · 195,469 records · ERP + CRM

---

## Architecture
ERP System (CSV)          CRM System (CSV)
│                         │
▼                         ▼
┌─────────────────────────────────────┐
│  🥉 BRONZE — Raw Ingestion          │
│  SQL Server · No transformations    │
└──────────────────┬──────────────────┘
▼
┌─────────────────────────────────────┐
│  🥈 SILVER — Cleansed & Standardized│
│  Deduplication · Type casting       │
└──────────────────┬──────────────────┘
▼
┌─────────────────────────────────────┐
│  🥇 GOLD — Star Schema              │
│  dim_customers · fct_sales          │
└──────────────────┬──────────────────┘
▼
┌─────────────────────────────────────┐
│  🔄 DBT — Transformations & Lineage │
│  staging → intermediate → marts     │
│  7 models · 4 tests · lineage graph │
└──────────────────┬──────────────────┘
▼
┌─────────────────────────────────────┐
│  📊 METABASE — BI Dashboard         │
│  Revenue · Segments · Products      │
└─────────────────────────────────────┘

---

## dbt Lineage Graph

![dbt Lineage Graph](docs/images/dbt_lineage.png)

---

## Metabase Dashboard

![Metabase Dashboard](docs/images/metabase_dashboard.png)

---

## Medallion Layers

### 🥉 Bronze — Raw Ingestion
- All 10 source CSV files loaded as-is
- No transformations applied
- Full audit trail preserved
- Tables: `crm_cust_info`, `crm_sales_details`, `crm_prd_info`,
  `erp_cust_az12`, `erp_loc_a101`, `erp_px_cat_g1v2`

### 🥈 Silver — Cleansed & Standardized
- Whitespace trimmed, nulls handled
- Date integers (20101229) converted to DATE type
- Gender/marital status normalized
- Duplicates removed using ROW_NUMBER()
- Data quality flags added

### 🥇 Gold — Star Schema
| Object | Type | Description |
|--------|------|-------------|
| `dim_customers` | Dimension | Customer master + RFM segments |
| `fct_sales` | Fact | Order-level transactions |
| `mart_product_performance` | Aggregate | Revenue ranking by product |

---

## dbt Models
models/
├── staging/
│   ├── stg_crm_customers.sql
│   ├── stg_crm_sales.sql
│   └── stg_crm_products.sql
├── intermediate/
│   └── int_customer_orders.sql
└── marts/
├── dim_customers.sql
├── fct_sales.sql
└── mart_product_performance.sql

**Results:** `dbt run` → PASS=7 ERROR=0 · `dbt test` → PASS=3 ERROR=0

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| SQL Server 2022 | Database engine |
| T-SQL | Transformation scripts |
| dbt Core 1.11 | Model lineage + testing |
| Metabase | BI dashboards |
| Medallion Architecture | Bronze/Silver/Gold layers |
| Star Schema | Dimensional modeling |

---

## Project Structure
sql-data-warehouse-project/
├── datasets/          # Source CSV files
├── scripts/           # Original SQL scripts (bronze/silver/gold)
├── dbt_warehouse/     # dbt project
│   ├── models/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   └── dbt_project.yml
├── docs/
│   └── images/
│       ├── dbt_lineage.png
│       └── metabase_dashboard.png
├── tests/
└── README.md

---

# 1. Run SQL scripts
EXEC bronze.load_bronze;
EXEC silver.load_silver;

# 2. Run dbt
cd dbt_warehouse
pip install dbt-sqlserver
dbt debug
dbt run
dbt test
dbt docs serve --port 8081

# 3. Launch Metabase
docker run -d -p 3000:3000 --name metabase metabase/metabase
# Open http://localhost:3000
```
