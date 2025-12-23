{{ config(
    materialized='incremental',
    unique_key='customerid'
) }}

with source_data as (
    select
        customerid,
        name,
        age,
        city,
        email,
        updated_at
    from {{ source('dbt_source_data_bronze', 'CUSTOMER') }}
)

select * from source_data

{% if is_incremental() %}
    where updated_at > (
        select coalesce(max(updated_at), '1900-01-01'::timestamp)
        from {{ this }}
    )
{% endif %}