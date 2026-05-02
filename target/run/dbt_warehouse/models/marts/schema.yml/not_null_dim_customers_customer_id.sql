
    
    -- Create target schema if it does not
  USE [DataWarehouse];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbt_dev')
  BEGIN
    EXEC('CREATE SCHEMA [dbt_dev]')
  END

  

  
  EXEC('create view 
    [dbt_dev].[testview_f37780c56243f03fc6e9e4bd35d76651_8475]
   as 
    
    
    



select customer_id
from "DataWarehouse"."dbt_dev_marts"."dim_customers"
where customer_id is null



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [dbt_dev].[testview_f37780c56243f03fc6e9e4bd35d76651_8475]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [dbt_dev].[testview_f37780c56243f03fc6e9e4bd35d76651_8475]
  ;')