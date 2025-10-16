with customers as (
  select * 
  from {{ source('dbt_source_data_landing', 'SRC_CUSTOMERS') }}
),

orders as (
  select * 
  from {{ source('dbt_source_data_landing', 'SRC_ORDERS') }}
),

order_items as (
  select *
  from {{ source('dbt_source_data_landing', 'SRC_ORDER_ITEMS') }}
),

payments as (
  select *
  from {{ source('dbt_source_data_landing', 'SRC_ORDER_PAYMENTS') }}
),

products as (
  select * 
  from {{ source('dbt_source_data_landing', 'SRC_PRODUCTS') }}
),

sellers as (
  select *
  from {{ source('dbt_source_data_landing', 'SRC_SELLERS') }}
),

geolocation as (
  select *
  from {{ source('dbt_source_data_landing', 'SRC_GEOLOCATION') }}
),

-- Enrich orders with sum of order items prices and freight
order_items_agg as (
  select
    order_id,
    sum(price) as total_price,
    sum(freight_value) as total_freight,
    count(distinct product_id) as distinct_products_count
  from order_items
  group by order_id
),

-- Aggregate payments info per order
payments_agg as (
  select
    order_id,
    count(distinct payment_type) as payment_types_count,
    sum(payment_value) as total_payment_value,
    max(payment_installments) as max_installments
  from payments
  group by order_id
),

-- Join everything together
final as (
  select
    c.customer_id,
    c.customer_unique_id,
    c.customer_state,
    c.customer_city,
    c.customer_zip_code_prefix,
    
    o.order_id,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_customer_date,
    
    oi.total_price,
    oi.total_freight,
    oi.distinct_products_count,
    
    p.payment_types_count,
    p.total_payment_value,
    p.max_installments,
    
    s.seller_id,
    s.seller_city,
    s.seller_state,
    
    prod.product_id,
    prod.product_category_name,
    
    geo.geolocation_lat,
    geo.geolocation_lng,
    geo.geolocation_city,
    geo.geolocation_state
    
  from orders o
  left join customers c on o.customer_id = c.customer_id
  left join order_items_agg oi on o.order_id = oi.order_id
  left join payments_agg p on o.order_id = p.order_id
  left join order_items oi_full on o.order_id = oi_full.order_id  -- to join seller id and product id
  left join sellers s on oi_full.seller_id = s.seller_id
  left join products prod on oi_full.product_id = prod.product_id
  left join geolocation geo on c.customer_zip_code_prefix = geo.geolocation_zip_code_prefix
)

select
  customer_id,
  customer_unique_id,
  customer_state,
  customer_city,
  customer_zip_code_prefix,
  
  order_id,
  order_status,
  order_purchase_timestamp,
  order_approved_at,
  order_delivered_customer_date,
  
  total_price,
  total_freight,
  distinct_products_count,
  
  payment_types_count,
  total_payment_value,
  max_installments,
  
  seller_id,
  seller_city,
  seller_state,
  
  product_id,
  product_category_name,
  
  geolocation_lat,
  geolocation_lng,
  geolocation_city,
  geolocation_state

from final