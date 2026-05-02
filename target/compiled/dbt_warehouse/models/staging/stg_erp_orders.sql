with source as (
    select * from "DataWarehouse"."bronze"."erp_px_cat_g1v2"
),

renamed as (
    select
        sls_ord_num                         as order_number,
        sls_prd_key                         as product_key,
        sls_cust_id                         as customer_id,
        sls_order_dt                        as order_date,
        sls_ship_dt                         as ship_date,
        sls_due_dt                          as due_date,
        sls_sales                           as sales_amount,
        sls_quantity                        as quantity,
        sls_price                           as unit_price,
        datediff(day, sls_order_dt, sls_ship_dt) as fulfillment_days
    from source
    where sls_ord_num is not null
      and sls_sales > 0
)

select * from renamed