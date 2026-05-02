
    
    -- Create target schema if it does not
  USE [DataWarehouse];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbt_dev')
  BEGIN
    EXEC('CREATE SCHEMA [dbt_dev]')
  END

  

  
  EXEC('create view 
    [dbt_dev].[testview_5d334d26351fc6c5b8afa76b26838eea_5255]
   as 
    
    
    

with all_values as (

    select
        customer_segment as value_field,
        count(*) as n_records

    from "DataWarehouse"."dbt_dev_marts"."dim_customers"
    group by customer_segment

)

select *
from all_values
where value_field not in (
    ''High Value'',''Mid Value'',''Low Value''
)



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [dbt_dev].[testview_5d334d26351fc6c5b8afa76b26838eea_5255]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [dbt_dev].[testview_5d334d26351fc6c5b8afa76b26838eea_5255]
  ;')