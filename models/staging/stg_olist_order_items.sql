WITH source AS (
    SELECT *
    FROM {{ source('olist_raw', 'olist_order_items') }}
),

renamed AS (
    SELECT
        {{ clean_id('order_id') }} AS order_id,
        {{ clean_id('order_item_id') }} AS order_item_id,
        {{ clean_id('product_id') }} AS product_id,
        {{ clean_id('seller_id') }} AS seller_id,
        TRY_TO_TIMESTAMP_NTZ(shipping_limit_date) AS shipping_limit_at,
        price AS item_price,
        freight_value,
        (price + freight_value) AS total_item_value
    FROM source
)

SELECT * FROM renamed