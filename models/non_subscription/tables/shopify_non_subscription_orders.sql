{{
  config({
    "materialized" : "incremental",
    "unique_key" : "id",
    "sort" : "created_at",
    "sql_where" : "updated_at >= (select max(updated_at) from {{this}})"
    })
}}

SELECT 

--IDs
       o.id,
       o.customer_id,

--Customer Info
       o.email,
--Order Status
       o.financial_status,
       o.fulfillment_status,
       o.processing_method,
       o.gateway,
       
--Timestamps
       o.created_at,
       o.customer_created_at,
       greatest(c.updated_at, oa.updated_at, o.updated_at, po.updated_at) as updated_at,
       po.created_at as previous_order_created_at,
--Numbers
       o.customer_order_number,

--Order Aggregates
       oa.count_of_items,
       oa.net_sales,
       oa.gross_sales,
       oa.weight,

--Customer Aggregates
       number_of_orders,
       average_order_value,
       first_order_date,
       last_order_date,
       years_active,
       lifetime_revenue,
       items_purchased,
       annual_revenue,

--Calculated Columns
       datediff(second, o.customer_created_at, o.created_at) as time_since_customer_creation,
       datediff(second, first_order_date, o.created_at) as time_since_first_order,
       datediff(second, po.created_at, o.created_at) as time_since_previous_order,
       number_of_orders = o.customer_order_number as is_most_recent_order

FROM {{ref('shopify_base_non_subscription_orders')}} o
JOIN {{ref('shopify_non_subscription_order_aggregates')}} oa on oa.order_id = o.id
JOIN {{ref('shopify_non_subscription_customers')}} c on c.id = o.customer_id
LEFT JOIN {{ref('shopify_base_non_subscription_orders')}} po on po.customer_id = o.customer_id and po.customer_order_number = (o.customer_order_number - 1)