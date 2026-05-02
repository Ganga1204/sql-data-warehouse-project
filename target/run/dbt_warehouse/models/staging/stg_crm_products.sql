USE [DataWarehouse];
    
    

    

    
    USE [DataWarehouse];
    EXEC('
        create view "dbt_dev_staging"."stg_crm_products__dbt_tmp" as with source as (
    select * from "DataWarehouse"."bronze"."crm_prd_info"
),

renamed as (
    select
        prd_id                                   as product_id,
        trim(prd_key)                            as product_key,
        trim(prd_nm)                             as product_name,
        prd_cost                                 as product_cost,
        prd_line                                 as product_line,
        prd_start_dt                             as start_date,
        prd_end_dt                               as end_date,
        case
            when prd_end_dt is null
              or prd_end_dt > getdate() then 1
            else 0
        end                                      as is_active
    from source
)

select * from renamed;
    ')

