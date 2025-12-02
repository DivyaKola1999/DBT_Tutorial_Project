{{ config(
    materialized='incremental',
    unique_key='movie_id'
) }}

with source_data as (

    select
        movie_id,
        title,
        genre,
        release_year,
        duration_minutes,
        rating,
        updated_at,
        current_timestamp() as etl_date
    from {{ ref('movies') }}

)

select * from source_data

{% if is_incremental() %}

where updated_at > (select max(updated_at) from {{ this }})

{% endif %}