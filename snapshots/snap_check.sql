{% snapshot customer_check %}

{{
  config(
    target_schema='snapshots',
    unique_key='customerid',
    strategy='check',
    check_cols=['name', 'age', 'city', 'email'],
    invalidate_hard_deletes=false
  )
}}

select
  customerid,
  name,
  age,
  city,
  email
from {{ ref('cust_info') }}

{% endsnapshot %}
