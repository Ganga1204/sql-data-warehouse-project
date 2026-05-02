
  
    USE [DataWarehouse];
    USE [DataWarehouse];
    
    

    

    
    USE [DataWarehouse];
    EXEC('
        create view "dbt_dev_marts"."dim_customers__dbt_tmp__dbt_tmp_vw" as with customer_orders as (
    select * from "DataWarehouse"."dbt_dev_intermediate"."int_customer_orders"
),

customer_metrics as (
    select
        customer_id,
        first_name,
        last_name,
        gender,
        marital_status,
        customer_since,
        count(distinct order_number)              as total_orders,
        sum(sales_amount)                         as lifetime_revenue,
        avg(cast(sales_amount as float))          as avg_order_value,
        min(order_date)                           as first_order_date,
        max(order_date)                           as last_order_date,
        avg(cast(fulfillment_days as float))      as avg_fulfillment_days,
        case
            when sum(sales_amount) >= 5000 then ''High Value''
            when sum(sales_amount) >= 1000 then ''Mid Value''
            else ''Low Value''
        end                                       as customer_segment
    from customer_orders
    group by
        customer_id,
        first_name,
        last_name,
        gender,
        marital_status,
        customer_since
),

-- deduplicate: keep one row per customer_id
-- if same customer_id appears with different names/attributes,
-- keep the one with highest lifetime revenue
deduped as (
    select
        *,
        row_number() over (
            partition by customer_id
            order by lifetime_revenue desc
        ) as rn
    from customer_metrics
)

select
    customer_id,
    first_name,
    last_name,
    gender,
    marital_status,
    customer_since,
    total_orders,
    lifetime_revenue,
    avg_order_value,
    first_order_date,
    last_order_date,
    avg_fulfillment_days,
    customer_segment
from deduped
where rn = 1;
    ')

EXEC('
            SELECT * INTO "DataWarehouse"."dbt_dev_marts"."dim_customers__dbt_tmp" FROM "DataWarehouse"."dbt_dev_marts"."dim_customers__dbt_tmp__dbt_tmp_vw" 
    OPTION (LABEL = ''dbt-sqlserver'');

        ')

    
    EXEC('DROP VIEW IF EXISTS dbt_dev_marts.dim_customers__dbt_tmp__dbt_tmp_vw')



    
    use [DataWarehouse];
    if EXISTS (
        SELECT *
        FROM sys.indexes with (nolock)
        WHERE name = 'dbt_dev_marts_dim_customers__dbt_tmp_cci'
        AND object_id=object_id('dbt_dev_marts_dim_customers__dbt_tmp')
    )
    DROP index "dbt_dev_marts"."dim_customers__dbt_tmp".dbt_dev_marts_dim_customers__dbt_tmp_cci
    CREATE CLUSTERED COLUMNSTORE INDEX dbt_dev_marts_dim_customers__dbt_tmp_cci
    ON "dbt_dev_marts"."dim_customers__dbt_tmp"

   


  