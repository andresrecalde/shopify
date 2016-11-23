SELECT 

--IDs
       o.id,
       o.customer_id,

--Customer Info
       o.email,
--Order Status
       financial_status,
       fulfillment_status,
       processing_method,
       gateway,
       
--Timestamps
       o.created_at,
       c.created_at as customer_created_at,
       o.updated_at,

--Calculated Columns
       rank() over (partition by o.customer_id order by o.created_at, o.id ASC) AS customer_order_number

FROM {{ref('shopify_source_orders')}} o
JOIN {{ref('shopify_base_customers')}} c on c.id = o.customer_id