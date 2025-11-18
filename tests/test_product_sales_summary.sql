-- This test will FAIL if any rows are returned.
-- It validates key fields and numeric fields in the product_sales_summary model.

with data as (
    select *
    from {{ ref('product_sales_summary') }}
)

select *
from data
where
    productid is null
    or productname is null
    or category is null
    or total_quantity_sold < 0
    or total_sales_amount < 0

