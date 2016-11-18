select

  id,
  parent_id,
  order_id,

  status,
  error_code,
  message,

  kind,
  amount,
  "authorization",
  currency,
  gateway,

  source_name,

  created_at,
  _sdc_received_at

from
  {{ var('source_schema') }}.{{ var('transactions_table') }}

where
  -- filter test transactions
  test = false
