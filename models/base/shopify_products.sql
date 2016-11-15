select

  id,
  title,
  product_type,
  vendor,
  tags,
  handle,
  published_at,
  created_at,
  updated_at,
  _sdc_received_at

from
  {{ var('source_schema') }}.{{ var('products_table') }}
