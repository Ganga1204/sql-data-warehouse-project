
    
    -- Create target schema if it does not
  USE [DataWarehouse];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbt_dev')
  BEGIN
    EXEC('CREATE SCHEMA [dbt_dev]')
  END

  

  
  EXEC('create view 
    [dbt_dev].[testview_fa528d9c620a0d451a180e17b56ff796_2422]
   as 
    
    
    



select order_number
from "DataWarehouse"."dbt_dev_marts"."fct_sales"
where order_number is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [dbt_dev].[testview_fa528d9c620a0d451a180e17b56ff796_2422]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [dbt_dev].[testview_fa528d9c620a0d451a180e17b56ff796_2422]
  ;')