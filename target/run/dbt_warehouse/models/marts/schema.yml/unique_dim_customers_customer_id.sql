
    
    -- Create target schema if it does not
  USE [DataWarehouse];
  IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dbt_dev')
  BEGIN
    EXEC('CREATE SCHEMA [dbt_dev]')
  END

  

  
  EXEC('create view 
    [dbt_dev].[testview_1a82ee9af8453076dd5877c05b39795c_15653]
   as 
    
    
    

select
    customer_id as unique_field,
    count(*) as n_records

from "DataWarehouse"."dbt_dev_marts"."dim_customers"
where customer_id is not null
group by customer_id
having count(*) > 1



  ;')
  select
    
    count(*) as failures,
    case when count(*) != 0
      then 'true' else 'false' end as should_warn,
    case when count(*) != 0
      then 'true' else 'false' end as should_error
  from (
    select * from 
    [dbt_dev].[testview_1a82ee9af8453076dd5877c05b39795c_15653]
  
  ) dbt_internal_test;

  EXEC('drop view 
    [dbt_dev].[testview_1a82ee9af8453076dd5877c05b39795c_15653]
  ;')