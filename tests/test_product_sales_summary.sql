-- This test fails if any metric is null or negative

select *
from {{ ref('product_sales_summary') }}
where total_quantity_sold <= 0
   or total_quantity_sold is null
   or total_sales_amount <= 0
   or total_sales_amount is null
