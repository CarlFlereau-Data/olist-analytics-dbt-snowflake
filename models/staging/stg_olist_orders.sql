WITH source AS (
    SELECT * 
    FROM {{source('olist_raw', 'olist_orders')}}

),

renamed AS (
    SELECT
    {{ clean_id('order_id') }} AS order_id,
    {{ clean_id('customer_id') }} AS customer_id,
    order_status,
    TRY_TO_TIMESTAMP_NTZ(order_purchase_timestamp) AS ordered_at,
    TRY_TO_TIMESTAMP_NTZ(order_approved_at) AS approved_at,
    TRY_TO_TIMESTAMP_NTZ(order_delivered_carrier_date) AS delivered_carrier_at,
    TRY_TO_TIMESTAMP_NTZ(order_delivered_customer_date) AS delivered_to_customer_at,
    TRY_TO_TIMESTAMP_NTZ(order_estimated_delivery_date) AS estimated_delivery_at

    FROM source
)

SELECT * FROM renamed