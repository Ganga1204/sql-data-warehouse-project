USE [DataWarehouse];
    
    

    

    
    USE [DataWarehouse];
    EXEC('
        create view "dbt_dev_staging"."stg_crm_customers__dbt_tmp" as with source as (
    select * from "DataWarehouse"."bronze"."crm_cust_info"
),

renamed as (
    select
        cst_id                              as customer_id,
        trim(cst_firstname)                 as first_name,
        trim(cst_lastname)                  as last_name,
        lower(trim(cst_marital_status))     as marital_status,
        lower(trim(cst_gndr))               as gender,
        cst_create_date                     as created_date,
        case
            when cst_id is null then ''invalid''
            else ''valid''
        end                                 as record_status
    from source
    where cst_id is not null
)

select * from renamed;
    ')

