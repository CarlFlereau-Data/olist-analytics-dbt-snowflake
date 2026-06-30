WITH source AS (
    SELECT * 
    FROM {{source('olist_raw', 'olist_sellers')}}
),
renamed AS (
    SELECT
    {{ clean_id('seller_id') }} AS seller_id,
    seller_zip_code_prefix AS zip_code_prefix,
    initcap(seller_city) AS seller_city,
    upper(seller_state) AS seller_state
    FROM source
)

SELECT * FROM renamed