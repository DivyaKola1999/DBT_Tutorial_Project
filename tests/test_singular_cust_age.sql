select *
from {{ ref('customer_age_group') }}
where age > 120