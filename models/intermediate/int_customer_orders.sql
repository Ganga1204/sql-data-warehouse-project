with customers as (
    select * from {{ ref('stg_crm_customers') }}
),

orders as (
    select * from {{ ref('stg_crm_sales') }}
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    c.gender,
    c.marital_status,
    c.created_date                   as customer_since,
    o.order_number,
    o.product_key,
    o.order_date,
    o.sales_amount,
    o.quantity,
    o.fulfillment_days
from customers c
inner join orders o
    on c.customer_id = o.customer_id