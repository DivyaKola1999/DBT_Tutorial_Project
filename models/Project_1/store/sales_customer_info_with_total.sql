with sales_agg as (
    select
        customerid,
        sum(totalprice) as total_spent
    from DBT_SOURCE_DATA.BRONZE.SALES
    group by customerid
),

customer_data as (
    select customerid, name,email, city, age
    from DBT_SOURCE_DATA.BRONZE.CUSTOMER
)

select
    s.customerid,
    c.name,
    c.email,
    c.city,
    c.age,
    s.total_spent
from sales_agg s
left join customer_data c on s.customerid = c.customerid