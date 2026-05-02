with source as (
    select * from {{ source('bronze', 'crm_sales_details') }}
)

select
    sls_ord_num                                      as order_number,
    sls_prd_key                                      as product_key,
    sls_cust_id                                      as customer_id,

    -- integers like 20101229 → convert to varchar first, then to date
    try_cast(
        try_cast(sls_order_dt as varchar(8)) as date
    )                                                as order_date,

    try_cast(
        try_cast(sls_ship_dt as varchar(8)) as date
    )                                                as ship_date,

    try_cast(
        try_cast(sls_due_dt as varchar(8)) as date
    )                                                as due_date,

    sls_sales                                        as sales_amount,
    sls_quantity                                     as quantity,
    sls_price                                        as unit_price,

    case
        when sls_order_dt is null
          or sls_ship_dt  is null then null
        else datediff(
            day,
            try_cast(try_cast(sls_order_dt as varchar(8)) as date),
            try_cast(try_cast(sls_ship_dt  as varchar(8)) as date)
        )
    end                                              as fulfillment_days

from source
where sls_ord_num is not null
  and sls_sales   > 0