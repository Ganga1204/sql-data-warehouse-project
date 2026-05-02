
  
    USE [DataWarehouse];
    USE [DataWarehouse];
    
    

    

    
    USE [DataWarehouse];
    EXEC('
        create view "dbt_dev_marts"."mart_product_performance__dbt_tmp__dbt_tmp_vw" as with sales as (
    select * from "DataWarehouse"."dbt_dev_marts"."fct_sales"
),

product_summary as (
    select
        product_key,
        count(distinct order_number)             as total_orders,
        sum(quantity)                            as total_units_sold,
        sum(sales_amount)                        as total_revenue,
        avg(cast(sales_amount as float))         as avg_order_revenue,
        min(order_date)                          as first_sale_date,
        max(order_date)                          as last_sale_date
    from sales
    group by product_key
)

select
    *,
    rank() over (order by total_revenue desc)    as revenue_rank
from product_summary;
    ')

EXEC('
            SELECT * INTO "DataWarehouse"."dbt_dev_marts"."mart_product_performance__dbt_tmp" FROM "DataWarehouse"."dbt_dev_marts"."mart_product_performance__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbt_dev_marts.mart_product_performance__dbt_tmp__dbt_tmp_vw')



    
    use [DataWarehouse];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbt_dev_marts_mart_product_performance__dbt_tmp_cci'
        AND object_id=object_id('dbt_dev_marts_mart_product_performance__dbt_tmp')
    )
    DROP index "dbt_dev_marts"."mart_product_performance__dbt_tmp".dbt_dev_marts_mart_product_performance__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbt_dev_marts_mart_product_performance__dbt_tmp_cci
    ON "dbt_dev_marts"."mart_product_performance__dbt_tmp"

   


  