{{ 
    config(materialized='table')
}}

with cust as(
    select * from {{ ref('sales_customer_info_with_total') }}
)

select 
    *,
    {{ m_age_group('age') }} as age_group
    from cust