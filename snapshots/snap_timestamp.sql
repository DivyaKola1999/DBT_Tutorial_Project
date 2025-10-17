{% snapshot customer_timestamp %}

{{
  config(
    target_schema='snapshots',
    unique_key='customerid',
    strategy='timestamp',
    updated_at='updated_at', 
    invalidate_hard_deletes=false
  )
}}

select
  customerid,
  name,
  age,
  city,
  email,
  updated_at  
from {{ ref('cust_info') }}

{% endsnapshot %}
