select

  id,
  order_id,
  user_id,
  restock,
  note,
  created_at,
  _sdc_received_at

from
  {{ var('source_schema') }}.{{ var('refunds_table') }}
