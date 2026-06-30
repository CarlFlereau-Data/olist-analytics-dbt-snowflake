WITH source AS (
    SELECT * 
    FROM {{source('olist_raw', 'olist_order_payments')}}
),
renamed AS (
    SELECT
    {{ clean_id('order_id') }} AS order_id,
    payment_sequential,
    LOWER(payment_type) AS payment_type,
    payment_installments AS nb_installments,
    payment_value AS payment_value
    FROM source
)

SELECT * FROM renamed