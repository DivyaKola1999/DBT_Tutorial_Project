{{ 
    config(materialized='table')
}}

select
  customerid,
  name,
  age,
  city,
  email,
  updated_at 
from {{ source('dbt_source_data_bronze', 'CUSTOMER') }}