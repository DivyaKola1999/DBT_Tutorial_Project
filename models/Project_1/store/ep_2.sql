with cte as (
  select * from {{ ref('ep_1') }}
)
select * from cte where age_group = 'twenties'