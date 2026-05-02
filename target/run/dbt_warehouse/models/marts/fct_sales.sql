
  
    USE [DataWarehouse];
    USE [DataWarehouse];
    
    

    

    
    USE [DataWarehouse];
    EXEC('
        create view "dbt_dev_marts"."fct_sales__dbt_tmp__dbt_tmp_vw" as with orders as (
    select * from "DataWarehouse"."dbt_dev_intermediate"."int_customer_orders"
)

select
    order_number,
    order_date,
    customer_id,
    first_name + '' '' + last_name     as customer_name,
    product_key,
    quantity,
    sales_amount,
    fulfillment_days,
    year(order_date)                  as order_year,
    month(order_date)                 as order_month,
    datename(month,   order_date)     as order_month_name,
    datename(quarter, order_date)     as order_quarter
from orders;
    ')

EXEC('
            SELECT * INTO "DataWarehouse"."dbt_dev_marts"."fct_sales__dbt_tmp" FROM "DataWarehouse"."dbt_dev_marts"."fct_sales__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbt_dev_marts.fct_sales__dbt_tmp__dbt_tmp_vw')



    
    use [DataWarehouse];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbt_dev_marts_fct_sales__dbt_tmp_cci'
        AND object_id=object_id('dbt_dev_marts_fct_sales__dbt_tmp')
    )
    DROP index "dbt_dev_marts"."fct_sales__dbt_tmp".dbt_dev_marts_fct_sales__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbt_dev_marts_fct_sales__dbt_tmp_cci
    ON "dbt_dev_marts"."fct_sales__dbt_tmp"

   


  