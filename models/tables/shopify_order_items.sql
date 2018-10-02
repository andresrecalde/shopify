select  
    
--IDs
    oi.id,
    oi.order_id,
    oi.product_id,
    oi.variant_id,
    o.customer_id,
    o.order_number,

--Item Info
    oi.name,
    oi.title,
    oi.variant_title,
    oi.sku,
    oi.product_type,

  
--Numbers
    oi.price,
    oi.quantity,
    oi.line_item_discount,
    line_item_net_sales,
    line_item_gross_sales,
    oi.weight,
    o.weight as order_weight,
    weight_unit,
    line_item_weight,
    oi.refunded_quantity,
    oi.refunded_subtotal,
    o.customer_order_number,    
    o.net_sales as order_net_sales,
    o.gross_sales as order_gross_sales,
--Timestamps
    o.created_at,
    o.cancelled_at,
    greatest(o.updated_at, oi.updated_at) as updated_at,

--Order Status
    o.financial_status,
    oi.fulfillment_status,

--Calculated Columns
    case
        when o.source = 'recharge' then 'Subscription'
        else 'Non-Subscription'
    end as subscription_type

--Order Aggregates
    

FROM {{ref('shopify_base_order_items')}} oi
JOIN {{ref('shopify_orders')}} o on oi.order_id = o.id