{{ config(materialized='table') }}

with sales_data as (
    select * from {{ source('dbt_source_data_bronze', 'SALES') }}
),

product_data as (
    select * from {{ source('dbt_source_data_bronze', 'PRODUCT') }}
)

select
    p.productid,
    p.productname,
    p.category,
    sum(s.quantity) as total_quantity_sold,
    sum(s.totalprice) as total_sales_amount
from sales_data s
join product_data p on s.productid = p.productid
group by p.productid, p.productname, p.category
order by total_sales_amount desc