with sales as (
    select * from {{ ref('fct_sales') }}
),

product_summary as (
    select
        product_key,
        count(distinct order_number)             as total_orders,
        sum(quantity)                            as total_units_sold,
        sum(sales_amount)                        as total_revenue,
        avg(cast(sales_amount as float))         as avg_order_revenue,
        min(order_date)                          as first_sale_date,
        max(order_date)                          as last_sale_date
    from sales
    group by product_key
)

select
    *,
    rank() over (order by total_revenue desc)    as revenue_rank
from product_summary