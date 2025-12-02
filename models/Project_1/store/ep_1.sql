{{ config(materialized='ephemeral') }}

select
  customerid,
  age,
  case
    when age between 20 and 29 then 'twenties'
    when age between 30 and 39 then 'thirties'
    else 'other'
  end as age_group
from {{ source('dbt_source_data_bronze', 'CUSTOMER') }}