with source_data as (
    select
        SELECT
    customerid,
    name,
    age,
    CASE
        WHEN age < 18 THEN 'Minor'
        WHEN age BETWEEN 18 AND 34 THEN 'Young Adult'
        WHEN age BETWEEN 35 AND 54 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    city,
    email
    from {{ source('dbt_source_data_bronze', 'CUSTOMER') }}
)

select * from source_data