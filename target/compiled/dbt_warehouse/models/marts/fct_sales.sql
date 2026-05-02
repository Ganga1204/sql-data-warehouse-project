with orders as (
    select * from "DataWarehouse"."dbt_dev_intermediate"."int_customer_orders"
)

select
    order_number,
    order_date,
    customer_id,
    first_name + ' ' + last_name     as customer_name,
    product_key,
    quantity,
    sales_amount,
    fulfillment_days,
    year(order_date)                  as order_year,
    month(order_date)                 as order_month,
    datename(month,   order_date)     as order_month_name,
    datename(quarter, order_date)     as order_quarter
from orders